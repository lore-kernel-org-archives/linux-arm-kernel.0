From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:38 +0200
Subject: [PATCH 06/10] mtd: mxc_nand: split chip_select function and put it
 into devtype struct
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-6-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 1389d40..be17b7a 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -153,6 +153,7 @@ struct mxc_nand_devtype_data {
 	void (*irq_control)(struct mxc_nand_host *, int);
 	u32 (*get_ecc_status)(struct mxc_nand_host *);
 	struct nand_ecclayout *ecclayout_512, *ecclayout_2k, *ecclayout_4k;
+	void (*select_chip)(struct mtd_info *mtd, int chip);
 };
 
 struct mxc_nand_host {
@@ -722,7 +723,7 @@ static int mxc_nand_verify_buf(struct mtd_info *mtd,
 
 /* This function is used by upper layer for select and
  * deselect of the NAND chip */
-static void mxc_nand_select_chip(struct mtd_info *mtd, int chip)
+static void mxc_nand_select_chip_v1_v3(struct mtd_info *mtd, int chip)
 {
 	struct nand_chip *nand_chip = mtd->priv;
 	struct mxc_nand_host *host = nand_chip->priv;
@@ -741,11 +742,30 @@ static void mxc_nand_select_chip(struct mtd_info *mtd, int chip)
 		clk_enable(host->clk);
 		host->clk_act = 1;
 	}
+}
+
+static void mxc_nand_select_chip_v2(struct mtd_info *mtd, int chip)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	struct mxc_nand_host *host = nand_chip->priv;
+
+	if (chip == -1) {
+		/* Disable the NFC clock */
+		if (host->clk_act) {
+			clk_disable(host->clk);
+			host->clk_act = 0;
+		}
+		return;
+	}
 
-	if (nfc_is_v21()) {
-		host->active_cs = chip;
-		writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
+	if (!host->clk_act) {
+		/* Enable the NFC clock */
+		clk_enable(host->clk);
+		host->clk_act = 1;
 	}
+
+	host->active_cs = chip;
+	writew(host->active_cs << 4, NFC_V1_V2_BUF_ADDR);
 }
 
 /*
@@ -1118,6 +1138,7 @@ static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
 	.ecclayout_512 = &nandv1_hw_eccoob_smallpage,
 	.ecclayout_2k = &nandv1_hw_eccoob_largepage,
 	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
+	.select_chip = mxc_nand_select_chip_v1_v3,
 };
 
 /* v21: 25, 35 */
@@ -1134,6 +1155,7 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
 	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
 	.ecclayout_4k = &nandv2_hw_eccoob_4k,
+	.select_chip = mxc_nand_select_chip_v2,
 };
 
 /* v3: 51, 53 */
@@ -1150,6 +1172,7 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
 	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
 	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
+	.select_chip = mxc_nand_select_chip_v1_v3,
 };
 
 static int __init mxcnd_probe(struct platform_device *pdev)
@@ -1184,7 +1207,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	this->priv = host;
 	this->dev_ready = mxc_nand_dev_ready;
 	this->cmdfunc = mxc_nand_command;
-	this->select_chip = mxc_nand_select_chip;
 	this->read_byte = mxc_nand_read_byte;
 	this->read_word = mxc_nand_read_word;
 	this->write_buf = mxc_nand_write_buf;
@@ -1247,6 +1269,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	} else
 		BUG();
 
+	this->select_chip = host->devtype_data->select_chip;
 	this->ecc.size = 512;
 	this->ecc.layout = host->devtype_data->ecclayout_512;
 
-- 
1.7.10
