From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  6 Jun 2012 12:33:15 +0200
Subject: [PATCH 3/4] mtd nand mxc_nand: add i.MX53 support
In-Reply-To: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
References: <1338978796-26129-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1338978796-26129-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only relevant change between i.MX51 and i.MX53 is that
a bitfield is shifted one bit to the left.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |   48 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index cc0f6e7..1aae564 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -43,8 +43,8 @@
 
 #define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
 #define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
-#define nfc_is_v3_2()		(cpu_is_mx51() || cpu_is_mx53())
-#define nfc_is_v3()		nfc_is_v3_2()
+#define nfc_is_v3_2a()		cpu_is_mx51()
+#define nfc_is_v3_2b()		cpu_is_mx53()
 
 /* Addresses for NFC registers */
 #define NFC_V1_V2_BUF_SIZE		(host->regs + 0x00)
@@ -122,7 +122,7 @@
 #define NFC_V3_CONFIG2_2CMD_PHASES		(1 << 4)
 #define NFC_V3_CONFIG2_NUM_ADDR_PHASE0		(1 << 5)
 #define NFC_V3_CONFIG2_ECC_MODE_8		(1 << 6)
-#define NFC_V3_CONFIG2_PPB(x)			(((x) & 0x3) << 7)
+#define NFC_V3_CONFIG2_PPB(x, shift)		(((x) & 0x3) << shift)
 #define NFC_V3_CONFIG2_NUM_ADDR_PHASE1(x)	(((x) & 0x3) << 12)
 #define NFC_V3_CONFIG2_INT_MSK			(1 << 15)
 #define NFC_V3_CONFIG2_ST_CMD(x)		(((x) & 0xff) << 24)
@@ -174,6 +174,7 @@ struct mxc_nand_devtype_data {
 	int spare_len;
 	int eccbytes;
 	int eccsize;
+	int ppb_shift;
 };
 
 struct mxc_nand_host {
@@ -1001,7 +1002,9 @@ static void preset_v3(struct mtd_info *mtd)
 	}
 
 	if (mtd->writesize) {
-		config2 |= NFC_V3_CONFIG2_PPB(ffs(mtd->erasesize / mtd->writesize) - 6);
+		config2 |= NFC_V3_CONFIG2_PPB(
+				ffs(mtd->erasesize / mtd->writesize) - 6,
+				host->devtype_data->ppb_shift);
 		host->eccsize = get_eccsize(mtd);
 		if (host->eccsize == 8)
 			config2 |= NFC_V3_CONFIG2_ECC_MODE_8;
@@ -1213,7 +1216,7 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.eccsize = 0,
 };
 
-/* v3: i.MX51, i.MX53 */
+/* v3.2a: i.MX51 */
 static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.preset = preset_v3,
 	.send_cmd = send_cmd_v3,
@@ -1237,6 +1240,34 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.spare_len = 64,
 	.eccbytes = 0,
 	.eccsize = 0,
+	.ppb_shift = 7,
+};
+
+/* v3.2b: i.MX53 */
+static const struct mxc_nand_devtype_data imx53_nand_devtype_data = {
+	.preset = preset_v3,
+	.send_cmd = send_cmd_v3,
+	.send_addr = send_addr_v3,
+	.send_page = send_page_v3,
+	.send_read_id = send_read_id_v3,
+	.get_dev_status = get_dev_status_v3,
+	.check_int = check_int_v3,
+	.irq_control = irq_control_v3,
+	.get_ecc_status = get_ecc_status_v3,
+	.ecclayout_512 = &nandv2_hw_eccoob_smallpage,
+	.ecclayout_2k = &nandv2_hw_eccoob_largepage,
+	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
+	.select_chip = mxc_nand_select_chip_v1_v3,
+	.correct_data = mxc_nand_correct_data_v2_v3,
+	.irqpending_quirk = 0,
+	.needs_ip = 1,
+	.regs_offset = 0,
+	.spare0_offset = 0x1000,
+	.axi_offset = 0x1e00,
+	.spare_len = 64,
+	.eccbytes = 0,
+	.eccsize = 0,
+	.ppb_shift = 8,
 };
 
 #ifdef CONFIG_OF_MTD
@@ -1253,6 +1284,9 @@ static const struct of_device_id mxcnd_dt_ids[] = {
 	}, {
 		.compatible = "fsl,imx51-nand",
 		.data = &imx51_nand_devtype_data,
+	}, {
+		.compatible = "fsl,imx53-nand",
+		.data = &imx53_nand_devtype_data,
 	},
 	{ /* sentinel */ }
 };
@@ -1306,8 +1340,10 @@ static int __init mxcnd_probe_pdata(struct mxc_nand_host *host)
 			host->devtype_data = &imx27_nand_devtype_data;
 	} else if (nfc_is_v21()) {
 		host->devtype_data = &imx25_nand_devtype_data;
-	} else if (nfc_is_v3_2()) {
+	} else if (nfc_is_v3_2a()) {
 		host->devtype_data = &imx51_nand_devtype_data;
+	} else if (nfc_is_v3_2b()) {
+		host->devtype_data = &imx53_nand_devtype_data;
 	} else
 		BUG();
 
-- 
1.7.10
