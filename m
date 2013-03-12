From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 22:59:59 -0600
Subject: [RFC PATCH] ARM: bcm2835: convert to multi-platform
Message-ID: <1363064399-19559-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows BCM2835 be included in a kernel build that supports multiple
SoCs at once, which is useful for distro kernels.

This change:
* Moves bcm2835's debug-macro.S into ARM's include/debug/, and hooks it
  into the relevant menu.
* Moves bcm2835's Kconfig into its own directory, as seems typical for
  multi-platform conversions.
* Removes bcm2835_soc.h, and moves the content to the files where it was
  used; just one usage per define.
* Deletes some headers and Makefile.boot that aren't needed now that we
  support multi-platform.

TO DO:
* It'd be nice to restore uncompress.h. I need to take a look at Shawn
  Guo's patches related to this, and presumably rebase this on top of
  them.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
 arch/arm/Kconfig                                   |   22 +---------
 arch/arm/Kconfig.debug                             |    5 +++
 arch/arm/configs/bcm2835_defconfig                 |    2 +
 .../mach/debug-macro.S => include/debug/bcm2835.S} |    3 +-
 arch/arm/mach-bcm2835/Kconfig                      |   15 +++++++
 arch/arm/mach-bcm2835/Makefile.boot                |    1 -
 arch/arm/mach-bcm2835/bcm2835.c                    |    6 ++-
 arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h   |   29 -------------
 arch/arm/mach-bcm2835/include/mach/gpio.h          |    1 -
 arch/arm/mach-bcm2835/include/mach/timex.h         |   26 ------------
 arch/arm/mach-bcm2835/include/mach/uncompress.h    |   44 --------------------
 11 files changed, 30 insertions(+), 124 deletions(-)
 rename arch/arm/{mach-bcm2835/include/mach/debug-macro.S => include/debug/bcm2835.S} (86%)
 create mode 100644 arch/arm/mach-bcm2835/Kconfig
 delete mode 100644 arch/arm/mach-bcm2835/Makefile.boot
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/timex.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..0d3daa6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -362,26 +362,6 @@ config ARCH_AT91
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
 
-config ARCH_BCM2835
-	bool "Broadcom BCM2835 family"
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_AMBA
-	select ARM_ERRATA_411920
-	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select CLKSRC_OF
-	select COMMON_CLK
-	select CPU_V6
-	select GENERIC_CLOCKEVENTS
-	select MULTI_IRQ_HANDLER
-	select PINCTRL
-	select PINCTRL_BCM2835
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  This enables support for the Broadcom BCM2835 SoC. This SoC is
-	  use in the Raspberry Pi, and Roku 2 devices.
-
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family"
 	select ARM_GIC
@@ -1037,6 +1017,8 @@ source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-bcm/Kconfig"
 
+source "arch/arm/mach-bcm2835/Kconfig"
+
 source "arch/arm/mach-clps711x/Kconfig"
 
 source "arch/arm/mach-cns3xxx/Kconfig"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..a877d51 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -89,6 +89,10 @@ choice
 		bool "Kernel low-level debugging on 9263 and 9g45"
 		depends on HAVE_AT91_DBGU1
 
+	config DEBUG_BCM2835
+		bool "Kernel low-level debugging on BCM2835 PL011 UART"
+		depends on ARCH_BCM2835
+
 	config DEBUG_CLPS711X_UART1
 		bool "Kernel low-level debugging messages via UART1"
 		depends on ARCH_CLPS711X
@@ -579,6 +583,7 @@ endchoice
 
 config DEBUG_LL_INCLUDE
 	string
+	default "debug/bcm2835.S" if DEBUG_BCM2835
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 7bcf189..cd81396 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -29,6 +29,8 @@ CONFIG_EMBEDDED=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_JUMP_LABEL=y
+CONFIG_ARCH_MULTI_V6=y
+# CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_BCM2835=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
diff --git a/arch/arm/mach-bcm2835/include/mach/debug-macro.S b/arch/arm/include/debug/bcm2835.S
similarity index 86%
rename from arch/arm/mach-bcm2835/include/mach/debug-macro.S
rename to arch/arm/include/debug/bcm2835.S
index 8a161e4..aed9199 100644
--- a/arch/arm/mach-bcm2835/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/bcm2835.S
@@ -11,7 +11,8 @@
  *
  */
 
-#include <mach/bcm2835_soc.h>
+#define BCM2835_DEBUG_PHYS 0x20201000
+#define BCM2835_DEBUG_VIRT 0xf0201000
 
 	.macro	addruart, rp, rv, tmp
 	ldr	\rp, =BCM2835_DEBUG_PHYS
diff --git a/arch/arm/mach-bcm2835/Kconfig b/arch/arm/mach-bcm2835/Kconfig
new file mode 100644
index 0000000..560045c
--- /dev/null
+++ b/arch/arm/mach-bcm2835/Kconfig
@@ -0,0 +1,15 @@
+config ARCH_BCM2835
+	bool "Broadcom BCM2835 family" if ARCH_MULTI_V6
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_ERRATA_411920
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select CLKSRC_OF
+	select CPU_V6
+	select GENERIC_CLOCKEVENTS
+	select PINCTRL
+	select PINCTRL_BCM2835
+	help
+	  This enables support for the Broadcom BCM2835 SoC. This SoC is
+	  use in the Raspberry Pi, and Roku 2 devices.
diff --git a/arch/arm/mach-bcm2835/Makefile.boot b/arch/arm/mach-bcm2835/Makefile.boot
deleted file mode 100644
index b327175..0000000
--- a/arch/arm/mach-bcm2835/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-bcm2835/bcm2835.c b/arch/arm/mach-bcm2835/bcm2835.c
index 6f57859..740fa9e 100644
--- a/arch/arm/mach-bcm2835/bcm2835.c
+++ b/arch/arm/mach-bcm2835/bcm2835.c
@@ -23,8 +23,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/bcm2835_soc.h>
-
 #define PM_RSTC				0x1c
 #define PM_RSTS				0x20
 #define PM_WDOG				0x24
@@ -34,6 +32,10 @@
 #define PM_RSTC_WRCFG_FULL_RESET	0x00000020
 #define PM_RSTS_HADWRH_SET		0x00000040
 
+#define BCM2835_PERIPH_PHYS	0x20000000
+#define BCM2835_PERIPH_VIRT	0xf0000000
+#define BCM2835_PERIPH_SIZE	SZ_16M
+
 static void __iomem *wdt_regs;
 
 /*
diff --git a/arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h b/arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
deleted file mode 100644
index d4dfcf7..0000000
--- a/arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * Copyright (C) 2012 Stephen Warren
- *
- * Derived from code:
- * Copyright (C) 2010 Broadcom
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
-#ifndef __MACH_BCM2835_BCM2835_SOC_H__
-#define __MACH_BCM2835_BCM2835_SOC_H__
-
-#include <asm/sizes.h>
-
-#define BCM2835_PERIPH_PHYS	0x20000000
-#define BCM2835_PERIPH_VIRT	0xf0000000
-#define BCM2835_PERIPH_SIZE	SZ_16M
-#define BCM2835_DEBUG_PHYS	0x20201000
-#define BCM2835_DEBUG_VIRT	0xf0201000
-
-#endif
diff --git a/arch/arm/mach-bcm2835/include/mach/gpio.h b/arch/arm/mach-bcm2835/include/mach/gpio.h
deleted file mode 100644
index 40a8c17..0000000
--- a/arch/arm/mach-bcm2835/include/mach/gpio.h
+++ /dev/null
@@ -1 +0,0 @@
-/* empty */
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
index bf86dca..0000000
--- a/arch/arm/mach-bcm2835/include/mach/uncompress.h
+++ /dev/null
@@ -1,44 +0,0 @@
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
-- 
1.7.10.4
