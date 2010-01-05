From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 5 Jan 2010 14:59:58 -0700
Subject: [PATCH 2/2] Remove now-defunct ts7250 nand driver
Message-ID: <201001051459.58621.hartleys@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ts72xx platform has been updated to use the generic platform nand
driver (plat_nand.c).  This removes the now-defunct ts7250.c nand driver.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Matthieu Crapet <mcrapet@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Jesse Off <joff@embeddedARM.com>

---

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
index 3bd934e..61c0e13 100644
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
@@ -9,9 +9,6 @@
  * febff000	22000000	4K	model number register
  * febfe000	22400000	4K	options register
  * febfd000	22800000	4K	options register #2
- * febfc000	[67]0000000	4K	NAND data register
- * febfb000	[67]0400000	4K	NAND control register
- * febfa000	[67]0800000	4K	NAND busy register
  * febf9000	10800000	4K	TS-5620 RTC index register
  * febf8000	11700000	4K	TS-5620 RTC data register
  */
@@ -41,22 +38,6 @@
 #define TS72XX_OPTIONS2_TS9420_BOOT	0x02
 
 
-#define TS72XX_NAND1_DATA_PHYS_BASE	0x60000000
-#define TS72XX_NAND2_DATA_PHYS_BASE	0x70000000
-#define TS72XX_NAND_DATA_VIRT_BASE	0xfebfc000
-#define TS72XX_NAND_DATA_SIZE		0x00001000
-
-#define TS72XX_NAND1_CONTROL_PHYS_BASE	0x60400000
-#define TS72XX_NAND2_CONTROL_PHYS_BASE	0x70400000
-#define TS72XX_NAND_CONTROL_VIRT_BASE	0xfebfb000
-#define TS72XX_NAND_CONTROL_SIZE	0x00001000
-
-#define TS72XX_NAND1_BUSY_PHYS_BASE	0x60800000
-#define TS72XX_NAND2_BUSY_PHYS_BASE	0x70800000
-#define TS72XX_NAND_BUSY_VIRT_BASE	0xfebfa000
-#define TS72XX_NAND_BUSY_SIZE		0x00001000
-
-
 #define TS72XX_RTC_INDEX_VIRT_BASE	0xfebf9000
 #define TS72XX_RTC_INDEX_PHYS_BASE	0x10800000
 #define TS72XX_RTC_INDEX_SIZE		0x00001000
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 677cd53..48c727f 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -95,12 +95,6 @@ config MTD_NAND_OMAP_PREFETCH_DMA
 	 or in DMA interrupt mode.
 	 Say y for DMA mode or MPU mode will be used
 
-config MTD_NAND_TS7250
-	tristate "NAND Flash device on TS-7250 board"
-	depends on MACH_TS72XX
-	help
-	  Support for NAND flash on Technologic Systems TS-7250 platform.
-
 config MTD_NAND_IDS
 	tristate
 
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 1407bd1..fedf10d 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_MTD_NAND_DISKONCHIP)	+= diskonchip.o
 obj-$(CONFIG_MTD_NAND_H1900)		+= h1910.o
 obj-$(CONFIG_MTD_NAND_RTC_FROM4)	+= rtc_from4.o
 obj-$(CONFIG_MTD_NAND_SHARPSL)		+= sharpsl.o
-obj-$(CONFIG_MTD_NAND_TS7250)		+= ts7250.o
 obj-$(CONFIG_MTD_NAND_NANDSIM)		+= nandsim.o
 obj-$(CONFIG_MTD_NAND_CS553X)		+= cs553x_nand.o
 obj-$(CONFIG_MTD_NAND_NDFC)		+= ndfc.o
diff --git a/drivers/mtd/nand/ts7250.c b/drivers/mtd/nand/ts7250.c
deleted file mode 100644
index 0f5562a..0000000
--- a/drivers/mtd/nand/ts7250.c
+++ /dev/null
@@ -1,207 +0,0 @@
-/*
- * drivers/mtd/nand/ts7250.c
- *
- * Copyright (C) 2004 Technologic Systems (support at embeddedARM.com)
- *
- * Derived from drivers/mtd/nand/edb7312.c
- *   Copyright (C) 2004 Marius Gr?ger (mag at sysgo.de)
- *
- * Derived from drivers/mtd/nand/autcpu12.c
- *   Copyright (c) 2001 Thomas Gleixner (gleixner at autronix.de)
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Overview:
- *   This is a device driver for the NAND flash device found on the
- *   TS-7250 board which utilizes a Samsung 32 Mbyte part.
- */
-
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/partitions.h>
-#include <linux/io.h>
-
-#include <mach/hardware.h>
-#include <mach/ts72xx.h>
-
-#include <asm/sizes.h>
-#include <asm/mach-types.h>
-
-/*
- * MTD structure for TS7250 board
- */
-static struct mtd_info *ts7250_mtd = NULL;
-
-#ifdef CONFIG_MTD_PARTITIONS
-static const char *part_probes[] = { "cmdlinepart", NULL };
-
-#define NUM_PARTITIONS 3
-
-/*
- * Define static partitions for flash device
- */
-static struct mtd_partition partition_info32[] = {
-	{
-		.name		= "TS-BOOTROM",
-		.offset		= 0x00000000,
-		.size		= 0x00004000,
-	}, {
-		.name		= "Linux",
-		.offset		= 0x00004000,
-		.size		= 0x01d00000,
-	}, {
-		.name		= "RedBoot",
-		.offset		= 0x01d04000,
-		.size		= 0x002fc000,
-	},
-};
-
-/*
- * Define static partitions for flash device
- */
-static struct mtd_partition partition_info128[] = {
-	{
-		.name		= "TS-BOOTROM",
-		.offset		= 0x00000000,
-		.size		= 0x00004000,
-	}, {
-		.name		= "Linux",
-		.offset		= 0x00004000,
-		.size		= 0x07d00000,
-	}, {
-		.name		= "RedBoot",
-		.offset		= 0x07d04000,
-		.size		= 0x002fc000,
-	},
-};
-#endif
-
-
-/*
- *	hardware specific access to control-lines
- *
- *	ctrl:
- *	NAND_NCE: bit 0 -> bit 2
- *	NAND_CLE: bit 1 -> bit 1
- *	NAND_ALE: bit 2 -> bit 0
- */
-static void ts7250_hwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
-{
-	struct nand_chip *chip = mtd->priv;
-
-	if (ctrl & NAND_CTRL_CHANGE) {
-		unsigned long addr = TS72XX_NAND_CONTROL_VIRT_BASE;
-		unsigned char bits;
-
-		bits = (ctrl & NAND_NCE) << 2;
-		bits |= ctrl & NAND_CLE;
-		bits |= (ctrl & NAND_ALE) >> 2;
-
-		__raw_writeb((__raw_readb(addr) & ~0x7) | bits, addr);
-	}
-
-	if (cmd != NAND_CMD_NONE)
-		writeb(cmd, chip->IO_ADDR_W);
-}
-
-/*
- *	read device ready pin
- */
-static int ts7250_device_ready(struct mtd_info *mtd)
-{
-	return __raw_readb(TS72XX_NAND_BUSY_VIRT_BASE) & 0x20;
-}
-
-/*
- * Main initialization routine
- */
-static int __init ts7250_init(void)
-{
-	struct nand_chip *this;
-	const char *part_type = 0;
-	int mtd_parts_nb = 0;
-	struct mtd_partition *mtd_parts = 0;
-
-	if (!machine_is_ts72xx() || board_is_ts7200())
-		return -ENXIO;
-
-	/* Allocate memory for MTD device structure and private data */
-	ts7250_mtd = kmalloc(sizeof(struct mtd_info) + sizeof(struct nand_chip), GFP_KERNEL);
-	if (!ts7250_mtd) {
-		printk("Unable to allocate TS7250 NAND MTD device structure.\n");
-		return -ENOMEM;
-	}
-
-	/* Get pointer to private data */
-	this = (struct nand_chip *)(&ts7250_mtd[1]);
-
-	/* Initialize structures */
-	memset(ts7250_mtd, 0, sizeof(struct mtd_info));
-	memset(this, 0, sizeof(struct nand_chip));
-
-	/* Link the private data with the MTD structure */
-	ts7250_mtd->priv = this;
-	ts7250_mtd->owner = THIS_MODULE;
-
-	/* insert callbacks */
-	this->IO_ADDR_R = (void *)TS72XX_NAND_DATA_VIRT_BASE;
-	this->IO_ADDR_W = (void *)TS72XX_NAND_DATA_VIRT_BASE;
-	this->cmd_ctrl = ts7250_hwcontrol;
-	this->dev_ready = ts7250_device_ready;
-	this->chip_delay = 15;
-	this->ecc.mode = NAND_ECC_SOFT;
-
-	printk("Searching for NAND flash...\n");
-	/* Scan to find existence of the device */
-	if (nand_scan(ts7250_mtd, 1)) {
-		kfree(ts7250_mtd);
-		return -ENXIO;
-	}
-#ifdef CONFIG_MTD_PARTITIONS
-	ts7250_mtd->name = "ts7250-nand";
-	mtd_parts_nb = parse_mtd_partitions(ts7250_mtd, part_probes, &mtd_parts, 0);
-	if (mtd_parts_nb > 0)
-		part_type = "command line";
-	else
-		mtd_parts_nb = 0;
-#endif
-	if (mtd_parts_nb == 0) {
-		mtd_parts = partition_info32;
-		if (ts7250_mtd->size >= (128 * 0x100000))
-			mtd_parts = partition_info128;
-		mtd_parts_nb = NUM_PARTITIONS;
-		part_type = "static";
-	}
-
-	/* Register the partitions */
-	printk(KERN_NOTICE "Using %s partition definition\n", part_type);
-	add_mtd_partitions(ts7250_mtd, mtd_parts, mtd_parts_nb);
-
-	/* Return happy */
-	return 0;
-}
-
-module_init(ts7250_init);
-
-/*
- * Clean up routine
- */
-static void __exit ts7250_cleanup(void)
-{
-	/* Unregister the device */
-	del_mtd_device(ts7250_mtd);
-
-	/* Free the MTD device structure */
-	kfree(ts7250_mtd);
-}
-
-module_exit(ts7250_cleanup);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Jesse Off <joff@embeddedARM.com>");
-MODULE_DESCRIPTION("MTD map driver for Technologic Systems TS-7250 board");
