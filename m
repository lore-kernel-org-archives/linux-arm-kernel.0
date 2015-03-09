From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 20:34:19 +0100
Subject: [PATCH v2] MTD: cfi: reduce stack size
Message-ID: <2376719.UMjvd0rdnO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cfi_staa_write_buffers function uses a large amount of kernel stack
whenever CONFIG_MTD_MAP_BANK_WIDTH_32 is set, and that results in a
warning on ARM allmodconfig builds:

drivers/mtd/chips/cfi_cmdset_0020.c: In function 'cfi_staa_write_buffers':
drivers/mtd/chips/cfi_cmdset_0020.c:651:1: warning: the frame size of 1208 bytes is larger than 1024 bytes [-Wframe-larger-than=]

It turns out that this is largely a result of a suboptimal implementation
of map_word_andequal(). Replacing this function with a straightforward
one reduces the stack size in this function by exactly 200 bytes,
shrinks the .text segment for this file from 27648 bytes to 26608 bytes,
and makes the warning go away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index 5f487d776411..7b5841663d4f 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -314,7 +314,15 @@ static inline map_word map_word_or(struct map_info *map, map_word val1, map_word
 	return r;
 }
 
-#define map_word_andequal(m, a, b, z) map_word_equal(m, z, map_word_and(m, a, b))
+static inline int map_word_andequal(struct map_info *map, map_word val1, map_word val2, map_word val3)
+{
+	int i;
+	for (i=0; i < map_words(map); i++) {
+		if ((val1.x[i] & val2.x[i]) != val3.x[i])
+			return 0;
+	}
+	return 1;
+}
 
 static inline int map_word_bitsset(struct map_info *map, map_word val1, map_word val2)
 {
