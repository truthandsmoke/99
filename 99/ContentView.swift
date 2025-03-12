import SwiftUI

struct ContentView: View {
    @State private var names: [String: String] = [
        "Ar-Rahman": "The Most Gracious",
        "Ar-Rahim": "The Most Merciful",
        "Al-Malik": "The King",
        "Al-Quddus": "The Holy",
        "As-Salam": "The Peaceful",
        "Al-Muhaymin": "The Guardian",
        "Al-Aziz": "The Almighty",
        "Al-Jabbar": "The Compeller",
        "Al-Mutakabbir": "The Majestic",
        "Al-Khaliq": "The Creator",
        "Al-Bari": "The Evolver",
        "Al-Musawwir": "The Fashioner of Forms",
        "Al-Ghaffar": "The Forgiving",
        "Al-Qahhar": "The Subduer",
        "Al-Wahhab": "The Bestower",
        "Ar-Razzaq": "The Provider",
        "Al-Fattah": "The Opener",
        "Al-Alim": "The Knower of All",
        "Al-Qabid": "The Constrictor",
        "Al-Basit": "The Reliever",
        "Al-Khafid": "The Abaser",
        "Ar-Rafi": "The Exalter",
        "Al-Muizz": "The Bestower of Honor",
        "Al-Mudhill": "The Humiliator",
        "As-Sami": "The Hearer of All",
        "Al-Basir": "The Seer of All",
        "Al-Hakam": "The Judge",
        "Al-Adl": "The Just",
        "Al-Latif": "The Subtle One",
        "Al-Khabir": "The All-Aware",
        "Al-Halim": "The Forbearing",
        "Al-Azim": "The Magnificent",
        "Al-Ghafur": "The Forgiver and Concealer of Faults",
        "Ash-Shakur": "The Rewarder of Thankfulness",
        "Al-Ali": "The Highest",
        "Al-Kabir": "The Greatest",
        "Al-Hafiz": "The Preserver",
        "Al-Muqit": "The Nourisher",
        "Al-Hasib": "The Accounter",
        "Al-Jalil": "The Mighty",
        "Al-Karim": "The Generous",
        "Ar-Raqib": "The Watchful One",
        "Al-Mujib": "The Responder to Prayer",
        "Al-Wasi": "The All-Encompassing",
        "Al-Hakim": "The Perfectly Wise",
        "Al-Wadud": "The Loving One",
        "Al-Baith": "The Resurrector",
        "Ash-Shahid": "The Witness",
        "Al-Haqq": "The Truth",
        "Al-Wakil": "The Trustee",
        "Al-Qawi": "The Strong",
        "Al-Matin": "The Firm",
        "Al-Hamid": "The Praiseworthy",
        "Al-Muhsi": "The Accounter of All",
        "Al-Mubdi": "The Originator",
        "Al-Muid": "The Restorer",
        "Al-Muhyi": "The Giver of Life",
        "Al-Mumit": "The Taker of Life",
        "Al-Hayy": "The Living",
        "Al-Qayyum": "The Self-Subsisting",
        "Al-Wajid": "The Perceiver",
        "Al-Majid": "The Illustrious",
        "Al-Wahid": "The One",
        "Al-Ahad": "The One",
        "As-Samad": "The Eternal Refuge",
        "Al-Qadir": "The Powerful",
        "Al-Muqtadir": "The Determiner of All",
        "Al-Muqaddim": "The Expediter",
        "Al-Muakhkhir": "The Delayer",
        "Al-Awwal": "The First",
        "Al-Akhir": "The Last",
        "Az-Zahir": "The Manifest",
        "Al-Batin": "The Hidden",
        "Al-Wali": "The Protecting Friend",
        "Al-Mutaali": "The Supreme",
        "Al-Barr": "The Kind",
        "At-Tawwab": "The Ever-Returning",
        "Al-Muntaqim": "The Avenger",
        "Al-Afuww": "The Pardoner",
        "Ar-Rauf": "The Compassionate",
        "Malik-ul-Mulk": "The Owner of All",
        "Dhu-l-Jalal wa-l-Ikram": "The Lord of Majesty and Bounty",
        "Al-Muqsit": "The Equitable",
        "Al-Jami": "The Gatherer",
        "Al-Ghani": "The Self-Sufficient",
        "Al-Mughni": "The Enricher",
        "Al-Mani": "The Preventer of Harm",
        "Ad-Darr": "The Creator of The Harmful",
        "An-Nafi": "The Creator of Good",
        "An-Nur": "The Light",
        "Al-Hadi": "The Guide",
        "Al-Badi": "The Incomparable",
        "Al-Baqi": "The Everlasting",
        "Al-Warith": "The Inheritor of All",
        "Ar-Rashid": "The Righteous Teacher",
        "As-Sabur": "The Patient"
    ]
        
        @State private var userTypedNames = [String]()
        @State private var revealedName: String?
        @State private var revealedCharacters = 0
        @State private var inputText = ""
        @State private var showingAlert = false
        @State private var selectedExplanation = ""
        
        @State private var correctGuesses = 0
        @State private var totalGuesses = 0
        @State private var startTime = Date()
        @State private var elapsedTime: TimeInterval = 0
        @State private var earnedTime: TimeInterval = 0
        @State private var lastCorrectTimestamp: Date?
        @State private var points = 0
        @State private var isQuizEnded = false
        @State private var isDefinitionQuizActive = false
        
        @State private var gameLogs = [String]()
        
        var body: some View {
            VStack {
                if isDefinitionQuizActive {
                    DefinitionsQuizView(userTypedNames: $userTypedNames, names: names, points: $points, gameLogs: $gameLogs)
                } else {
                    if !isQuizEnded {
                        Text("99 Names of Allah Quiz")
                            .font(.largeTitle)
                            .padding()
                        
                        Text("Elapsed Time: \(elapsedTime, specifier: "%.1f")s")
                        Text("Earned Time: \(earnedTime, specifier: "%.1f")s")
                        Text("Points: \(points)")
                        
                        TextField("Enter a name", text: $inputText, onCommit: {
                            handleUserInput()
                        })
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        if let revealedName = revealedName {
                            Text("Guess the name: \(revealedName.prefix(revealedCharacters))")
                        }
                        
                        List(userTypedNames, id: \.self) { name in
                            Text(name)
                        }
                        
                        Button("Quit") {
                            endQuiz()
                        }
                    } else {
                        Text("Quiz Ended")
                            .font(.title)
                            .padding()
                        
                        List(gameLogs, id: \.self) { log in
                            Text(log)
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                startQuiz()
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if !isQuizEnded && !isDefinitionQuizActive {
                    updateElapsedTime()
                    revealNextLetter()
                }
            }
        }
        
        func startQuiz() {
            startTime = Date()
            revealedName = getNextRevealedName()
        }
        
        func updateElapsedTime() {
            elapsedTime = Date().timeIntervalSince(startTime)
            earnedTime = elapsedTime * 10
        }
        
        func handleUserInput() {
            let input = inputText
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
                .replacingOccurrences(of: "-", with: "")
            
            inputText = ""
            
            if let currentRevealedName = revealedName {
                let normalizedName = currentRevealedName
                    .lowercased()
                    .replacingOccurrences(of: "-", with: "")
                
                if input == normalizedName {
                    if !userTypedNames.contains(currentRevealedName) {
                        userTypedNames.append(currentRevealedName)
                        correctGuesses += 1
                        points += calculatePoints(for: currentRevealedName)
                        
                        if let lastTimestamp = lastCorrectTimestamp {
                            let timeDiff = Date().timeIntervalSince(lastTimestamp)
                            if timeDiff <= 4 {
                                points += 10 * calculatePoints(for: currentRevealedName)
                            } else if timeDiff <= 8 {
                                points += 5 * calculatePoints(for: currentRevealedName)
                            }
                        }
                        
                        lastCorrectTimestamp = Date()
                        
                        // Log the correct guess
                        logGameData(name: currentRevealedName, definition: names[currentRevealedName] ?? "")
                        
                        self.revealedName = getNextRevealedName()
                        revealedCharacters = 0
                    }
                }
            }
            
            totalGuesses += 1
        }
        
        func calculatePoints(for name: String) -> Int {
            if revealedCharacters == name.count {
                return 2
            } else {
                return 5
            }
        }
        
        func revealNextLetter() {
            guard let name = revealedName else { return }
            
            if revealedCharacters < name.count {
                revealedCharacters += 1
            }
        }
        
        func getNextRevealedName() -> String? {
            let availableNames = names.keys.filter { !userTypedNames.contains($0) }
            return availableNames.randomElement()
        }
        
        func endQuiz() {
            isQuizEnded = true
            isDefinitionQuizActive = true
        }
        
        func logGameData(name: String, definition: String) {
            let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
            let logEntry = "Name: \(name), Definition: \(definition), Timestamp: \(timestamp)"
            gameLogs.append(logEntry)
        }
    }

    struct DefinitionsQuizView: View {
        @Binding var userTypedNames: [String]
        var names: [String: String]
        @Binding var points: Int
        @Binding var gameLogs: [String]
        @State private var currentQuestionIndex = 0
        @State private var userAnswer = ""
        @State private var score = 0
        @State private var quizEnded = false
        
        var body: some View {
            VStack {
                if quizEnded {
                    Text("Definitions Quiz Ended")
                        .font(.title)
                        .padding()
                    Text("Final Score: \(score)")
                        .font(.title2)
                        .padding()
                    
                    List(gameLogs, id: \.self) { log in
                        Text(log)
                    }
                } else {
                    let currentQuestion = userTypedNames[currentQuestionIndex]
                    
                    Text("Definition of \(currentQuestion):")
                        .font(.headline)
                        .padding()
                    
                    // Removed the visible definition
                    // Text(definition)
                    //     .padding()
                    
                    TextField("Enter your answer", text: $userAnswer)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button("Submit") {
                        checkAnswer()
                    }
                    .padding()
                    
                    Button("Next") {
                        nextQuestion()
                    }
                    .padding()
                }
            }
            .padding()
        }
        
        func checkAnswer() {
            let currentQuestion = userTypedNames[currentQuestionIndex]
            let correctAnswer = names[currentQuestion] ?? ""
            if userAnswer.lowercased() == correctAnswer.lowercased() {
                score += 1
            }
            userAnswer = ""
        }
        
        func nextQuestion() {
            currentQuestionIndex += 1
            if currentQuestionIndex >= userTypedNames.count {
                quizEnded = true
            }
        }
    }

    @main
    struct NamesOfAllahQuizApp: App {
        var body: some Scene {
            WindowGroup {
                ContentView()
            }
        }
    }
