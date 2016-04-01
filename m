From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri,  1 Apr 2016 14:54:29 +0200
Subject: [PATCH 09/12] mtd: nand: mxc: rely on generic DT parsing done in
 nand_scan_ident()
In-Reply-To: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1459515272-31011-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1459515272-31011-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The core now takes care of parsing generic DT properties in
nand_scan_ident() when nand_set_flash_node() has been called.
Rely on this initialization instead of calling of_get_nand_xxx()
manually.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/mtd/nand/mxc_nand.c | 50 ++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 854c832..f25913b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -34,7 +34,6 @@
 #include <linux/completion.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_mtd.h>
 
 #include <asm/mach/flash.h>
 #include <linux/platform_data/mtd-mxc_nand.h>
@@ -1461,25 +1460,12 @@ MODULE_DEVICE_TABLE(of, mxcnd_dt_ids);
 static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	struct device_node *np = host->dev->of_node;
-	struct mxc_nand_platform_data *pdata = &host->pdata;
 	const struct of_device_id *of_id =
 		of_match_device(mxcnd_dt_ids, host->dev);
-	int buswidth;
 
 	if (!np)
 		return 1;
 
-	if (of_get_nand_ecc_mode(np) >= 0)
-		pdata->hw_ecc = 1;
-
-	pdata->flash_bbt = of_get_nand_on_flash_bbt(np);
-
-	buswidth = of_get_nand_bus_width(np);
-	if (buswidth < 0)
-		return buswidth;
-
-	pdata->width = buswidth / 8;
-
 	host->devtype_data = of_id->data;
 
 	return 0;
@@ -1578,25 +1564,18 @@ static int mxcnd_probe(struct platform_device *pdev)
 	this->ecc.size = 512;
 	this->ecc.layout = host->devtype_data->ecclayout_512;
 
-	if (host->pdata.hw_ecc) {
-		this->ecc.calculate = mxc_nand_calculate_ecc;
-		this->ecc.hwctl = mxc_nand_enable_hwecc;
-		this->ecc.correct = host->devtype_data->correct_data;
+	if (host->pdata.hw_ecc)
 		this->ecc.mode = NAND_ECC_HW;
-	} else {
+	else
 		this->ecc.mode = NAND_ECC_SOFT;
-	}
 
 	/* NAND bus width determines access functions used by upper layer */
 	if (host->pdata.width == 2)
 		this->options |= NAND_BUSWIDTH_16;
 
-	if (host->pdata.flash_bbt) {
-		this->bbt_td = &bbt_main_descr;
-		this->bbt_md = &bbt_mirror_descr;
-		/* update flash based bbt */
+	/* update flash based bbt */
+	if (host->pdata.flash_bbt)
 		this->bbt_options |= NAND_BBT_USE_FLASH;
-	}
 
 	init_completion(&host->op_completion);
 
@@ -1637,6 +1616,27 @@ static int mxcnd_probe(struct platform_device *pdev)
 		goto escan;
 	}
 
+	switch (this->ecc.mode) {
+	case NAND_ECC_HW:
+		this->ecc.calculate = mxc_nand_calculate_ecc;
+		this->ecc.hwctl = mxc_nand_enable_hwecc;
+		this->ecc.correct = host->devtype_data->correct_data;
+		break;
+
+	case NAND_ECC_SOFT:
+	case NAND_ECC_SOFT_BCH:
+		break;
+
+	default:
+		err = -EINVAL;
+		goto escan;
+	}
+
+	if (this->bbt_options & NAND_BBT_USE_FLASH) {
+		this->bbt_td = &bbt_main_descr;
+		this->bbt_md = &bbt_mirror_descr;
+	}
+
 	/* allocate the right size buffer now */
 	devm_kfree(&pdev->dev, (void *)host->data_buf);
 	host->data_buf = devm_kzalloc(&pdev->dev, mtd->writesize + mtd->oobsize,
-- 
2.5.0
