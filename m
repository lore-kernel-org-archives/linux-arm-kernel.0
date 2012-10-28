From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 28 Oct 2012 11:24:12 +0100
Subject: [PATCH 1/2] arm: bcm2835: move to the multiplatform support
Message-ID: <1351419853-25146-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit integrates the bcm2835 into the list of platforms
supported by the multiplatform mechanism, which makes it possible to
build a single kernel binary image that boots on various SoCs.

In order to make this happen, we have to:

 * Move the ARCH_BCM2835 Kconfig option down to
   arch/arm/mach-bcm2835/Kconfig and make a few adjustements.

 * Move the DEBUG_LL/earlyprintk support from
   arch/arm/mach-bcm2835/include/mach/ to arch/arm/include/debug/

 * Remove files that have become useless (timex.h, uncompress.h)

 * Move the last remaining header file bcm2835_soc.h down to
   arch/arm/mach-bcm2835/.

The resulting binary kernel has been successfully booted on both the
Rasberry Pi platform and the Globalscale Mirabox (a Marvell Armada 370
based platform).

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Note that if you have CONFIG_VFP enabled, you need "[PATCH v3] ARM:
vfp: fix save and restore when running on pre-VFPv3 and CONFIG_VFPv3
set" to be applied in order to avoid a VFP-related kernel panic when
starting the first userspace application. Thanks to Albin Tonnerre for
pointing me to the right fix for this problem!
---
 arch/arm/Kconfig                                   |   20 +--------
 arch/arm/Kconfig.debug                             |    8 ++++
 .../mach/debug-macro.S => include/debug/bcm2835.S} |    3 +-
 arch/arm/mach-bcm2835/Kconfig                      |   18 ++++++++
 arch/arm/mach-bcm2835/Makefile.boot                |    3 --
 arch/arm/mach-bcm2835/bcm2835.c                    |    2 +-
 .../{include/mach/bcm2835_soc.h => bcm2835.h}      |    2 -
 arch/arm/mach-bcm2835/include/mach/timex.h         |   26 -----------
 arch/arm/mach-bcm2835/include/mach/uncompress.h    |   45 --------------------
 9 files changed, 31 insertions(+), 96 deletions(-)
 rename arch/arm/{mach-bcm2835/include/mach/debug-macro.S => include/debug/bcm2835.S} (86%)
 create mode 100644 arch/arm/mach-bcm2835/Kconfig
 delete mode 100644 arch/arm/mach-bcm2835/Makefile.boot
 rename arch/arm/mach-bcm2835/{include/mach/bcm2835_soc.h => bcm2835.h} (91%)
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/timex.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7030500..7681840 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -334,24 +334,6 @@ config ARCH_AT91
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
 
-config ARCH_BCM2835
-	bool "Broadcom BCM2835 family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_ERRATA_411920
-	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select CPU_V6
-	select GENERIC_CLOCKEVENTS
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	select USE_OF
-	select USE_IRQCHIP
-	help
-	  This enables support for the Broadcom BCM2835 SoC. This SoC is
-	  use in the Raspberry Pi, and Roku 2 devices.
-
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	select ARM_GIC
@@ -1023,6 +1005,8 @@ source "arch/arm/mach-mvebu/Kconfig"
 
 source "arch/arm/mach-at91/Kconfig"
 
+source "arch/arm/mach-bcm2835/Kconfig"
+
 source "arch/arm/mach-clps711x/Kconfig"
 
 source "arch/arm/mach-cns3xxx/Kconfig"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0f3857..23495b3 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -89,6 +89,13 @@ choice
 		bool "Kernel low-level debugging on 9263 and 9g45"
 		depends on HAVE_AT91_DBGU1
 
+	config DEBUG_BCM2835_UART
+		bool "Kernel low-level debugging messages via BCM2835 UART"
+		depends on ARCH_BCM2835
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on BCM2835 based platforms.
+
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -411,6 +418,7 @@ endchoice
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/bcm2835.S" if DEBUG_BCM2835_UART
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
diff --git a/arch/arm/mach-bcm2835/include/mach/debug-macro.S b/arch/arm/include/debug/bcm2835.S
similarity index 86%
rename from arch/arm/mach-bcm2835/include/mach/debug-macro.S
rename to arch/arm/include/debug/bcm2835.S
index 8a161e4..afe8e04 100644
--- a/arch/arm/mach-bcm2835/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/bcm2835.S
@@ -11,7 +11,8 @@
  *
  */
 
-#include <mach/bcm2835_soc.h>
+#define BCM2835_DEBUG_PHYS	0x20201000
+#define BCM2835_DEBUG_VIRT	0xf0201000
 
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =BCM2835_DEBUG_PHYS
diff --git a/arch/arm/mach-bcm2835/Kconfig b/arch/arm/mach-bcm2835/Kconfig
new file mode 100644
index 0000000..e9bb58d
--- /dev/null
+++ b/arch/arm/mach-bcm2835/Kconfig
@@ -0,0 +1,18 @@
+config ARCH_BCM2835
+	bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_ERRATA_411920
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_V6
+	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	select USE_OF
+	select USE_IRQCHIP
+	help
+	  This enables support for the Broadcom BCM2835 SoC. This SoC is
+	  use in the Raspberry Pi, and Roku 2 devices.
+
diff --git a/arch/arm/mach-bcm2835/Makefile.boot b/arch/arm/mach-bcm2835/Makefile.boot
deleted file mode 100644
index 2d30e17..0000000
--- a/arch/arm/mach-bcm2835/Makefile.boot
+++ /dev/null
@@ -1,3 +0,0 @@
-   zreladdr-y := 0x00008000
-params_phys-y := 0x00000100
-initrd_phys-y := 0x00800000
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index ab1bccd..cb2f963 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -21,7 +21,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/bcm2835_soc.h>
+#include "bcm2835.h"
 
 static struct map_desc io_map __initdata = {
 	.virtual = BCM2835_PERIPH_VIRT,
diff --git a/arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h b/arch/arm/mach-bcm2835/bcm2835.h
similarity index 91%
rename from arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
rename to arch/arm/mach-bcm2835/bcm2835.h
index d4dfcf7..8fbad3a 100644
--- a/arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
+++ b/arch/arm/mach-bcm2835/bcm2835.h
@@ -23,7 +23,5 @@
 #define BCM2835_PERIPH_PHYS	0x20000000
 #define BCM2835_PERIPH_VIRT	0xf0000000
 #define BCM2835_PERIPH_SIZE	SZ_16M
-#define BCM2835_DEBUG_PHYS	0x20201000
-#define BCM2835_DEBUG_VIRT	0xf0201000
 
 #endif
diff --git a/arch/arm/mach-bcm2835/include/mach/timex.h b/arch/arm/mach-bcm2835/include/mach/timex.h
deleted file mode 100644
index 6d021e1..0000000
--- a/arch/arm/mach-bcm2835/include/mach/timex.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *  BCM2835 system clock frequency
- *
- *  Copyright (C) 2010 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef __ASM_ARCH_TIMEX_H
-#define __ASM_ARCH_TIMEX_H
-
-#define CLOCK_TICK_RATE		(1000000)
-
-#endif
diff --git a/arch/arm/mach-bcm2835/include/mach/uncompress.h b/arch/arm/mach-bcm2835/include/mach/uncompress.h
deleted file mode 100644
index cc46dcc..0000000
--- a/arch/arm/mach-bcm2835/include/mach/uncompress.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright (C) 2010 Broadcom
- * Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-
-#include <linux/io.h>
-#include <linux/amba/serial.h>
-#include <mach/bcm2835_soc.h>
-
-#define UART0_BASE BCM2835_DEBUG_PHYS
-
-#define BCM2835_UART_DR IOMEM(UART0_BASE + UART01x_DR)
-#define BCM2835_UART_FR IOMEM(UART0_BASE + UART01x_FR)
-#define BCM2835_UART_CR IOMEM(UART0_BASE + UART011_CR)
-
-static inline void putc(int c)
-{
-	while (__raw_readl(BCM2835_UART_FR) & UART01x_FR_TXFF)
-		barrier();
-
-	__raw_writel(c, BCM2835_UART_DR);
-}
-
-static inline void flush(void)
-{
-	int fr;
-
-	do {
-		fr = __raw_readl(BCM2835_UART_FR);
-		barrier();
-	} while ((fr & (UART011_FR_TXFE | UART01x_FR_BUSY)) != UART011_FR_TXFE);
-}
-
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
-- 
1.7.9.5
