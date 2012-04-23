From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Apr 2012 11:23:35 +0200
Subject: [PATCH 03/10] mtd: mxc_nand: move function pointers to a per-SOC
 struct
In-Reply-To: <20120423092240.GA18013@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
Message-ID: <1335173022-22371-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares switching to platform ids and of-tree probing.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/mtd/nand/mxc_nand.c |  197 ++++++++++++++++++++++++++-----------------
 1 file changed, 118 insertions(+), 79 deletions(-)

diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index a78e763..1672e4b 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -140,6 +140,19 @@
 
 #define NFC_V3_DELAY_LINE		(host->regs_ip + 0x34)
 
+struct mxc_nand_host;
+
+struct mxc_nand_devtype_data {
+	void (*preset)(struct mtd_info *);
+	void (*send_cmd)(struct mxc_nand_host *, uint16_t, int);
+	void (*send_addr)(struct mxc_nand_host *, uint16_t, int);
+	void (*send_page)(struct mtd_info *, unsigned int);
+	void (*send_read_id)(struct mxc_nand_host *);
+	uint16_t (*get_dev_status)(struct mxc_nand_host *);
+	int (*check_int)(struct mxc_nand_host *);
+	void (*irq_control)(struct mxc_nand_host *, int);
+};
+
 struct mxc_nand_host {
 	struct mtd_info		mtd;
 	struct nand_chip	nand;
@@ -165,14 +178,7 @@ struct mxc_nand_host {
 	unsigned int		buf_start;
 	int			spare_len;
 
-	void			(*preset)(struct mtd_info *);
-	void			(*send_cmd)(struct mxc_nand_host *, uint16_t, int);
-	void			(*send_addr)(struct mxc_nand_host *, uint16_t, int);
-	void			(*send_page)(struct mtd_info *, unsigned int);
-	void			(*send_read_id)(struct mxc_nand_host *);
-	uint16_t		(*get_dev_status)(struct mxc_nand_host *);
-	int			(*check_int)(struct mxc_nand_host *);
-	void			(*irq_control)(struct mxc_nand_host *, int);
+	const struct mxc_nand_devtype_data *devtype_data;
 
 	/*
 	 * On i.MX21 the CONFIG2:INT bit cannot be read if interrupts are masked
@@ -251,20 +257,6 @@ static struct nand_ecclayout nandv2_hw_eccoob_4k = {
 
 static const char *part_probes[] = { "RedBoot", "cmdlinepart", NULL };
 
-static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
-{
-	struct mxc_nand_host *host = dev_id;
-
-	if (!host->check_int(host))
-		return IRQ_NONE;
-
-	irq_control(host, 0);
-
-	complete(&host->op_completion);
-
-	return IRQ_HANDLED;
-}
-
 static int check_int_v3(struct mxc_nand_host *host)
 {
 	uint32_t tmp;
@@ -329,10 +321,25 @@ static void irq_control(struct mxc_nand_host *host, int activate)
 		else
 			disable_irq_nosync(host->irq);
 	} else {
-		host->irq_control(host, activate);
+		host->devtype_data->irq_control(host, activate);
 	}
 }
 
+static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
+{
+	struct mxc_nand_host *host = dev_id;
+
+	if (!host->devtype_data->check_int(host))
+		return IRQ_NONE;
+
+	irq_control(host, 0);
+
+	complete(&host->op_completion);
+
+	return IRQ_HANDLED;
+}
+
+
 /* This function polls the NANDFC to wait for the basic operation to
  * complete by checking the INT bit of config2 register.
  */
@@ -341,14 +348,14 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 	int max_retries = 8000;
 
 	if (useirq) {
-		if (!host->check_int(host)) {
+		if (!host->devtype_data->check_int(host)) {
 			INIT_COMPLETION(host->op_completion);
 			irq_control(host, 1);
 			wait_for_completion(&host->op_completion);
 		}
 	} else {
 		while (max_retries-- > 0) {
-			if (host->check_int(host))
+			if (host->devtype_data->check_int(host))
 				break;
 
 			udelay(1);
@@ -621,7 +628,7 @@ static u_char mxc_nand_read_byte(struct mtd_info *mtd)
 
 	/* Check for status request */
 	if (host->status_request)
-		return host->get_dev_status(host) & 0xFF;
+		return host->devtype_data->get_dev_status(host) & 0xFF;
 
 	ret = *(uint8_t *)(host->data_buf + host->buf_start);
 	host->buf_start++;
@@ -756,34 +763,44 @@ static void mxc_do_addr_cycle(struct mtd_info *mtd, int column, int page_addr)
 		 * perform a read/write buf operation, the saved column
 		  * address is used to index into the full page.
 		 */
-		host->send_addr(host, 0, page_addr == -1);
+		host->devtype_data->send_addr(host, 0, page_addr == -1);
 		if (mtd->writesize > 512)
 			/* another col addr cycle for 2k page */
-			host->send_addr(host, 0, false);
+			host->devtype_data->send_addr(host, 0, false);
 	}
 
 	/* Write out page address, if necessary */
 	if (page_addr != -1) {
 		/* paddr_0 - p_addr_7 */
-		host->send_addr(host, (page_addr & 0xff), false);
+		host->devtype_data->send_addr(host, (page_addr & 0xff), false);
 
 		if (mtd->writesize > 512) {
 			if (mtd->size >= 0x10000000) {
 				/* paddr_8 - paddr_15 */
-				host->send_addr(host, (page_addr >> 8) & 0xff, false);
-				host->send_addr(host, (page_addr >> 16) & 0xff, true);
+				host->devtype_data->send_addr(host,
+						(page_addr >> 8) & 0xff,
+						false);
+				host->devtype_data->send_addr(host,
+						(page_addr >> 16) & 0xff,
+						true);
 			} else
 				/* paddr_8 - paddr_15 */
-				host->send_addr(host, (page_addr >> 8) & 0xff, true);
+				host->devtype_data->send_addr(host,
+						(page_addr >> 8) & 0xff, true);
 		} else {
 			/* One more address cycle for higher density devices */
 			if (mtd->size >= 0x4000000) {
 				/* paddr_8 - paddr_15 */
-				host->send_addr(host, (page_addr >> 8) & 0xff, false);
-				host->send_addr(host, (page_addr >> 16) & 0xff, true);
+				host->devtype_data->send_addr(host,
+						(page_addr >> 8) & 0xff,
+						false);
+				host->devtype_data->send_addr(host,
+						(page_addr >> 16) & 0xff,
+						true);
 			} else
 				/* paddr_8 - paddr_15 */
-				host->send_addr(host, (page_addr >> 8) & 0xff, true);
+				host->devtype_data->send_addr(host,
+						(page_addr >> 8) & 0xff, true);
 		}
 	}
 }
@@ -942,15 +959,15 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 	/* Command pre-processing step */
 	switch (command) {
 	case NAND_CMD_RESET:
-		host->preset(mtd);
-		host->send_cmd(host, command, false);
+		host->devtype_data->preset(mtd);
+		host->devtype_data->send_cmd(host, command, false);
 		break;
 
 	case NAND_CMD_STATUS:
 		host->buf_start = 0;
 		host->status_request = true;
 
-		host->send_cmd(host, command, true);
+		host->devtype_data->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
@@ -963,13 +980,14 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		command = NAND_CMD_READ0; /* only READ0 is valid */
 
-		host->send_cmd(host, command, false);
+		host->devtype_data->send_cmd(host, command, false);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 
 		if (mtd->writesize > 512)
-			host->send_cmd(host, NAND_CMD_READSTART, true);
+			host->devtype_data->send_cmd(host,
+					NAND_CMD_READSTART, true);
 
-		host->send_page(mtd, NFC_OUTPUT);
+		host->devtype_data->send_page(mtd, NFC_OUTPUT);
 
 		memcpy(host->data_buf, host->main_area0, mtd->writesize);
 		copy_spare(mtd, true);
@@ -982,28 +1000,28 @@ static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
 
 		host->buf_start = column;
 
-		host->send_cmd(host, command, false);
+		host->devtype_data->send_cmd(host, command, false);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
 	case NAND_CMD_PAGEPROG:
 		memcpy(host->main_area0, host->data_buf, mtd->writesize);
 		copy_spare(mtd, false);
-		host->send_page(mtd, NFC_INPUT);
-		host->send_cmd(host, command, true);
+		host->devtype_data->send_page(mtd, NFC_INPUT);
+		host->devtype_data->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 		break;
 
 	case NAND_CMD_READID:
-		host->send_cmd(host, command, true);
+		host->devtype_data->send_cmd(host, command, true);
 		mxc_do_addr_cycle(mtd, column, page_addr);
-		host->send_read_id(host);
+		host->devtype_data->send_read_id(host);
 		host->buf_start = column;
 		break;
 
 	case NAND_CMD_ERASE1:
 	case NAND_CMD_ERASE2:
-		host->send_cmd(host, command, false);
+		host->devtype_data->send_cmd(host, command, false);
 		mxc_do_addr_cycle(mtd, column, page_addr);
 
 		break;
@@ -1037,6 +1055,42 @@ static struct nand_bbt_descr bbt_mirror_descr = {
 	.pattern = mirror_pattern,
 };
 
+/* v1: 21, 27, 31 */
+static const struct mxc_nand_devtype_data imx21_nand_devtype_data = {
+	.preset = preset_v1_v2,
+	.send_cmd = send_cmd_v1_v2,
+	.send_addr = send_addr_v1_v2,
+	.send_page = send_page_v1_v2,
+	.send_read_id = send_read_id_v1_v2,
+	.get_dev_status = get_dev_status_v1_v2,
+	.check_int = check_int_v1_v2,
+	.irq_control = irq_control_v1_v2,
+};
+
+/* v21: 25, 35 */
+static const struct mxc_nand_devtype_data imx25_nand_devtype_data = {
+	.preset = preset_v1_v2,
+	.send_cmd = send_cmd_v1_v2,
+	.send_addr = send_addr_v1_v2,
+	.send_page = send_page_v1_v2,
+	.send_read_id = send_read_id_v1_v2,
+	.get_dev_status = get_dev_status_v1_v2,
+	.check_int = check_int_v1_v2,
+	.irq_control = irq_control_v1_v2,
+};
+
+/* v3: 51, 53 */
+static const struct mxc_nand_devtype_data imx51_nand_devtype_data = {
+	.preset = preset_v3,
+	.send_cmd = send_cmd_v3,
+	.send_addr = send_addr_v3,
+	.send_page = send_page_v3,
+	.send_read_id = send_read_id_v3,
+	.get_dev_status = get_dev_status_v3,
+	.check_int = check_int_v3,
+	.irq_control = irq_control_v3,
+};
+
 static int __init mxcnd_probe(struct platform_device *pdev)
 {
 	struct nand_chip *this;
@@ -1100,27 +1154,10 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 
 	host->main_area0 = host->base;
 
-	if (nfc_is_v1() || nfc_is_v21()) {
-		host->preset = preset_v1_v2;
-		host->send_cmd = send_cmd_v1_v2;
-		host->send_addr = send_addr_v1_v2;
-		host->send_page = send_page_v1_v2;
-		host->send_read_id = send_read_id_v1_v2;
-		host->get_dev_status = get_dev_status_v1_v2;
-		host->check_int = check_int_v1_v2;
-		host->irq_control = irq_control_v1_v2;
+	if (nfc_is_v1()) {
+		host->devtype_data = &imx21_nand_devtype_data;
 		if (cpu_is_mx21())
 			host->irqpending_quirk = 1;
-	}
-
-	if (nfc_is_v21()) {
-		host->regs = host->base + 0x1e00;
-		host->spare0 = host->base + 0x1000;
-		host->spare_len = 64;
-		oob_smallpage = &nandv2_hw_eccoob_smallpage;
-		oob_largepage = &nandv2_hw_eccoob_largepage;
-		this->ecc.bytes = 9;
-	} else if (nfc_is_v1()) {
 		host->regs = host->base + 0xe00;
 		host->spare0 = host->base + 0x800;
 		host->spare_len = 16;
@@ -1128,7 +1165,16 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		oob_largepage = &nandv1_hw_eccoob_largepage;
 		this->ecc.bytes = 3;
 		host->eccsize = 1;
+	} else if (nfc_is_v21()) {
+		host->devtype_data = &imx25_nand_devtype_data;
+		host->regs = host->base + 0x1e00;
+		host->spare0 = host->base + 0x1000;
+		host->spare_len = 64;
+		oob_smallpage = &nandv2_hw_eccoob_smallpage;
+		oob_largepage = &nandv2_hw_eccoob_largepage;
+		this->ecc.bytes = 9;
 	} else if (nfc_is_v3_2()) {
+		host->devtype_data = &imx51_nand_devtype_data;
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 		if (!res) {
 			err = -ENODEV;
@@ -1142,14 +1188,6 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		host->regs_axi = host->base + 0x1e00;
 		host->spare0 = host->base + 0x1000;
 		host->spare_len = 64;
-		host->preset = preset_v3;
-		host->send_cmd = send_cmd_v3;
-		host->send_addr = send_addr_v3;
-		host->send_page = send_page_v3;
-		host->send_read_id = send_read_id_v3;
-		host->check_int = check_int_v3;
-		host->get_dev_status = get_dev_status_v3;
-		host->irq_control = irq_control_v3;
 		oob_smallpage = &nandv2_hw_eccoob_smallpage;
 		oob_largepage = &nandv2_hw_eccoob_largepage;
 	} else
@@ -1186,10 +1224,11 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	host->irq = platform_get_irq(pdev, 0);
 
 	/*
-	 * Use host->irq_control here instead of irq_control because we must not
-	 * disable_irq_nosync without having requested the irq
+	 * Use host->devtype_data->irq_control() here instead of irq_control()
+	 * because we must not disable_irq_nosync without having requested the
+	 * irq.
 	 */
-	host->irq_control(host, 0);
+	host->devtype_data->irq_control(host, 0);
 
 	err = request_irq(host->irq, mxc_nfc_irq, IRQF_DISABLED, DRIVER_NAME, host);
 	if (err)
@@ -1202,7 +1241,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	 */
 	if (host->irqpending_quirk) {
 		disable_irq_nosync(host->irq);
-		host->irq_control(host, 1);
+		host->devtype_data->irq_control(host, 1);
 	}
 
 	/* first scan to find the device and get the page size */
@@ -1212,7 +1251,7 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 	}
 
 	/* Call preset again, with correct writesize this time */
-	host->preset(mtd);
+	host->devtype_data->preset(mtd);
 
 	if (mtd->writesize == 2048)
 		this->ecc.layout = oob_largepage;
-- 
1.7.10
