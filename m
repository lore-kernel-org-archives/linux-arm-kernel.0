From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri,  2 Mar 2018 18:03:43 +0100
Subject: [PATCH 35/52] mtd: rawnand: sh_flctl: move all NAND chip related
 setup in one function
In-Reply-To: <20180302170400.6712-1-miquel.raynal@bootlin.com>
References: <20180302170400.6712-1-miquel.raynal@bootlin.com>
Message-ID: <20180302170400.6712-36-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare the conversion of the sh_flctl driver to nand_scan() by moving
all the configuration that must be made after nand_scan_ident() in one
single function. Create a pdata entry in the controller structure for
that.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/sh_flctl.c | 38 +++++++++++++++++++-------------------
 include/linux/mtd/sh_flctl.h    |  1 +
 2 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index 9eb3cf9db111..d14c26cb59df 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1007,6 +1007,16 @@ static int flctl_chip_init_tail(struct mtd_info *mtd)
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
 	struct nand_chip *chip = &flctl->chip;
 
+	if (chip->options & NAND_BUSWIDTH_16) {
+		/*
+		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
+		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
+		 * flctl->flcmncr_base to pdata->flcmncr_val.
+		 */
+		flctl->pdata->flcmncr_val |= SEL_16BIT;
+		flctl->flcmncr_base = flctl->pdata->flcmncr_val;
+	}
+
 	if (mtd->writesize == 512) {
 		flctl->page_size = 0;
 		if (chip->chipsize > (32 << 20)) {
@@ -1122,7 +1132,6 @@ static int flctl_probe(struct platform_device *pdev)
 	struct sh_flctl *flctl;
 	struct mtd_info *flctl_mtd;
 	struct nand_chip *nand;
-	struct sh_flctl_platform_data *pdata;
 	int ret;
 	int irq;
 
@@ -1150,11 +1159,11 @@ static int flctl_probe(struct platform_device *pdev)
 	}
 
 	if (pdev->dev.of_node)
-		pdata = flctl_parse_dt(&pdev->dev);
+		flctl->pdata = flctl_parse_dt(&pdev->dev);
 	else
-		pdata = dev_get_platdata(&pdev->dev);
+		flctl->pdata = dev_get_platdata(&pdev->dev);
 
-	if (!pdata) {
+	if (!flctl->pdata) {
 		dev_err(&pdev->dev, "no setup data defined\n");
 		return -EINVAL;
 	}
@@ -1165,9 +1174,9 @@ static int flctl_probe(struct platform_device *pdev)
 	nand_set_flash_node(nand, pdev->dev.of_node);
 	flctl_mtd->dev.parent = &pdev->dev;
 	flctl->pdev = pdev;
-	flctl->hwecc = pdata->has_hwecc;
-	flctl->holden = pdata->use_holden;
-	flctl->flcmncr_base = pdata->flcmncr_val;
+	flctl->hwecc = flctl->pdata->has_hwecc;
+	flctl->holden = flctl->pdata->use_holden;
+	flctl->flcmncr_base = flctl->pdata->flcmncr_val;
 	flctl->flintdmacr_base = flctl->hwecc ? (STERINTE | ECERB) : STERINTE;
 
 	/* Set address of hardware control function */
@@ -1183,7 +1192,7 @@ static int flctl_probe(struct platform_device *pdev)
 	nand->set_features = nand_get_set_features_notsupp;
 	nand->get_features = nand_get_set_features_notsupp;
 
-	if (pdata->flcmncr_val & SEL_16BIT)
+	if (flctl->pdata->flcmncr_val & SEL_16BIT)
 		nand->options |= NAND_BUSWIDTH_16;
 
 	pm_runtime_enable(&pdev->dev);
@@ -1195,16 +1204,6 @@ static int flctl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_chip;
 
-	if (nand->options & NAND_BUSWIDTH_16) {
-		/*
-		 * NAND_BUSWIDTH_16 may have been set by nand_scan_ident().
-		 * Add the SEL_16BIT flag in pdata->flcmncr_val and re-assign
-		 * flctl->flcmncr_base to pdata->flcmncr_val.
-		 */
-		pdata->flcmncr_val |= SEL_16BIT;
-		flctl->flcmncr_base = pdata->flcmncr_val;
-	}
-
 	ret = flctl_chip_init_tail(flctl_mtd);
 	if (ret)
 		goto err_chip;
@@ -1213,7 +1212,8 @@ static int flctl_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_chip;
 
-	ret = mtd_device_register(flctl_mtd, pdata->parts, pdata->nr_parts);
+	ret = mtd_device_register(flctl_mtd, flctl->pdata->parts,
+				  flctl->pdata->nr_parts);
 
 	return 0;
 
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index c759d403cbc0..c9f486c6c019 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -148,6 +148,7 @@ struct sh_flctl {
 	struct dev_pm_qos_request pm_qos;
 	void __iomem		*reg;
 	resource_size_t		fifo;
+	struct sh_flctl_platform_data *pdata;
 
 	uint8_t	done_buff[2048 + 64];	/* max size 2048 + 64 */
 	int	read_bytes;
-- 
2.14.1
