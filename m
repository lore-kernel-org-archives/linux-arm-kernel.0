From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 07 Jul 2013 13:50:32 +0100
Subject: [PATCH RFC 7/9] ARM: debug: add support for word accesses to
 debug/8250.S
In-Reply-To: <20130707124326.GP24642@n2100.arm.linux.org.uk>
References: <20130707124326.GP24642@n2100.arm.linux.org.uk>
Message-ID: <E1UvoQC-0006I5-1S@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 32-bit word access support to debug/8250.S and convert Picoxcell
and SoCFPGA to this.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug             |   13 ++++++++++---
 arch/arm/include/debug/8250.S      |   24 +++++++++++++++++++++---
 arch/arm/include/debug/8250_32.S   |   27 ---------------------------
 arch/arm/include/debug/picoxcell.S |   19 -------------------
 arch/arm/include/debug/socfpga.S   |   21 ---------------------
 5 files changed, 31 insertions(+), 73 deletions(-)
 delete mode 100644 arch/arm/include/debug/8250_32.S
 delete mode 100644 arch/arm/include/debug/picoxcell.S
 delete mode 100644 arch/arm/include/debug/socfpga.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index defd881..c15177f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -836,9 +836,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/nomadik.S" if DEBUG_NOMADIK_UART
 	default "debug/nspire.S" if DEBUG_NSPIRE_CX_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
-	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
-	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/sti.S" if DEBUG_STI_UART
 	default "debug/tegra.S" if DEBUG_TEGRA_UART
 	default "debug/u300.S" if DEBUG_U300_UART
@@ -855,7 +853,8 @@ config DEBUG_UART_8250
 	depends on DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE || \
 		DEBUG_NSPIRE_CLASSIC_UART || \
 		DEBUG_PXA_UART1 || DEBUG_MMP_UART2 || DEBUG_MMP_UART3 || \
-		DEBUG_ROCKCHIP_UART || \
+		DEBUG_ROCKCHIP_UART || DEBUG_PICOXCELL_UART || \
+		DEBUG_SOCFPGA_UART || \
 		DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1 || \
 		ARCH_DOVE || ARCH_EBSA110 || \
 		(FOOTBRIDGE && !DEBUG_DC21285_PORT) || \
@@ -877,6 +876,7 @@ config DEBUG_UART_PHYS
 	default 0x40100000 if DEBUG_PXA_UART1
 	default 0x42000000 if ARCH_GEMINI
 	default 0x7c0003f8 if FOOTBRIDGE
+	default 0x80230000 if DEBUG_PICOXCELL_UART
 	default 0x90020000 if DEBUG_NSPIRE_CLASSIC_UART
 	default 0xc8000000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
@@ -888,6 +888,7 @@ config DEBUG_UART_PHYS
 	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
 				ARCH_ORION5X
 	default 0xfe800000 if ARCH_IOP32X
+	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_UART_8250
@@ -906,6 +907,7 @@ config DEBUG_UART_VIRT
 	default 0xfe012000 if ARCH_ORION5X
 	default 0xfe017000 if DEBUG_MMP_UART2
 	default 0xfe018000 if DEBUG_MMP_UART3
+	default 0xfe230000 if DEBUG_PICOXCELL_UART
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xfeb24000 if DEBUG_RK3X_UART0
 	default 0xfeb26000 if DEBUG_RK3X_UART1
@@ -913,6 +915,7 @@ config DEBUG_UART_VIRT
 	default 0xfed60000 if DEBUG_RK29_UART0
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
+	default 0xfec02000 if DEBUG_SOCFPGA_UART
 	default 0xfed12000 if ARCH_KIRKWOOD
 	default 0xfee003f8 if FOOTBRIDGE
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART
@@ -922,6 +925,10 @@ config DEBUG_UART_VIRT
 	default 0xfefff700 if ARCH_IOP33X
 	depends on DEBUG_UART_8250
 
+config DEBUG_UART_8250_WORD
+	def_bool y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART
+	depends on DEBUG_UART_8250
+
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
 	depends on DEBUG_UART_8250
diff --git a/arch/arm/include/debug/8250.S b/arch/arm/include/debug/8250.S
index 4df055b..cb25bae 100644
--- a/arch/arm/include/debug/8250.S
+++ b/arch/arm/include/debug/8250.S
@@ -14,14 +14,32 @@
 		ldr	\rv, =CONFIG_DEBUG_UART_VIRT
 		.endm
 
+#ifdef CONFIG_DEBUG_UART_8250_WORD
+		.macro	store, rd, rx:vararg
+		str	\rd, \rx
+		.endm
+
+		.macro	load, rd, rx:vararg
+		ldr	\rd, \rx
+		.endm
+#else
+		.macro	store, rd, rx:vararg
+		strb	\rd, \rx
+		.endm
+
+		.macro	load, rd, rx:vararg
+		ldrb	\rd, \rx
+		.endm
+#endif
+
 #define UART_SHIFT CONFIG_DEBUG_UART_8250_SHIFT
 
 		.macro	senduart,rd,rx
-		strb	\rd, [\rx, #UART_TX << UART_SHIFT]
+		store	\rd, [\rx, #UART_TX << UART_SHIFT]
 		.endm
 
 		.macro	busyuart,rd,rx
-1002:		ldrb	\rd, [\rx, #UART_LSR << UART_SHIFT]
+1002:		load	\rd, [\rx, #UART_LSR << UART_SHIFT]
 		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
 		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
 		bne	1002b
@@ -29,7 +47,7 @@
 
 		.macro	waituart,rd,rx
 #ifdef CONFIG_DEBUG_UART_8250_FLOW_CONTROL
-1001:		ldrb	\rd, [\rx, #UART_MSR << UART_SHIFT]
+1001:		load	\rd, [\rx, #UART_MSR << UART_SHIFT]
 		tst	\rd, #UART_MSR_CTS
 		beq	1001b
 #endif
diff --git a/arch/arm/include/debug/8250_32.S b/arch/arm/include/debug/8250_32.S
deleted file mode 100644
index 8db01ee..0000000
--- a/arch/arm/include/debug/8250_32.S
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Derived from arch/arm/mach-davinci/include/mach/debug-macro.S to use 32-bit
- * accesses to the 8250.
- */
-
-#include <linux/serial_reg.h>
-
-		.macro	senduart,rd,rx
-		str	\rd, [\rx, #UART_TX << UART_SHIFT]
-		.endm
-
-		.macro	busyuart,rd,rx
-1002:		ldr	\rd, [\rx, #UART_LSR << UART_SHIFT]
-		and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
-		teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
-		bne	1002b
-		.endm
-
-		/* The UART's don't have any flow control IO's wired up. */
-		.macro	waituart,rd,rx
-		.endm
diff --git a/arch/arm/include/debug/picoxcell.S b/arch/arm/include/debug/picoxcell.S
deleted file mode 100644
index bc1f07c..0000000
--- a/arch/arm/include/debug/picoxcell.S
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#define UART_SHIFT 2
-#define PICOXCELL_UART1_BASE		0x80230000
-#define PHYS_TO_IO(x)			(((x) & 0x00ffffff) | 0xfe000000)
-
-		.macro	addruart, rp, rv, tmp
-		ldr	\rv, =PHYS_TO_IO(PICOXCELL_UART1_BASE)
-		ldr	\rp, =PICOXCELL_UART1_BASE
-		.endm
-
-#include "8250_32.S"
diff --git a/arch/arm/include/debug/socfpga.S b/arch/arm/include/debug/socfpga.S
deleted file mode 100644
index 966b2f9..0000000
--- a/arch/arm/include/debug/socfpga.S
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  Copyright (C) 1994-1999 Russell King
- *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#define UART_SHIFT 2
-#define DEBUG_LL_UART_OFFSET	0x00002000
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #DEBUG_LL_UART_OFFSET
-		orr	\rp, \rp, #0x00c00000
-		orr	\rv, \rp, #0xfe000000	@ virtual base
-		orr	\rp, \rp, #0xff000000	@ physical base
-		.endm
-
-#include "8250_32.S"
-
-- 
1.7.4.4
