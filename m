From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Sep 2015 17:59:25 +0900
Subject: [PATCH 09/21] ARM: shmobile: bockw: remove "reference" board file and
 config
In-Reply-To: <cover.1442478814.git.horms+renesas@verge.net.au>
References: <cover.1442478814.git.horms+renesas@verge.net.au>
Message-ID: <892b19fe503f5478f14c77d5f14df9f954292baf.1442478814.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Replaced by multi-platform.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                 | 13 ----
 arch/arm/mach-shmobile/Makefile                |  1 -
 arch/arm/mach-shmobile/Makefile.boot           |  1 -
 arch/arm/mach-shmobile/board-bockw-reference.c | 86 --------------------------
 4 files changed, 101 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 926e336d6aeb..670dce3953d0 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -126,19 +126,6 @@ config MACH_BOCKW
 	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C
 	select USE_OF
 
-config MACH_BOCKW_REFERENCE
-	bool "BOCK-W  - Reference Device Tree Implementation"
-	depends on ARCH_R8A7778
-	select ARCH_REQUIRE_GPIOLIB
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
-	select USE_OF
-	---help---
-	   Use reference implementation of BockW board support
-	   which makes use of device tree at the expense
-	   of not supporting a number of devices.
-
-	   This is intended to aid developers
-
 comment "Renesas ARM SoCs System Configuration"
 
 config CPU_HAS_INTEVT
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index b02841528e05..8f235c5ec28d 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
 # Board objects
 ifndef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
-obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
 endif
 
 # Framework support
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index a489fe9a76cd..1a4ab160e361 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,7 +1,6 @@
 # per-board load address for uImage
 loadaddr-y	:=
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
-loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 
 __ZRELADDR	:= $(sort $(loadaddr-y))
    zreladdr-y   += $(__ZRELADDR)
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
deleted file mode 100644
index 4f78296f7d04..000000000000
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ /dev/null
@@ -1,86 +0,0 @@
-/*
- * Bock-W board support
- *
- * Copyright (C) 2013  Renesas Solutions Corp.
- * Copyright (C) 2013  Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/of_platform.h>
-
-#include <asm/mach/arch.h>
-
-#include "common.h"
-#include "r8a7778.h"
-
-/*
- *	see board-bock.c for checking detail of dip-switch
- */
-
-#define FPGA	0x18200000
-#define IRQ0MR	0x30
-#define COMCTLR	0x101c
-
-#define PFC	0xfffc0000
-#define PUPR4	0x110
-static void __init bockw_init(void)
-{
-	void __iomem *fpga;
-	void __iomem *pfc;
-
-#ifndef CONFIG_COMMON_CLK
-	r8a7778_clock_init();
-#endif
-	r8a7778_init_irq_extpin_dt(1);
-	r8a7778_add_dt_devices();
-
-	fpga = ioremap_nocache(FPGA, SZ_1M);
-	if (fpga) {
-		/*
-		 * CAUTION
-		 *
-		 * IRQ0/1 is cascaded interrupt from FPGA.
-		 * it should be cared in the future
-		 * Now, it is assuming IRQ0 was used only from SMSC.
-		 */
-		u16 val = ioread16(fpga + IRQ0MR);
-		val &= ~(1 << 4); /* enable SMSC911x */
-		iowrite16(val, fpga + IRQ0MR);
-
-		iounmap(fpga);
-	}
-
-	pfc = ioremap_nocache(PFC, 0x200);
-	if (pfc) {
-		/*
-		 * FIXME
-		 *
-		 * SDHI CD/WP pin needs pull-up
-		 */
-		iowrite32(ioread32(pfc + PUPR4) | (3 << 26), pfc + PUPR4);
-		iounmap(pfc);
-	}
-
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
-static const char *const bockw_boards_compat_dt[] __initconst = {
-	"renesas,bockw-reference",
-	NULL,
-};
-
-DT_MACHINE_START(BOCKW_DT, "bockw")
-	.init_early	= shmobile_init_delay,
-	.init_irq	= r8a7778_init_irq_dt,
-	.init_machine	= bockw_init,
-	.init_late	= shmobile_init_late,
-	.dt_compat	= bockw_boards_compat_dt,
-MACHINE_END
-- 
2.1.4
