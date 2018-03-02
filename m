From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:33 +0100
Subject: [PATCH 25/52] mtd: rawnand: lpc32xx_slc: convert driver to nand_scan()
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-26-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two helpers have been added to the core to make ECC-related
configuration between the detection phase and the final NAND scan. Use
these hooks and convert the driver to just use nand_scan() instead of
both nand_scan_ident() and nand_scan_tail().

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/lpc32xx_slc.c | 73 ++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
index 342f666ad435..81c71bc12637 100644
--- a/drivers/mtd/nand/raw/lpc32xx_slc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
@@ -779,6 +779,42 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
 	return ncfg;
 }
 
+static int lpc32xx_nand_attach_chip(struct nand_chip *chip)
+{
+	struct mtd_info *mtd = nand_to_mtd(chip);
+	struct lpc32xx_nand_host *host = nand_get_controller_data(chip);
+
+	/* OOB and ECC CPU and DMA work areas */
+	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
+
+	/*
+	 * Small page FLASH has a unique OOB layout, but large and huge
+	 * page FLASH use the standard layout. Small page FLASH uses a
+	 * custom BBT marker layout.
+	 */
+	if (mtd->writesize <= 512)
+		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
+
+	/* These sizes remain the same regardless of page size */
+	chip->ecc.size = 256;
+	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
+	chip->ecc.prepad = 0;
+	chip->ecc.postpad = 0;
+
+	/*
+	 * Use a custom BBT marker setup for small page FLASH that
+	 * won't interfere with the ECC layout. Large and huge page
+	 * FLASH use the standard layout.
+	 */
+	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
+	    mtd->writesize <= 512) {
+		chip->bbt_td = &bbt_smallpage_main_descr;
+		chip->bbt_md = &bbt_smallpage_mirror_descr;
+	}
+
+	return 0;
+}
+
 /*
  * Probe for NAND controller
  */
@@ -884,41 +920,8 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	}
 
 	/* Find NAND device */
-	res = nand_scan_ident(mtd, 1, NULL);
-	if (res)
-		goto release_dma;
-
-	/* OOB and ECC CPU and DMA work areas */
-	host->ecc_buf = (uint32_t *)(host->data_buf + LPC32XX_DMA_DATA_SIZE);
-
-	/*
-	 * Small page FLASH has a unique OOB layout, but large and huge
-	 * page FLASH use the standard layout. Small page FLASH uses a
-	 * custom BBT marker layout.
-	 */
-	if (mtd->writesize <= 512)
-		mtd_set_ooblayout(mtd, &lpc32xx_ooblayout_ops);
-
-	/* These sizes remain the same regardless of page size */
-	chip->ecc.size = 256;
-	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
-	chip->ecc.prepad = chip->ecc.postpad = 0;
-
-	/*
-	 * Use a custom BBT marker setup for small page FLASH that
-	 * won't interfere with the ECC layout. Large and huge page
-	 * FLASH use the standard layout.
-	 */
-	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
-	    mtd->writesize <= 512) {
-		chip->bbt_td = &bbt_smallpage_main_descr;
-		chip->bbt_md = &bbt_smallpage_mirror_descr;
-	}
-
-	/*
-	 * Fills out all the uninitialized function pointers with the defaults
-	 */
-	res = nand_scan_tail(mtd);
+	chip->ecc.attach_chip = lpc32xx_nand_attach_chip;
+	res = nand_scan(mtd, 1);
 	if (res)
 		goto release_dma;
 
-- 
2.14.1
