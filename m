From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:30 +0200
Subject: [PATCH 10/12] mtd: nand: pxa3xx: rely on generic DT parsing done in
 nand_scan_ident()
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-11-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core now takes care of parsing generic DT properties in
nand_scan_ident() when nand_set_flash_node() has been called.
Rely on this initialization instead of calling of_get_nand_xxx()
manually.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/pxa3xx_nand.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/pxa3xx_nand.c b/drivers/mtd/nand/pxa3xx_nand.c
index d650885..38d26ab 100644
--- a/drivers/mtd/nand/pxa3xx_nand.c
+++ b/drivers/mtd/nand/pxa3xx_nand.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_mtd.h>
 #include <linux/platform_data/mtd-nand-pxa3xx.h>
 
 #define	CHIP_DELAY_TIMEOUT	msecs_to_jiffies(200)
@@ -1651,6 +1650,12 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 	if (info->variant == PXA3XX_NAND_VARIANT_ARMADA370)
 		nand_writel(info, NDECCCTRL, 0x0);
 
+	if (pdata->flash_bbt)
+		chip->bbt_options |= NAND_BBT_USE_FLASH;
+
+	chip->ecc.strength = pdata->ecc_strength;
+	chip->ecc.size = pdata->ecc_step_size;
+
 	if (nand_scan_ident(mtd, 1, NULL))
 		return -ENODEV;
 
@@ -1663,13 +1668,12 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		}
 	}
 
-	if (pdata->flash_bbt) {
+	if (chip->bbt_options & NAND_BBT_USE_FLASH) {
 		/*
 		 * We'll use a bad block table stored in-flash and don't
 		 * allow writing the bad block marker to the flash.
 		 */
-		chip->bbt_options |= NAND_BBT_USE_FLASH |
-				     NAND_BBT_NO_OOB_BBM;
+		chip->bbt_options |= NAND_BBT_NO_OOB_BBM;
 		chip->bbt_td = &bbt_main_descr;
 		chip->bbt_md = &bbt_mirror_descr;
 	}
@@ -1689,10 +1693,9 @@ static int pxa3xx_nand_scan(struct mtd_info *mtd)
 		}
 	}
 
-	if (pdata->ecc_strength && pdata->ecc_step_size) {
-		ecc_strength = pdata->ecc_strength;
-		ecc_step = pdata->ecc_step_size;
-	} else {
+	ecc_strength = chip->ecc.strength;
+	ecc_step = chip->ecc.size;
+	if (!ecc_strength || !ecc_step) {
 		ecc_strength = chip->ecc_strength_ds;
 		ecc_step = chip->ecc_step_ds;
 	}
@@ -1903,15 +1906,6 @@ static int pxa3xx_nand_probe_dt(struct platform_device *pdev)
 	if (of_get_property(np, "marvell,nand-keep-config", NULL))
 		pdata->keep_config = 1;
 	of_property_read_u32(np, "num-cs", &pdata->num_cs);
-	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);
-
-	pdata->ecc_strength = of_get_nand_ecc_strength(np);
-	if (pdata->ecc_strength < 0)
-		pdata->ecc_strength = 0;
-
-	pdata->ecc_step_size = of_get_nand_ecc_step_size(np);
-	if (pdata->ecc_step_size < 0)
-		pdata->ecc_step_size = 0;
 
 	pdev->dev.platform_data = pdata;
 
-- 
2.5.0
