From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:37 +0200
Subject: [PATCH 05/10] mtd: mxc_nand: put ecc layout into devtype structs
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes problems on v1 and v2 regarding 4k pages more obvious.
As I don't have a 4k flash handy I just keep the status quo.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index c9cdec2..1389d40 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -152,6 +152,7 @@ struct mxc_nand_devtype_data {
 	int (*check_int)(struct mxc_nand_host *);
 	void (*irq_control)(struct mxc_nand_host *, int);
 	u32 (*get_ecc_status)(struct mxc_nand_host *);
+	struct nand_ecclayout *ecclayout_512, *ecclayout_2k, *ecclayout_4k;
 };
 
 struct mxc_nand_host {
@@ -1114,6 +1115,9 @@ static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
 	.get_ecc_status = get_ecc_status_v1,
+	.ecclayout_512 = &nandv1_hw_eccoob_smallpage,
+	.ecclayout_2k = &nandv1_hw_eccoob_largepage,
+	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
 };
 
 /* v21: 25, 35 */
@@ -1127,6 +1131,9 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.check_int = check_int_v1_v2,
 	.irq_control = irq_control_v1_v2,
 	.get_ecc_status = get_ecc_status_v2,
+	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
+	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
+	.ecclayout_4k = &nandv2_hw_eccoob_4k,
 };
 
 /* v3: 51, 53 */
@@ -1140,6 +1147,9 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.check_int = check_int_v3,
 	.irq_control = irq_control_v3,
 	.get_ecc_status = get_ecc_status_v3,
+	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
+	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
+	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
 };
 
 static int __init mxcnd_probe(struct platform_device *pdev)
@@ -1150,7 +1160,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	struct mxc_nand_host *host;
 	struct resource *res;
 	int err = 0;
-	struct nand_ecclayout *oob_smallpage, *oob_largepage;
 
 	/* Allocate memory for MTD device structure and private data */
 	host = kzalloc(sizeof(struct mxc_nand_host) + NAND_MAX_PAGESIZE +
@@ -1212,8 +1221,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->regs = host->base + 0xe00;
 		host->spare0 = host->base + 0x800;
 		host->spare_len = 16;
-		oob_smallpage = &nandv1_hw_eccoob_smallpage;
-		oob_largepage = &nandv1_hw_eccoob_largepage;
 		this->ecc.bytes = 3;
 		host->eccsize = 1;
 	} else if (nfc_is_v21()) {
@@ -1221,8 +1228,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->regs = host->base + 0x1e00;
 		host->spare0 = host->base + 0x1000;
 		host->spare_len = 64;
-		oob_smallpage = &nandv2_hw_eccoob_smallpage;
-		oob_largepage = &nandv2_hw_eccoob_largepage;
 		this->ecc.bytes = 9;
 	} else if (nfc_is_v3_2()) {
 		host->devtype_data = &imx51_nand_devtype_data;
@@ -1239,13 +1244,11 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->regs_axi = host->base + 0x1e00;
 		host->spare0 = host->base + 0x1000;
 		host->spare_len = 64;
-		oob_smallpage = &nandv2_hw_eccoob_smallpage;
-		oob_largepage = &nandv2_hw_eccoob_largepage;
 	} else
 		BUG();
 
 	this->ecc.size = 512;
-	this->ecc.layout = oob_smallpage;
+	this->ecc.layout = host->devtype_data->ecclayout_512;
 
 	if (pdata->hw_ecc) {
 		this->ecc.calculate = mxc_nand_calculate_ecc;
@@ -1305,9 +1308,9 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	host->devtype_data->preset(mtd);
 
 	if (mtd->writesize == 2048)
-		this->ecc.layout = oob_largepage;
-	if (nfc_is_v21() && mtd->writesize == 4096)
-		this->ecc.layout = &nandv2_hw_eccoob_4k;
+		this->ecc.layout = host->devtype_data->ecclayout_2k;
+	else if (mtd->writesize == 4096)
+		this->ecc.layout = host->devtype_data->ecclayout_4k;
 
 	/* second phase scan */
 	if (nand_scan_tail(mtd)) {
-- 
1.7.10
