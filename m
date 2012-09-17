From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:35:03 +0800
Subject: [PATCH 34/34] ARM: imx: enable multi-platform build
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-35-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It enables multi-platform build for imx.  ARCH_MXC, ARCH_IMX_V4_V5 and
ARCH_IMX_V6_V7 become invisible options to users, and are controlled
by multi-platform options.  AUTO_ZRELADDR and ARM_PATCH_PHYS_VIRT
are selected by ARCH_MXC now to save the duplication.

Headers timex.h and uncompress.h are not needed for multi-platform
build.  Remove them.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig                            |   13 ---
 arch/arm/mach-imx/Kconfig                   |   46 +++++-----
 arch/arm/mach-imx/include/mach/timex.h      |   22 -----
 arch/arm/mach-imx/include/mach/uncompress.h |  132 ---------------------------
 4 files changed, 22 insertions(+), 191 deletions(-)
 delete mode 100644 arch/arm/mach-imx/include/mach/timex.h
 delete mode 100644 arch/arm/mach-imx/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1d73bbc..afcd466 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -420,19 +420,6 @@ config ARCH_FOOTBRIDGE
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
-config ARCH_MXC
-	bool "Freescale MXC/iMX-based"
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	select USE_OF
-	help
-	  Support for Freescale MXC/iMX-based family of processors
-
 config ARCH_MXS
 	bool "Freescale MXS-based"
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index b8f0f7d..e6a5764 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,4 +1,20 @@
-if ARCH_MXC
+config ARCH_MXC
+	def_bool y if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
+	select AUTO_ZRELADDR if !ZBOOT_ROM
+	select ARM_PATCH_PHYS_VIRT
+	select GENERIC_CLOCKEVENTS
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	select USE_OF
+	help
+	  Support for Freescale MXC/iMX-based family of processors
+
+menu "Freescale i.MX support"
+	depends on ARCH_MXC
 
 config MXC_IRQ_PRIOR
 	bool "Use IRQ priority"
@@ -161,19 +177,9 @@ config	SOC_IMX51
 	select PINCTRL
 	select PINCTRL_IMX51
 
-menu "Freescale MXC Implementations"
-
-choice
-	prompt "Freescale CPU family:"
-	default ARCH_IMX_V6_V7
-
 config ARCH_IMX_V4_V5
-	bool "i.MX1, i.MX21, i.MX25, i.MX27"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
-	select ARM_PATCH_PHYS_VIRT
-	help
-	  This enables support for systems based on the Freescale i.MX ARMv4
-	  and ARMv5 SoCs
+	def_bool y
+	depends on ARCH_MULTI_V4_V5
 
 if ARCH_IMX_V4_V5
 
@@ -456,13 +462,9 @@ config MACH_IMX27_DT
 endif
 
 config ARCH_IMX_V6_V7
-	bool "i.MX3, i.MX5, i.MX6"
-	select AUTO_ZRELADDR if !ZBOOT_ROM
-	select ARM_PATCH_PHYS_VIRT
+	def_bool y
+	depends on ARCH_MULTI_V6_V7
 	select MIGHT_HAVE_CACHE_L2X0
-	help
-	  This enables support for systems based on the Freescale i.MX3, i.MX5
-	  and i.MX6 family.
 
 if ARCH_IMX_V6_V7
 
@@ -847,10 +849,6 @@ config SOC_IMX6Q
 
 endif
 
-endchoice
-
-endmenu
-
 source "arch/arm/mach-imx/devices/Kconfig"
 
-endif
+endmenu
diff --git a/arch/arm/mach-imx/include/mach/timex.h b/arch/arm/mach-imx/include/mach/timex.h
deleted file mode 100644
index 10343d1..0000000
--- a/arch/arm/mach-imx/include/mach/timex.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- *  Copyright (C) 1999 ARM Limited
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
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
-#ifndef __ASM_ARCH_MXC_TIMEX_H__
-#define __ASM_ARCH_MXC_TIMEX_H__
-
-/* Bogus value */
-#define CLOCK_TICK_RATE	12345678
-
-#endif				/* __ASM_ARCH_MXC_TIMEX_H__ */
diff --git a/arch/arm/mach-imx/include/mach/uncompress.h b/arch/arm/mach-imx/include/mach/uncompress.h
deleted file mode 100644
index 477971b..0000000
--- a/arch/arm/mach-imx/include/mach/uncompress.h
+++ /dev/null
@@ -1,132 +0,0 @@
-/*
- *  arch/arm/plat-mxc/include/mach/uncompress.h
- *
- *  Copyright (C) 1999 ARM Limited
- *  Copyright (C) Shane Nay (shane at minirl.com)
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
-#ifndef __ASM_ARCH_MXC_UNCOMPRESS_H__
-#define __ASM_ARCH_MXC_UNCOMPRESS_H__
-
-#define __MXC_BOOT_UNCOMPRESS
-
-#include <asm/mach-types.h>
-
-unsigned long uart_base;
-
-#define UART(x) (*(volatile unsigned long *)(uart_base + (x)))
-
-#define USR2 0x98
-#define USR2_TXFE (1<<14)
-#define TXR  0x40
-#define UCR1 0x80
-#define UCR1_UARTEN 1
-
-/*
- * The following code assumes the serial port has already been
- * initialized by the bootloader.  We search for the first enabled
- * port in the most probable order.  If you didn't setup a port in
- * your bootloader then nothing will appear (which might be desired).
- *
- * This does not append a newline
- */
-
-static void putc(int ch)
-{
-	if (!uart_base)
-		return;
-	if (!(UART(UCR1) & UCR1_UARTEN))
-		return;
-
-	while (!(UART(USR2) & USR2_TXFE))
-		barrier();
-
-	UART(TXR) = ch;
-}
-
-static inline void flush(void)
-{
-}
-
-#define MX1_UART1_BASE_ADDR	0x00206000
-#define MX25_UART1_BASE_ADDR	0x43f90000
-#define MX2X_UART1_BASE_ADDR	0x1000a000
-#define MX3X_UART1_BASE_ADDR	0x43F90000
-#define MX3X_UART2_BASE_ADDR	0x43F94000
-#define MX3X_UART5_BASE_ADDR	0x43FB4000
-#define MX51_UART1_BASE_ADDR	0x73fbc000
-#define MX50_UART1_BASE_ADDR	0x53fbc000
-#define MX53_UART1_BASE_ADDR	0x53fbc000
-
-static __inline__ void __arch_decomp_setup(unsigned long arch_id)
-{
-	switch (arch_id) {
-	case MACH_TYPE_MX1ADS:
-	case MACH_TYPE_SCB9328:
-		uart_base = MX1_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX25_3DS:
-		uart_base = MX25_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_IMX27LITE:
-	case MACH_TYPE_MX27_3DS:
-	case MACH_TYPE_MX27ADS:
-	case MACH_TYPE_PCM038:
-	case MACH_TYPE_MX21ADS:
-	case MACH_TYPE_PCA100:
-	case MACH_TYPE_MXT_TD60:
-	case MACH_TYPE_IMX27IPCAM:
-		uart_base = MX2X_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX31LITE:
-	case MACH_TYPE_ARMADILLO5X0:
-	case MACH_TYPE_MX31MOBOARD:
-	case MACH_TYPE_QONG:
-	case MACH_TYPE_MX31_3DS:
-	case MACH_TYPE_PCM037:
-	case MACH_TYPE_MX31ADS:
-	case MACH_TYPE_MX35_3DS:
-	case MACH_TYPE_PCM043:
-	case MACH_TYPE_LILLY1131:
-	case MACH_TYPE_VPR200:
-	case MACH_TYPE_EUKREA_CPUIMX35SD:
-		uart_base = MX3X_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MAGX_ZN5:
-		uart_base = MX3X_UART2_BASE_ADDR;
-		break;
-	case MACH_TYPE_BUG:
-		uart_base = MX3X_UART5_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX51_BABBAGE:
-	case MACH_TYPE_EUKREA_CPUIMX51SD:
-	case MACH_TYPE_MX51_3DS:
-		uart_base = MX51_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX50_RDP:
-		uart_base = MX50_UART1_BASE_ADDR;
-		break;
-	case MACH_TYPE_MX53_EVK:
-	case MACH_TYPE_MX53_LOCO:
-	case MACH_TYPE_MX53_SMD:
-	case MACH_TYPE_MX53_ARD:
-		uart_base = MX53_UART1_BASE_ADDR;
-		break;
-	default:
-		break;
-	}
-}
-
-#define arch_decomp_setup()	__arch_decomp_setup(arch_id)
-#define arch_decomp_wdog()
-
-#endif				/* __ASM_ARCH_MXC_UNCOMPRESS_H__ */
-- 
1.7.9.5
