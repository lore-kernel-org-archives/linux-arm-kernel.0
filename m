From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:40 +0200
Subject: [PATCH 08/10] mtd: mxc_nand: put several more fields into devtype_data
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-8-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |  128 +++++++++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 35 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index ac4b2e9..81ffb9b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -156,6 +156,22 @@ struct mxc_nand_devtype_data {
 	void (*select_chip)(struct mtd_info *mtd, int chip);
 	int (*correct_data)(struct mtd_info *mtd, u_char *dat,
 			u_char *read_ecc, u_char *calc_ecc);
+
+	/*
+	 * On i.MX21 the CONFIG2:INT bit cannot be read if interrupts are masked
+	 * (CONFIG1:INT_MSK is set). To handle this the driver uses
+	 * enable_irq/disable_irq_nosync instead of CONFIG1:INT_MSK
+	 */
+	int irqpending_quirk;
+	int needs_ip;
+
+	size_t regs_offset;
+	size_t spare0_offset;
+	size_t axi_offset;
+
+	int spare_len;
+	int eccbytes;
+	int eccsize;
 };
 
 struct mxc_nand_host {
@@ -181,16 +197,8 @@ struct mxc_nand_host {
 
 	uint8_t			*data_buf;
 	unsigned int		buf_start;
-	int			spare_len;
 
 	const struct mxc_nand_devtype_data *devtype_data;
-
-	/*
-	 * On i.MX21 the CONFIG2:INT bit cannot be read if interrupts are masked
-	 * (CONFIG1:INT_MSK is set). To handle this the driver uses
-	 * enable_irq/disable_irq_nosync instead of CONFIG1:INT_MSK
-	 */
-	int irqpending_quirk;
 };
 
 /* OOB placement block for use with hardware ecc generation */
@@ -284,7 +292,7 @@ static int check_int_v1_v2(struct mxc_nand_host *host)
 	if (!(tmp & NFC_V1_V2_CONFIG2_INT))
 		return 0;
 
-	if (!host->irqpending_quirk)
+	if (!host->devtype_data->irqpending_quirk)
 		writew(tmp & ~NFC_V1_V2_CONFIG2_INT, NFC_V1_V2_CONFIG2);
 
 	return 1;
@@ -320,7 +328,7 @@ static void irq_control_v3(struct mxc_nand_host *host, int activate)
 
 static void irq_control(struct mxc_nand_host *host, int activate)
 {
-	if (host->irqpending_quirk) {
+	if (host->devtype_data->irqpending_quirk) {
 		if (activate)
 			enable_irq(host->irq);
 		else
@@ -406,7 +414,7 @@ static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 	writew(cmd, NFC_V1_V2_FLASH_CMD);
 	writew(NFC_CMD, NFC_V1_V2_CONFIG2);
 
-	if (host->irqpending_quirk && (cmd == NAND_CMD_RESET)) {
+	if (host->devtype_data->irqpending_quirk && (cmd == NAND_CMD_RESET)) {
 		int max_retries = 100;
 		/* Reset completion is indicated by NFC_CONFIG2 */
 		/* being set to 0 */
@@ -781,7 +789,7 @@ static void copy_spare(struct mtd_info *mtd, bool bfrom)
 	u16 n = mtd->writesize >> 9;
 	u8 *d = host->data_buf + mtd->writesize;
 	u8 *s = host->spare0;
-	u16 t = host->spare_len;
+	u16 t = host->devtype_data->spare_len;
 
 	j = (mtd->oobsize / n >> 1) << 1;
 
@@ -881,7 +889,7 @@ static void preset_v1(struct mtd_info *mtd)
 	if (nand_chip->ecc.mode == NAND_ECC_HW)
 		config1 |= NFC_V1_V2_CONFIG1_ECC_EN;
 
-	if (!host->irqpending_quirk)
+	if (!host->devtype_data->irqpending_quirk)
 		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
 
 	host->eccsize = 1;
@@ -911,7 +919,7 @@ static void preset_v2(struct mtd_info *mtd)
 
 	config1 |= NFC_V2_CONFIG1_FP_INT;
 
-	if (!host->irqpending_quirk)
+	if (!host->devtype_data->irqpending_quirk)
 		config1 |= NFC_V1_V2_CONFIG1_INT_MSK;
 
 	if (mtd->writesize) {
@@ -1126,7 +1134,7 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = mirror_pattern,
 };
 
-/* v1: 21, 27, 31 */
+/* v1 + irqpending_quirk: 21 */
 static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
 	.preset = preset_v1,
 	.send_cmd = send_cmd_v1_v2,
@@ -1142,6 +1150,39 @@ static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
 	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
 	.select_chip = mxc_nand_select_chip_v1_v3,
 	.correct_data = mxc_nand_correct_data_v1,
+	.irqpending_quirk = 1,
+	.needs_ip = 0,
+	.regs_offset = 0xe00,
+	.spare0_offset = 0x800,
+	.spare_len = 16,
+	.eccbytes = 3,
+	.eccsize = 1,
+};
+
+/* v1 + !irqpending_quirk: 27, 31 */
+static const struct mxc_nand_devtype_data imx27_nand_devtype_data = {
+	.preset = preset_v1,
+	.send_cmd = send_cmd_v1_v2,
+	.send_addr = send_addr_v1_v2,
+	.send_page = send_page_v1,
+	.send_read_id = send_read_id_v1_v2,
+	.get_dev_status = get_dev_status_v1_v2,
+	.check_int = check_int_v1_v2,
+	.irq_control = irq_control_v1_v2,
+	.get_ecc_status = get_ecc_status_v1,
+	.ecclayout_512 = &nandv1_hw_eccoob_smallpage,
+	.ecclayout_2k = &nandv1_hw_eccoob_largepage,
+	.ecclayout_4k = &nandv1_hw_eccoob_smallpage, /* XXX: needs fix */
+	.select_chip = mxc_nand_select_chip_v1_v3,
+	.correct_data = mxc_nand_correct_data_v1,
+	.irqpending_quirk = 0,
+	.needs_ip = 0,
+	.regs_offset = 0xe00,
+	.spare0_offset = 0x800,
+	.axi_offset = 0,
+	.spare_len = 16,
+	.eccbytes = 3,
+	.eccsize = 1,
 };
 
 /* v21: 25, 35 */
@@ -1160,6 +1201,14 @@ static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
 	.ecclayout_4k = &nandv2_hw_eccoob_4k,
 	.select_chip = mxc_nand_select_chip_v2,
 	.correct_data = mxc_nand_correct_data_v2_v3,
+	.irqpending_quirk = 0,
+	.needs_ip = 0,
+	.regs_offset = 0x1e00,
+	.spare0_offset = 0x1000,
+	.axi_offset = 0,
+	.spare_len = 64,
+	.eccbytes = 9,
+	.eccsize = 0,
 };
 
 /* v3: 51, 53 */
@@ -1178,6 +1227,14 @@ static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
 	.ecclayout_4k = &nandv2_hw_eccoob_smallpage, /* XXX: needs fix */
 	.select_chip = mxc_nand_select_chip_v1_v3,
 	.correct_data = mxc_nand_correct_data_v2_v3,
+	.irqpending_quirk = 0,
+	.needs_ip = 1,
+	.regs_offset = 0,
+	.spare0_offset = 0x1000,
+	.axi_offset = 0x1e00,
+	.spare_len = 64,
+	.eccbytes = 0,
+	.eccsize = 0,
 };
 
 static int __init mxcnd_probe(struct platform_device *pdev)
@@ -1242,22 +1299,31 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	host->main_area0 = host->base;
 
 	if (nfc_is_v1()) {
-		host->devtype_data = &imx21_nand_devtype_data;
 		if (cpu_is_mx21())
-			host->irqpending_quirk = 1;
-		host->regs = host->base + 0xe00;
-		host->spare0 = host->base + 0x800;
-		host->spare_len = 16;
-		this->ecc.bytes = 3;
-		host->eccsize = 1;
+			host->devtype_data = &imx21_nand_devtype_data;
+		else
+			host->devtype_data = &imx27_nand_devtype_data;
 	} else if (nfc_is_v21()) {
 		host->devtype_data = &imx25_nand_devtype_data;
-		host->regs = host->base + 0x1e00;
-		host->spare0 = host->base + 0x1000;
-		host->spare_len = 64;
-		this->ecc.bytes = 9;
 	} else if (nfc_is_v3_2()) {
 		host->devtype_data = &imx51_nand_devtype_data;
+	} else
+		BUG();
+
+	if (host->devtype_data->regs_offset)
+		host->regs = host->base + host->devtype_data->regs_offset;
+	host->spare0 = host->base + host->devtype_data->spare0_offset;
+	if (host->devtype_data->axi_offset)
+		host->regs_axi = host->base + host->devtype_data->axi_offset;
+
+	this->ecc.bytes = host->devtype_data->eccbytes;
+	host->eccsize = host->devtype_data->eccsize;
+
+	this->select_chip = host->devtype_data->select_chip;
+	this->ecc.size = 512;
+	this->ecc.layout = host->devtype_data->ecclayout_512;
+
+	if (host->devtype_data->needs_ip) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		if (!res) {
 			err = -ENODEV;
@@ -1268,15 +1334,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 			err = -ENOMEM;
 			goto eirq;
 		}
-		host->regs_axi = host->base + 0x1e00;
-		host->spare0 = host->base + 0x1000;
-		host->spare_len = 64;
-	} else
-		BUG();
-
-	this->select_chip = host->devtype_data->select_chip;
-	this->ecc.size = 512;
-	this->ecc.layout = host->devtype_data->ecclayout_512;
+	}
 
 	if (pdata->hw_ecc) {
 		this->ecc.calculate = mxc_nand_calculate_ecc;
-- 
1.7.10
