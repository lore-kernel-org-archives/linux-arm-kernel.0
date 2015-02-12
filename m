From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 12 Feb 2015 13:10:19 +0200
Subject: [PATCH 2/2] mtd: nand: driver for Conexant Digicolor NAND Flash
 Controller
In-Reply-To: <e6a998f130c40cee0a72e23b4f7f65bece0d6b21.1423739332.git.baruch@tkos.co.il>
References: <e6a998f130c40cee0a72e23b4f7f65bece0d6b21.1423739332.git.baruch@tkos.co.il>
Message-ID: <ffec2fc232083355fdb171efb9daf59686ac2fed.1423739332.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds driver for the NAND flash controller on the CX92755 SoC. This
SoC is one of the Conexant Digicolor series, and this driver should support
other SoCs in this series.

Only hardware syndrome ECC mode is currently supported.

This driver was tested on the Equinox CX92755 EVK, with the Samsung K9GAG08U0E
NAND chip (MLC, 8K pages, 436 bytes OOB). Test included attach of UBI volume,
mount of UBIFS filesystem, and files read/write.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/mtd/nand/Kconfig          |   6 +
 drivers/mtd/nand/Makefile         |   1 +
 drivers/mtd/nand/digicolor_nand.c | 616 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 623 insertions(+)
 create mode 100644 drivers/mtd/nand/digicolor_nand.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7d0150d20432..035f0078e62e 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -524,4 +524,10 @@ config MTD_NAND_SUNXI
 	help
 	  Enables support for NAND Flash chips on Allwinner SoCs.
 
+config MTD_NAND_DIGICOLOR
+	tristate "Support for NAND on Conexant Digicolor SoCs"
+	depends on ARCH_DIGICOLOR
+	help
+	  Enables support for NAND Flash chips on Conexant Digicolor SoCs.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index bd38f21d2e28..e7fd578123cd 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -51,5 +51,6 @@ obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
 obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
 obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
 obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
+obj-$(CONFIG_MTD_NAND_DIGICOLOR)	+= digicolor_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o
diff --git a/drivers/mtd/nand/digicolor_nand.c b/drivers/mtd/nand/digicolor_nand.c
new file mode 100644
index 000000000000..5249953c7eba
--- /dev/null
+++ b/drivers/mtd/nand/digicolor_nand.c
@@ -0,0 +1,616 @@
+/*
+ *  Driver for Conexant Digicolor NAND Flash Controller
+ *
+ * Author: Baruch Siach <baruch@tkos.co.il>
+ *
+ * Copyright (C) 2014, 2015 Paradox Innovation Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_mtd.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+
+#define DRIVER_NAME "digicolor_nand"
+
+#define NFC_CONTROL			0x180
+#define NFC_CONTROL_LOCAL_RESET		BIT(0)
+#define NFC_CONTROL_ENABLE		BIT(1)
+#define NFC_CONTROL_BCH_TCONFIG(n)	((n) << 13)
+#define NFC_CONTROL_BCH_KCONFIG		(77 << 16)
+#define NFC_CONTROL_BCH_DATA_FIELD_RANGE_1024	BIT(30)
+
+#define NFC_STATUS_1			0x18c
+#define NFC_STATUS_1_CORRECTABLE_ERRORS(reg)	(((reg) >> 16) & 0x7ff)
+#define NFC_STATUS_1_UNCORRECTED_ERROR	BIT(31)
+
+#define NFC_COMMAND			0x1a0
+#define NFC_COMMAND_CODE_OFF		28
+#define CMD_CHIP_ENABLE(n)		((~(1 << (n)) & 0xf) << 20)
+#define CMD_STOP_ON_COMPLETE		BIT(15)
+#define CMD_ECC_ENABLE			BIT(13)
+#define CMD_TOGGLE			BIT(13) /* WAIT READY command */
+#define CMD_ECC_STATUS			BIT(12)
+#define CMD_RB_DATA			BIT(12) /* WAIT READY command */
+#define CMD_NUMBER_BYTES(n)		((n) << 8) /* ALE command */
+#define CMD_SKIP_LENGTH(n)		(((n) & 0xf) << 8) /* READ/WRITE */
+#define CMD_SKIP_OFFSET(n)		((n) << 16)
+#define CMD_RB_MASK(n)			((1 << (n)) & 0xf)
+#define CMD_IMMEDIATE_DATA		0xff /* bad block mark */
+
+#define CMD_CLE				(0 << NFC_COMMAND_CODE_OFF)
+#define CMD_ALE				(1 << NFC_COMMAND_CODE_OFF)
+#define CMD_PAGEREAD			(2 << NFC_COMMAND_CODE_OFF)
+#define CMD_PAGEWRITE			(3 << NFC_COMMAND_CODE_OFF)
+#define CMD_WAITREADY			(4 << NFC_COMMAND_CODE_OFF)
+#define CMD_WAIT			(5 << NFC_COMMAND_CODE_OFF)
+
+#define NFC_DATA			0x1c0
+#define ALE_DATA_OFF(n)			(((n)-1)*8)
+
+#define NFC_TIMING_CONFIG		0x1c4
+#define TIMING_ASSERT(clk)		((clk) & 0xff)
+#define TIMING_DEASSERT(clk)		(((clk) & 0xff) << 8)
+#define TIMING_SAMPLE(clk)		(((clk) & 0xf) << 24)
+
+#define NFC_INTFLAG_CLEAR		0x1c8
+#define NFC_INT_CMDREG_READY		BIT(8)
+#define NFC_INT_READ_DATAREG_READY	BIT(9)
+#define NFC_INT_WRITE_DATAREG_READY	BIT(10)
+#define NFC_INT_COMMAND_COMPLETE	BIT(11)
+#define NFC_INT_ECC_STATUS_READY	BIT(12)
+
+/* IO registers operations */
+enum { CMD, DATA_READ, DATA_WRITE, ECC_STATUS };
+
+#define INITIAL_TCCS	500 /* ns; from the ONFI spec version 4.0, ?4.17.1 */
+#define TIMEOUT_MS	100
+
+struct digicolor_nfc {
+	void __iomem		*regs;
+	struct mtd_info		mtd;
+	struct nand_chip	nand;
+	struct device		*dev;
+
+	unsigned long		clk_rate;
+
+	u32 ale_cmd;
+	u32 ale_data;
+	int ale_data_bytes;
+
+	u32 nand_cs;
+	int t_ccs;
+};
+
+/*
+ * Table of BCH configuration options. The index of this table (0 - 5) is set
+ * in the BchTconfig field of the NFC_CONTROL register.
+ */
+struct bch_configs_t {
+	int bits;	/* correctable error bits number (strength) per step */
+	int r_bytes;	/* extra bytes needed per step */
+} bch_configs[] = {
+	{  6, 11 },
+	{  7, 13 },
+	{  8, 14 },
+	{ 24, 42 },
+	{ 28, 49 },
+	{ 30, 53 },
+};
+
+static int digicolor_nfc_buf_blank(const uint8_t *buf, int len)
+{
+	const uint32_t *p = (const uint32_t *)buf;
+	int i;
+
+	for (i = 0; i < (len >> 2); i++)
+		if (p[i] != 0xffffffff)
+			return 0;
+
+	return 1;
+}
+
+static bool digicolor_nfc_ready(struct digicolor_nfc *nfc, u32 mask)
+{
+	u32 status = readl_relaxed(nfc->regs + NFC_INTFLAG_CLEAR);
+
+	return !!(status & mask);
+}
+
+static int digicolor_nfc_wait_ready(struct digicolor_nfc *nfc, int op)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(TIMEOUT_MS);
+	u32 mask;
+
+	switch (op) {
+	case CMD:		mask = NFC_INT_CMDREG_READY; break;
+	case DATA_READ:		mask = NFC_INT_READ_DATAREG_READY; break;
+	case DATA_WRITE:	mask = NFC_INT_WRITE_DATAREG_READY; break;
+	case ECC_STATUS:	mask = NFC_INT_ECC_STATUS_READY; break;
+	}
+
+	do {
+		if (digicolor_nfc_ready(nfc, mask))
+			return 0;
+	} while (time_before(jiffies, timeout));
+
+	dev_err(nfc->dev, "register ready (op: %d) timeout\n", op);
+	return -ETIMEDOUT;
+}
+
+static void digicolor_nfc_cmd_write(struct digicolor_nfc *nfc, u32 data)
+{
+	if (digicolor_nfc_wait_ready(nfc, CMD))
+		return;
+	writel_relaxed(data, nfc->regs + NFC_COMMAND);
+}
+
+static int digicolor_nfc_ecc_status(struct digicolor_nfc *nfc)
+{
+	u32 status;
+
+	if (digicolor_nfc_wait_ready(nfc, ECC_STATUS))
+		return -1;
+
+	status = readl_relaxed(nfc->regs + NFC_STATUS_1);
+	writel_relaxed(NFC_INT_ECC_STATUS_READY, nfc->regs + NFC_INTFLAG_CLEAR);
+
+	if (status & NFC_STATUS_1_UNCORRECTED_ERROR)
+		return -1;
+
+	return NFC_STATUS_1_CORRECTABLE_ERRORS(status);
+}
+
+static void digicolor_nfc_wait_ns(struct digicolor_nfc *nfc, int wait_ns)
+{
+	uint64_t tmp = ((uint64_t) nfc->clk_rate * wait_ns);
+	u8 clk;
+
+	do_div(tmp, NSEC_PER_SEC);
+	clk = tmp > 0xff ? 0xff : tmp;
+	digicolor_nfc_cmd_write(nfc, CMD_WAIT | clk);
+}
+
+static int digicolor_nfc_dev_ready(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+	u32 readready;
+	u32 cs = nfc->nand_cs;
+
+	readready = CMD_WAITREADY | CMD_CHIP_ENABLE(cs) | CMD_RB_MASK(cs)
+		| CMD_TOGGLE | CMD_RB_DATA;
+	digicolor_nfc_cmd_write(nfc, readready);
+
+	return 1;
+}
+
+static void digicolor_nfc_cmd_ctrl(struct mtd_info *mtd, int cmd,
+				   unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+	u32 cs = nfc->nand_cs;
+
+	if (ctrl & NAND_CLE) {
+		digicolor_nfc_cmd_write(nfc,
+					CMD_CLE | CMD_CHIP_ENABLE(cs) | cmd);
+		if (cmd == NAND_CMD_RNDOUTSTART || cmd == NAND_CMD_RNDIN) {
+			digicolor_nfc_wait_ns(nfc, nfc->t_ccs);
+		} else if (cmd == NAND_CMD_RESET) {
+			digicolor_nfc_wait_ns(nfc, 200);
+			digicolor_nfc_dev_ready(mtd);
+		}
+	} else if (ctrl & NAND_ALE) {
+		if (ctrl & NAND_CTRL_CHANGE) {
+			/* First ALE data byte */
+			nfc->ale_cmd = CMD_ALE | CMD_CHIP_ENABLE(cs)
+				| (cmd & 0xff);
+			nfc->ale_data_bytes++;
+			return;
+		}
+		/* More ALE data bytes. Assume no more than 5 address cycles */
+		nfc->ale_data |= cmd << ALE_DATA_OFF(nfc->ale_data_bytes++);
+		return;
+	} else if (nfc->ale_data_bytes > 0) {
+		/* Finish ALE */
+		nfc->ale_cmd |= CMD_NUMBER_BYTES(nfc->ale_data_bytes - 1);
+		digicolor_nfc_cmd_write(nfc, nfc->ale_cmd);
+		if (nfc->ale_data_bytes > 1)
+			digicolor_nfc_cmd_write(nfc, nfc->ale_data);
+		nfc->ale_data_bytes = nfc->ale_data = 0;
+	}
+}
+
+static uint8_t digicolor_nfc_rw_byte(struct digicolor_nfc *nfc, int byte)
+{
+	bool read = (byte == -1);
+	u32 cs = nfc->nand_cs;
+
+	digicolor_nfc_cmd_write(nfc, read ? CMD_PAGEREAD : CMD_PAGEWRITE
+				| CMD_CHIP_ENABLE(cs));
+	digicolor_nfc_cmd_write(nfc, 1);
+
+	if (digicolor_nfc_wait_ready(nfc, read ? DATA_READ : DATA_WRITE))
+		return 0;
+
+	if (read)
+		return readl_relaxed(nfc->regs + NFC_DATA);
+	else
+		writel_relaxed(byte & 0xff, nfc->regs + NFC_DATA);
+
+	return 0;
+}
+
+static uint8_t digicolor_nfc_read_byte(struct mtd_info *mtd)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+
+	return digicolor_nfc_rw_byte(nfc, -1);
+}
+
+static void digicolor_nfc_write_byte(struct mtd_info *mtd, uint8_t byte)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+
+	digicolor_nfc_rw_byte(nfc, byte);
+}
+
+static void digicolor_nfc_rw_buf(struct digicolor_nfc *nfc, uint8_t *read_buf,
+				 const uint8_t *write_buf, int len, bool ecc)
+{
+	uint32_t *pr = (uint32_t *)read_buf;
+	const uint32_t *pw = (const uint32_t *)write_buf;
+	u32 cs = nfc->nand_cs;
+	int op = read_buf ? DATA_READ : DATA_WRITE;
+	int i;
+	u32 cmd, data, buf_tail;
+
+	cmd = read_buf ? CMD_PAGEREAD : CMD_PAGEWRITE;
+	cmd |= CMD_CHIP_ENABLE(cs);
+	data = len & 0xffff;
+	if (ecc) {
+		cmd |= CMD_ECC_ENABLE | CMD_SKIP_LENGTH(1);
+		if (op == DATA_READ)
+			cmd |= CMD_ECC_STATUS;
+		if (op == DATA_WRITE)
+			cmd |= CMD_IMMEDIATE_DATA;
+		data |= CMD_SKIP_OFFSET(nfc->mtd.writesize);
+	}
+
+	digicolor_nfc_cmd_write(nfc, cmd);
+	digicolor_nfc_cmd_write(nfc, data);
+
+	while (len >= 4) {
+		if (digicolor_nfc_wait_ready(nfc, op))
+			return;
+		if (op == DATA_READ)
+			*pr++ = readl_relaxed(nfc->regs + NFC_DATA);
+		else
+			writel_relaxed(*pw++, nfc->regs + NFC_DATA);
+		len -= 4;
+	}
+
+	if (len > 0) {
+		if (digicolor_nfc_wait_ready(nfc, op))
+			return;
+		if (op == DATA_READ)
+			buf_tail = readl_relaxed(nfc->regs + NFC_DATA);
+		for (i = 0; i < len; i++) {
+			u8 *tr = (u8 *)pr;
+			const u8 *tw = (const u8 *)pw;
+
+			if (op == DATA_READ) {
+				tr[i] = buf_tail & 0xff;
+				buf_tail >>= 8;
+			} else {
+				buf_tail <<= 8;
+				buf_tail |= tw[i];
+			}
+		}
+		if (op == DATA_WRITE)
+			writel_relaxed(buf_tail, nfc->regs + NFC_DATA);
+	}
+}
+
+static void digicolor_nfc_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+
+	digicolor_nfc_rw_buf(nfc, buf, NULL, len, false);
+}
+
+static void digicolor_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+				    int len)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+
+	digicolor_nfc_rw_buf(nfc, NULL, buf, len, false);
+}
+
+static int digicolor_nfc_read_page_syndrome(struct mtd_info *mtd,
+					    struct nand_chip *chip,
+					    uint8_t *buf, int oob_required,
+					    int page)
+{
+	struct digicolor_nfc *nfc = chip->priv;
+	int step, ecc_stat;
+	struct nand_oobfree *oobfree = &chip->ecc.layout->oobfree[0];
+	u8 *oob = chip->oob_poi + oobfree->offset;
+	unsigned int max_bitflips = 0;
+
+	for (step = 0; step < chip->ecc.steps; step++) {
+		digicolor_nfc_rw_buf(nfc, buf, NULL, chip->ecc.size, true);
+
+		ecc_stat = digicolor_nfc_ecc_status(nfc);
+		if (ecc_stat < 0 &&
+		    !digicolor_nfc_buf_blank(buf, chip->ecc.size)) {
+			mtd->ecc_stats.failed++;
+		} else if (ecc_stat > 0) {
+			mtd->ecc_stats.corrected += ecc_stat;
+			max_bitflips = max_t(unsigned int, max_bitflips,
+					     ecc_stat);
+		}
+
+		buf += chip->ecc.size;
+	}
+
+	if (oob_required)
+		digicolor_nfc_rw_buf(nfc, oob, NULL, oobfree->length, false);
+
+	return max_bitflips;
+}
+
+static int digicolor_nfc_write_page_syndrome(struct mtd_info *mtd,
+					     struct nand_chip *chip,
+					     const uint8_t *buf,
+					     int oob_required)
+{
+	struct digicolor_nfc *nfc = chip->priv;
+	struct nand_oobfree *oobfree = &chip->ecc.layout->oobfree[0];
+	u8 *oob = chip->oob_poi + oobfree->offset;
+
+	digicolor_nfc_rw_buf(nfc, NULL, buf, mtd->writesize, true);
+
+	if (oob_required)
+		digicolor_nfc_rw_buf(nfc, NULL, oob, oobfree->length, false);
+
+	return 0;
+}
+
+static int digicolor_nfc_read_oob_syndrome(struct mtd_info *mtd,
+					   struct nand_chip *chip, int page)
+{
+	struct digicolor_nfc *nfc = chip->priv;
+
+	chip->cmdfunc(mtd, NAND_CMD_READ0, mtd->writesize, page);
+	digicolor_nfc_rw_buf(nfc, chip->oob_poi, NULL, mtd->oobsize, false);
+
+	return 0;
+}
+
+static void digicolor_nfc_hw_init(struct digicolor_nfc *nfc)
+{
+	unsigned int ns_per_clk = NSEC_PER_SEC / nfc->clk_rate;
+	u32 timing = 0;
+
+	writel_relaxed(NFC_CONTROL_LOCAL_RESET, nfc->regs + NFC_CONTROL);
+	udelay(10);
+	writel_relaxed(0, nfc->regs + NFC_CONTROL);
+	udelay(5);
+	/*
+	 * Maximum assert/deassert time; asynchronous SDR mode 0
+	 * Deassert time = max(tWH,tREH) = 30ns
+	 * Assert time = max(tRC,tRP,tWC,tWP) = 100ns
+	 * Sample time = 0
+	 */
+	timing |= TIMING_DEASSERT(DIV_ROUND_UP(30, ns_per_clk));
+	timing |= TIMING_ASSERT(DIV_ROUND_UP(100, ns_per_clk));
+	timing |= TIMING_SAMPLE(0);
+	writel_relaxed(timing, nfc->regs + NFC_TIMING_CONFIG);
+	writel_relaxed(NFC_CONTROL_ENABLE, nfc->regs + NFC_CONTROL);
+}
+
+static int digicolor_nfc_ecc_init(struct digicolor_nfc *nfc,
+				  struct device_node *np)
+{
+	struct mtd_info *mtd = &nfc->mtd;
+	struct nand_chip *chip = &nfc->nand;
+	int bch_data_range, bch_t, steps, mode, i;
+	u32 ctrl = NFC_CONTROL_ENABLE | NFC_CONTROL_BCH_KCONFIG;
+	struct nand_ecclayout *layout;
+
+	mode = of_get_nand_ecc_mode(np);
+	if (mode < 0)
+		return mode;
+	if (mode != NAND_ECC_HW_SYNDROME) {
+		dev_err(nfc->dev, "unsupported ECC mode\n");
+		return -EINVAL;
+	}
+
+	bch_data_range = of_get_nand_ecc_step_size(np);
+	if (bch_data_range < 0)
+		return bch_data_range;
+	if (bch_data_range != 512 && bch_data_range != 1024) {
+		dev_err(nfc->dev, "unsupported nand-ecc-step-size value\n");
+		return -EINVAL;
+	}
+	if (bch_data_range == 1024)
+		ctrl |= NFC_CONTROL_BCH_DATA_FIELD_RANGE_1024;
+	steps = mtd->writesize / bch_data_range;
+
+	bch_t = of_get_nand_ecc_strength(np);
+	if (bch_t < 0)
+		return bch_t;
+	for (i = 0; i < ARRAY_SIZE(bch_configs); i++)
+		if (bch_t == bch_configs[i].bits)
+			break;
+	if (i >= ARRAY_SIZE(bch_configs)) {
+		dev_err(nfc->dev, "unsupported nand-ecc-strength value %d\n",
+			bch_t);
+		return -EINVAL;
+	}
+	if (bch_configs[i].r_bytes * steps > (mtd->oobsize-1)) {
+		dev_err(nfc->dev, "OOB too small for selected ECC strength\n");
+		return -EINVAL;
+	}
+	ctrl |= NFC_CONTROL_BCH_TCONFIG(i);
+
+	writel_relaxed(ctrl, nfc->regs + NFC_CONTROL);
+
+	chip->ecc.size = bch_data_range;
+	chip->ecc.strength = bch_t;
+	chip->ecc.bytes = bch_configs[i].r_bytes;
+	chip->ecc.steps = steps;
+	chip->ecc.mode = mode;
+	chip->ecc.read_page = digicolor_nfc_read_page_syndrome;
+	chip->ecc.write_page = digicolor_nfc_write_page_syndrome;
+	chip->ecc.read_oob = digicolor_nfc_read_oob_syndrome;
+
+	layout = devm_kzalloc(nfc->dev, sizeof(*layout), GFP_KERNEL);
+	if (layout == NULL)
+		return -ENOMEM;
+	layout->eccbytes = chip->ecc.bytes * steps;
+	/* leave 1 byte for bad block mark at the beginning of oob */
+	for (i = 0; i < layout->eccbytes; i++)
+		layout->eccpos[i] = i + 1;
+	layout->oobfree[0].length = mtd->oobsize - layout->eccbytes - 1;
+	layout->oobfree[0].offset = layout->eccbytes + 1;
+
+	chip->ecc.layout = layout;
+
+	return 0;
+}
+
+static int digicolor_nfc_probe(struct platform_device *pdev)
+{
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	struct digicolor_nfc *nfc;
+	struct resource *r;
+	struct clk *clk;
+	struct device_node *nand_np;
+	struct mtd_part_parser_data ppdata;
+	int irq, ret;
+	u32 cs;
+
+	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
+	if (!nfc)
+		return -ENOMEM;
+
+	nfc->dev = &pdev->dev;
+	chip = &nfc->nand;
+	mtd = &nfc->mtd;
+	mtd->priv = chip;
+	mtd->dev.parent = &pdev->dev;
+	mtd->owner = THIS_MODULE;
+	mtd->name = DRIVER_NAME;
+
+	chip->priv = nfc;
+	chip->cmd_ctrl = digicolor_nfc_cmd_ctrl;
+	chip->read_byte = digicolor_nfc_read_byte;
+	chip->read_buf = digicolor_nfc_read_buf;
+	chip->write_byte = digicolor_nfc_write_byte;
+	chip->write_buf = digicolor_nfc_write_buf;
+	chip->dev_ready = digicolor_nfc_dev_ready;
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	nfc->clk_rate = clk_get_rate(clk);
+
+	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	nfc->regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(nfc->regs))
+		return PTR_ERR(nfc->regs);
+
+	irq = platform_get_irq(pdev, 0);
+	if (IS_ERR_VALUE(irq))
+		return irq;
+
+	if (of_get_child_count(pdev->dev.of_node) > 1)
+		dev_warn(&pdev->dev,
+			 "only one NAND chip is currently supported\n");
+	nand_np = of_get_next_available_child(pdev->dev.of_node, NULL);
+	if (!nand_np) {
+		dev_err(&pdev->dev, "missing NAND chip node\n");
+		return -ENXIO;
+	}
+	ret = of_property_read_u32(nand_np, "reg", &cs);
+	if (ret) {
+		dev_err(&pdev->dev, "%s: no valid reg property\n",
+			nand_np->full_name);
+		return ret;
+	}
+	nfc->nand_cs = cs;
+
+	nfc->t_ccs = INITIAL_TCCS;
+
+	digicolor_nfc_hw_init(nfc);
+
+	ret = nand_scan_ident(mtd, 1, NULL);
+	if (ret)
+		return ret;
+	ret = digicolor_nfc_ecc_init(nfc, nand_np);
+	if (ret)
+		return ret;
+	ret = nand_scan_tail(mtd);
+	if (ret)
+		return ret;
+
+	ppdata.of_node = nand_np;
+	ret = mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
+	if (ret) {
+		nand_release(mtd);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, nfc);
+
+	return 0;
+}
+
+static int digicolor_nfc_remove(struct platform_device *pdev)
+{
+	struct digicolor_nfc *nfc = platform_get_drvdata(pdev);
+
+	nand_release(&nfc->mtd);
+
+	return 0;
+}
+
+static const struct of_device_id digicolor_nfc_ids[] = {
+	{ .compatible = "cnxt,cx92755-nfc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sunxi_nfc_ids);
+
+static struct platform_driver digicolor_nfc_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = digicolor_nfc_ids,
+	},
+	.probe = digicolor_nfc_probe,
+	.remove = digicolor_nfc_remove,
+};
+module_platform_driver(digicolor_nfc_driver);
+
+MODULE_AUTHOR("Baruch Siach <baruch@tkos.co.il>");
+MODULE_DESCRIPTION("Conexant Digicolor NAND Flash Controller");
+MODULE_LICENSE("GPL");
-- 
2.1.4
