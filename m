From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:39 +0200
Subject: [PATCH 07/10] mtd: mxc_nand: put callback for data correction into
 devtype struct
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-7-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This gets rid of one more nfc_is_vX().

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index be17b7a..ac4b2e9 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -154,6 +154,8 @@ struct mxc_nand_devtype_data {
 	u32 (*get_ecc_status)(struct mxc_nand_host *);
 	struct nand_ecclayout *ecclayout_512, *ecclayout_2k, *ecclayout_4k;
 	void (*select_chip)(struct mtd_info *mtd, int chip);
+	int (*correct_data)(struct mtd_info *mtd, u_char *dat,
+			u_char *read_ecc, u_char *calc_ecc);
 };
 
 struct mxc_nand_host {
@@ -1139,6 +1141,7 @@ static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
 	.ecclayout_2k = &nandv1_hw_eccoob_largepage,
 	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
 	.select_chip = mxc_nand_select_chip_v1_v3,
+	.correct_data = mxc_nand_correct_data_v1,
 };
 
 /* v21: 25, 35 */
@@ -1156,6 +1159,7 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
 	.ecclayout_4k = &nandv2_hw_eccoob_4k,
 	.select_chip = mxc_nand_select_chip_v2,
+	.correct_data = mxc_nand_correct_data_v2_v3,
 };
 
 /* v3: 51, 53 */
@@ -1173,6 +1177,7 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
 	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
 	.select_chip = mxc_nand_select_chip_v1_v3,
+	.correct_data = mxc_nand_correct_data_v2_v3,
 };
 
 static int __init mxcnd_probe(struct platform_device *pdev)
@@ -1276,10 +1281,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	if (pdata->hw_ecc) {
 		this->ecc.calculate = mxc_nand_calculate_ecc;
 		this->ecc.hwctl = mxc_nand_enable_hwecc;
-		if (nfc_is_v1())
-			this->ecc.correct = mxc_nand_correct_data_v1;
-		else
-			this->ecc.correct = mxc_nand_correct_data_v2_v3;
+		this->ecc.correct = host->devtype_data->correct_data;
 		this->ecc.mode = NAND_ECC_HW;
 	} else {
 		this->ecc.mode = NAND_ECC_SOFT;
-- 
1.7.10
