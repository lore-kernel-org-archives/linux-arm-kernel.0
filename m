From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:31 +0200
Subject: [PATCH 11/12] mtd: nand: sh_flctl: rely on generic DT parsing done in
 nand_scan_ident()
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-12-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core now takes care of parsing generic DT properties in
nand_scan_ident() when nand_set_flash_node() has been called.
Rely on this initialization instead of calling of_get_nand_xxx()
manually.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/sh_flctl.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 4814402..8d4e97c 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -31,7 +31,6 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_mtd.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1044,8 +1043,6 @@ static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
 	const struct of_device_id *match;
 	struct flctl_soc_config *config;
 	struct sh_flctl_platform_data *pdata;
-	struct device_node *dn = dev->of_node;
-	int ret;
 
 	match = of_match_device(of_flctl_match, dev);
 	if (match)
@@ -1065,15 +1062,6 @@ static struct sh_flctl_platform_data *flctl_parse_dt(struct device *dev)
 	pdata->has_hwecc = config->has_hwecc;
 	pdata->use_holden = config->use_holden;
 
-	/* parse user defined options */
-	ret = of_get_nand_bus_width(dn);
-	if (ret == 16)
-		pdata->flcmncr_val |= SEL_16BIT;
-	else if (ret != 8) {
-		dev_err(dev, "%s: invalid bus width\n", __func__);
-		return NULL;
-	}
-
 	return pdata;
 }
 
@@ -1141,20 +1129,29 @@ static int flctl_probe(struct platform_device *pdev)
 	nand->select_chip = flctl_select_chip;
 	nand->cmdfunc = flctl_cmdfunc;
 
-	if (pdata->flcmncr_val & SEL_16BIT) {
-		nand->options |= NAND_BUSWIDTH_16;
-		nand->read_word = flctl_read_word;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
 	flctl_setup_dma(flctl);
 
+	if (pdata->flcmncr_val & SEL_16BIT)
+		nand->options |= NAND_BUSWIDTH_16;
+
 	ret = nand_scan_ident(flctl_mtd, 1, NULL);
 	if (ret)
 		goto err_chip;
 
+	if (nand->options & NAND_BUSWIDTH_16) {
+		/*
+		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
+		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
+		 * flctl->flcmncr_base to pdata->flcmncr_val.
+		 */
+		pdata->flcmncr_val |= SEL_16BIT;
+		flctl->flcmncr_base = pdata->flcmncr_val;
+		nand->read_word = flctl_read_word;
+	}
+
 	ret = flctl_chip_init_tail(flctl_mtd);
 	if (ret)
 		goto err_chip;
-- 
2.5.0
