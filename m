From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:37 +0100
Subject: [PATCH 29/52] mtd: rawnand: mxc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-30-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/mxc_nand.c | 132 ++++++++++++++++++++--------------------
 1 file changed, 67 insertions(+), 65 deletions(-)

diff --git a/drivers/mtd/nand/raw/mxc_nand.c b/drivers/mtd/nand/raw/mxc_nand.c
index 948fe3e9d8da..585f5ce623c8 100644
--- a/drivers/mtd/nand/raw/mxc_nand.c
+++ b/drivers/mtd/nand/raw/mxc_nand.c
@@ -1703,6 +1703,70 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
 }
 #endif
 
+static int mxcnd_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct mxc_nand_host *host = nand_get_controller_data(chip);
+	struct device *dev = mtd->dev.parent;
+
+	switch (chip->ecc.mode) {
+	case NAND_ECC_HW:
+		chip->ecc.read_page = mxc_nand_read_page;
+		chip->ecc.read_page_raw = mxc_nand_read_page_raw;
+		chip->ecc.read_oob = mxc_nand_read_oob;
+		chip->ecc.write_page = mxc_nand_write_page_ecc;
+		chip->ecc.write_page_raw = mxc_nand_write_page_raw;
+		chip->ecc.write_oob = mxc_nand_write_oob;
+		break;
+
+	case NAND_ECC_SOFT:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
+		chip->bbt_td = &bbt_main_descr;
+		chip->bbt_md = &bbt_mirror_descr;
+	}
+
+	/* Allocate the right size buffer now */
+	devm_kfree(dev, (void *)host->data_buf);
+	host->data_buf = devm_kzalloc(dev, mtd->writesize + mtd->oobsize,
+				      GFP_KERNEL);
+	if (!host->data_buf)
+		return -ENOMEM;
+
+	/* Call preset again, with correct writesize chip time */
+	host->devtype_data->preset(mtd);
+
+	if (!chip->ecc.bytes) {
+		if (host->eccsize == 8)
+			chip->ecc.bytes = 18;
+		else if (host->eccsize == 4)
+			chip->ecc.bytes = 9;
+	}
+
+	/*
+	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
+	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
+	 * into copying invalid data to/from the spare IO buffer, as this
+	 * might cause ECC data corruption when doing sub-page write to a
+	 * partially written page.
+	 */
+	host->used_oobsize = min(mtd->oobsize, 218U);
+
+	if (chip->ecc.mode == NAND_ECC_HW) {
+		if (is_imx21_nfc(host) || is_imx27_nfc(host))
+			chip->ecc.strength = 1;
+		else
+			chip->ecc.strength = (host->eccsize == 4) ? 4 : 8;
+	}
+
+	return 0;
+}
+
 static int mxcnd_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
@@ -1842,71 +1906,9 @@ static int mxcnd_probe(struct platform_device *pdev)
 		host->devtype_data->irq_control(host, 1);
 	}
 
-	/* first scan to find the device and get the page size */
-	err = nand_scan_ident(mtd, is_imx25_nfc(host) ? 4 : 1, NULL);
-	if (err)
-		goto escan;
-
-	switch (this->ecc.mode) {
-	case NAND_ECC_HW:
-		this->ecc.read_page = mxc_nand_read_page;
-		this->ecc.read_page_raw = mxc_nand_read_page_raw;
-		this->ecc.read_oob = mxc_nand_read_oob;
-		this->ecc.write_page = mxc_nand_write_page_ecc;
-		this->ecc.write_page_raw = mxc_nand_write_page_raw;
-		this->ecc.write_oob = mxc_nand_write_oob;
-		break;
-
-	case NAND_ECC_SOFT:
-		break;
-
-	default:
-		err = -EINVAL;
-		goto escan;
-	}
-
-	if (this->bbt_options & NAND_BBT_USE_FLASH) {
-		this->bbt_td = &bbt_main_descr;
-		this->bbt_md = &bbt_mirror_descr;
-	}
-
-	/* allocate the right size buffer now */
-	devm_kfree(&pdev->dev, (void *)host->data_buf);
-	host->data_buf = devm_kzalloc(&pdev->dev, mtd->writesize + mtd->oobsize,
-					GFP_KERNEL);
-	if (!host->data_buf) {
-		err = -ENOMEM;
-		goto escan;
-	}
-
-	/* Call preset again, with correct writesize this time */
-	host->devtype_data->preset(mtd);
-
-	if (!this->ecc.bytes) {
-		if (host->eccsize == 8)
-			this->ecc.bytes = 18;
-		else if (host->eccsize == 4)
-			this->ecc.bytes = 9;
-	}
-
-	/*
-	 * Experimentation shows that i.MX NFC can only handle up to 218 oob
-	 * bytes. Limit used_oobsize to 218 so as to not confuse copy_spare()
-	 * into copying invalid data to/from the spare IO buffer, as this
-	 * might cause ECC data corruption when doing sub-page write to a
-	 * partially written page.
-	 */
-	host->used_oobsize = min(mtd->oobsize, 218U);
-
-	if (this->ecc.mode == NAND_ECC_HW) {
-		if (is_imx21_nfc(host) || is_imx27_nfc(host))
-			this->ecc.strength = 1;
-		else
-			this->ecc.strength = (host->eccsize == 4) ? 4 : 8;
-	}
-
-	/* second phase scan */
-	err = nand_scan_tail(mtd);
+	/* Scan the NAND device */
+	this->ecc.attach_chip = mxcnd_attach_chip;
+	err = nand_scan(mtd, is_imx25_nfc(host) ? 4 : 1);
 	if (err)
 		goto escan;
 
-- 
2.14.1
