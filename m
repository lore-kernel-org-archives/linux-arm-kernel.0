From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 20 Jul 2018 17:14:55 +0200
Subject: [PATCH v4 03/35] mtd: rawnand: davinci: convert driver to nand_scan()
In-Reply-To: <20180720151527.16038-1-miquel.raynal@bootlin.com>
References: <20180720151527.16038-1-miquel.raynal@bootlin.com>
Message-ID: <20180720151527.16038-4-miquel.raynal@bootlin.com>
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
 drivers/mtd/nand/raw/davinci_nand.c | 195 +++++++++++++++++++-----------------
 1 file changed, 102 insertions(+), 93 deletions(-)

diff --git a/drivers/mtd/nand/raw/davinci_nand.c b/drivers/mtd/nand/raw/davinci_nand.c
index 626c9363e460..40145e206a6b 100644
--- a/drivers/mtd/nand/raw/davinci_nand.c
+++ b/drivers/mtd/nand/raw/davinci_nand.c
@@ -53,7 +53,7 @@
 struct davinci_nand_info {
 	struct nand_chip	chip;
 
-	struct device		*dev;
+	struct platform_device	*pdev;
 
 	bool			is_readmode;
 
@@ -605,6 +605,104 @@ static struct davinci_nand_pdata
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
+static const struct nand_controller_ops davinci_nand_controller_ops = {
+	.attach_chip = davinci_nand_attach_chip,
+};
+
 static int nand_davinci_probe(struct platform_device *pdev)
 {
 	struct davinci_nand_pdata	*pdata;
@@ -658,7 +756,7 @@ static int nand_davinci_probe(struct platform_device *pdev)
 		return -EADDRNOTAVAIL;
 	}
 
-	info->dev		= &pdev->dev;
+	info->pdev		= pdev;
 	info->base		= base;
 	info->vaddr		= vaddr;
 
@@ -708,97 +806,13 @@ static int nand_davinci_probe(struct platform_device *pdev)
 	spin_unlock_irq(&davinci_nand_lock);
 
 	/* Scan to find existence of the device(s) */
-	ret = nand_scan_ident(mtd, pdata->mask_chipsel ? 2 : 1, NULL);
+	info->chip.dummy_controller.ops = &davinci_nand_controller_ops;
+	ret = nand_scan(mtd, pdata->mask_chipsel ? 2 : 1);
 	if (ret < 0) {
 		dev_dbg(&pdev->dev, "no NAND chip(s) found\n");
 		return ret;
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
 		ret = mtd_device_register(mtd, pdata->parts, pdata->nr_parts);
 	else
@@ -815,11 +829,6 @@ static int nand_davinci_probe(struct platform_device *pdev)
 err_cleanup_nand:
 	nand_cleanup(&info->chip);
 
-err:
-	spin_lock_irq(&davinci_nand_lock);
-	if (info->chip.ecc.mode == NAND_ECC_HW_SYNDROME)
-		ecc4_busy = false;
-	spin_unlock_irq(&davinci_nand_lock);
 	return ret;
 }
 
-- 
2.14.1
