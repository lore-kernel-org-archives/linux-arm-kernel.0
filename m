From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon,  7 Dec 2015 23:26:16 +0100
Subject: [PATCH 21/23] staging: mt29f_spinand: switch to mtd_ooblayout_ops
In-Reply-To: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1449527178-5930-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1449527178-5930-22-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 44 ++++++++++++++++-----------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index cb9d5ab..967d50a 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -42,23 +42,29 @@ static inline struct spinand_state *mtd_to_state(struct mtd_info *mtd)
 static int enable_hw_ecc;
 static int enable_read_hw_ecc;
 
-static struct nand_ecclayout spinand_oob_64 = {
-	.eccbytes = 24,
-	.eccpos = {
-		1, 2, 3, 4, 5, 6,
-		17, 18, 19, 20, 21, 22,
-		33, 34, 35, 36, 37, 38,
-		49, 50, 51, 52, 53, 54, },
-	.oobfree = {
-		{.offset = 8,
-			.length = 8},
-		{.offset = 24,
-			.length = 8},
-		{.offset = 40,
-			.length = 8},
-		{.offset = 56,
-			.length = 8},
-	}
+static int spinand_oob_64_eccpos(struct mtd_info *mtd, int eccbyte)
+{
+	if (eccbyte > 23)
+		return -ERANGE;
+
+	return ((eccbyte / 6) * 16) + 1;
+}
+
+static int spinand_oob_64_oobfree(struct mtd_info *mtd, int section,
+				  struct nand_oobfree *oobfree)
+{
+	if (section > 3)
+		return -ERANGE;
+
+	oobfree->offset = (section * 16) + 8;
+	oobfree->length = 8;
+
+	return 0;
+}
+
+const struct mtd_ooblayout_ops spinand_oob_64_ops = {
+	.eccpos = spinand_oob_64_eccpos,
+	.oobfree = spinand_oob_64_oobfree,
 };
 #endif
 
@@ -883,7 +889,6 @@ static int spinand_probe(struct spi_device *spi_nand)
 
 	chip->ecc.strength = 1;
 	chip->ecc.total	= chip->ecc.steps * chip->ecc.bytes;
-	chip->ecc.layout = &spinand_oob_64;
 	chip->ecc.read_page = spinand_read_page_hwecc;
 	chip->ecc.write_page = spinand_write_page_hwecc;
 #else
@@ -911,6 +916,9 @@ static int spinand_probe(struct spi_device *spi_nand)
 	mtd->priv = chip;
 	mtd->dev.parent = &spi_nand->dev;
 	mtd->oobsize = 64;
+#ifdef CONFIG_MTD_SPINAND_ONDIEECC
+	mtd_set_ooblayout(mtd, &spinand_oob_64_ops);
+#endif
 
 	if (nand_scan(mtd, 1))
 		return -ENXIO;
-- 
2.1.4
