From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  6 Aug 2010 15:53:11 +0200
Subject: [PATCH 8/8] mxc_nand: Add v3 (i.MX51) Support
In-Reply-To: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
References: <1281102791-8089-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1281102791-8089-9-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/Kconfig    |    2 +-
 drivers/mtd/nand/mxc_nand.c |  222 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 222 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 362d177..b8a03bd 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -482,7 +482,7 @@ config MTD_NAND_MPC5121_NFC
 
 config MTD_NAND_MXC
 	tristate "MXC NAND support"
-	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3
+	depends on ARCH_MX2 || ARCH_MX25 || ARCH_MX3 || ARCH_MX51
 	help
 	  This enables the driver for the NAND flash controller on the
 	  MXC processors.
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 030da08..d88f0fa 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -39,6 +39,8 @@
 
 #define nfc_is_v21()		(cpu_is_mx25() || cpu_is_mx35())
 #define nfc_is_v1()		(cpu_is_mx31() || cpu_is_mx27() || cpu_is_mx21())
+#define nfc_is_v3_2()		cpu_is_mx51()
+#define nfc_is_v3()		nfc_is_v3_2()
 
 /* Addresses for NFC registers */
 #define NFC_V1_V2_BUF_SIZE		(host->regs + 0x00)
@@ -80,6 +82,54 @@
 #define NFC_ID				(1 << 4)
 #define NFC_STATUS			(1 << 5)
 
+#define NFC_V3_FLASH_CMD		(host->regs_axi + 0x00)
+#define NFC_V3_FLASH_ADDR0		(host->regs_axi + 0x04)
+
+#define NFC_V3_CONFIG1			(host->regs_axi + 0x34)
+#define NFC_V3_CONFIG1_SP_EN		(1 << 0)
+#define NFC_V3_CONFIG1_RBA(x)		(((x) & 0x7 ) << 4)
+
+#define NFC_V3_ECC_STATUS_RESULT	(host->regs_axi + 0x38)
+
+#define NFC_V3_LAUNCH			(host->regs_axi + 0x40)
+
+#define NFC_V3_WRPROT			(host->regs_ip + 0x0)
+#define NFC_V3_WRPROT_LOCK_TIGHT	(1 << 0)
+#define NFC_V3_WRPROT_LOCK		(1 << 1)
+#define NFC_V3_WRPROT_UNLOCK		(1 << 2)
+#define NFC_V3_WRPROT_BLS_UNLOCK	(2 << 6)
+
+#define NFC_V3_WRPROT_UNLOCK_BLK_ADD0   (host->regs_ip + 0x04)
+
+#define NFC_V3_CONFIG2			(host->regs_ip + 0x24)
+#define NFC_V3_CONFIG2_PS_512			(0 << 0)
+#define NFC_V3_CONFIG2_PS_2048			(1 << 0)
+#define NFC_V3_CONFIG2_PS_4096			(2 << 0)
+#define NFC_V3_CONFIG2_ONE_CYCLE		(1 << 2)
+#define NFC_V3_CONFIG2_ECC_EN			(1 << 3)
+#define NFC_V3_CONFIG2_2CMD_PHASES		(1 << 4)
+#define NFC_V3_CONFIG2_NUM_ADDR_PHASE0		(1 << 5)
+#define NFC_V3_CONFIG2_ECC_MODE_8		(1 << 6)
+#define NFC_V3_CONFIG2_PPB(x)			(((x) & 0x3) << 7)
+#define NFC_V3_CONFIG2_NUM_ADDR_PHASE1(x)	(((x) & 0x3) << 12)
+#define NFC_V3_CONFIG2_INT_MSK			(1 << 15)
+#define NFC_V3_CONFIG2_ST_CMD(x)		(((x) & 0xff) << 24)
+#define NFC_V3_CONFIG2_SPAS(x)			(((x) & 0xff) << 16)
+
+#define NFC_V3_CONFIG3				(host->regs_ip + 0x28)
+#define NFC_V3_CONFIG3_ADD_OP(x)		(((x) & 0x3) << 0)
+#define NFC_V3_CONFIG3_FW8			(1 << 3)
+#define NFC_V3_CONFIG3_SBB(x)			(((x) & 0x7) << 8)
+#define NFC_V3_CONFIG3_NUM_OF_DEVICES(x)	(((x) & 0x7) << 12)
+#define NFC_V3_CONFIG3_RBB_MODE			(1 << 15)
+#define NFC_V3_CONFIG3_NO_SDMA			(1 << 20)
+
+#define NFC_V3_IPC			(host->regs_ip + 0x2C)
+#define NFC_V3_IPC_CREQ			(1 << 0)
+#define NFC_V3_IPC_INT			(1 << 31)
+
+#define NFC_V3_DELAY_LINE		(host->regs_ip + 0x34)
+
 struct mxc_nand_host {
 	struct mtd_info		mtd;
 	struct nand_chip	nand;
@@ -91,6 +141,8 @@ struct mxc_nand_host {
 
 	void __iomem		*base;
 	void __iomem		*regs;
+	void __iomem		*regs_axi;
+	void __iomem		*regs_ip;
 	int			status_request;
 	struct clk		*clk;
 	int			clk_act;
@@ -169,6 +221,20 @@ static irqreturn_t mxc_nfc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static int check_int_v3(struct mxc_nand_host *host)
+{
+	uint32_t tmp;
+
+	tmp = readl(NFC_V3_IPC);
+	if (!(tmp & NFC_V3_IPC_INT))
+		return 0;
+
+	tmp &= ~NFC_V3_IPC_INT;
+	writel(tmp, NFC_V3_IPC);
+
+	return 1;
+}
+
 static int check_int_v1_v2(struct mxc_nand_host *host)
 {
 	uint32_t tmp;
@@ -209,6 +275,18 @@ static void wait_op_done(struct mxc_nand_host *host, int useirq)
 	}
 }
 
+static void send_cmd_v3(struct mxc_nand_host *host, uint16_t cmd, int useirq)
+{
+	/* fill command */
+	writel(cmd, NFC_V3_FLASH_CMD);
+
+	/* send out command */
+	writel(NFC_CMD, NFC_V3_LAUNCH);
+
+	/* Wait for operation to complete */
+	wait_op_done(host, useirq);
+}
+
 /* This function issues the specified command to the NAND device and
  * waits for completion. */
 static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
@@ -237,6 +315,17 @@ static void send_cmd_v1_v2(struct mxc_nand_host *host, uint16_t cmd, int useirq)
 	}
 }
 
+static void send_addr_v3(struct mxc_nand_host *host, uint16_t addr, int islast)
+{
+	/* fill address */
+	writel(addr, NFC_V3_FLASH_ADDR0);
+
+	/* send out address */
+	writel(NFC_ADDR, NFC_V3_LAUNCH);
+
+	wait_op_done(host, 0);
+}
+
 /* This function sends an address (or partial address) to the
  * NAND device. The address is used to select the source/destination for
  * a NAND command. */
@@ -251,6 +340,22 @@ static void send_addr_v1_v2(struct mxc_nand_host *host, uint16_t addr, int islas
 	wait_op_done(host, islast);
 }
 
+static void send_page_v3(struct mtd_info *mtd, unsigned int ops)
+{
+	struct nand_chip *nand_chip = mtd->priv;
+	struct mxc_nand_host *host = nand_chip->priv;
+	uint32_t tmp;
+
+	tmp = readl(NFC_V3_CONFIG1);
+	tmp &= ~(7 << 4);
+	writel(tmp, NFC_V3_CONFIG1);
+
+	/* transfer data from NFC ram to nand */
+	writel(ops, NFC_V3_LAUNCH);
+
+	wait_op_done(host, false);
+}
+
 static void send_page_v1_v2(struct mtd_info *mtd, unsigned int ops)
 {
 	struct nand_chip *nand_chip = mtd->priv;
@@ -274,6 +379,16 @@ static void send_page_v1_v2(struct mtd_info *mtd, unsigned int ops)
 	}
 }
 
+static void send_read_id_v3(struct mxc_nand_host *host)
+{
+	/* Read ID into main buffer */
+	writel(NFC_ID, NFC_V3_LAUNCH);
+
+	wait_op_done(host, true);
+
+	memcpy(host->data_buf, host->main_area0, 16);
+}
+
 /* Request the NANDFC to perform a read of the NAND device ID. */
 static void send_read_id_v1_v2(struct mxc_nand_host *host)
 {
@@ -299,6 +414,14 @@ static void send_read_id_v1_v2(struct mxc_nand_host *host)
 	memcpy(host->data_buf, host->main_area0, 16);
 }
 
+static uint16_t get_dev_status_v3(struct mxc_nand_host *host)
+{
+	writew(NFC_STATUS, NFC_V3_LAUNCH);
+	wait_op_done(host, true);
+
+	return readl(NFC_V3_CONFIG1) >> 16;
+}
+
 /* This function requests the NANDFC to perform a read of the
  * NAND device status and returns the current status. */
 static uint16_t get_dev_status_v1_v2(struct mxc_nand_host *host)
@@ -381,7 +504,10 @@ static int mxc_nand_correct_data_v2_v3(struct mtd_info *mtd, u_char *dat,
 
 	no_subpages = mtd->writesize >> 9;
 
-	ecc_stat = readl(NFC_V1_V2_ECC_STATUS_RESULT);
+	if (nfc_is_v21())
+		ecc_stat = readl(NFC_V1_V2_ECC_STATUS_RESULT);
+	else
+		ecc_stat = readl(NFC_V3_ECC_STATUS_RESULT);
 
 	do {
 		err = ecc_stat & ecc_bit_mask;
@@ -643,6 +769,72 @@ static void preset_v1_v2(struct mtd_info *mtd)
 	writew(0x4, NFC_V1_V2_WRPROT);
 }
 
+static void preset_v3(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct mxc_nand_host *host = chip->priv;
+	uint32_t config2, config3;
+	int i, addr_phases;
+
+	writel(NFC_V3_CONFIG1_RBA(0), NFC_V3_CONFIG1);
+	writel(NFC_V3_IPC_CREQ, NFC_V3_IPC);
+
+	/* Unlock the internal RAM Buffer */
+	writel(NFC_V3_WRPROT_BLS_UNLOCK | NFC_V3_WRPROT_UNLOCK,
+			NFC_V3_WRPROT);
+
+	/* Blocks to be unlocked */
+	for (i = 0; i < NAND_MAX_CHIPS; i++)
+		writel(0x0 |	(0xffff << 16),
+				NFC_V3_WRPROT_UNLOCK_BLK_ADD0 + (i << 2));
+
+	writel(0, NFC_V3_IPC);
+
+	config2 = NFC_V3_CONFIG2_ONE_CYCLE |
+		NFC_V3_CONFIG2_2CMD_PHASES |
+		NFC_V3_CONFIG2_SPAS(mtd->oobsize >> 1) |
+		NFC_V3_CONFIG2_ST_CMD(0x70) |
+		NFC_V3_CONFIG2_NUM_ADDR_PHASE0;
+
+	if (chip->ecc.mode == NAND_ECC_HW)
+		config2 |= NFC_V3_CONFIG2_ECC_EN;
+
+	addr_phases = fls(chip->pagemask) >> 3;
+
+	if (mtd->writesize == 2048) {
+		config2 |= NFC_V3_CONFIG2_PS_2048;
+		config2 |= NFC_V3_CONFIG2_NUM_ADDR_PHASE1(addr_phases);
+	} else if (mtd->writesize == 4096) {
+		config2 |= NFC_V3_CONFIG2_PS_4096;
+		config2 |= NFC_V3_CONFIG2_NUM_ADDR_PHASE1(addr_phases);
+	} else {
+		config2 |= NFC_V3_CONFIG2_PS_512;
+		config2 |= NFC_V3_CONFIG2_NUM_ADDR_PHASE1(addr_phases - 1);
+	}
+
+	if (mtd->writesize) {
+		config2 |= NFC_V3_CONFIG2_PPB(ffs(mtd->erasesize / mtd->writesize) - 6);
+		host->eccsize = get_eccsize(mtd);
+		if (host->eccsize == 8)
+			config2 |= NFC_V3_CONFIG2_ECC_MODE_8;
+	}
+
+	writel(config2, NFC_V3_CONFIG2);
+
+	config3 = NFC_V3_CONFIG3_NUM_OF_DEVICES(0) |
+			NFC_V3_CONFIG3_NO_SDMA |
+			NFC_V3_CONFIG3_RBB_MODE |
+			NFC_V3_CONFIG3_SBB(6) | /* Reset default */
+			NFC_V3_CONFIG3_ADD_OP(0);
+
+	if (!(chip->options & NAND_BUSWIDTH_16))
+		config3 |= NFC_V3_CONFIG3_FW8;
+
+	writel(config3, NFC_V3_CONFIG3);
+
+	writel(0, NFC_V3_DELAY_LINE);
+}
+
 /* Used by the upper layer to write command to NAND Flash for
  * different operations to be carried out on NAND Flash */
 static void mxc_nand_command(struct mtd_info *mtd, unsigned command,
@@ -843,6 +1035,30 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 		oob_smallpage = &nandv1_hw_eccoob_smallpage;
 		oob_largepage = &nandv1_hw_eccoob_largepage;
 		this->ecc.bytes = 3;
+		host->eccsize = 1;
+	} else if (nfc_is_v3_2()) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res) {
+			err = -ENODEV;
+			goto eirq;
+		}
+		host->regs_ip = ioremap(res->start, resource_size(res));
+		if (!host->regs_ip) {
+			err = -ENOMEM;
+			goto eirq;
+		}
+		host->regs_axi = host->base + 0x1e00;
+		host->spare0 = host->base + 0x1000;
+		host->spare_len = 64;
+		host->preset = preset_v3;
+		host->send_cmd = send_cmd_v3;
+		host->send_addr = send_addr_v3;
+		host->send_page = send_page_v3;
+		host->send_read_id = send_read_id_v3;
+		host->check_int = check_int_v3;
+		host->get_dev_status = get_dev_status_v3;
+		oob_smallpage = &nandv2_hw_eccoob_smallpage;
+		oob_largepage = &nandv2_hw_eccoob_largepage;
 	} else
 		BUG();
 
@@ -920,6 +1136,8 @@ static int __init mxcnd_probe(struct platform_device *pdev)
 escan:
 	free_irq(host->irq, host);
 eirq:
+	if (host->regs_ip)
+		iounmap(host->regs_ip);
 	iounmap(host->base);
 eres:
 	clk_put(host->clk);
@@ -939,6 +1157,8 @@ static int __devexit mxcnd_remove(struct platform_device *pdev)
 
 	nand_release(&host->mtd);
 	free_irq(host->irq, host);
+	if (host->regs_ip)
+		iounmap(host->regs_ip);
 	iounmap(host->base);
 	kfree(host);
 
-- 
1.7.1
