From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 20 Nov 2015 14:32:35 -0800
Subject: [PATCH] mtd: maps: kill DC21285 driver
Message-ID: <1448058755-45834-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver wouldn't build for over 5 years, between commit:

  bd31b85960a7 ("locking, ARM: Annotate low level hw locks as raw")

and

  e5babdf928e5 ("mtd: dc21285: use raw spinlock functions for nw_gpio_lock")

Also, it's unsafe to build into arbitrary kernels, as it might just
start probing around memory, whether or not there's a compatible flash
there. See comments here, last time someone tried to enable it:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347133.html

So, let's kill it. I bet no one will notice.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nico@linaro.org>
---
 drivers/mtd/maps/Kconfig   |   8 --
 drivers/mtd/maps/Makefile  |   1 -
 drivers/mtd/maps/dc21285.c | 231 ---------------------------------------------
 3 files changed, 240 deletions(-)
 delete mode 100644 drivers/mtd/maps/dc21285.c

diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 7c95a656f9e4..ddad3645f481 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -262,14 +262,6 @@ config MTD_SA1100
 	  the SA1100 and SA1110, including the Assabet and the Compaq iPAQ.
 	  If you have such a board, say 'Y'.
 
-config MTD_DC21285
-	tristate "CFI Flash device mapped on DC21285 Footbridge"
-	depends on MTD_CFI && ARCH_FOOTBRIDGE && MTD_COMPLEX_MAPPINGS
-	help
-	  This provides a driver for the flash accessed using Intel's
-	  21285 bridge used with Intel's StrongARM processors. More info at
-	  <http://www.intel.com/design/bridge/docs/21285_documentation.htm>.
-
 config MTD_IXP4XX
 	tristate "CFI Flash device mapped on Intel IXP4xx based systems"
 	depends on MTD_CFI && MTD_COMPLEX_MAPPINGS && ARCH_IXP4XX
diff --git a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
index 141c91a5b24c..c67fcf03c3ce 100644
--- a/drivers/mtd/maps/Makefile
+++ b/drivers/mtd/maps/Makefile
@@ -8,7 +8,6 @@ endif
 
 # Chip mappings
 obj-$(CONFIG_MTD_CFI_FLAGADM)	+= cfi_flagadm.o
-obj-$(CONFIG_MTD_DC21285)	+= dc21285.o
 obj-$(CONFIG_MTD_L440GX)	+= l440gx.o
 obj-$(CONFIG_MTD_AMD76XROM)	+= amd76xrom.o
 obj-$(CONFIG_MTD_ESB2ROM)	+= esb2rom.o
diff --git a/drivers/mtd/maps/dc21285.c b/drivers/mtd/maps/dc21285.c
deleted file mode 100644
index 70a3db3ab856..000000000000
--- a/drivers/mtd/maps/dc21285.c
+++ /dev/null
@@ -1,231 +0,0 @@
-/*
- * MTD map driver for flash on the DC21285 (the StrongARM-110 companion chip)
- *
- * (C) 2000  Nicolas Pitre <nico@fluxnic.net>
- *
- * This code is GPL
- */
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/map.h>
-#include <linux/mtd/partitions.h>
-
-#include <asm/io.h>
-#include <asm/hardware/dec21285.h>
-#include <asm/mach-types.h>
-
-
-static struct mtd_info *dc21285_mtd;
-
-#ifdef CONFIG_ARCH_NETWINDER
-/*
- * This is really ugly, but it seams to be the only
- * realiable way to do it, as the cpld state machine
- * is unpredictible. So we have a 25us penalty per
- * write access.
- */
-static void nw_en_write(void)
-{
-	unsigned long flags;
-
-	/*
-	 * we want to write a bit pattern XXX1 to Xilinx to enable
-	 * the write gate, which will be open for about the next 2ms.
-	 */
-	raw_spin_lock_irqsave(&nw_gpio_lock, flags);
-	nw_cpld_modify(CPLD_FLASH_WR_ENABLE, CPLD_FLASH_WR_ENABLE);
-	raw_spin_unlock_irqrestore(&nw_gpio_lock, flags);
-
-	/*
-	 * let the ISA bus to catch on...
-	 */
-	udelay(25);
-}
-#else
-#define nw_en_write() do { } while (0)
-#endif
-
-static map_word dc21285_read8(struct map_info *map, unsigned long ofs)
-{
-	map_word val;
-	val.x[0] = *(uint8_t*)(map->virt + ofs);
-	return val;
-}
-
-static map_word dc21285_read16(struct map_info *map, unsigned long ofs)
-{
-	map_word val;
-	val.x[0] = *(uint16_t*)(map->virt + ofs);
-	return val;
-}
-
-static map_word dc21285_read32(struct map_info *map, unsigned long ofs)
-{
-	map_word val;
-	val.x[0] = *(uint32_t*)(map->virt + ofs);
-	return val;
-}
-
-static void dc21285_copy_from(struct map_info *map, void *to, unsigned long from, ssize_t len)
-{
-	memcpy(to, (void*)(map->virt + from), len);
-}
-
-static void dc21285_write8(struct map_info *map, const map_word d, unsigned long adr)
-{
-	if (machine_is_netwinder())
-		nw_en_write();
-	*CSR_ROMWRITEREG = adr & 3;
-	adr &= ~3;
-	*(uint8_t*)(map->virt + adr) = d.x[0];
-}
-
-static void dc21285_write16(struct map_info *map, const map_word d, unsigned long adr)
-{
-	if (machine_is_netwinder())
-		nw_en_write();
-	*CSR_ROMWRITEREG = adr & 3;
-	adr &= ~3;
-	*(uint16_t*)(map->virt + adr) = d.x[0];
-}
-
-static void dc21285_write32(struct map_info *map, const map_word d, unsigned long adr)
-{
-	if (machine_is_netwinder())
-		nw_en_write();
-	*(uint32_t*)(map->virt + adr) = d.x[0];
-}
-
-static void dc21285_copy_to_32(struct map_info *map, unsigned long to, const void *from, ssize_t len)
-{
-	while (len > 0) {
-		map_word d;
-		d.x[0] = *((uint32_t*)from);
-		dc21285_write32(map, d, to);
-		from += 4;
-		to += 4;
-		len -= 4;
-	}
-}
-
-static void dc21285_copy_to_16(struct map_info *map, unsigned long to, const void *from, ssize_t len)
-{
-	while (len > 0) {
-		map_word d;
-		d.x[0] = *((uint16_t*)from);
-		dc21285_write16(map, d, to);
-		from += 2;
-		to += 2;
-		len -= 2;
-	}
-}
-
-static void dc21285_copy_to_8(struct map_info *map, unsigned long to, const void *from, ssize_t len)
-{
-	map_word d;
-	d.x[0] = *((uint8_t*)from);
-	dc21285_write8(map, d, to);
-	from++;
-	to++;
-	len--;
-}
-
-static struct map_info dc21285_map = {
-	.name = "DC21285 flash",
-	.phys = NO_XIP,
-	.size = 16*1024*1024,
-	.copy_from = dc21285_copy_from,
-};
-
-/* Partition stuff */
-static const char * const probes[] = { "RedBoot", "cmdlinepart", NULL };
-
-static int __init init_dc21285(void)
-{
-	/* Determine bankwidth */
-	switch (*CSR_SA110_CNTL & (3<<14)) {
-		case SA110_CNTL_ROMWIDTH_8:
-			dc21285_map.bankwidth = 1;
-			dc21285_map.read = dc21285_read8;
-			dc21285_map.write = dc21285_write8;
-			dc21285_map.copy_to = dc21285_copy_to_8;
-			break;
-		case SA110_CNTL_ROMWIDTH_16:
-			dc21285_map.bankwidth = 2;
-			dc21285_map.read = dc21285_read16;
-			dc21285_map.write = dc21285_write16;
-			dc21285_map.copy_to = dc21285_copy_to_16;
-			break;
-		case SA110_CNTL_ROMWIDTH_32:
-			dc21285_map.bankwidth = 4;
-			dc21285_map.read = dc21285_read32;
-			dc21285_map.write = dc21285_write32;
-			dc21285_map.copy_to = dc21285_copy_to_32;
-			break;
-		default:
-			printk (KERN_ERR "DC21285 flash: undefined bankwidth\n");
-			return -ENXIO;
-	}
-	printk (KERN_NOTICE "DC21285 flash support (%d-bit bankwidth)\n",
-		dc21285_map.bankwidth*8);
-
-	/* Let's map the flash area */
-	dc21285_map.virt = ioremap(DC21285_FLASH, 16*1024*1024);
-	if (!dc21285_map.virt) {
-		printk("Failed to ioremap\n");
-		return -EIO;
-	}
-
-	if (machine_is_ebsa285()) {
-		dc21285_mtd = do_map_probe("cfi_probe", &dc21285_map);
-	} else {
-		dc21285_mtd = do_map_probe("jedec_probe", &dc21285_map);
-	}
-
-	if (!dc21285_mtd) {
-		iounmap(dc21285_map.virt);
-		return -ENXIO;
-	}
-
-	dc21285_mtd->owner = THIS_MODULE;
-
-	mtd_device_parse_register(dc21285_mtd, probes, NULL, NULL, 0);
-
-	if(machine_is_ebsa285()) {
-		/*
-		 * Flash timing is determined with bits 19-16 of the
-		 * CSR_SA110_CNTL.  The value is the number of wait cycles, or
-		 * 0 for 16 cycles (the default).  Cycles are 20 ns.
-		 * Here we use 7 for 140 ns flash chips.
-		 */
-		/* access time */
-		*CSR_SA110_CNTL = ((*CSR_SA110_CNTL & ~0x000f0000) | (7 << 16));
-		/* burst time */
-		*CSR_SA110_CNTL = ((*CSR_SA110_CNTL & ~0x00f00000) | (7 << 20));
-		/* tristate time */
-		*CSR_SA110_CNTL = ((*CSR_SA110_CNTL & ~0x0f000000) | (7 << 24));
-	}
-
-	return 0;
-}
-
-static void __exit cleanup_dc21285(void)
-{
-	mtd_device_unregister(dc21285_mtd);
-	map_destroy(dc21285_mtd);
-	iounmap(dc21285_map.virt);
-}
-
-module_init(init_dc21285);
-module_exit(cleanup_dc21285);
-
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Nicolas Pitre <nico@fluxnic.net>");
-MODULE_DESCRIPTION("MTD map driver for DC21285 boards");
-- 
2.6.0.rc2.230.g3dd15c0
