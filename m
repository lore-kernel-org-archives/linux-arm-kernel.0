From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Mar 2015 17:51:55 +0100
Subject: [PATCH] mtd: clean up whitespace in linux/mtd/map.h
In-Reply-To: <2266200.3mx7btcFe5@wuerfel>
References: <2266200.3mx7btcFe5@wuerfel>
Message-ID: <2220416.D2kDyFWh1C@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the only comments I got for the "mtd: cfi: reduce stack size"
patch were about whitespace changes, it appears necessary to fix
up the rest of the file as well, which contains the exact same
mistakes.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The two patches can be applied in either order, or this one dropped
entirely, I don't care as long as the other patch can get merged,
or get some constructive feedback.

diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index 5f487d776411..47c59991491b 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -77,7 +77,7 @@
 /* ensure we never evaluate anything shorted than an unsigned long
  * to zero, and ensure we'll never miss the end of an comparison (bjd) */
 
-#define map_calc_words(map) ((map_bankwidth(map) + (sizeof(unsigned long)-1))/ sizeof(unsigned long))
+#define map_calc_words(map) ((map_bankwidth(map) + (sizeof(unsigned long)-1)) / sizeof(unsigned long))
 
 #ifdef CONFIG_MTD_MAP_BANK_WIDTH_8
 # ifdef map_bankwidth
@@ -181,7 +181,7 @@ static inline int map_bankwidth_supported(int w)
 	}
 }
 
-#define MAX_MAP_LONGS ( ((MAX_MAP_BANKWIDTH*8) + BITS_PER_LONG - 1) / BITS_PER_LONG )
+#define MAX_MAP_LONGS (((MAX_MAP_BANKWIDTH * 8) + BITS_PER_LONG - 1) / BITS_PER_LONG)
 
 typedef union {
 	unsigned long x[MAX_MAP_LONGS];
@@ -264,20 +264,22 @@ void unregister_mtd_chip_driver(struct mtd_chip_driver *);
 struct mtd_info *do_map_probe(const char *name, struct map_info *map);
 void map_destroy(struct mtd_info *mtd);
 
-#define ENABLE_VPP(map) do { if(map->set_vpp) map->set_vpp(map, 1); } while(0)
-#define DISABLE_VPP(map) do { if(map->set_vpp) map->set_vpp(map, 0); } while(0)
+#define ENABLE_VPP(map) do { if (map->set_vpp) map->set_vpp(map, 1); } while (0)
+#define DISABLE_VPP(map) do { if (map->set_vpp) map->set_vpp(map, 0); } while (0)
 
 #define INVALIDATE_CACHED_RANGE(map, from, size) \
-	do { if(map->inval_cache) map->inval_cache(map, from, size); } while(0)
+	do { if (map->inval_cache) map->inval_cache(map, from, size); } while (0)
 
 
 static inline int map_word_equal(struct map_info *map, map_word val1, map_word val2)
 {
 	int i;
-	for (i=0; i<map_words(map); i++) {
+
+	for (i = 0; i < map_words(map); i++) {
 		if (val1.x[i] != val2.x[i])
 			return 0;
 	}
+
 	return 1;
 }
 
@@ -286,9 +288,9 @@ static inline map_word map_word_and(struct map_info *map, map_word val1, map_wor
 	map_word r;
 	int i;
 
-	for (i=0; i<map_words(map); i++) {
+	for (i = 0; i < map_words(map); i++)
 		r.x[i] = val1.x[i] & val2.x[i];
-	}
+
 	return r;
 }
 
@@ -297,9 +299,9 @@ static inline map_word map_word_clr(struct map_info *map, map_word val1, map_wor
 	map_word r;
 	int i;
 
-	for (i=0; i<map_words(map); i++) {
+	for (i = 0; i < map_words(map); i++)
 		r.x[i] = val1.x[i] & ~val2.x[i];
-	}
+
 	return r;
 }
 
@@ -308,9 +310,9 @@ static inline map_word map_word_or(struct map_info *map, map_word val1, map_word
 	map_word r;
 	int i;
 
-	for (i=0; i<map_words(map); i++) {
+	for (i = 0; i < map_words(map); i++)
 		r.x[i] = val1.x[i] | val2.x[i];
-	}
+
 	return r;
 }
 
@@ -320,10 +322,11 @@ static inline int map_word_bitsset(struct map_info *map, map_word val1, map_word
 {
 	int i;
 
-	for (i=0; i<map_words(map); i++) {
+	for (i = 0; i < map_words(map); i++) {
 		if (val1.x[i] & val2.x[i])
 			return 1;
 	}
+
 	return 0;
 }
 
@@ -355,14 +358,16 @@ static inline map_word map_word_load_partial(struct map_info *map, map_word orig
 
 	if (map_bankwidth_is_large(map)) {
 		char *dest = (char *)&orig;
+
 		memcpy(dest+start, buf, len);
 	} else {
-		for (i=start; i < start+len; i++) {
+		for (i = start; i < start+len; i++) {
 			int bitpos;
+
 #ifdef __LITTLE_ENDIAN
-			bitpos = i*8;
+			bitpos = i * 8;
 #else /* __BIG_ENDIAN */
-			bitpos = (map_bankwidth(map)-1-i)*8;
+			bitpos = (map_bankwidth(map) - 1 - i) * 8;
 #endif
 			orig.x[0] &= ~(0xff << bitpos);
 			orig.x[0] |= (unsigned long)buf[i-start] << bitpos;
@@ -384,9 +389,10 @@ static inline map_word map_word_ff(struct map_info *map)
 
 	if (map_bankwidth(map) < MAP_FF_LIMIT) {
 		int bw = 8 * map_bankwidth(map);
+
 		r.x[0] = (1UL << bw) - 1;
 	} else {
-		for (i=0; i<map_words(map); i++)
+		for (i = 0; i < map_words(map); i++)
 			r.x[i] = ~0UL;
 	}
 	return r;
@@ -407,7 +413,7 @@ static inline map_word inline_map_read(struct map_info *map, unsigned long ofs)
 		r.x[0] = __raw_readq(map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
-		memcpy_fromio(r.x, map->virt+ofs, map->bankwidth);
+		memcpy_fromio(r.x, map->virt + ofs, map->bankwidth);
 	else
 		BUG();
 
