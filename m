From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:49 +0100
Subject: [PATCH 41/52] mtd: rawnand: txx9ndfmc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-42-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/txx9ndfmc.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/nand/raw/txx9ndfmc.c b/drivers/mtd/nand/raw/txx9ndfmc.c
index b567d212fe7d..5c20219bca98 100644
--- a/drivers/mtd/nand/raw/txx9ndfmc.c
+++ b/drivers/mtd/nand/raw/txx9ndfmc.c
@@ -254,21 +254,17 @@ static void txx9ndfmc_initialize(struct platform_device *dev)
 #define TXX9NDFMC_NS_TO_CYC(gbusclk, ns) \
 	DIV_ROUND_UP((ns) * DIV_ROUND_UP(gbusclk, 1000), 1000000)
 
-static int txx9ndfmc_nand_scan(struct mtd_info *mtd)
+static int txx9ndfmc_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (!ret) {
-		if (mtd->writesize >= 512) {
-			/* Hardware ECC 6 byte ECC per 512 Byte data */
-			chip->ecc.size = 512;
-			chip->ecc.bytes = 6;
-		}
-		ret = nand_scan_tail(mtd);
+	if (mtd->writesize >= 512) {
+		/* Hardware ECC 6 byte ECC per 512 Byte data */
+		chip->ecc.size = 512;
+		chip->ecc.bytes = 6;
 	}
-	return ret;
+
+	return 0;
 }
 
 static int __init txx9ndfmc_probe(struct platform_device *dev)
@@ -332,7 +328,7 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		chip->ecc.correct = txx9ndfmc_correct_data;
 		chip->ecc.hwctl = txx9ndfmc_enable_hwecc;
 		chip->ecc.mode = NAND_ECC_HW;
-		/* txx9ndfmc_nand_scan will overwrite ecc.size and ecc.bytes */
+		/* nand_scan() will overwrite ecc.size and ecc.bytes */
 		chip->ecc.size = 256;
 		chip->ecc.bytes = 3;
 		chip->ecc.strength = 1;
@@ -359,7 +355,8 @@ static int __init txx9ndfmc_probe(struct platform_device *dev)
 		if (plat->wide_mask & (1 << i))
 			chip->options |= NAND_BUSWIDTH_16;
 
-		if (txx9ndfmc_nand_scan(mtd)) {
+		chip->ecc.attach_chip = txx9ndfmc_attach_chip;
+		if (nand_scan(mtd, 1)) {
 			kfree(txx9_priv->mtdname);
 			kfree(txx9_priv);
 			continue;
-- 
2.14.1
