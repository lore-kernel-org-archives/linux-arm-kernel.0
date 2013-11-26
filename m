From: b32955@freescale.com (Huang Shijie)
Date: Tue, 26 Nov 2013 14:32:54 +0800
Subject: [PATCH 3/4] mtd: spi-nor: add the framework for SPI NOR
In-Reply-To: <1385447575-23773-1-git-send-email-b32955@freescale.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
Message-ID: <1385447575-23773-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch cloned most of the m25p80.c. In theory, it adds a new spi-nor layer.

Before this patch, the layer is like:

                   MTD
         ------------------------
                  m25p80
         ------------------------
	       spi bus driver
         ------------------------
	        SPI NOR chip

After this patch, the layer is like:
                   MTD
         ------------------------
                  spi-nor
         ------------------------
                  m25p80
         ------------------------
	       spi bus driver
         ------------------------
	       SPI NOR chip

With the spi-nor controller driver(Freescale Quadspi), it looks like:
                   MTD
         ------------------------
                  spi-nor
         ------------------------
                fsl-quadspi
         ------------------------
	       SPI NOR chip

New APIs:
   spi_nor_register: used to register a spi-nor flash.
   spi_nor_unregister: used to unregister a spi-nor flash.

The m25p80 and spi-nor controller driver should implement the hooks
   @read_reg, @write_reg, @write, @read.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/Kconfig           |    2 +
 drivers/mtd/Makefile          |    1 +
 drivers/mtd/devices/Kconfig   |    2 +-
 drivers/mtd/spi-nor/Kconfig   |    6 +
 drivers/mtd/spi-nor/Makefile  |    1 +
 drivers/mtd/spi-nor/spi-nor.c | 1057 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |    5 +
 7 files changed, 1073 insertions(+), 1 deletions(-)
 create mode 100644 drivers/mtd/spi-nor/Kconfig
 create mode 100644 drivers/mtd/spi-nor/Makefile
 create mode 100644 drivers/mtd/spi-nor/spi-nor.c

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 5fab4e6e..8adb5af 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -320,6 +320,8 @@ source "drivers/mtd/onenand/Kconfig"
 
 source "drivers/mtd/lpddr/Kconfig"
 
+source "drivers/mtd/spi-nor/Kconfig"
+
 source "drivers/mtd/ubi/Kconfig"
 
 endif # MTD
diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
index 4cfb31e..40fd153 100644
--- a/drivers/mtd/Makefile
+++ b/drivers/mtd/Makefile
@@ -32,4 +32,5 @@ inftl-objs		:= inftlcore.o inftlmount.o
 
 obj-y		+= chips/ lpddr/ maps/ devices/ nand/ onenand/ tests/
 
+obj-$(CONFIG_MTD_SPI_NOR_BASE)	+= spi-nor/
 obj-$(CONFIG_MTD_UBI)		+= ubi/
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 0128138..004b17b 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -80,7 +80,7 @@ config MTD_DATAFLASH_OTP
 
 config MTD_M25P80
 	tristate "Support most SPI Flash chips (AT26DF, M25P, W25X, ...)"
-	depends on SPI_MASTER
+	depends on SPI_MASTER && MTD_SPI_NOR_BASE
 	help
 	  This enables access to most modern SPI flash chips, used for
 	  program and data storage.   Series supported include Atmel AT26DF,
diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
new file mode 100644
index 0000000..41591af
--- /dev/null
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -0,0 +1,6 @@
+config MTD_SPI_NOR_BASE
+	bool "the framework for SPI-NOR support"
+	depends on MTD
+	help
+	  This is the framework for the SPI NOR which can be used by the SPI
+	  device drivers and the SPI-NOR device driver.
diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
new file mode 100644
index 0000000..7dfe1f9
--- /dev/null
+++ b/drivers/mtd/spi-nor/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_MTD_SPI_NOR_BASE)	+= spi-nor.o
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
new file mode 100644
index 0000000..0e84c730
--- /dev/null
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -0,0 +1,1057 @@
+/*
+ * Cloned most of the code from the m25p80.c
+ *
+ * This code is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/mutex.h>
+#include <linux/math64.h>
+#include <linux/slab.h>
+#include <linux/sched.h>
+#include <linux/mod_devicetable.h>
+
+#include <linux/mtd/cfi.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/of_platform.h>
+#include <linux/spi/flash.h>
+#include <linux/mtd/spi-nor.h>
+
+/* Define max times to check status register before we give up. */
+#define	MAX_READY_WAIT_JIFFIES	(40 * HZ)	/* M25P16 specs 40s max chip erase */
+
+#define JEDEC_MFR(_jedec_id)	((_jedec_id) >> 16)
+
+/*
+ * Read the status register, returning its value in the location
+ * Return the status register value.
+ * Returns negative if error occurred.
+ */
+static int read_sr(struct spi_nor *flash)
+{
+	int ret;
+	u8 val;
+
+	ret = flash->read_reg(flash, OPCODE_RDSR, &val, 1);
+	if (ret < 0) {
+		pr_err("error %d reading SR\n", (int) ret);
+		return ret;
+	}
+
+	return val;
+}
+
+/*
+ * Read configuration register, returning its value in the
+ * location. Return the configuration register value.
+ * Returns negative if error occured.
+ */
+static int read_cr(struct spi_nor *flash)
+{
+	int ret;
+	u8 val;
+
+	ret = flash->read_reg(flash, OPCODE_RDCR, &val, 1);
+	if (ret < 0) {
+		dev_err(flash->dev, "error %d reading CR\n", ret);
+		return ret;
+	}
+
+	return val;
+}
+
+/*
+ * Write status register 1 byte
+ * Returns negative if error occurred.
+ */
+static inline int write_sr(struct spi_nor *flash, u8 val)
+{
+	flash->command[0] = OPCODE_WRSR;
+	flash->command[1] = val;
+	return flash->write_reg(flash, 2, 0);
+}
+
+/*
+ * Set write enable latch with Write Enable command.
+ * Returns negative if error occurred.
+ */
+static inline int write_enable(struct spi_nor *flash)
+{
+	flash->command[0] = OPCODE_WREN;
+	return flash->write_reg(flash, 1, 0);
+}
+
+/*
+ * Write status Register and configuration register with 2 bytes
+ * The first byte will be written to the status register, while the
+ * second byte will be written to the configuration register.
+ * Return negative if error occured.
+ */
+static int write_sr_cr(struct spi_nor *flash, u16 val)
+{
+	flash->command[0] = OPCODE_WRSR;
+	flash->command[1] = val & 0xff;
+	flash->command[2] = (val >> 8);
+
+	return flash->write_reg(flash, 3, 0);
+}
+
+/*
+ * Send write disble instruction to the chip.
+ */
+static inline int write_disable(struct spi_nor *flash)
+{
+	flash->command[0] = OPCODE_WRDI;
+	return flash->write_reg(flash, 1, 0);
+}
+
+static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
+{
+	return container_of(mtd, struct spi_nor, mtd);
+}
+
+/* Enable/disable 4-byte addressing mode. */
+static inline int set_4byte(struct spi_nor *flash, u32 jedec_id, int enable)
+{
+	int status;
+	bool need_wren = false;
+
+	switch (JEDEC_MFR(jedec_id)) {
+	case CFI_MFR_ST: /* Micron, actually */
+		/* Some Micron need WREN command; all will accept it */
+		need_wren = true;
+	case CFI_MFR_MACRONIX:
+	case 0xEF /* winbond */:
+		if (need_wren)
+			write_enable(flash);
+
+		flash->command[0] = enable ? OPCODE_EN4B : OPCODE_EX4B;
+		status = flash->write_reg(flash, 1, 0);
+		if (need_wren)
+			write_disable(flash);
+
+		return status;
+	default:
+		/* Spansion style */
+		flash->command[0] = OPCODE_BRWR;
+		flash->command[1] = enable << 7;
+		return flash->write_reg(flash, 2, 0);
+	}
+}
+
+/*
+ * Service routine to read status register until ready, or timeout occurs.
+ * Returns non-zero if error.
+ */
+static int wait_till_ready(struct spi_nor *flash)
+{
+	unsigned long deadline;
+	int sr;
+
+	deadline = jiffies + MAX_READY_WAIT_JIFFIES;
+
+	do {
+		if ((sr = read_sr(flash)) < 0)
+			break;
+		else if (!(sr & SR_WIP))
+			return 0;
+
+		cond_resched();
+
+	} while (!time_after_eq(jiffies, deadline));
+
+	return 1;
+}
+
+/*
+ * Erase the whole flash memory
+ *
+ * Returns 0 if successful, non-zero otherwise.
+ */
+static int erase_chip(struct spi_nor *flash)
+{
+	pr_debug("%s: %s %lldKiB\n", dev_name(flash->dev), __func__,
+			(long long)(flash->mtd.size >> 10));
+
+	/* Wait until finished previous write command. */
+	if (wait_till_ready(flash))
+		return 1;
+
+	/* Send write enable, then erase commands. */
+	write_enable(flash);
+
+	/* Set up command buffer. */
+	flash->command[0] = OPCODE_CHIP_ERASE;
+
+	return flash->write_reg(flash, 1, 0);
+}
+
+/*
+ * Erase one sector of flash memory at offset ``offset'' which is any
+ * address within the sector which should be erased.
+ *
+ * Returns 0 if successful, non-zero otherwise.
+ */
+static int erase_sector(struct spi_nor *flash, u32 offset)
+{
+	pr_debug("%s: %s %dKiB at 0x%08x\n", dev_name(flash->dev),
+			__func__, flash->mtd.erasesize / 1024, offset);
+
+	/* Wait until finished previous write command. */
+	if (wait_till_ready(flash))
+		return 1;
+
+	/* Send write enable, then erase commands. */
+	write_enable(flash);
+
+	/* Set up command buffer. */
+	flash->command[0] = flash->erase_opcode;
+	return flash->write_reg(flash, 1, offset);
+}
+
+/*
+ * Erase an address range on the flash chip.  The address range may extend
+ * one or more erase sectors.  Return an error is there is a problem erasing.
+ */
+static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct spi_nor *flash = mtd_to_spi_nor(mtd);
+	u32 addr,len;
+	uint32_t rem;
+
+	pr_debug("%s: %s at 0x%llx, len %lld\n", dev_name(flash->dev),
+			__func__, (long long)instr->addr,
+			(long long)instr->len);
+
+	div_u64_rem(instr->len, mtd->erasesize, &rem);
+	if (rem)
+		return -EINVAL;
+
+	addr = instr->addr;
+	len = instr->len;
+
+	mutex_lock(&flash->lock);
+
+	/* whole-chip erase? */
+	if (len == mtd->size) {
+		if (erase_chip(flash)) {
+			instr->state = MTD_ERASE_FAILED;
+			mutex_unlock(&flash->lock);
+			return -EIO;
+		}
+
+	/* REVISIT in some cases we could speed up erasing large regions
+	 * by using OPCODE_SE instead of OPCODE_BE_4K.  We may have set up
+	 * to use "small sector erase", but that's not always optimal.
+	 */
+
+	/* "sector"-at-a-time erase */
+	} else {
+		while (len) {
+			if (erase_sector(flash, addr)) {
+				instr->state = MTD_ERASE_FAILED;
+				mutex_unlock(&flash->lock);
+				return -EIO;
+			}
+
+			addr += mtd->erasesize;
+			len -= mtd->erasesize;
+		}
+	}
+
+	mutex_unlock(&flash->lock);
+
+	instr->state = MTD_ERASE_DONE;
+	mtd_erase_callback(instr);
+
+	return 0;
+}
+
+
+static int spi_nor_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *flash = mtd_to_spi_nor(mtd);
+	uint32_t offset = ofs;
+	uint8_t status_old, status_new;
+	int res = 0;
+
+	mutex_lock(&flash->lock);
+	/* Wait until finished previous command */
+	if (wait_till_ready(flash)) {
+		res = 1;
+		goto err;
+	}
+
+	status_old = read_sr(flash);
+
+	if (offset < mtd->size - (mtd->size / 2))
+		status_new = status_old | SR_BP2 | SR_BP1 | SR_BP0;
+	else if (offset < mtd->size - (mtd->size / 4))
+		status_new = (status_old & ~SR_BP0) | SR_BP2 | SR_BP1;
+	else if (offset < mtd->size - (mtd->size / 8))
+		status_new = (status_old & ~SR_BP1) | SR_BP2 | SR_BP0;
+	else if (offset < mtd->size - (mtd->size / 16))
+		status_new = (status_old & ~(SR_BP0 | SR_BP1)) | SR_BP2;
+	else if (offset < mtd->size - (mtd->size / 32))
+		status_new = (status_old & ~SR_BP2) | SR_BP1 | SR_BP0;
+	else if (offset < mtd->size - (mtd->size / 64))
+		status_new = (status_old & ~(SR_BP2 | SR_BP0)) | SR_BP1;
+	else
+		status_new = (status_old & ~(SR_BP2 | SR_BP1)) | SR_BP0;
+
+	/* Only modify protection if it will not unlock other areas */
+	if ((status_new & (SR_BP2 | SR_BP1 | SR_BP0)) >
+				(status_old & (SR_BP2 | SR_BP1 | SR_BP0))) {
+		write_enable(flash);
+		if (write_sr(flash, status_new) < 0) {
+			res = 1;
+			goto err;
+		}
+	}
+
+err:	mutex_unlock(&flash->lock);
+	return res;
+}
+
+static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
+{
+	struct spi_nor *flash = mtd_to_spi_nor(mtd);
+	uint32_t offset = ofs;
+	uint8_t status_old, status_new;
+	int res = 0;
+
+	mutex_lock(&flash->lock);
+	/* Wait until finished previous command */
+	if (wait_till_ready(flash)) {
+		res = 1;
+		goto err;
+	}
+
+	status_old = read_sr(flash);
+
+	if (offset+len > mtd->size - (mtd->size / 64))
+		status_new = status_old & ~(SR_BP2 | SR_BP1 | SR_BP0);
+	else if (offset+len > mtd->size - (mtd->size / 32))
+		status_new = (status_old & ~(SR_BP2 | SR_BP1)) | SR_BP0;
+	else if (offset+len > mtd->size - (mtd->size / 16))
+		status_new = (status_old & ~(SR_BP2 | SR_BP0)) | SR_BP1;
+	else if (offset+len > mtd->size - (mtd->size / 8))
+		status_new = (status_old & ~SR_BP2) | SR_BP1 | SR_BP0;
+	else if (offset+len > mtd->size - (mtd->size / 4))
+		status_new = (status_old & ~(SR_BP0 | SR_BP1)) | SR_BP2;
+	else if (offset+len > mtd->size - (mtd->size / 2))
+		status_new = (status_old & ~SR_BP1) | SR_BP2 | SR_BP0;
+	else
+		status_new = (status_old & ~SR_BP0) | SR_BP2 | SR_BP1;
+
+	/* Only modify protection if it will not lock other areas */
+	if ((status_new & (SR_BP2 | SR_BP1 | SR_BP0)) <
+				(status_old & (SR_BP2 | SR_BP1 | SR_BP0))) {
+		write_enable(flash);
+		if (write_sr(flash, status_new) < 0) {
+			res = 1;
+			goto err;
+		}
+	}
+
+err:	mutex_unlock(&flash->lock);
+	return res;
+}
+
+struct flash_info {
+	/* JEDEC id zero means "no ID" (most older chips); otherwise it has
+	 * a high byte of zero plus three data bytes: the manufacturer id,
+	 * then a two byte device id.
+	 */
+	u32		jedec_id;
+	u16             ext_id;
+
+	/* The size listed here is what works with OPCODE_SE, which isn't
+	 * necessarily called a "sector" by the vendor.
+	 */
+	unsigned	sector_size;
+	u16		n_sectors;
+
+	u16		page_size;
+	u16		addr_width;
+
+	u16		flags;
+#define	SECT_4K		0x01		/* OPCODE_BE_4K works uniformly */
+#define	M25P_NO_ERASE	0x02		/* No erase command needed */
+#define	SST_WRITE	0x04		/* use SST byte programming */
+#define	M25P_NO_FR	0x08		/* Can't do fastread */
+#define	SECT_4K_PMC	0x10		/* OPCODE_BE_4K_PMC works uniformly */
+#define	M25P80_QUAD_READ	0x20    /* Flash supports Quad Read */
+};
+
+#define INFO(_jedec_id, _ext_id, _sector_size, _n_sectors, _flags)	\
+	((kernel_ulong_t)&(struct flash_info) {				\
+		.jedec_id = (_jedec_id),				\
+		.ext_id = (_ext_id),					\
+		.sector_size = (_sector_size),				\
+		.n_sectors = (_n_sectors),				\
+		.page_size = 256,					\
+		.flags = (_flags),					\
+	})
+
+#define CAT25_INFO(_sector_size, _n_sectors, _page_size, _addr_width, _flags)	\
+	((kernel_ulong_t)&(struct flash_info) {				\
+		.sector_size = (_sector_size),				\
+		.n_sectors = (_n_sectors),				\
+		.page_size = (_page_size),				\
+		.addr_width = (_addr_width),				\
+		.flags = (_flags),					\
+	})
+
+/* NOTE: double check command sets and memory organization when you add
+ * more flash chips.  This current list focusses on newer chips, which
+ * have been converging on command sets which including JEDEC ID.
+ */
+const struct spi_device_id spi_nor_ids[] = {
+	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
+	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K) },
+	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K) },
+
+	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K) },
+	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K) },
+	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
+
+	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
+	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
+	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K) },
+	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K) },
+
+	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
+
+	/* EON -- en25xxx */
+	{ "en25f32",    INFO(0x1c3116, 0, 64 * 1024,   64, SECT_4K) },
+	{ "en25p32",    INFO(0x1c2016, 0, 64 * 1024,   64, 0) },
+	{ "en25q32b",   INFO(0x1c3016, 0, 64 * 1024,   64, 0) },
+	{ "en25p64",    INFO(0x1c2017, 0, 64 * 1024,  128, 0) },
+	{ "en25q64",    INFO(0x1c3017, 0, 64 * 1024,  128, SECT_4K) },
+	{ "en25qh256",  INFO(0x1c7019, 0, 64 * 1024,  512, 0) },
+
+	/* ESMT */
+	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64, SECT_4K) },
+
+	/* Everspin */
+	{ "mr25h256", CAT25_INFO( 32 * 1024, 1, 256, 2, M25P_NO_ERASE | M25P_NO_FR) },
+	{ "mr25h10",  CAT25_INFO(128 * 1024, 1, 256, 3, M25P_NO_ERASE | M25P_NO_FR) },
+
+	/* GigaDevice */
+	{ "gd25q32", INFO(0xc84016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "gd25q64", INFO(0xc84017, 0, 64 * 1024, 128, SECT_4K) },
+
+	/* Intel/Numonyx -- xxxs33b */
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
+
+	/* Macronix */
+	{ "mx25l2005a",  INFO(0xc22012, 0, 64 * 1024,   4, SECT_4K) },
+	{ "mx25l4005a",  INFO(0xc22013, 0, 64 * 1024,   8, SECT_4K) },
+	{ "mx25l8005",   INFO(0xc22014, 0, 64 * 1024,  16, 0) },
+	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
+	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, 0) },
+	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
+	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, 0) },
+	{ "mx25l12805d", INFO(0xc22018, 0, 64 * 1024, 256, 0) },
+	{ "mx25l12855e", INFO(0xc22618, 0, 64 * 1024, 256, 0) },
+	{ "mx25l25635e", INFO(0xc22019, 0, 64 * 1024, 512, 0) },
+	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
+	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024, M25P80_QUAD_READ) },
+
+	/* Micron */
+	{ "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, 0) },
+	{ "n25q128a11",  INFO(0x20bb18, 0, 64 * 1024,  256, 0) },
+	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256, 0) },
+	{ "n25q256a",    INFO(0x20ba19, 0, 64 * 1024,  512, SECT_4K) },
+	{ "n25q512a",    INFO(0x20bb20, 0, 64 * 1024, 1024, SECT_4K) },
+
+	/* PMC */
+	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
+	{ "pm25lv010",   INFO(0,        0, 32 * 1024,    4, SECT_4K_PMC) },
+	{ "pm25lq032",   INFO(0x7f9d46, 0, 64 * 1024,   64, SECT_4K) },
+
+	/* Spansion -- single (large) sector size only, at least
+	 * for the chips listed here (without boot sectors).
+	 */
+	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64, 0) },
+	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, 0) },
+	{ "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, 0) },
+	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512, M25P80_QUAD_READ) },
+	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256, 0) },
+	{ "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024, 256, 0) },
+	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
+	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },
+	{ "s25fl129p0", INFO(0x012018, 0x4d00, 256 * 1024,  64, 0) },
+	{ "s25fl129p1", INFO(0x012018, 0x4d01,  64 * 1024, 256, 0) },
+	{ "s25sl004a",  INFO(0x010212,      0,  64 * 1024,   8, 0) },
+	{ "s25sl008a",  INFO(0x010213,      0,  64 * 1024,  16, 0) },
+	{ "s25sl016a",  INFO(0x010214,      0,  64 * 1024,  32, 0) },
+	{ "s25sl032a",  INFO(0x010215,      0,  64 * 1024,  64, 0) },
+	{ "s25sl064a",  INFO(0x010216,      0,  64 * 1024, 128, 0) },
+	{ "s25fl016k",  INFO(0xef4015,      0,  64 * 1024,  32, SECT_4K) },
+	{ "s25fl064k",  INFO(0xef4017,      0,  64 * 1024, 128, SECT_4K) },
+
+	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
+	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
+	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16, SECT_4K | SST_WRITE) },
+	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32, SECT_4K | SST_WRITE) },
+	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64, SECT_4K | SST_WRITE) },
+	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
+	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1, SECT_4K | SST_WRITE) },
+	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2, SECT_4K | SST_WRITE) },
+	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4, SECT_4K | SST_WRITE) },
+	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8, SECT_4K | SST_WRITE) },
+
+	/* ST Microelectronics -- newer production may have feature updates */
+	{ "m25p05",  INFO(0x202010,  0,  32 * 1024,   2, 0) },
+	{ "m25p10",  INFO(0x202011,  0,  32 * 1024,   4, 0) },
+	{ "m25p20",  INFO(0x202012,  0,  64 * 1024,   4, 0) },
+	{ "m25p40",  INFO(0x202013,  0,  64 * 1024,   8, 0) },
+	{ "m25p80",  INFO(0x202014,  0,  64 * 1024,  16, 0) },
+	{ "m25p16",  INFO(0x202015,  0,  64 * 1024,  32, 0) },
+	{ "m25p32",  INFO(0x202016,  0,  64 * 1024,  64, 0) },
+	{ "m25p64",  INFO(0x202017,  0,  64 * 1024, 128, 0) },
+	{ "m25p128", INFO(0x202018,  0, 256 * 1024,  64, 0) },
+	{ "n25q032", INFO(0x20ba16,  0,  64 * 1024,  64, 0) },
+
+	{ "m25p05-nonjedec",  INFO(0, 0,  32 * 1024,   2, 0) },
+	{ "m25p10-nonjedec",  INFO(0, 0,  32 * 1024,   4, 0) },
+	{ "m25p20-nonjedec",  INFO(0, 0,  64 * 1024,   4, 0) },
+	{ "m25p40-nonjedec",  INFO(0, 0,  64 * 1024,   8, 0) },
+	{ "m25p80-nonjedec",  INFO(0, 0,  64 * 1024,  16, 0) },
+	{ "m25p16-nonjedec",  INFO(0, 0,  64 * 1024,  32, 0) },
+	{ "m25p32-nonjedec",  INFO(0, 0,  64 * 1024,  64, 0) },
+	{ "m25p64-nonjedec",  INFO(0, 0,  64 * 1024, 128, 0) },
+	{ "m25p128-nonjedec", INFO(0, 0, 256 * 1024,  64, 0) },
+
+	{ "m45pe10", INFO(0x204011,  0, 64 * 1024,    2, 0) },
+	{ "m45pe80", INFO(0x204014,  0, 64 * 1024,   16, 0) },
+	{ "m45pe16", INFO(0x204015,  0, 64 * 1024,   32, 0) },
+
+	{ "m25pe20", INFO(0x208012,  0, 64 * 1024,  4,       0) },
+	{ "m25pe80", INFO(0x208014,  0, 64 * 1024, 16,       0) },
+	{ "m25pe16", INFO(0x208015,  0, 64 * 1024, 32, SECT_4K) },
+
+	{ "m25px32",    INFO(0x207116,  0, 64 * 1024, 64, SECT_4K) },
+	{ "m25px32-s0", INFO(0x207316,  0, 64 * 1024, 64, SECT_4K) },
+	{ "m25px32-s1", INFO(0x206316,  0, 64 * 1024, 64, SECT_4K) },
+	{ "m25px64",    INFO(0x207117,  0, 64 * 1024, 128, 0) },
+
+	/* Winbond -- w25x "blocks" are 64K, "sectors" are 4KiB */
+	{ "w25x10", INFO(0xef3011, 0, 64 * 1024,  2,  SECT_4K) },
+	{ "w25x20", INFO(0xef3012, 0, 64 * 1024,  4,  SECT_4K) },
+	{ "w25x40", INFO(0xef3013, 0, 64 * 1024,  8,  SECT_4K) },
+	{ "w25x80", INFO(0xef3014, 0, 64 * 1024,  16, SECT_4K) },
+	{ "w25x16", INFO(0xef3015, 0, 64 * 1024,  32, SECT_4K) },
+	{ "w25x32", INFO(0xef3016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "w25q32", INFO(0xef4016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "w25q32dw", INFO(0xef6016, 0, 64 * 1024,  64, SECT_4K) },
+	{ "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
+	{ "w25q80", INFO(0xef5014, 0, 64 * 1024,  16, SECT_4K) },
+	{ "w25q80bl", INFO(0xef4014, 0, 64 * 1024,  16, SECT_4K) },
+	{ "w25q128", INFO(0xef4018, 0, 64 * 1024, 256, SECT_4K) },
+	{ "w25q256", INFO(0xef4019, 0, 64 * 1024, 512, SECT_4K) },
+
+	/* Catalyst / On Semiconductor -- non-JEDEC */
+	{ "cat25c11", CAT25_INFO(  16, 8, 16, 1, M25P_NO_ERASE | M25P_NO_FR) },
+	{ "cat25c03", CAT25_INFO(  32, 8, 16, 2, M25P_NO_ERASE | M25P_NO_FR) },
+	{ "cat25c09", CAT25_INFO( 128, 8, 32, 2, M25P_NO_ERASE | M25P_NO_FR) },
+	{ "cat25c17", CAT25_INFO( 256, 8, 32, 2, M25P_NO_ERASE | M25P_NO_FR) },
+	{ "cat25128", CAT25_INFO(2048, 8, 64, 2, M25P_NO_ERASE | M25P_NO_FR) },
+	{ },
+};
+
+static const struct spi_device_id *jedec_probe(struct spi_nor *flash)
+{
+	int			tmp;
+	u8			id[5];
+	u32			jedec;
+	u16                     ext_jedec;
+	struct flash_info	*info;
+
+	tmp = flash->read_reg(flash, OPCODE_RDID, id, 5);
+	if (tmp < 0) {
+		pr_debug(" error %d reading JEDEC ID\n", tmp);
+		return ERR_PTR(tmp);
+	}
+	jedec = id[0];
+	jedec = jedec << 8;
+	jedec |= id[1];
+	jedec = jedec << 8;
+	jedec |= id[2];
+
+	ext_jedec = id[3] << 8 | id[4];
+
+	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
+		info = (void *)spi_nor_ids[tmp].driver_data;
+		if (info->jedec_id == jedec) {
+			if (info->ext_id != 0 && info->ext_id != ext_jedec)
+				continue;
+			return &spi_nor_ids[tmp];
+		}
+	}
+	pr_err("unrecognized JEDEC id %06x\n", jedec);
+	return ERR_PTR(-ENODEV);
+}
+
+static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
+			size_t *retlen, u_char *buf)
+{
+	struct spi_nor *flash = mtd_to_spi_nor(mtd);
+	int ret;
+
+	pr_debug("%s: %s from 0x%08x, len %zd\n", dev_name(flash->dev),
+			__func__, (u32)from, len);
+
+	mutex_lock(&flash->lock);
+
+	/* Wait till previous write/erase is done. */
+	if (wait_till_ready(flash)) {
+		/* REVISIT status return?? */
+		mutex_unlock(&flash->lock);
+		return 1;
+	}
+
+	ret = flash->read(flash, from, len, retlen, buf);
+
+	mutex_unlock(&flash->lock);
+	return ret;
+}
+
+static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
+		size_t *retlen, const u_char *buf)
+{
+	struct spi_nor *flash = mtd_to_spi_nor(mtd);
+	size_t actual;
+	int ret;
+
+	pr_debug("%s: %s to 0x%08x, len %zd\n", dev_name(flash->dev),
+			__func__, (u32)to, len);
+
+	mutex_lock(&flash->lock);
+
+	/* Wait until finished previous write command. */
+	ret = wait_till_ready(flash);
+	if (ret)
+		goto time_out;
+
+	write_enable(flash);
+
+	flash->sst_write_second = false;
+
+	actual = to % 2;
+	/* Start write from odd address. */
+	if (actual) {
+		flash->program_opcode = OPCODE_BP;
+
+		/* write one byte. */
+		flash->write(flash, to, 1, retlen, buf);
+		ret = wait_till_ready(flash);
+		if (ret)
+			goto time_out;
+	}
+	to += actual;
+
+	/* Write out most of the data here. */
+	for (; actual < len - 1; actual += 2) {
+		flash->program_opcode = OPCODE_AAI_WP;
+
+		/* write two bytes. */
+		flash->write(flash, to, 2, retlen, buf + actual);
+		ret = wait_till_ready(flash);
+		if (ret)
+			goto time_out;
+		to += 2;
+		flash->sst_write_second = true;
+	}
+	flash->sst_write_second = false;
+
+	write_disable(flash);
+	ret = wait_till_ready(flash);
+	if (ret)
+		goto time_out;
+
+	/* Write out trailing byte if it exists. */
+	if (actual != len) {
+		write_enable(flash);
+
+		flash->program_opcode = OPCODE_BP;
+		flash->write(flash, to, 1, retlen, buf + actual);
+
+		ret = wait_till_ready(flash);
+		if (ret)
+			goto time_out;
+		write_disable(flash);
+	}
+time_out:
+	mutex_unlock(&flash->lock);
+	return ret;
+}
+
+/*
+ * Write an address range to the flash chip.  Data must be written in
+ * FLASH_PAGESIZE chunks.  The address range may be any size provided
+ * it is within the physical boundaries.
+ */
+static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
+	size_t *retlen, const u_char *buf)
+{
+	struct spi_nor *flash = mtd_to_spi_nor(mtd);
+	u32 page_offset, page_size, i;
+
+	pr_debug("%s: %s to 0x%08x, len %zd\n", dev_name(flash->dev),
+			__func__, (u32)to, len);
+
+	mutex_lock(&flash->lock);
+
+	/* Wait until finished previous write command. */
+	if (wait_till_ready(flash)) {
+		mutex_unlock(&flash->lock);
+		return 1;
+	}
+	write_enable(flash);
+
+	page_offset = to & (flash->page_size - 1);
+
+	/* do all the bytes fit onto one page? */
+	if (page_offset + len <= flash->page_size) {
+		flash->write(flash, to, len, retlen, buf);
+	} else {
+		/* the size of data remaining on the first page */
+		page_size = flash->page_size - page_offset;
+		flash->write(flash, to, page_size, retlen, buf);
+
+		/* write everything in flash->page_size chunks */
+		for (i = page_size; i < len; i += page_size) {
+			page_size = len - i;
+			if (page_size > flash->page_size)
+				page_size = flash->page_size;
+
+			wait_till_ready(flash);
+			write_enable(flash);
+
+			flash->write(flash, to + i, page_size, retlen, buf + i);
+		}
+	}
+
+	mutex_unlock(&flash->lock);
+	return 0;
+}
+
+static int macronix_quad_enable(struct spi_nor *flash)
+{
+	int ret, val;
+
+	val = read_sr(flash);
+	write_enable(flash);
+
+	flash->command[0] = OPCODE_WRSR;
+	flash->command[1] = val | SR_QUAD_EN_MX;
+	flash->write_reg(flash, 2, 0);
+
+	if (wait_till_ready(flash))
+		return 1;
+
+	ret = read_sr(flash);
+	if (!(ret > 0 && (ret & SR_QUAD_EN_MX))) {
+		dev_err(flash->dev, "Macronix Quad bit not set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spansion_quad_enable(struct spi_nor *flash)
+{
+	int ret;
+	int quad_en = CR_QUAD_EN_SPAN << 8;
+
+	write_enable(flash);
+
+	ret = write_sr_cr(flash, quad_en);
+	if (ret < 0) {
+		dev_err(flash->dev,
+			"error while writing configuration register\n");
+		return -EINVAL;
+	}
+
+	/* read back and check it */
+	ret = read_cr(flash);
+	if (!(ret > 0 && (ret & CR_QUAD_EN_SPAN))) {
+		dev_err(flash->dev, "Spansion Quad bit not set\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int set_quad_mode(struct spi_nor *flash, u32 jedec_id)
+{
+	int status;
+
+	switch (JEDEC_MFR(jedec_id)) {
+	case CFI_MFR_MACRONIX:
+		status = macronix_quad_enable(flash);
+		if (status) {
+			dev_err(flash->dev, "Macronix quad-read not enabled\n");
+			return -EINVAL;
+		}
+		return status;
+	default:
+		status = spansion_quad_enable(flash);
+		if (status) {
+			dev_err(flash->dev, "Spansion quad-read not enabled\n");
+			return -EINVAL;
+		}
+		return status;
+	}
+}
+
+static int spi_nor_check(struct spi_nor *flash)
+{
+	if (!flash->dev || !flash->read || !flash->write ||
+		!flash->read_reg || !flash->write_reg) {
+		pr_err("spi-nor: please fill all the necessary fields!\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int spi_nor_register(struct spi_nor *flash, const struct spi_device_id *id,
+			bool quad_read)
+{
+	struct mtd_part_parser_data	ppdata;
+	struct flash_info		*info;
+	struct flash_platform_data	*data;
+	struct device *dev = flash->dev;
+	struct mtd_info *mtd = &flash->mtd;
+	struct device_node *np = dev->of_node;
+	int ret;
+	int i;
+
+	ret = spi_nor_check(flash);
+	if (ret)
+		return ret;
+
+	/* Platform data helps sort out which chip type we have, as
+	 * well as how this board partitions it.  If we don't have
+	 * a chip ID, try the JEDEC id commands; they'll work for most
+	 * newer chips, even if we don't recognize the particular chip.
+	 */
+	data = dev_get_platdata(dev);
+	if (data && data->type) {
+		const struct spi_device_id *plat_id;
+
+		for (i = 0; i < ARRAY_SIZE(spi_nor_ids) - 1; i++) {
+			plat_id = &spi_nor_ids[i];
+			if (strcmp(data->type, plat_id->name))
+				continue;
+			break;
+		}
+
+		if (i < ARRAY_SIZE(spi_nor_ids) - 1)
+			id = plat_id;
+		else
+			dev_warn(dev, "unrecognized id %s\n", data->type);
+	}
+
+	info = (void *)id->driver_data;
+
+	if (info->jedec_id) {
+		const struct spi_device_id *jid;
+
+		jid = jedec_probe(flash);
+		if (IS_ERR(jid)) {
+			return PTR_ERR(jid);
+		} else if (jid != id) {
+			/*
+			 * JEDEC knows better, so overwrite platform ID. We
+			 * can't trust partitions any longer, but we'll let
+			 * mtd apply them anyway, since some partitions may be
+			 * marked read-only, and we don't want to lose that
+			 * information, even if it's not 100% accurate.
+			 */
+			dev_warn(dev, "found %s, expected %s\n",
+				 jid->name, id->name);
+			id = jid;
+			info = (void *)jid->driver_data;
+		}
+	}
+
+	mutex_init(&flash->lock);
+
+	/*
+	 * Atmel, SST and Intel/Numonyx serial flash tend to power
+	 * up with the software protection bits set
+	 */
+
+	if (JEDEC_MFR(info->jedec_id) == CFI_MFR_ATMEL ||
+	    JEDEC_MFR(info->jedec_id) == CFI_MFR_INTEL ||
+	    JEDEC_MFR(info->jedec_id) == CFI_MFR_SST) {
+		write_enable(flash);
+		write_sr(flash, 0);
+	}
+
+	if (data && data->name)
+		flash->mtd.name = data->name;
+	else
+		flash->mtd.name = dev_name(dev);
+
+	flash->mtd.type = MTD_NORFLASH;
+	flash->mtd.writesize = 1;
+	flash->mtd.flags = MTD_CAP_NORFLASH;
+	flash->mtd.size = info->sector_size * info->n_sectors;
+	flash->mtd._erase = spi_nor_erase;
+	flash->mtd._read = spi_nor_read;
+
+	/* flash protection support for STmicro chips */
+	if (JEDEC_MFR(info->jedec_id) == CFI_MFR_ST) {
+		flash->mtd._lock = spi_nor_lock;
+		flash->mtd._unlock = spi_nor_unlock;
+	}
+
+	/* sst flash chips use AAI word program */
+	if (info->flags & SST_WRITE)
+		flash->mtd._write = sst_write;
+	else
+		flash->mtd._write = spi_nor_write;
+
+	/* prefer "small sector" erase if possible */
+	if (info->flags & SECT_4K) {
+		flash->erase_opcode = OPCODE_BE_4K;
+		flash->mtd.erasesize = 4096;
+	} else if (info->flags & SECT_4K_PMC) {
+		flash->erase_opcode = OPCODE_BE_4K_PMC;
+		flash->mtd.erasesize = 4096;
+	} else {
+		flash->erase_opcode = OPCODE_SE;
+		flash->mtd.erasesize = info->sector_size;
+	}
+
+	if (info->flags & M25P_NO_ERASE)
+		flash->mtd.flags |= MTD_NO_ERASE;
+
+	ppdata.of_node = dev->of_node;
+	flash->mtd.dev.parent = dev;
+	flash->page_size = info->page_size;
+	flash->mtd.writebufsize = flash->page_size;
+
+	if (np) {
+		/* If we were instantiated by DT, use it */
+		if (of_property_read_bool(np, "m25p,fast-read"))
+			flash->flash_read = M25P80_FAST;
+	} else {
+		/* If we weren't instantiated by DT, default to fast-read */
+		flash->flash_read = M25P80_FAST;
+	}
+
+	/* Some devices cannot do fast-read, no matter what DT tells us */
+	if (info->flags & M25P_NO_FR)
+		flash->flash_read = M25P80_NORMAL;
+
+	/* Quad-read mode takes precedence over fast/normal */
+	if (quad_read && info->flags & M25P80_QUAD_READ) {
+		ret = set_quad_mode(flash, info->jedec_id);
+		if (ret) {
+			dev_err(dev, "quad mode not supported\n");
+			return ret;
+		}
+		flash->flash_read = M25P80_QUAD;
+	}
+
+	/* Default commands */
+	switch (flash->flash_read) {
+	case M25P80_QUAD:
+		flash->read_opcode = OPCODE_QUAD_READ;
+		break;
+	case M25P80_FAST:
+		flash->read_opcode = OPCODE_FAST_READ;
+		break;
+	case M25P80_NORMAL:
+		flash->read_opcode = OPCODE_NORM_READ;
+		break;
+	default:
+		dev_err(dev, "No Read opcode defined\n");
+		return -EINVAL;
+	}
+
+	flash->program_opcode = OPCODE_PP;
+
+	if (info->addr_width)
+		flash->addr_width = info->addr_width;
+	else if (flash->mtd.size > 0x1000000) {
+		/* enable 4-byte addressing if the device exceeds 16MiB */
+		flash->addr_width = 4;
+		if (JEDEC_MFR(info->jedec_id) == CFI_MFR_AMD) {
+			/* Dedicated 4-byte command set */
+			switch (flash->flash_read) {
+			case M25P80_QUAD:
+				flash->read_opcode = OPCODE_QUAD_READ;
+				break;
+			case M25P80_FAST:
+				flash->read_opcode = OPCODE_FAST_READ_4B;
+				break;
+			case M25P80_NORMAL:
+				flash->read_opcode = OPCODE_NORM_READ_4B;
+				break;
+			}
+			flash->program_opcode = OPCODE_PP_4B;
+			/* No small sector erase for 4-byte command set */
+			flash->erase_opcode = OPCODE_SE_4B;
+			flash->mtd.erasesize = info->sector_size;
+		} else
+			set_4byte(flash, info->jedec_id, 1);
+	} else {
+		flash->addr_width = 3;
+	}
+
+	dev_info(dev, "%s (%lld Kbytes)\n", id->name,
+			(long long)flash->mtd.size >> 10);
+
+	pr_debug("mtd .name = %s, .size = 0x%llx (%lldMiB) "
+			".erasesize = 0x%.8x (%uKiB) .numeraseregions = %d\n",
+		flash->mtd.name,
+		(long long)flash->mtd.size, (long long)(flash->mtd.size >> 20),
+		flash->mtd.erasesize, flash->mtd.erasesize / 1024,
+		flash->mtd.numeraseregions);
+
+	if (flash->mtd.numeraseregions)
+		for (i = 0; i < flash->mtd.numeraseregions; i++)
+			pr_debug("mtd.eraseregions[%d] = { .offset = 0x%llx, "
+				".erasesize = 0x%.8x (%uKiB), "
+				".numblocks = %d }\n",
+				i, (long long)flash->mtd.eraseregions[i].offset,
+				flash->mtd.eraseregions[i].erasesize,
+				flash->mtd.eraseregions[i].erasesize / 1024,
+				flash->mtd.eraseregions[i].numblocks);
+
+
+	/* partitions should match sector boundaries; and it may be good to
+	 * use readonly partitions for writeprotected sectors (BP2..BP0).
+	 */
+	return mtd_device_parse_register(mtd, NULL, &ppdata,
+			data ? data->parts : NULL,
+			data ? data->nr_parts : 0);
+}
+
+int spi_nor_unregister(struct spi_nor *flash)
+{
+	return mtd_device_unregister(&flash->mtd);
+}
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Freescale Semiconductor Inc.");
+MODULE_DESCRIPTION("framework for SPI NOR flash");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 8da1f69..2d6dc56 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -93,4 +93,9 @@ struct spi_nor {
 	int (*read)(struct spi_nor *flash, loff_t from, size_t len,
 			size_t *retlen, u_char *buf);
 };
+
+int spi_nor_register(struct spi_nor *flash, const struct spi_device_id *id,
+			bool quad_read);
+int spi_nor_unregister(struct spi_nor *flash);
+extern const struct spi_device_id spi_nor_ids[];
 #endif
-- 
1.7.2.rc3
