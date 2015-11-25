From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 16:37:55 +0100
Subject: [PATCH 7/7] ARM: mmp: move into ARCH_MULTIPLATFORM
In-Reply-To: <1448465875-435039-1-git-send-email-arnd@arndb.de>
References: <1448465875-435039-1-git-send-email-arnd@arndb.de>
Message-ID: <1448465875-435039-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With all dependencies taken care of, this enables building
the Marvell mmp platform as part of ARCH_MULTIPLATFORM, along
with other ARMv5 and ARMv7 platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                            | 16 ----------
 arch/arm/mach-mmp/Kconfig                   | 36 ++++++++++++++++++-----
 arch/arm/mach-mmp/Makefile                  |  1 +
 arch/arm/mach-mmp/include/mach/uncompress.h | 45 -----------------------------
 arch/arm/plat-pxa/Makefile                  |  1 +
 5 files changed, 30 insertions(+), 69 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1bceaec85900..bf9ab47fa14b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -527,22 +527,6 @@ config ARCH_ORION5X
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
 	  Orion-2 (5281), Orion-1-90 (6183).
 
-config ARCH_MMP
-	bool "Marvell PXA168/910/MMP2"
-	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select GENERIC_ALLOCATOR
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PXA
-	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
-	select PINCTRL
-	select PLAT_PXA
-	select SPARSE_IRQ
-	help
-	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
-
 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index fdbfadf00c84..4773fe1d8b3f 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,9 +1,24 @@
+menuconfig ARCH_MMP
+	bool "Marvell PXA168/910/MMP2"
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_ALLOCATOR
+	select GENERIC_CLOCKEVENTS
+	select GPIO_PXA
+	select PINCTRL
+	select PLAT_PXA
+	help
+	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
+
 if ARCH_MMP
 
-menu "Marvell PXA168/910/MMP2 Implmentations"
+menu "Marvell PXA168/910/MMP2 Implementations"
+
+if ATAGS
 
 config MACH_ASPENITE
 	bool "Marvell's PXA168 Aspenite Development Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -11,6 +26,7 @@ config MACH_ASPENITE
 
 config MACH_ZYLONITE2
 	bool "Marvell's PXA168 Zylonite2 Development Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -18,6 +34,7 @@ config MACH_ZYLONITE2
 
 config MACH_AVENGERS_LITE
 	bool "Marvell's PXA168 Avengers Lite Development Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -25,6 +42,7 @@ config MACH_AVENGERS_LITE
 
 config MACH_TAVOREVB
 	bool "Marvell's PXA910 TavorEVB Development Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA910
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
@@ -32,6 +50,7 @@ config MACH_TAVOREVB
 
 config MACH_TTC_DKB
 	bool "Marvell's PXA910 TavorEVB Development Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA910
 	help
 	  Say 'Y' here if you want to support the Marvell PXA910-based
@@ -39,7 +58,7 @@ config MACH_TTC_DKB
 
 config MACH_BROWNSTONE
 	bool "Marvell's Brownstone Development Platform"
-	depends on !CPU_MOHAWK
+	depends on ARCH_MULTI_V7
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
@@ -50,7 +69,7 @@ config MACH_BROWNSTONE
 
 config MACH_FLINT
 	bool "Marvell's Flint Development Platform"
-	depends on !CPU_MOHAWK
+	depends on ARCH_MULTI_V7
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-based
@@ -61,7 +80,7 @@ config MACH_FLINT
 
 config MACH_MARVELL_JASPER
 	bool "Marvell's Jasper Development Platform"
-	depends on !CPU_MOHAWK
+	depends on ARCH_MULTI_V7
 	select CPU_MMP2
 	help
 	  Say 'Y' here if you want to support the Marvell MMP2-base
@@ -72,6 +91,7 @@ config MACH_MARVELL_JASPER
 
 config MACH_TETON_BGA
 	bool "Marvell's PXA168 Teton BGA Development Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
@@ -79,14 +99,16 @@ config MACH_TETON_BGA
 
 config MACH_GPLUGD
 	bool "Marvell's PXA168 GuruPlug Display (gplugD) Board"
+	depends on ARCH_MULTI_V5
 	select CPU_PXA168
 	help
 	  Say 'Y' here if you want to support the Marvell PXA168-based
 	  GuruPlug Display (gplugD) Board
+endif
 
 config MACH_MMP_DT
 	bool "Support MMP (ARMv5) platforms from device tree"
-	select USE_OF
+	depends on ARCH_MULTI_V5
 	select PINCTRL
 	select PINCTRL_SINGLE
 	select COMMON_CLK
@@ -99,11 +121,9 @@ config MACH_MMP_DT
 
 config MACH_MMP2_DT
 	bool "Support MMP2 (ARMv7) platforms from device tree"
-	depends on !CPU_MOHAWK
-	select USE_OF
+	depends on ARCH_MULTI_V7
 	select PINCTRL
 	select PINCTRL_SINGLE
-	select COMMON_CLK
 	select ARCH_HAS_RESET_CONTROLLER
 	select CPU_PJ4
 	help
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 98f0f6388e44..7677ad5414e9 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for Marvell's PXA168 processors line
 #
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-pxa/include
 
 obj-y				+= common.o devices.o time.o
 
diff --git a/arch/arm/mach-mmp/include/mach/uncompress.h b/arch/arm/mach-mmp/include/mach/uncompress.h
deleted file mode 100644
index 8890fa8fa771..000000000000
--- a/arch/arm/mach-mmp/include/mach/uncompress.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * arch/arm/mach-mmp/include/mach/uncompress.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/serial_reg.h>
-#include <mach/addr-map.h>
-#include <asm/mach-types.h>
-
-#define UART1_BASE	(APB_PHYS_BASE + 0x36000)
-#define UART2_BASE	(APB_PHYS_BASE + 0x17000)
-#define UART3_BASE	(APB_PHYS_BASE + 0x18000)
-
-volatile unsigned long *UART;
-
-static inline void putc(char c)
-{
-	/* UART enabled? */
-	if (!(UART[UART_IER] & UART_IER_UUE))
-		return;
-
-	while (!(UART[UART_LSR] & UART_LSR_THRE))
-		barrier();
-
-	UART[UART_TX] = c;
-}
-
-/*
- * This does not append a newline
- */
-static inline void flush(void)
-{
-}
-
-static inline void arch_decomp_setup(void)
-{
-	/* default to UART2 */
-	UART = (unsigned long *)UART2_BASE;
-
-	if (machine_is_avengers_lite())
-		UART = (unsigned long *)UART3_BASE;
-}
diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
index e507aebbef52..557b134db772 100644
--- a/arch/arm/plat-pxa/Makefile
+++ b/arch/arm/plat-pxa/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for code common across different PXA processor families
 #
+ccflags-$(CONFIG_ARCH_MMP) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_ARCH_PXA)		:= dma.o
 
-- 
2.1.0.rc2
