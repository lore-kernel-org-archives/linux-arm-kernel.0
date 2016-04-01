From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:28 +0200
Subject: [PATCH 08/12] mtd: nand: lpc32xx: rely on generic DT parsing done in
 nand_scan_ident()
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-9-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core now takes care of parsing generic DT properties in
nand_scan_ident() when nand_set_flash_node() has been called.
Rely on this initialization instead of calling of_get_nand_xxx()
manually.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/lpc32xx_slc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/lpc32xx_slc.c b/drivers/mtd/nand/lpc32xx_slc.c
index 3b8f373..99925a2 100644
--- a/drivers/mtd/nand/lpc32xx_slc.c
+++ b/drivers/mtd/nand/lpc32xx_slc.c
@@ -194,7 +194,6 @@ struct lpc32xx_nand_cfg_slc {
 	uint32_t rwidth;
 	uint32_t rhold;
 	uint32_t rsetup;
-	bool use_bbt;
 	int wp_gpio;
 	struct mtd_partition *parts;
 	unsigned num_parts;
@@ -747,7 +746,6 @@ static struct lpc32xx_nand_cfg_slc *lpc32xx_parse_dt(struct device *dev)
 		return NULL;
 	}
 
-	ncfg->use_bbt = of_get_nand_on_flash_bbt(np);
 	ncfg->wp_gpio = of_get_named_gpio(np, "gpios", 0);
 
 	return ncfg;
@@ -882,19 +880,15 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 	chip->ecc.bytes = LPC32XX_SLC_DEV_ECC_BYTES;
 	chip->ecc.prepad = chip->ecc.postpad = 0;
 
-	/* Avoid extra scan if using BBT, setup BBT support */
-	if (host->ncfg->use_bbt) {
-		chip->bbt_options |= NAND_BBT_USE_FLASH;
-
-		/*
-		 * Use a custom BBT marker setup for small page FLASH that
-		 * won't interfere with the ECC layout. Large and huge page
-		 * FLASH use the standard layout.
-		 */
-		if (mtd->writesize <= 512) {
-			chip->bbt_td = &bbt_smallpage_main_descr;
-			chip->bbt_md = &bbt_smallpage_mirror_descr;
-		}
+	/*
+	 * Use a custom BBT marker setup for small page FLASH that
+	 * won't interfere with the ECC layout. Large and huge page
+	 * FLASH use the standard layout.
+	 */
+	if ((chip->bbt_options & NAND_BBT_USE_FLASH) &&
+	    mtd->writesize <= 512) {
+		chip->bbt_td = &bbt_smallpage_main_descr;
+		chip->bbt_md = &bbt_smallpage_mirror_descr;
 	}
 
 	/*
-- 
2.5.0
