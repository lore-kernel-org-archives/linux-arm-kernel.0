From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 11:33 +0100
Subject: [PATCH] staging: goldfish: use div64_s64 instead of do_div
Message-ID: <1676170.0qik6mzm6D@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goldfish nand driver divides a signed 64-bit number (loff_t)
in multiple places using the do_div() function. This has always
been unreliable but now produces a compiler warning (since 4.5-rc1):

goldfish/goldfish_nand.c: In function 'goldfish_nand_erase':
goldfish/goldfish_nand.c:107:91: error: comparison of distinct pointer types lacks a cast [-Werror]
goldfish/goldfish_nand.c: In function 'goldfish_nand_read_oob':
goldfish/goldfish_nand.c:145:91: error: comparison of distinct pointer types lacks a cast [-Werror]

This changes the code to the equivalent div_s64{,_rem} that
works correctly for negative numbers (which we should never
get here).

The warning has shown up on ARM allmodconfig builds after the goldfish
bus driver has become visible on ARM.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: bd2f348db503 ("goldfish: refactor goldfish platform configs")

diff --git a/drivers/staging/goldfish/goldfish_nand.c b/drivers/staging/goldfish/goldfish_nand.c
index f223b3a5a428..76d60eed1490 100644
--- a/drivers/staging/goldfish/goldfish_nand.c
+++ b/drivers/staging/goldfish/goldfish_nand.c
@@ -100,11 +100,11 @@ static int goldfish_nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
 	loff_t ofs = instr->addr;
 	u32 len = instr->len;
-	u32 rem;
+	s32 rem;
 
 	if (ofs + len > mtd->size)
 		goto invalid_arg;
-	rem = do_div(ofs, mtd->writesize);
+	ofs = div_s64_rem(ofs, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	ofs *= (mtd->writesize + mtd->oobsize);
@@ -133,7 +133,7 @@ invalid_arg:
 static int goldfish_nand_read_oob(struct mtd_info *mtd, loff_t ofs,
 				  struct mtd_oob_ops *ops)
 {
-	u32 rem;
+	s32 rem;
 
 	if (ofs + ops->len > mtd->size)
 		goto invalid_arg;
@@ -142,7 +142,7 @@ static int goldfish_nand_read_oob(struct mtd_info *mtd, loff_t ofs,
 	if (ops->ooblen + ops->ooboffs > mtd->oobsize)
 		goto invalid_arg;
 
-	rem = do_div(ofs, mtd->writesize);
+	ofs = div_s64_rem(ofs, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	ofs *= (mtd->writesize + mtd->oobsize);
@@ -165,7 +165,7 @@ invalid_arg:
 static int goldfish_nand_write_oob(struct mtd_info *mtd, loff_t ofs,
 				   struct mtd_oob_ops *ops)
 {
-	u32 rem;
+	s32 rem;
 
 	if (ofs + ops->len > mtd->size)
 		goto invalid_arg;
@@ -174,7 +174,7 @@ static int goldfish_nand_write_oob(struct mtd_info *mtd, loff_t ofs,
 	if (ops->ooblen + ops->ooboffs > mtd->oobsize)
 		goto invalid_arg;
 
-	rem = do_div(ofs, mtd->writesize);
+	ofs = div_s64_rem(ofs, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	ofs *= (mtd->writesize + mtd->oobsize);
@@ -197,12 +197,12 @@ invalid_arg:
 static int goldfish_nand_read(struct mtd_info *mtd, loff_t from, size_t len,
 			      size_t *retlen, u_char *buf)
 {
-	u32 rem;
+	s32 rem;
 
 	if (from + len > mtd->size)
 		goto invalid_arg;
 
-	rem = do_div(from, mtd->writesize);
+	from = div_s64_rem(from, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	from *= (mtd->writesize + mtd->oobsize);
@@ -219,12 +219,12 @@ invalid_arg:
 static int goldfish_nand_write(struct mtd_info *mtd, loff_t to, size_t len,
 			       size_t *retlen, const u_char *buf)
 {
-	u32 rem;
+	s32 rem;
 
 	if (to + len > mtd->size)
 		goto invalid_arg;
 
-	rem = do_div(to, mtd->writesize);
+	to = div_s64_rem(to, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	to *= (mtd->writesize + mtd->oobsize);
@@ -240,12 +240,12 @@ invalid_arg:
 
 static int goldfish_nand_block_isbad(struct mtd_info *mtd, loff_t ofs)
 {
-	u32 rem;
+	s32 rem;
 
 	if (ofs >= mtd->size)
 		goto invalid_arg;
 
-	rem = do_div(ofs, mtd->erasesize);
+	ofs = div_s64_rem(ofs, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	ofs *= mtd->erasesize / mtd->writesize;
@@ -261,12 +261,12 @@ invalid_arg:
 
 static int goldfish_nand_block_markbad(struct mtd_info *mtd, loff_t ofs)
 {
-	u32 rem;
+	s32 rem;
 
 	if (ofs >= mtd->size)
 		goto invalid_arg;
 
-	rem = do_div(ofs, mtd->erasesize);
+	ofs = div_s64_rem(ofs, mtd->writesize, &rem);
 	if (rem)
 		goto invalid_arg;
 	ofs *= mtd->erasesize / mtd->writesize;
@@ -321,7 +321,7 @@ static int goldfish_nand_init_device(struct platform_device *pdev,
 	mtd->oobavail = mtd->oobsize;
 	mtd->erasesize = readl(base + NAND_DEV_ERASE_SIZE) /
 			(mtd->writesize + mtd->oobsize) * mtd->writesize;
-	do_div(mtd->size, mtd->writesize + mtd->oobsize);
+	mtd->size = div_s64(mtd->size, mtd->writesize + mtd->oobsize);
 	mtd->size *= mtd->writesize;
 	dev_dbg(&pdev->dev,
 		"goldfish nand dev%d: size %llx, page %d, extra %d, erase %d\n",
