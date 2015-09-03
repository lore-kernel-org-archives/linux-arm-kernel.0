From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Sep 2015 18:06:33 -0700
Subject: [PATCH v12 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <1441242397-870-1-git-send-email-stefan@agner.ch>
References: <1441242397-870-1-git-send-email-stefan@agner.ch>
Message-ID: <1441242397-870-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver supports Freescale NFC (NAND flash controller) found on
Vybrid (VF610), MPC5125, MCF54418 and Kinetis K70. The driver has
been tested using 8-bit and 16-bit NAND interface on the ARM based
Vybrid SoC VF500 and VF610 platform.
parameter page reading.

Limitations:
- Untested on MPC5125 and M54418.
- DMA and pipelining not used.
- 2K pages or less.
- No chip select, one NAND chip per controller.
- No hardware ECC.

Some paths have been hand-optimized and evaluated by measurements
made using mtd_speedtest.ko on a 100MB MTD partition.

Colibri VF50
        eb write     %   eb read     %   page write      %   page read     %
rel/opt     5175           11537                4560             11039
opt         5164 -0.21     11420 -1.01          4737 +3.88       10918 -1.10
none        5113 -1.20     11352 -1.60          4490 -1.54       10865 -1.58

Colibri VF61
        eb write     %   eb read     %   page write      %   page read     %
rel/opt     5766           13096                5459             12846
opt         5883 +2.03     13064 -0.24          5561 +1.87       12802 -0.34
none        5701 -1.13     12980 -0.89          5488 +0.53       12735 -0.86

rel = using readl_relaxed/writel_relaxed in optimized paths
opt = hand-optimized by combining multiple accesses into one read/write

The measurements have not been statistically verfied, hence use them
with care. The author came to the conclusion that using the relaxed
variants of readl/writel are not worth the additional code.

Signed-off-by: Bill Pringlemeir <bpringlemeir@nbsps.com>
Tested-by: Albert ARIBAUD <albert.aribaud@3adev.fr>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 MAINTAINERS                  |   6 +
 drivers/mtd/nand/Kconfig     |   9 +
 drivers/mtd/nand/Makefile    |   1 +
 drivers/mtd/nand/vf610_nfc.c | 686 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 702 insertions(+)
 create mode 100644 drivers/mtd/nand/vf610_nfc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9567329..59975c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10835,6 +10835,12 @@ S:	Maintained
 F:	Documentation/fb/uvesafb.txt
 F:	drivers/video/fbdev/uvesafb.*
 
+VF610 NAND DRIVER
+M:	Stefan Agner <stefan@agner.ch>
+L:	linux-mtd at lists.infradead.org
+S:	Supported
+F:	drivers/mtd/nand/vf610_nfc.c
+
 VFAT/FAT/MSDOS FILESYSTEM
 M:	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
 S:	Maintained
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 3324281..9f9736c 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -460,6 +460,15 @@ config MTD_NAND_MPC5121_NFC
 	  This enables the driver for the NAND flash controller on the
 	  MPC5121 SoC.
 
+config MTD_NAND_VF610_NFC
+	tristate "Support for Freescale NFC for VF610/MPC5125"
+	depends on (SOC_VF610 || COMPILE_TEST)
+	help
+	  Enables support for NAND Flash Controller on some Freescale
+	  processors like the VF610, MPC5125, MCF54418 or Kinetis K70.
+	  The driver supports a maximum 2k page size. The driver
+	  currently does not support hardware ECC.
+
 config MTD_NAND_MXC
 	tristate "MXC NAND support"
 	depends on ARCH_MXC
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 1f897ec..a490af8 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_MTD_NAND_SOCRATES)		+= socrates_nand.o
 obj-$(CONFIG_MTD_NAND_TXX9NDFMC)	+= txx9ndfmc.o
 obj-$(CONFIG_MTD_NAND_NUC900)		+= nuc900_nand.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
+obj-$(CONFIG_MTD_NAND_VF610_NFC)	+= vf610_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
 obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
new file mode 100644
index 0000000..0d76b3d1247
--- /dev/null
+++ b/drivers/mtd/nand/vf610_nfc.c
@@ -0,0 +1,686 @@
+/*
+ * Copyright 2009-2015 Freescale Semiconductor, Inc. and others
+ *
+ * Description: MPC5125, VF610, MCF54418 and Kinetis K70 Nand driver.
+ * Jason ported to M54418TWR and MVFA5 (VF610).
+ * Authors: Stefan Agner <stefan.agner@toradex.com>
+ *          Bill Pringlemeir <bpringlemeir@nbsps.com>
+ *          Shaohui Xie <b21989@freescale.com>
+ *          Jason Jin <Jason.jin@freescale.com>
+ *
+ * Based on original driver mpc5121_nfc.c.
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Limitations:
+ * - Untested on MPC5125 and M54418.
+ * - DMA and pipelining not used.
+ * - 2K pages or less.
+ * - No chip select, one NAND chip per controller.
+ * - No hardware ECC.
+ */
+
+#include <linux/module.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_mtd.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define	DRV_NAME		"vf610_nfc"
+
+/* Register Offsets */
+#define NFC_FLASH_CMD1			0x3F00
+#define NFC_FLASH_CMD2			0x3F04
+#define NFC_COL_ADDR			0x3F08
+#define NFC_ROW_ADDR			0x3F0c
+#define NFC_ROW_ADDR_INC		0x3F14
+#define NFC_FLASH_STATUS1		0x3F18
+#define NFC_FLASH_STATUS2		0x3F1c
+#define NFC_CACHE_SWAP			0x3F28
+#define NFC_SECTOR_SIZE			0x3F2c
+#define NFC_FLASH_CONFIG		0x3F30
+#define NFC_IRQ_STATUS			0x3F38
+
+/* Addresses for NFC MAIN RAM BUFFER areas */
+#define NFC_MAIN_AREA(n)		((n) *  0x1000)
+
+#define PAGE_2K				0x0800
+#define OOB_64				0x0040
+#define OOB_MAX				0x0100
+
+/*
+ * NFC_CMD2[CODE] values. See section:
+ *  - 31.4.7 Flash Command Code Description, Vybrid manual
+ *  - 23.8.6 Flash Command Sequencer, MPC5125 manual
+ *
+ * Briefly these are bitmasks of controller cycles.
+ */
+#define READ_PAGE_CMD_CODE		0x7EE0
+#define READ_ONFI_PARAM_CMD_CODE	0x4860
+#define PROGRAM_PAGE_CMD_CODE		0x7FC0
+#define ERASE_CMD_CODE			0x4EC0
+#define READ_ID_CMD_CODE		0x4804
+#define RESET_CMD_CODE			0x4040
+#define STATUS_READ_CMD_CODE		0x4068
+
+/* NFC ECC mode define */
+#define ECC_BYPASS			0
+
+/*** Register Mask and bit definitions */
+
+/* NFC_FLASH_CMD1 Field */
+#define CMD_BYTE2_MASK				0xFF000000
+#define CMD_BYTE2_SHIFT				24
+
+/* NFC_FLASH_CM2 Field */
+#define CMD_BYTE1_MASK				0xFF000000
+#define CMD_BYTE1_SHIFT				24
+#define CMD_CODE_MASK				0x00FFFF00
+#define CMD_CODE_SHIFT				8
+#define BUFNO_MASK				0x00000006
+#define BUFNO_SHIFT				1
+#define START_BIT				BIT(0)
+
+/* NFC_COL_ADDR Field */
+#define COL_ADDR_MASK				0x0000FFFF
+#define COL_ADDR_SHIFT				0
+
+/* NFC_ROW_ADDR Field */
+#define ROW_ADDR_MASK				0x00FFFFFF
+#define ROW_ADDR_SHIFT				0
+#define ROW_ADDR_CHIP_SEL_RB_MASK		0xF0000000
+#define ROW_ADDR_CHIP_SEL_RB_SHIFT		28
+#define ROW_ADDR_CHIP_SEL_MASK			0x0F000000
+#define ROW_ADDR_CHIP_SEL_SHIFT			24
+
+/* NFC_FLASH_STATUS2 Field */
+#define STATUS_BYTE1_MASK			0x000000FF
+
+/* NFC_FLASH_CONFIG Field */
+#define CONFIG_ECC_SRAM_ADDR_MASK		0x7FC00000
+#define CONFIG_ECC_SRAM_ADDR_SHIFT		22
+#define CONFIG_ECC_SRAM_REQ_BIT			BIT(21)
+#define CONFIG_DMA_REQ_BIT			BIT(20)
+#define CONFIG_ECC_MODE_MASK			0x000E0000
+#define CONFIG_ECC_MODE_SHIFT			17
+#define CONFIG_FAST_FLASH_BIT			BIT(16)
+#define CONFIG_16BIT				BIT(7)
+#define CONFIG_BOOT_MODE_BIT			BIT(6)
+#define CONFIG_ADDR_AUTO_INCR_BIT		BIT(5)
+#define CONFIG_BUFNO_AUTO_INCR_BIT		BIT(4)
+#define CONFIG_PAGE_CNT_MASK			0xF
+#define CONFIG_PAGE_CNT_SHIFT			0
+
+/* NFC_IRQ_STATUS Field */
+#define IDLE_IRQ_BIT				BIT(29)
+#define IDLE_EN_BIT				BIT(20)
+#define CMD_DONE_CLEAR_BIT			BIT(18)
+#define IDLE_CLEAR_BIT				BIT(17)
+
+enum vf610_nfc_alt_buf {
+	ALT_BUF_DATA = 0,
+	ALT_BUF_ID = 1,
+	ALT_BUF_STAT = 2,
+	ALT_BUF_ONFI = 3,
+};
+
+enum vf610_nfc_variant {
+	NFC_VFC610 = 1,
+};
+
+struct vf610_nfc {
+	struct mtd_info mtd;
+	struct nand_chip chip;
+	struct device *dev;
+	void __iomem *regs;
+	struct completion cmd_done;
+	uint buf_offset;
+	int write_sz;
+	/* Status and ID are in alternate locations. */
+	enum vf610_nfc_alt_buf alt_buf;
+	enum vf610_nfc_variant variant;
+	struct clk *clk;
+};
+
+#define mtd_to_nfc(_mtd) container_of(_mtd, struct vf610_nfc, mtd)
+
+static inline u32 vf610_nfc_read(struct vf610_nfc *nfc, uint reg)
+{
+	return readl(nfc->regs + reg);
+}
+
+static inline void vf610_nfc_write(struct vf610_nfc *nfc, uint reg, u32 val)
+{
+	writel(val, nfc->regs + reg);
+}
+
+static inline void vf610_nfc_set(struct vf610_nfc *nfc, uint reg, u32 bits)
+{
+	vf610_nfc_write(nfc, reg, vf610_nfc_read(nfc, reg) | bits);
+}
+
+static inline void vf610_nfc_clear(struct vf610_nfc *nfc, uint reg, u32 bits)
+{
+	vf610_nfc_write(nfc, reg, vf610_nfc_read(nfc, reg) & ~bits);
+}
+
+static inline void vf610_nfc_set_field(struct vf610_nfc *nfc, u32 reg,
+				       u32 mask, u32 shift, u32 val)
+{
+	vf610_nfc_write(nfc, reg,
+			(vf610_nfc_read(nfc, reg) & (~mask)) | val << shift);
+}
+
+static inline void vf610_nfc_memcpy(void *dst, const void __iomem *src,
+				    size_t n)
+{
+	/*
+	 * Use this accessor for the internal SRAM buffers. On the ARM
+	 * Freescale Vybrid SoC it's known that the driver can treat
+	 * the SRAM buffer as if it's memory. Other platform might need
+	 * to treat the buffers differently.
+	 *
+	 * For the time being, use memcpy
+	 */
+	memcpy(dst, src, n);
+}
+
+/* Clear flags for upcoming command */
+static inline void vf610_nfc_clear_status(struct vf610_nfc *nfc)
+{
+	u32 tmp = vf610_nfc_read(nfc, NFC_IRQ_STATUS);
+
+	tmp |= CMD_DONE_CLEAR_BIT | IDLE_CLEAR_BIT;
+	vf610_nfc_write(nfc, NFC_IRQ_STATUS, tmp);
+}
+
+static void vf610_nfc_done(struct vf610_nfc *nfc)
+{
+	unsigned long timeout = msecs_to_jiffies(100);
+
+	/*
+	 * Barrier is needed after this write. This write need
+	 * to be done before reading the next register the first
+	 * time.
+	 * vf610_nfc_set implicates such a barrier by using writel
+	 * to write to the register.
+	 */
+	vf610_nfc_set(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
+	vf610_nfc_set(nfc, NFC_FLASH_CMD2, START_BIT);
+
+	if (!wait_for_completion_timeout(&nfc->cmd_done, timeout))
+		dev_warn(nfc->dev, "Timeout while waiting for BUSY.\n");
+
+	vf610_nfc_clear_status(nfc);
+}
+
+static u8 vf610_nfc_get_id(struct vf610_nfc *nfc, int col)
+{
+	u32 flash_id;
+
+	if (col < 4) {
+		flash_id = vf610_nfc_read(nfc, NFC_FLASH_STATUS1);
+		flash_id >>= (3 - col) * 8;
+	} else {
+		flash_id = vf610_nfc_read(nfc, NFC_FLASH_STATUS2);
+		flash_id >>= 24;
+	}
+
+	return flash_id & 0xff;
+}
+
+static u8 vf610_nfc_get_status(struct vf610_nfc *nfc)
+{
+	return vf610_nfc_read(nfc, NFC_FLASH_STATUS2) & STATUS_BYTE1_MASK;
+}
+
+static void vf610_nfc_send_command(struct vf610_nfc *nfc, u32 cmd_byte1,
+				   u32 cmd_code)
+{
+	u32 tmp;
+
+	vf610_nfc_clear_status(nfc);
+
+	tmp = vf610_nfc_read(nfc, NFC_FLASH_CMD2);
+	tmp &= ~(CMD_BYTE1_MASK | CMD_CODE_MASK | BUFNO_MASK);
+	tmp |= cmd_byte1 << CMD_BYTE1_SHIFT;
+	tmp |= cmd_code << CMD_CODE_SHIFT;
+	vf610_nfc_write(nfc, NFC_FLASH_CMD2, tmp);
+}
+
+static void vf610_nfc_send_commands(struct vf610_nfc *nfc, u32 cmd_byte1,
+				    u32 cmd_byte2, u32 cmd_code)
+{
+	u32 tmp;
+
+	vf610_nfc_send_command(nfc, cmd_byte1, cmd_code);
+
+	tmp = vf610_nfc_read(nfc, NFC_FLASH_CMD1);
+	tmp &= ~CMD_BYTE2_MASK;
+	tmp |= cmd_byte2 << CMD_BYTE2_SHIFT;
+	vf610_nfc_write(nfc, NFC_FLASH_CMD1, tmp);
+}
+
+static irqreturn_t vf610_nfc_irq(int irq, void *data)
+{
+	struct mtd_info *mtd = data;
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+
+	vf610_nfc_clear(nfc, NFC_IRQ_STATUS, IDLE_EN_BIT);
+	complete(&nfc->cmd_done);
+
+	return IRQ_HANDLED;
+}
+
+static void vf610_nfc_addr_cycle(struct vf610_nfc *nfc, int column, int page)
+{
+	if (column != -1) {
+		if (nfc->chip.options & NAND_BUSWIDTH_16)
+			column = column / 2;
+		vf610_nfc_set_field(nfc, NFC_COL_ADDR, COL_ADDR_MASK,
+				    COL_ADDR_SHIFT, column);
+	}
+	if (page != -1)
+		vf610_nfc_set_field(nfc, NFC_ROW_ADDR, ROW_ADDR_MASK,
+				    ROW_ADDR_SHIFT, page);
+}
+
+static inline void vf610_nfc_transfer_size(struct vf610_nfc *nfc, int size)
+{
+	vf610_nfc_write(nfc, NFC_SECTOR_SIZE, size);
+}
+
+static void vf610_nfc_command(struct mtd_info *mtd, unsigned command,
+			      int column, int page)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	int trfr_sz = nfc->chip.options & NAND_BUSWIDTH_16 ? 1 : 0;
+
+	nfc->buf_offset = max(column, 0);
+	nfc->alt_buf = ALT_BUF_DATA;
+
+	switch (command) {
+	case NAND_CMD_SEQIN:
+		/* Use valid column/page from preread... */
+		vf610_nfc_addr_cycle(nfc, column, page);
+		/*
+		 * SEQIN => data => PAGEPROG sequence is done by the controller
+		 * hence we do not need to issue the command here...
+		 */
+		return;
+	case NAND_CMD_PAGEPROG:
+		trfr_sz += nfc->write_sz;
+		vf610_nfc_transfer_size(nfc, trfr_sz);
+		vf610_nfc_send_commands(nfc, NAND_CMD_SEQIN,
+					command, PROGRAM_PAGE_CMD_CODE);
+		break;
+
+	case NAND_CMD_RESET:
+		vf610_nfc_transfer_size(nfc, 0);
+		vf610_nfc_send_command(nfc, command, RESET_CMD_CODE);
+		break;
+
+	case NAND_CMD_READOOB:
+		trfr_sz += mtd->oobsize;
+		column = mtd->writesize;
+		vf610_nfc_transfer_size(nfc, trfr_sz);
+		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
+					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
+		vf610_nfc_addr_cycle(nfc, column, page);
+		break;
+
+	case NAND_CMD_READ0:
+		trfr_sz += mtd->writesize + mtd->oobsize;
+		vf610_nfc_transfer_size(nfc, trfr_sz);
+		vf610_nfc_send_commands(nfc, NAND_CMD_READ0,
+					NAND_CMD_READSTART, READ_PAGE_CMD_CODE);
+		vf610_nfc_addr_cycle(nfc, column, page);
+		break;
+
+	case NAND_CMD_PARAM:
+		nfc->alt_buf = ALT_BUF_ONFI;
+		trfr_sz = 3 * sizeof(struct nand_onfi_params);
+		vf610_nfc_transfer_size(nfc, trfr_sz);
+		vf610_nfc_send_command(nfc, command, READ_ONFI_PARAM_CMD_CODE);
+		vf610_nfc_addr_cycle(nfc, -1, column);
+		break;
+
+	case NAND_CMD_ERASE1:
+		vf610_nfc_transfer_size(nfc, 0);
+		vf610_nfc_send_commands(nfc, command,
+					NAND_CMD_ERASE2, ERASE_CMD_CODE);
+		vf610_nfc_addr_cycle(nfc, column, page);
+		break;
+
+	case NAND_CMD_READID:
+		nfc->alt_buf = ALT_BUF_ID;
+		nfc->buf_offset = 0;
+		vf610_nfc_transfer_size(nfc, 0);
+		vf610_nfc_send_command(nfc, command, READ_ID_CMD_CODE);
+		vf610_nfc_addr_cycle(nfc, -1, column);
+		break;
+
+	case NAND_CMD_STATUS:
+		nfc->alt_buf = ALT_BUF_STAT;
+		vf610_nfc_transfer_size(nfc, 0);
+		vf610_nfc_send_command(nfc, command, STATUS_READ_CMD_CODE);
+		break;
+	default:
+		return;
+	}
+
+	vf610_nfc_done(nfc);
+
+	nfc->write_sz = 0;
+}
+
+static void vf610_nfc_read_buf(struct mtd_info *mtd, u_char *buf, int len)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	uint c = nfc->buf_offset;
+
+	/* Alternate buffers are only supported through read_byte */
+	WARN_ON(nfc->alt_buf);
+
+	vf610_nfc_memcpy(buf, nfc->regs + NFC_MAIN_AREA(0) + c, len);
+
+	nfc->buf_offset += len;
+}
+
+static void vf610_nfc_write_buf(struct mtd_info *mtd, const uint8_t *buf,
+				int len)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	uint c = nfc->buf_offset;
+	uint l;
+
+	l = min_t(uint, len, mtd->writesize + mtd->oobsize - c);
+	vf610_nfc_memcpy(nfc->regs + NFC_MAIN_AREA(0) + c, buf, l);
+
+	nfc->write_sz += l;
+	nfc->buf_offset += l;
+}
+
+static uint8_t vf610_nfc_read_byte(struct mtd_info *mtd)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	u8 tmp;
+	uint c = nfc->buf_offset;
+
+	switch (nfc->alt_buf) {
+	case ALT_BUF_ID:
+		tmp = vf610_nfc_get_id(nfc, c);
+		break;
+	case ALT_BUF_STAT:
+		tmp = vf610_nfc_get_status(nfc);
+		break;
+#ifdef __LITTLE_ENDIAN
+	case ALT_BUF_ONFI:
+		/* Reverse byte since the controller uses big endianness */
+		c = nfc->buf_offset ^ 0x3;
+		/* fall-through */
+#endif
+	default:
+		tmp = *((u8 *)(nfc->regs + NFC_MAIN_AREA(0) + c));
+		break;
+	}
+	nfc->buf_offset++;
+	return tmp;
+}
+
+static u16 vf610_nfc_read_word(struct mtd_info *mtd)
+{
+	u16 tmp;
+
+	vf610_nfc_read_buf(mtd, (u_char *)&tmp, sizeof(tmp));
+	return tmp;
+}
+
+/* If not provided, upper layers apply a fixed delay. */
+static int vf610_nfc_dev_ready(struct mtd_info *mtd)
+{
+	/* NFC handles R/B internally; always ready.  */
+	return 1;
+}
+
+/*
+ * This function supports Vybrid only (MPC5125 would have full RB and four CS)
+ */
+static void vf610_nfc_select_chip(struct mtd_info *mtd, int chip)
+{
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+	u32 tmp = vf610_nfc_read(nfc, NFC_ROW_ADDR);
+
+	/* Vybrid only (MPC5125 would have full RB and four CS) */
+	if (nfc->variant != NFC_VFC610)
+		return;
+
+	tmp &= ~(ROW_ADDR_CHIP_SEL_RB_MASK | ROW_ADDR_CHIP_SEL_MASK);
+
+	if (chip >= 0) {
+		tmp |= 1 << ROW_ADDR_CHIP_SEL_RB_SHIFT;
+		tmp |= BIT(chip) << ROW_ADDR_CHIP_SEL_SHIFT;
+	}
+
+	vf610_nfc_write(nfc, NFC_ROW_ADDR, tmp);
+}
+
+static const struct of_device_id vf610_nfc_dt_ids[] = {
+	{ .compatible = "fsl,vf610-nfc", .data = (void *)NFC_VFC610 },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, vf610_nfc_dt_ids);
+
+static void vf610_nfc_preinit_controller(struct vf610_nfc *nfc)
+{
+	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
+	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_ADDR_AUTO_INCR_BIT);
+	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_BUFNO_AUTO_INCR_BIT);
+	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_BOOT_MODE_BIT);
+	vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_DMA_REQ_BIT);
+	vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_FAST_FLASH_BIT);
+
+	/* Disable virtual pages, only one elementary transfer unit */
+	vf610_nfc_set_field(nfc, NFC_FLASH_CONFIG, CONFIG_PAGE_CNT_MASK,
+			    CONFIG_PAGE_CNT_SHIFT, 1);
+}
+
+static void vf610_nfc_init_controller(struct vf610_nfc *nfc)
+{
+	if (nfc->chip.options & NAND_BUSWIDTH_16)
+		vf610_nfc_set(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
+	else
+		vf610_nfc_clear(nfc, NFC_FLASH_CONFIG, CONFIG_16BIT);
+}
+
+static int vf610_nfc_probe(struct platform_device *pdev)
+{
+	struct vf610_nfc *nfc;
+	struct resource *res;
+	struct mtd_info *mtd;
+	struct nand_chip *chip;
+	struct device_node *child;
+	const struct of_device_id *of_id;
+	int err = 0;
+	int irq;
+
+	nfc = devm_kzalloc(&pdev->dev, sizeof(*nfc), GFP_KERNEL);
+	if (!nfc)
+		return -ENOMEM;
+
+	nfc->dev = &pdev->dev;
+	mtd = &nfc->mtd;
+	chip = &nfc->chip;
+
+	mtd->priv = chip;
+	mtd->owner = THIS_MODULE;
+	mtd->dev.parent = nfc->dev;
+	mtd->name = DRV_NAME;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return -EINVAL;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	nfc->regs = devm_ioremap_resource(nfc->dev, res);
+	if (IS_ERR(nfc->regs))
+		return PTR_ERR(nfc->regs);
+
+	nfc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(nfc->clk))
+		return PTR_ERR(nfc->clk);
+
+	err = clk_prepare_enable(nfc->clk);
+	if (err) {
+		dev_err(nfc->dev, "Unable to enable clock!\n");
+		return err;
+	}
+
+	of_id = of_match_device(vf610_nfc_dt_ids, &pdev->dev);
+	nfc->variant = (enum vf610_nfc_variant)of_id->data;
+
+	for_each_available_child_of_node(nfc->dev->of_node, child) {
+		if (of_device_is_compatible(child, "fsl,vf610-nfc-nandcs")) {
+
+			if (chip->dn) {
+				dev_err(nfc->dev,
+					"Only one NAND chip supported!\n");
+				err = -EINVAL;
+				goto error;
+			}
+
+			chip->dn = child;
+		}
+	}
+
+	if (!chip->dn) {
+		dev_err(nfc->dev, "NAND chip sub-node missing!\n");
+		err = -ENODEV;
+		goto err_clk;
+	}
+
+	chip->dev_ready = vf610_nfc_dev_ready;
+	chip->cmdfunc = vf610_nfc_command;
+	chip->read_byte = vf610_nfc_read_byte;
+	chip->read_word = vf610_nfc_read_word;
+	chip->read_buf = vf610_nfc_read_buf;
+	chip->write_buf = vf610_nfc_write_buf;
+	chip->select_chip = vf610_nfc_select_chip;
+
+	chip->options |= NAND_NO_SUBPAGE_WRITE;
+
+	init_completion(&nfc->cmd_done);
+
+	err = devm_request_irq(nfc->dev, irq, vf610_nfc_irq, 0, DRV_NAME, mtd);
+	if (err) {
+		dev_err(nfc->dev, "Error requesting IRQ!\n");
+		goto error;
+	}
+
+	vf610_nfc_preinit_controller(nfc);
+
+	/* first scan to find the device and get the page size */
+	if (nand_scan_ident(mtd, 1, NULL)) {
+		err = -ENXIO;
+		goto error;
+	}
+
+	vf610_nfc_init_controller(nfc);
+
+	/* Bad block options. */
+	if (chip->bbt_options & NAND_BBT_USE_FLASH)
+		chip->bbt_options |= NAND_BBT_NO_OOB;
+
+	/* Single buffer only, max 256 OOB minus ECC status */
+	if (mtd->writesize + mtd->oobsize > PAGE_2K + OOB_MAX - 8) {
+		dev_err(nfc->dev, "Unsupported flash page size\n");
+		err = -ENXIO;
+		goto error;
+	}
+
+	/* second phase scan */
+	if (nand_scan_tail(mtd)) {
+		err = -ENXIO;
+		goto error;
+	}
+
+	platform_set_drvdata(pdev, mtd);
+
+	/* Register device in MTD */
+	return mtd_device_parse_register(mtd, NULL,
+		&(struct mtd_part_parser_data){
+			.of_node = chip->dn,
+		},
+		NULL, 0);
+
+error:
+	of_node_put(chip->dn);
+err_clk:
+	clk_disable_unprepare(nfc->clk);
+	return err;
+}
+
+static int vf610_nfc_remove(struct platform_device *pdev)
+{
+	struct mtd_info *mtd = platform_get_drvdata(pdev);
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+
+	nand_release(mtd);
+	clk_disable_unprepare(nfc->clk);
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int vf610_nfc_suspend(struct device *dev)
+{
+	struct mtd_info *mtd = dev_get_drvdata(dev);
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+
+	clk_disable_unprepare(nfc->clk);
+	return 0;
+}
+
+static int vf610_nfc_resume(struct device *dev)
+{
+	struct mtd_info *mtd = dev_get_drvdata(dev);
+	struct vf610_nfc *nfc = mtd_to_nfc(mtd);
+
+	pinctrl_pm_select_default_state(dev);
+
+	clk_prepare_enable(nfc->clk);
+
+	vf610_nfc_preinit_controller(nfc);
+	vf610_nfc_init_controller(nfc);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(vf610_nfc_pm_ops, vf610_nfc_suspend, vf610_nfc_resume);
+
+static struct platform_driver vf610_nfc_driver = {
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = vf610_nfc_dt_ids,
+		.pm	= &vf610_nfc_pm_ops,
+	},
+	.probe		= vf610_nfc_probe,
+	.remove		= vf610_nfc_remove,
+};
+
+module_platform_driver(vf610_nfc_driver);
+
+MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
+MODULE_DESCRIPTION("Freescale VF610/MPC5125 NFC MTD NAND driver");
+MODULE_LICENSE("GPL");
-- 
2.5.1
