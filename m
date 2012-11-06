From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  6 Nov 2012 22:55:28 +0100
Subject: [PATCH 3/8] mtd: uninitialized variable warning in map.h
In-Reply-To: <1352238933-4886-1-git-send-email-arnd@arndb.de>
References: <1352238933-4886-1-git-send-email-arnd@arndb.de>
Message-ID: <1352238933-4886-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The map_word_load() function initializes exactly
as many words in the buffer as required, but gcc
cannot figure this out and gives a misleading
warning. Marking the local variable as
uninitialized_var shuts up that warning.

Without this patch, building acs5k_defconfig results in:

drivers/mtd/chips/cfi_cmdset_0002.c: In function 'cfi_amdstd_panic_write':
include/linux/mtd/map.h:331:11: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]
drivers/mtd/chips/cfi_cmdset_0002.c: In function 'cfi_amdstd_write_words':
include/linux/mtd/map.h:331:11: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]
drivers/mtd/chips/cfi_cmdset_0001.c: In function 'cfi_intelext_write_words':
include/linux/mtd/map.h:331:11: warning: 'r.x[0]' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: linux-mtd at lists.infradead.org
---
 include/linux/mtd/map.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index 3595a02..e3559ba 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -328,7 +328,7 @@ static inline int map_word_bitsset(struct map_info *map, map_word val1, map_word
 
 static inline map_word map_word_load(struct map_info *map, const void *ptr)
 {
-	map_word r;
+	map_word uninitialized_var(r);
 
 	if (map_bankwidth_is_1(map))
 		r.x[0] = *(unsigned char *)ptr;
-- 
1.7.10
