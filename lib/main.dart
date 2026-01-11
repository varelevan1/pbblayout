import 'package:flutter/material.dart';

// Entry point aplikasi
void main() {
  runApp(const MyApp());
}

// Widget root aplikasi yang mengatur tema dan halaman awal
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Review',
      // Mengatur tema aplikasi dengan warna kuning (amber)
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      // Halaman utama aplikasi
      home: const FoodReviewPage(),
    );
  }
}

// Halaman utama yang menampilkan review makanan (StatefulWidget untuk menyimpan state)
class FoodReviewPage extends StatefulWidget {
  const FoodReviewPage({super.key});

  @override
  State<FoodReviewPage> createState() => _FoodReviewPageState();
}

class _FoodReviewPageState extends State<FoodReviewPage> {
  // Index untuk melacak halaman yang sedang ditampilkan
  int _currentIndex = 0;

  // List data makanan yang akan ditampilkan
  final List<FoodItem> foods = [
    FoodItem(
      name: 'KFC',
      rating: 5.0,
      imagePath: 'aset/KFC.png',
      comments: [
        Comment(
          username: 'User1',
          rating: 5,
          text: 'Ayam gorengnya sangat renyah dan bumbu meresap sempurna!',
        ),
        Comment(
          username: 'User2',
          rating: 5,
          text: 'Pelayanan cepat dan makanan selalu fresh. Puas banget!',
        ),
        Comment(
          username: 'User3',
          rating: 5,
          text: 'Porsi besar dan harganya worth it. Recommended!',
        ),
        Comment(
          username: 'User4',
          rating: 5,
          text: 'Makanan yang sangat lezat dan memuaskan. Highly recommended!',
        ),
        Comment(
          username: 'User5',
          rating: 5,
          text: 'Kualitas terbaik, selalu segar dan bergizi. Sangat bagus!',
        ),
      ],
    ),
    FoodItem(
      name: 'Bebek Bumbu Madura',
      rating: 5.0,
      imagePath: 'aset/BEBEK.png',
      comments: [
        Comment(
          username: 'User1',
          rating: 5,
          text: 'Bebek gorengnya empuk dan bumbunya khas Madura banget!',
        ),
        Comment(
          username: 'User2',
          rating: 5,
          text: 'Sambal dan lalapannya melengkapi cita rasa. Mantap!',
        ),
        Comment(
          username: 'User3',
          rating: 5,
          text: 'Dagingnya tidak amis dan teksturnya juara. Enak sekali!',
        ),
        Comment(
          username: 'User4',
          rating: 5,
          text: 'Bumbu yang pas, tekstur daging empuk. Luar biasa!',
        ),
        Comment(
          username: 'User5',
          rating: 5,
          text: 'Cita rasa autentik Madura, pasti order lagi. Sempurna!',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold: struktur dasar halaman dengan AppBar dan Body
    return Scaffold(
      // AppBar: header di bagian atas layar
      appBar: AppBar(
        elevation: 0, // Menghilangkan bayangan AppBar
        backgroundColor: Colors.grey[900], // Background gelap
        title: const Text(
          'Recipes',
          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Judul di tengah
        leading: Icon(Icons.menu, color: Colors.white), // Icon menu di kiri
      ),
      // Body: konten utama halaman
      body: Container(
        color: Colors.grey[900], // Background gelap
        // Column: menyusun widget secara vertikal
        child: Column(
          children: [
            // Expanded: membuat widget mengisi ruang yang tersedia
            Expanded(
              // PageView.builder: membuat halaman yang bisa di-swipe horizontal
              child: PageView.builder(
                // Callback ketika halaman berubah
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemCount: foods.length, // Jumlah halaman
                // Builder untuk setiap halaman
                itemBuilder: (context, index) {
                  return FoodDetailWidget(food: foods[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Model class untuk menyimpan data makanan
class FoodItem {
  final String name;        // Nama makanan
  final double rating;      // Rating makanan
  final String imagePath;   // Path gambar makanan
  final List<Comment> comments;  // List komentar user

  FoodItem({
    required this.name,
    required this.rating,
    required this.imagePath,
    required this.comments,
  });
}

// Model class untuk menyimpan data komentar
class Comment {
  final String username;    // Nama user
  final int rating;         // Rating yang diberikan user
  final String text;        // Teks komentar

  Comment({
    required this.username,
    required this.rating,
    required this.text,
  });
}

// Widget untuk menampilkan detail makanan (gambar, nama, rating, review)
class FoodDetailWidget extends StatelessWidget {
  final FoodItem food; // Data makanan yang akan ditampilkan

  const FoodDetailWidget({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SingleChildScrollView: membuat konten bisa di-scroll vertikal
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di semua sisi
        // Column: menyusun widget secara vertikal
        child: Column(
          children: [
            const SizedBox(height: 20), // Spacing vertikal
            
            // === SECTION: GAMBAR MAKANAN ===
            // Container untuk membuat gambar dengan border rounded
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.teal, // Background color
                borderRadius: BorderRadius.circular(20), // Sudut melengkung
              ),
              // ClipRRect: memotong gambar mengikuti border radius
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  food.imagePath, // Path gambar dari data
                  fit: BoxFit.cover, // Gambar memenuhi container
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // === SECTION: NAMA MAKANAN ===
            Text(
              food.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            
            // === SECTION: RATING BINTANG ===
            // Row: menyusun widget secara horizontal
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Posisi di tengah
              // List.generate: membuat 5 bintang secara dinamis
              children: List.generate(
                5,
                (index) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // === SECTION: JUDUL REVIEWS ===
            const Text(
              'Reviews',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            
            // === SECTION: LIST REVIEWS ===
            // ListView.builder: membuat list yang efisien untuk data dinamis
            ListView.builder(
              shrinkWrap: true, // ListView menyesuaikan tinggi konten
              physics: const NeverScrollableScrollPhysics(), // Disable scroll sendiri (ikut parent)
              itemCount: food.comments.length, // Jumlah item
              itemBuilder: (context, index) {
                final comment = food.comments[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  // Row: menyusun avatar dan konten secara horizontal
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start, // Align ke atas
                    children: [
                      // === USER AVATAR ===
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle, // Bentuk bulat
                        ),
                        child: const Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 12), // Spacing horizontal
                      
                      // === KONTEN KOMENTAR ===
                      // Expanded: mengisi ruang horizontal yang tersisa
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row untuk username dan rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Username
                                Text(
                                  comment.username,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // Rating bintang user
                                Row(
                                  children: List.generate(
                                    comment.rating,
                                    (i) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Teks komentar
                            Text(
                              comment.text,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              maxLines: 2, // Maksimal 2 baris
                              overflow: TextOverflow.ellipsis, // Tambahkan ... jika terlalu panjang
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            
            // === SECTION: TOMBOL RECIPE ===
            // SizedBox untuk mengatur ukuran button
            SizedBox(
              width: double.infinity, // Lebar penuh
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber[600], // Warna kuning
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Sudut melengkung
                  ),
                ),
                // Aksi ketika tombol ditekan
                onPressed: () {
                  // Menampilkan SnackBar di bawah layar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${food.name} Recipe'),
                      backgroundColor: Colors.amber[600],
                    ),
                  );
                },
                child: const Text(
                  'Recipe',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
