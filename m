From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:11 +0100
Subject: [PATCH 03/52] mtd: rawnand: bf5xx: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-4-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/bf5xx_nand.c | 48 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/raw/bf5xx_nand.c b/drivers/mtd/nand/raw/bf5xx_nand.c
index da7a6083b0e5..bc42bccf1beb 100644
--- a/drivers/mtd/nand/raw/bf5xx_nand.c
+++ b/drivers/mtd/nand/raw/bf5xx_nand.c
@@ -697,33 +697,31 @@ static int bf5xx_nand_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static int bf5xx_nand_scan(struct mtd_info *mtd)
+static int bf5xx_nand_attach_chip(struct nand_chip *chip)
 {
-	struct nand_chip *chip = mtd_to_nand(mtd);
-	int ret;
+	struct mtd_info *mtd = nand_to_mtd(chip);
 
-	ret = nand_scan_ident(mtd, 1, NULL);
-	if (ret)
-		return ret;
+	if (!hardware_ecc)
+		return 0;
 
-	if (hardware_ecc) {
-		/*
-		 * for nand with page size > 512B, think it as several sections with 512B
-		 */
-		if (likely(mtd->writesize >= 512)) {
-			chip->ecc.size = 512;
-			chip->ecc.bytes = 6;
-			chip->ecc.strength = 2;
-		} else {
-			chip->ecc.size = 256;
-			chip->ecc.bytes = 3;
-			chip->ecc.strength = 1;
-			bfin_write_NFC_CTL(bfin_read_NFC_CTL() & ~(1 << NFC_PG_SIZE_OFFSET));
-			SSYNC();
-		}
+	/*
+	 * For NAND with page size > 512B, it is like if it had several sections
+	 * of 512B.
+	 */
+	if (likely(mtd->writesize >= 512)) {
+		chip->ecc.size = 512;
+		chip->ecc.bytes = 6;
+		chip->ecc.strength = 2;
+	} else {
+		chip->ecc.size = 256;
+		chip->ecc.bytes = 3;
+		chip->ecc.strength = 1;
+		bfin_write_NFC_CTL(bfin_read_NFC_CTL() &
+				   ~(1 << NFC_PG_SIZE_OFFSET));
+		SSYNC();
 	}
 
-	return	nand_scan_tail(mtd);
+	return 0;
 }
 
 /*
@@ -821,10 +819,10 @@ static int bf5xx_nand_probe(struct platform_device *pdev)
 	}
 
 	/* scan hardware nand chip and setup mtd info data struct */
-	if (bf5xx_nand_scan(mtd)) {
-		err = -ENXIO;
+	chip->ecc.attach_chip = bf5xx_nand_attach_chip;
+	err = nand_scan(mtd, 1);
+	if (err)
 		goto out_err_nand_scan;
-	}
 
 #ifdef CONFIG_MTD_NAND_BF5XX_BOOTROM_ECC
 	chip->badblockpos = 63;
-- 
2.14.1
