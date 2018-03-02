From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:34 +0100
Subject: [PATCH 26/52] mtd: rawnand: marvell: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-27-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 201 +++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 97 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index cc21f9633edd..d7765445246f 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2284,6 +2284,107 @@ static int marvell_nfc_setup_data_interface(struct mtd_info *mtd, int chipnr,
 	return 0;
 }
 
+static int marvell_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct marvell_nand_chip *marvell_nand = to_marvell_nand(chip);
+	struct marvell_nfc *nfc = to_marvell_nfc(chip->controller);
+	struct pxa3xx_nand_platform_data *pdata = dev_get_platdata(nfc->dev);
+	int ret;
+
+	if (pdata && pdata->flash_bbt)
+		chip->bbt_options |= NAND_BBT_USE_FLASH;
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
+		/*
+		 * We'll use a bad block table stored in-flash and don't
+		 * allow writing the bad block marker to the flash.
+		 */
+		chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+	}
+
+	/* Save the chip-specific fields of NDCR */
+	marvell_nand->ndcr = NDCR_PAGE_SZ(mtd->writesize);
+	if (chip->options & NAND_BUSWIDTH_16)
+		marvell_nand->ndcr |= NDCR_DWIDTH_M | NDCR_DWIDTH_C;
+
+	/*
+	 * On small page NANDs, only one cycle is needed to pass the
+	 * column address.
+	 */
+	if (mtd->writesize <= 512) {
+		marvell_nand->addr_cyc = 1;
+	} else {
+		marvell_nand->addr_cyc = 2;
+		marvell_nand->ndcr |= NDCR_RA_START;
+	}
+
+	/*
+	 * Now add the number of cycles needed to pass the row
+	 * address.
+	 *
+	 * Addressing a chip using CS 2 or 3 should also need the third row
+	 * cycle but due to inconsistance in the documentation and lack of
+	 * hardware to test this situation, this case is not supported.
+	 */
+	if (chip->options & NAND_ROW_ADDR_3)
+		marvell_nand->addr_cyc += 3;
+	else
+		marvell_nand->addr_cyc += 2;
+
+	if (pdata) {
+		chip->ecc.size = pdata->ecc_step_size;
+		chip->ecc.strength = pdata->ecc_strength;
+	}
+
+	ret = marvell_nand_ecc_init(mtd, &chip->ecc);
+	if (ret) {
+		dev_err(nfc->dev, "ECC init failed: %d\n", ret);
+		return ret;
+	}
+
+	if (chip->ecc.mode == NAND_ECC_HW) {
+		/*
+		 * Subpage write not available with hardware ECC, prohibit also
+		 * subpage read as in userspace subpage access would still be
+		 * allowed and subpage write, if used, would lead to numerous
+		 * uncorrectable ECC errors.
+		 */
+		chip->options |= NAND_NO_SUBPAGE_WRITE;
+	}
+
+	if (pdata || nfc->caps->legacy_of_bindings) {
+		/*
+		 * We keep the MTD name unchanged to avoid breaking platforms
+		 * where the MTD cmdline parser is used and the bootloader
+		 * has not been updated to use the new naming scheme.
+		 */
+		mtd->name = "pxa3xx_nand-0";
+	} else if (!mtd->name) {
+		/*
+		 * If the new bindings are used and the bootloader has not been
+		 * updated to pass a new mtdparts parameter on the cmdline, you
+		 * should define the following property in your NAND node, ie:
+		 *
+		 *	label = "main-storage";
+		 *
+		 * This way, mtd->name will be set by the core when
+		 * nand_set_flash_node() is called.
+		 */
+		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
+					   "%s:nand.%d", dev_name(nfc->dev),
+					   marvell_nand->sels[0].cs);
+		if (!mtd->name) {
+			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
 static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 				  struct device_node *np)
 {
@@ -2435,105 +2536,11 @@ static int marvell_nand_chip_init(struct device *dev, struct marvell_nfc *nfc,
 	marvell_nand->ndtr1 = readl_relaxed(nfc->regs + NDTR1);
 
 	chip->options |= NAND_BUSWIDTH_AUTO;
-	ret = nand_scan_ident(mtd, marvell_nand->nsels, NULL);
-	if (ret) {
-		dev_err(dev, "could not identify the nand chip\n");
-		return ret;
-	}
-
-	if (pdata && pdata->flash_bbt)
-		chip->bbt_options |= NAND_BBT_USE_FLASH;
-
-	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
-		/*
-		 * We'll use a bad block table stored in-flash and don't
-		 * allow writing the bad block marker to the flash.
-		 */
-		chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
-		chip->bbt_td = &bbt_main_descr;
-		chip->bbt_md = &bbt_mirror_descr;
-	}
-
-	/* Save the chip-specific fields of NDCR */
-	marvell_nand->ndcr = NDCR_PAGE_SZ(mtd->writesize);
-	if (chip->options & NAND_BUSWIDTH_16)
-		marvell_nand->ndcr |= NDCR_DWIDTH_M | NDCR_DWIDTH_C;
-
-	/*
-	 * On small page NANDs, only one cycle is needed to pass the
-	 * column address.
-	 */
-	if (mtd->writesize <= 512) {
-		marvell_nand->addr_cyc = 1;
-	} else {
-		marvell_nand->addr_cyc = 2;
-		marvell_nand->ndcr |= NDCR_RA_START;
-	}
-
-	/*
-	 * Now add the number of cycles needed to pass the row
-	 * address.
-	 *
-	 * Addressing a chip using CS 2 or 3 should also need the third row
-	 * cycle but due to inconsistance in the documentation and lack of
-	 * hardware to test this situation, this case is not supported.
-	 */
-	if (chip->options & NAND_ROW_ADDR_3)
-		marvell_nand->addr_cyc += 3;
-	else
-		marvell_nand->addr_cyc += 2;
-
-	if (pdata) {
-		chip->ecc.size = pdata->ecc_step_size;
-		chip->ecc.strength = pdata->ecc_strength;
-	}
-
-	ret = marvell_nand_ecc_init(mtd, &chip->ecc);
-	if (ret) {
-		dev_err(dev, "ECC init failed: %d\n", ret);
-		return ret;
-	}
-
-	if (chip->ecc.mode == NAND_ECC_HW) {
-		/*
-		 * Subpage write not available with hardware ECC, prohibit also
-		 * subpage read as in userspace subpage access would still be
-		 * allowed and subpage write, if used, would lead to numerous
-		 * uncorrectable ECC errors.
-		 */
-		chip->options |= NAND_NO_SUBPAGE_WRITE;
-	}
-
-	if (pdata || nfc->caps->legacy_of_bindings) {
-		/*
-		 * We keep the MTD name unchanged to avoid breaking platforms
-		 * where the MTD cmdline parser is used and the bootloader
-		 * has not been updated to use the new naming scheme.
-		 */
-		mtd->name = "pxa3xx_nand-0";
-	} else if (!mtd->name) {
-		/*
-		 * If the new bindings are used and the bootloader has not been
-		 * updated to pass a new mtdparts parameter on the cmdline, you
-		 * should define the following property in your NAND node, ie:
-		 *
-		 *	label = "main-storage";
-		 *
-		 * This way, mtd->name will be set by the core when
-		 * nand_set_flash_node() is called.
-		 */
-		mtd->name = devm_kasprintf(nfc->dev, GFP_KERNEL,
-					   "%s:nand.%d", dev_name(nfc->dev),
-					   marvell_nand->sels[0].cs);
-		if (!mtd->name) {
-			dev_err(nfc->dev, "Failed to allocate mtd->name\n");
-			return -ENOMEM;
-		}
-	}
 
-	ret = nand_scan_tail(mtd);
+	chip->ecc.attach_chip = marvell_nand_attach_chip;
+	ret = nand_scan(mtd, marvell_nand->nsels);
 	if (ret) {
-		dev_err(dev, "nand_scan_tail failed: %d\n", ret);
+		dev_err(dev, "could not scan the nand chip\n");
 		return ret;
 	}
 
-- 
2.14.1
