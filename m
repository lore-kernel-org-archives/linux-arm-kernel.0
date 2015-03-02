From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  2 Mar 2015 13:28:23 +0200
Subject: [PATCH v2 2/2] mtd: nand: driver for Conexant Digicolor NAND Flash
 Controller
In-Reply-To: <fb9907fecb8b57d1b44ce03b97eb62225555de9f.1425295703.git.baruch@tkos.co.il>
References: <fb9907fecb8b57d1b44ce03b97eb62225555de9f.1425295703.git.baruch@tkos.co.il>
Message-ID: <fdcfa070d1c0209bb4a9c9b7cce52bd74081e92a.1425295703.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds driver for the NAND flash controller on the CX92755 SoC. This
SoC is one of the Conexant Digicolor series, and this driver should support
other SoCs in this series.

Only hardware syndrome ECC mode is currently supported.

This driver was tested on the Equinox CX92755 EVK, with the Samsung K9GAG08U0E
NAND chip (MLC, 8K pages, 436 bytes OOB). Test included attach of UBI volume,
mount of UBIFS filesystem, and files read/write.

The driver was also tested by all MTD tests (except torturetest), and passed
all of them. For oobtest the bitflip_limit parameter was set to 2.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
   * Address review comments of Boris Brezillon:
     - Fix MODULE_DEVICE_TABLE name
     - Remove digicolor_nfc_wait_ready() specific ops
     - Extend the comment on CMD_NUMBER_BYTES definition
     - Split bch_configs[] initialization from struct definition
     - digicolor_nfc_cmd_write() returns error on timeout
     - Differentiate between ETIMEDOUT and EIO in digicolor_nfc_ecc_status()
     - Bail out of digicolor_nfc_read_page_syndrome() on ECC status timeout
     - Remove redundant digicolor_nfc_dev_ready() after NAND_CMD_RESET
     - Fallback to ecc_strength_ds/ecc_step_ds when there are no ECC
       configuration DT properties
     - Add a comment explaining buffer tail handling in digicolor_nfc_rw_buf()
     - Split per-NAND chip fields into a separate struct
     - Use nand_sdr_timings to calculate signal timing configuration
     - dev_ready() returns 1 only when the chip is actually ready

   * Other changes:
     - Use readl_poll_timeout() in digicolor_nfc_wait_ready() instead of open
       coding the same functionality
     - Use memcpy() for buffer tail in digicolor_nfc_rw_buf()
     - Add ecc.write_oob that does the equivalent of ecc.read_oob; this fixes
       mtd_oobtest
     - Update commit message to reflect mtd tests status
     - Allow up to 4 bitflips on average per 1K of blank page; fixes
       mtd_oobtest error
---
 drivers/mtd/nand/Kconfig          |   6 +
 drivers/mtd/nand/Makefile         |   1 +
 drivers/mtd/nand/digicolor_nand.c | 663 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 670 insertions(+)
 create mode 100644 drivers/mtd/nand/digicolor_nand.c

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 5b76a173cd95..6ea9098e290d 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -529,4 +529,10 @@ config MTD_NAND_HISI504
 	help
 	  Enables support for NAND controller on Hisilicon SoC Hip04.
 
+config MTD_NAND_DIGICOLOR
+	tristate "Support for NAND on Conexant Digicolor SoCs"
+	depends on ARCH_DIGICOLOR
+	help
+	  Enables support for NAND Flash chips on Conexant Digicolor SoCs.
+
 endif # MTD_NAND
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 582bbd05aff7..1ae4cf0eec08 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -52,5 +52,6 @@ obj-$(CONFIG_MTD_NAND_XWAY)		+= xway_nand.o
 obj-$(CONFIG_MTD_NAND_BCM47XXNFLASH)	+= bcm47xxnflash/
 obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
 obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
+obj-$(CONFIG_MTD_NAND_DIGICOLOR)	+= digicolor_nand.o
 
 nand-objs := nand_base.o nand_bbt.o nand_timings.o
diff --git a/drivers/mtd/nand/digicolor_nand.c b/drivers/mtd/nand/digicolor_nand.c
new file mode 100644
index 000000000000..047f1cb86df4
--- /dev/null
+++ b/drivers/mtd/nand/digicolor_nand.c
@@ -0,0 +1,663 @@
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
+#include <linux/iopoll.h>
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
+#define CMD_NUMBER_BYTES(n)		((n) << 8) /* CLE/ALE commands */
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
+#define NFC_INT_CMD_READY		BIT(8)
+#define NFC_INT_DATA_READ_READY		BIT(9)
+#define NFC_INT_DATA_WRITE_READY	BIT(10)
+#define NFC_INT_COMMAND_COMPLETE_READY	BIT(11)
+#define NFC_INT_ECC_STATUS_READY	BIT(12)
+#define RDY(op)				NFC_INT_##op##_READY
+
+#define INITIAL_TCCS	500 /* ns; from the ONFI spec version 4.0, ?4.17.1 */
+#define TIMEOUT_MS	100
+
+struct digicolor_nand {
+	struct mtd_info		mtd;
+	struct nand_chip	nand;
+
+	u32 cs;
+	int t_ccs;
+};
+
+struct digicolor_nfc {
+	void __iomem		*regs;
+	struct device		*dev;
+	unsigned long		clk_rate;
+
+	u32 ale_cmd;
+	u32 ale_data;
+	int ale_data_bytes;
+	int ready_wait;
+
+	/* Only one NAND chip supported for now */
+	struct digicolor_nand	dc_nand;
+};
+
+struct bch_configs_t {
+	int bits;	/* correctable error bits number (strength) per step */
+	int r_bytes;	/* extra bytes needed per step */
+};
+
+/*
+ * Table of BCH configuration options. The index of this table (0 - 5) is set
+ * in the BchTconfig field of the NFC_CONTROL register.
+ */
+struct bch_configs_t bch_configs[] = {
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
+	int bitflip_limit = (len/1024) * 4;
+	u32 res;
+	int i;
+	unsigned int bitflips = 0;
+
+	for (i = 0; i < (len >> 2); i++) {
+		res = p[i] ^ 0xffffffff;
+		if (res)
+			bitflips += hweight32(res);
+	}
+
+	return bitflips <= bitflip_limit;
+}
+
+static int digicolor_nfc_wait_ready(struct digicolor_nfc *nfc, u32 mask)
+{
+	u32 status;
+	int ret;
+
+	ret = readl_poll_timeout(nfc->regs + NFC_INTFLAG_CLEAR, status,
+				 status & mask, 0, TIMEOUT_MS*1000);
+	if (ret == -ETIMEDOUT)
+		dev_err(nfc->dev, "register ready timeout (mask: %08x)\n",
+			mask);
+
+	return ret;
+}
+
+static int digicolor_nfc_cmd_write(struct digicolor_nfc *nfc, u32 data)
+{
+	if (digicolor_nfc_wait_ready(nfc, RDY(CMD)))
+		return -ETIMEDOUT;
+	writel_relaxed(data, nfc->regs + NFC_COMMAND);
+
+	return 0;
+}
+
+static int digicolor_nfc_ecc_status(struct digicolor_nfc *nfc)
+{
+	u32 status;
+
+	if (digicolor_nfc_wait_ready(nfc, RDY(ECC_STATUS)))
+		return -ETIMEDOUT;
+
+	status = readl_relaxed(nfc->regs + NFC_STATUS_1);
+	writel_relaxed(NFC_INT_ECC_STATUS_READY, nfc->regs + NFC_INTFLAG_CLEAR);
+
+	if (status & NFC_STATUS_1_UNCORRECTED_ERROR)
+		return -EIO;
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
+	u32 readready, status;
+	u32 cs = nfc->dc_nand.cs;
+
+	if (nfc->ready_wait) {
+		status = readl_relaxed(nfc->regs + NFC_INTFLAG_CLEAR);
+		if (status & RDY(COMMAND_COMPLETE)) {
+			nfc->ready_wait = 0;
+			writel_relaxed(RDY(COMMAND_COMPLETE),
+				       nfc->regs + NFC_INTFLAG_CLEAR);
+			return 1;
+		}
+		return 0;
+	}
+
+	readready = CMD_WAITREADY | CMD_CHIP_ENABLE(cs) | CMD_RB_MASK(cs)
+		| CMD_TOGGLE | CMD_RB_DATA | CMD_STOP_ON_COMPLETE;
+	digicolor_nfc_cmd_write(nfc, readready);
+	nfc->ready_wait = 1;
+
+	return 0;
+}
+
+static void digicolor_nfc_cmd_ctrl(struct mtd_info *mtd, int cmd,
+				   unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd->priv;
+	struct digicolor_nfc *nfc = chip->priv;
+	u32 cs = nfc->dc_nand.cs;
+
+	if (ctrl & NAND_CLE) {
+		digicolor_nfc_cmd_write(nfc,
+					CMD_CLE | CMD_CHIP_ENABLE(cs) | cmd);
+		if (cmd == NAND_CMD_RNDOUTSTART || cmd == NAND_CMD_RNDIN) {
+			digicolor_nfc_wait_ns(nfc, nfc->dc_nand.t_ccs);
+		} else if (cmd == NAND_CMD_RESET) {
+			digicolor_nfc_wait_ns(nfc, 200);
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
+	u32 cs = nfc->dc_nand.cs;
+
+	digicolor_nfc_cmd_write(nfc, read ? CMD_PAGEREAD : CMD_PAGEWRITE
+				| CMD_CHIP_ENABLE(cs));
+	digicolor_nfc_cmd_write(nfc, 1);
+
+	if (digicolor_nfc_wait_ready(nfc, read ?
+				     RDY(DATA_READ) : RDY(DATA_WRITE)))
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
+	struct mtd_info *mtd = &nfc->dc_nand.mtd;
+	uint32_t *pr = (uint32_t *)read_buf;
+	const uint32_t *pw = (const uint32_t *)write_buf;
+	u32 cs = nfc->dc_nand.cs;
+	bool read = (read_buf != NULL);
+	u32 op = read ? RDY(DATA_READ) : RDY(DATA_WRITE);
+	int i;
+	u32 cmd, data;
+
+	cmd = read_buf ? CMD_PAGEREAD : CMD_PAGEWRITE;
+	cmd |= CMD_CHIP_ENABLE(cs);
+	data = len & 0xffff;
+	if (ecc) {
+		cmd |= CMD_ECC_ENABLE | CMD_SKIP_LENGTH(1);
+		if (read)
+			cmd |= CMD_ECC_STATUS;
+		else
+			cmd |= CMD_IMMEDIATE_DATA;
+		data |= CMD_SKIP_OFFSET(mtd->writesize);
+	}
+
+	if (digicolor_nfc_cmd_write(nfc, cmd))
+		return;
+	if (digicolor_nfc_cmd_write(nfc, data))
+		return;
+
+	while (len >= 4) {
+		if (digicolor_nfc_wait_ready(nfc, op))
+			return;
+		if (read)
+			*pr++ = readl_relaxed(nfc->regs + NFC_DATA);
+		else
+			writel_relaxed(*pw++, nfc->regs + NFC_DATA);
+		len -= 4;
+	}
+
+	/*
+	 * The NFC_DATA register is 32bit wide, so we must write 4 bytes at a
+	 * time. In case we have a tail of less than 4 bytes (this might
+	 * happen when reading/writing the OOB area) we stuff these bytes into
+	 * the last register access.
+	 */
+	if (len > 0) {
+		u32 buf_tail = 0;
+
+		if (digicolor_nfc_wait_ready(nfc, op))
+			return;
+		if (read) {
+			buf_tail = readl_relaxed(nfc->regs + NFC_DATA);
+			memcpy(pr, &buf_tail, i);
+		} else {
+			memcpy(&buf_tail, pw, i);
+			writel_relaxed(buf_tail, nfc->regs + NFC_DATA);
+		}
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
+		if (ecc_stat == -EIO) {
+			if (!digicolor_nfc_buf_blank(buf, chip->ecc.size)) {
+				mtd->ecc_stats.failed++;
+				printk("%s: page: %d oob: %d\n", __func__,
+				       page, oob_required);
+			}
+		} else if (ecc_stat < 0) {
+			return ecc_stat;
+		} else /* ecc_stat >= 0 */ {
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
+static int digicolor_nfc_write_oob_syndrome(struct mtd_info *mtd,
+					    struct nand_chip *chip, int page)
+{
+	struct digicolor_nfc *nfc = chip->priv;
+	int status;
+
+	chip->cmdfunc(mtd, NAND_CMD_SEQIN, mtd->writesize, page);
+	digicolor_nfc_rw_buf(nfc, NULL, chip->oob_poi, mtd->oobsize, false);
+	chip->cmdfunc(mtd, NAND_CMD_PAGEPROG, -1, -1);
+	status = chip->waitfunc(mtd, chip);
+
+	return status & NAND_STATUS_FAIL ? -EIO : 0;
+}
+
+static void digicolor_nfc_hw_init(struct digicolor_nfc *nfc)
+{
+	struct nand_chip *nand = &nfc->dc_nand.nand;
+	unsigned int ns_per_clk = NSEC_PER_SEC / nfc->clk_rate;
+	unsigned int ps_per_clk = ns_per_clk * 1000;
+	const struct nand_sdr_timings *timings;
+	u32 timing = 0;
+	u32 assert_t, deassert_t;
+	int sample_t;
+
+	writel_relaxed(NFC_CONTROL_LOCAL_RESET, nfc->regs + NFC_CONTROL);
+	udelay(10);
+	writel_relaxed(0, nfc->regs + NFC_CONTROL);
+	udelay(5);
+
+	timings = onfi_async_timing_mode_to_sdr_timings(
+		nand->onfi_timing_mode_default);
+
+	deassert_t = max(timings->tWH_min, timings->tREH_min);
+	timing |= TIMING_DEASSERT(DIV_ROUND_UP(deassert_t, ps_per_clk));
+
+	assert_t = max(max(timings->tRC_min, timings->tRP_min),
+		       max(timings->tWC_min, timings->tWP_min));
+	timing |= TIMING_ASSERT(DIV_ROUND_UP(assert_t, ps_per_clk));
+
+	sample_t = max_t(int, 0,
+			 timings->tREA_max + timings->tRHOH_min - assert_t);
+	timing |= TIMING_SAMPLE(DIV_ROUND_UP(sample_t, ps_per_clk));
+
+	writel_relaxed(timing, nfc->regs + NFC_TIMING_CONFIG);
+	writel_relaxed(NFC_CONTROL_ENABLE, nfc->regs + NFC_CONTROL);
+}
+
+static int digicolor_nfc_ecc_init(struct digicolor_nfc *nfc,
+				  struct device_node *np)
+{
+	struct mtd_info *mtd = &nfc->dc_nand.mtd;
+	struct nand_chip *chip = &nfc->dc_nand.nand;
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
+		bch_data_range = chip->ecc_step_ds;
+	if (bch_data_range != 512 && bch_data_range != 1024) {
+		dev_err(nfc->dev, "unsupported ECC step value (%d)\n",
+			bch_data_range);
+		return -EINVAL;
+	}
+	if (bch_data_range == 1024)
+		ctrl |= NFC_CONTROL_BCH_DATA_FIELD_RANGE_1024;
+	steps = mtd->writesize / bch_data_range;
+
+	bch_t = of_get_nand_ecc_strength(np);
+	if (bch_t < 0)
+		bch_t = chip->ecc_strength_ds;
+	for (i = 0; i < ARRAY_SIZE(bch_configs); i++)
+		if (bch_configs[i].bits >= bch_t)
+			break;
+	if (i >= ARRAY_SIZE(bch_configs)) {
+		dev_err(nfc->dev, "unsupported ECC strength value (%d)\n",
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
+	chip->ecc.write_oob = digicolor_nfc_write_oob_syndrome;
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
+	chip = &nfc->dc_nand.nand;
+	mtd = &nfc->dc_nand.mtd;
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
+	nfc->dc_nand.cs = cs;
+
+	nfc->dc_nand.t_ccs = INITIAL_TCCS;
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
+	nand_release(&nfc->dc_nand.mtd);
+
+	return 0;
+}
+
+static const struct of_device_id digicolor_nfc_ids[] = {
+	{ .compatible = "cnxt,cx92755-nfc" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, digicolor_nfc_ids);
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
