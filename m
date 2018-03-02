From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:17 +0100
Subject: [PATCH 09/52] mtd: rawnand: davinci: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-10-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Also change the unused "struct device *dev" parameter of the driver
structure into a platform device to reuse it in the ->attach_chip()
hook.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/davinci_nand.c | 186 +++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 88 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index b5c107f8dc53..21dc67089335 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -54,7 +54,7 @@
 struct davinci_nand_info {
 	struct nand_chip	chip;
 
-	struct device		*dev;
+	struct platform_device	*pdev;
 	struct clk		*clk;
 
 	bool			is_readmode;
@@ -608,6 +608,100 @@ static struct davinci_nand_pdata
 }
 #endif
 
+static int davinci_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct davinci_nand_info *info = to_davinci_nand(mtd);
+	struct davinci_nand_pdata *pdata = nand_davinci_get_pdata(info->pdev);
+	int ret = 0;
+
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	switch (info->chip.ecc.mode) {
+	case NAND_ECC_NONE:
+		pdata->ecc_bits = 0;
+		break;
+	case NAND_ECC_SOFT:
+		pdata->ecc_bits = 0;
+		/*
+		 * This driver expects Hamming based ECC when ecc_mode is set
+		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
+		 * avoid adding an extra ->ecc_algo field to
+		 * davinci_nand_pdata.
+		 */
+		info->chip.ecc.algo = NAND_ECC_HAMMING;
+		break;
+	case NAND_ECC_HW:
+		if (pdata->ecc_bits == 4) {
+			/*
+			 * No sanity checks:  CPUs must support this,
+			 * and the chips may not use NAND_BUSWIDTH_16.
+			 */
+
+			/* No sharing 4-bit hardware between chipselects yet */
+			spin_lock_irq(&davinci_nand_lock);
+			if (ecc4_busy)
+				ret = -EBUSY;
+			else
+				ecc4_busy = true;
+			spin_unlock_irq(&davinci_nand_lock);
+
+			if (ret == -EBUSY)
+				return ret;
+
+			info->chip.ecc.calculate = nand_davinci_calculate_4bit;
+			info->chip.ecc.correct = nand_davinci_correct_4bit;
+			info->chip.ecc.hwctl = nand_davinci_hwctl_4bit;
+			info->chip.ecc.bytes = 10;
+			info->chip.ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
+			info->chip.ecc.algo = NAND_ECC_BCH;
+		} else {
+			/* 1bit ecc hamming */
+			info->chip.ecc.calculate = nand_davinci_calculate_1bit;
+			info->chip.ecc.correct = nand_davinci_correct_1bit;
+			info->chip.ecc.hwctl = nand_davinci_hwctl_1bit;
+			info->chip.ecc.bytes = 3;
+			info->chip.ecc.algo = NAND_ECC_HAMMING;
+		}
+		info->chip.ecc.size = 512;
+		info->chip.ecc.strength = pdata->ecc_bits;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Update ECC layout if needed ... for 1-bit HW ECC, the default
+	 * is OK, but it allocates 6 bytes when only 3 are needed (for
+	 * each 512 bytes).  For the 4-bit HW ECC, that default is not
+	 * usable:  10 bytes are needed, not 6.
+	 */
+	if (pdata->ecc_bits == 4) {
+		int chunks = mtd->writesize / 512;
+
+		if (!chunks || mtd->oobsize < 16) {
+			dev_dbg(&info->pdev->dev, "too small\n");
+			return -EINVAL;
+		}
+
+		/* For small page chips, preserve the manufacturer's
+		 * badblock marking data ... and make sure a flash BBT
+		 * table marker fits in the free bytes.
+		 */
+		if (chunks == 1) {
+			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
+		} else if (chunks == 4 || chunks == 8) {
+			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
+			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
+		} else {
+			return -EIO;
+		}
+	}
+
+	return ret;
+}
+
 static int nand_davinci_probe(struct platform_device *pdev)
 {
 	struct davinci_nand_pdata	*pdata;
@@ -661,7 +755,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	info->dev		= &pdev->dev;
+	info->pdev		= pdev;
 	info->base		= base;
 	info->vaddr		= vaddr;
 
@@ -729,97 +823,13 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	spin_unlock_irq(&davinci_nand_lock);
 
 	/* Scan to find existence of the device(s) */
-	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
+	info->chip.ecc.attach_chip = davinci_nand_attach_chip;
+	ret = nand_scan(mtd, pdata->mask_chipsel ? 2 : 1);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
 		goto err;
 	}
 
-	switch (info->chip.ecc.mode) {
-	case NAND_ECC_NONE:
-		pdata->ecc_bits = 0;
-		break;
-	case NAND_ECC_SOFT:
-		pdata->ecc_bits = 0;
-		/*
-		 * This driver expects Hamming based ECC when ecc_mode is set
-		 * to NAND_ECC_SOFT. Force ecc.algo to NAND_ECC_HAMMING to
-		 * avoid adding an extra ->ecc_algo field to
-		 * davinci_nand_pdata.
-		 */
-		info->chip.ecc.algo = NAND_ECC_HAMMING;
-		break;
-	case NAND_ECC_HW:
-		if (pdata->ecc_bits == 4) {
-			/* No sanity checks:  CPUs must support this,
-			 * and the chips may not use NAND_BUSWIDTH_16.
-			 */
-
-			/* No sharing 4-bit hardware between chipselects yet */
-			spin_lock_irq(&davinci_nand_lock);
-			if (ecc4_busy)
-				ret = -EBUSY;
-			else
-				ecc4_busy = true;
-			spin_unlock_irq(&davinci_nand_lock);
-
-			if (ret == -EBUSY)
-				return ret;
-
-			info->chip.ecc.calculate = nand_davinci_calculate_4bit;
-			info->chip.ecc.correct = nand_davinci_correct_4bit;
-			info->chip.ecc.hwctl = nand_davinci_hwctl_4bit;
-			info->chip.ecc.bytes = 10;
-			info->chip.ecc.options = NAND_ECC_GENERIC_ERASED_CHECK;
-			info->chip.ecc.algo = NAND_ECC_BCH;
-		} else {
-			/* 1bit ecc hamming */
-			info->chip.ecc.calculate = nand_davinci_calculate_1bit;
-			info->chip.ecc.correct = nand_davinci_correct_1bit;
-			info->chip.ecc.hwctl = nand_davinci_hwctl_1bit;
-			info->chip.ecc.bytes = 3;
-			info->chip.ecc.algo = NAND_ECC_HAMMING;
-		}
-		info->chip.ecc.size = 512;
-		info->chip.ecc.strength = pdata->ecc_bits;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Update ECC layout if needed ... for 1-bit HW ECC, the default
-	 * is OK, but it allocates 6 bytes when only 3 are needed (for
-	 * each 512 bytes).  For the 4-bit HW ECC, that default is not
-	 * usable:  10 bytes are needed, not 6.
-	 */
-	if (pdata->ecc_bits == 4) {
-		int	chunks = mtd->writesize / 512;
-
-		if (!chunks || mtd->oobsize < 16) {
-			dev_dbg(&pdev->dev, "too small\n");
-			ret = -EINVAL;
-			goto err;
-		}
-
-		/* For small page chips, preserve the manufacturer's
-		 * badblock marking data ... and make sure a flash BBT
-		 * table marker fits in the free bytes.
-		 */
-		if (chunks == 1) {
-			mtd_set_ooblayout(mtd, &hwecc4_small_ooblayout_ops);
-		} else if (chunks == 4 || chunks == 8) {
-			mtd_set_ooblayout(mtd, &nand_ooblayout_lp_ops);
-			info->chip.ecc.mode = NAND_ECC_HW_OOB_FIRST;
-		} else {
-			ret = -EIO;
-			goto err;
-		}
-	}
-
-	ret = nand_scan_tail(mtd);
-	if (ret < 0)
-		goto err;
-
 	if (pdata->parts)
 		ret = mtd_device_parse_register(mtd, NULL, NULL,
 					pdata->parts, pdata->nr_parts);
-- 
2.14.1
