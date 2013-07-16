From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:47:13 +0100
Subject: [PATCH RFC v2 14/14] ARM: debug: move Spear debug to generic PL01x
 code
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8PB-00048R-F3@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Spear debug code is a copy of the PL01x debugging code, so rather
than have this pointless code duplication, lets just use the standard
implementation instead.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                         |    7 ++++
 arch/arm/mach-spear/include/mach/debug-macro.S |   36 ------------------------
 arch/arm/mach-spear/include/mach/spear.h       |    2 -
 3 files changed, 7 insertions(+), 38 deletions(-)
 delete mode 100644 arch/arm/mach-spear/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4cfed9d..974359f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -893,6 +893,9 @@ config DEBUG_LL_INCLUDE
 config DEBUG_UART_PL01X
 	def_bool ARCH_EP93XX || \
 		ARCH_INTEGRATOR || \
+		ARCH_SPEAR3XX || \
+		ARCH_SPEAR6XX || \
+		ARCH_SPEAR13XX || \
 		ARCH_VERSATILE
 
 # Compatibility options for 8250
@@ -940,9 +943,11 @@ config DEBUG_UART_PHYS
 	default 0xc0013000 if DEBUG_U300_UART
 	default 0xc8000000 if ARCH_IXP4XX && !CPU_BIG_ENDIAN
 	default 0xc8000003 if ARCH_IXP4XX && CPU_BIG_ENDIAN
+	default 0xd0000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xd0012000 if DEBUG_MVEBU_UART
 	default 0xd4017000 if DEBUG_MMP_UART2
 	default 0xd4018000 if DEBUG_MMP_UART3
+	default 0xe0000000 if ARCH_SPEAR13XX
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf1012000 if DEBUG_MVEBU_UART_ALTERNATE
 	default 0xf1012000 if ARCH_DOVE || ARCH_KIRKWOOD || ARCH_MV78XX0 || \
@@ -973,6 +978,8 @@ config DEBUG_UART_VIRT
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
+	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
+	default 0xfd000000 if ARCH_SPEAR13XX
 	default 0xfd012000 if ARCH_MV78XX0
 	default 0xfde12000 if ARCH_DOVE
 	default 0xfe012000 if ARCH_ORION5X
diff --git a/arch/arm/mach-spear/include/mach/debug-macro.S b/arch/arm/mach-spear/include/mach/debug-macro.S
deleted file mode 100644
index 75b05ad..0000000
--- a/arch/arm/mach-spear/include/mach/debug-macro.S
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * arch/arm/plat-spear/include/plat/debug-macro.S
- *
- * Debugging macro include header for spear platform
- *
- * Copyright (C) 2009 ST Microelectronics
- * Viresh Kumar <viresh.linux@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <linux/amba/serial.h>
-#include <mach/spear.h>
-
-		.macro	addruart, rp, rv, tmp
-		mov	\rp, #SPEAR_DBG_UART_BASE		@ Physical base
-		mov	\rv, #VA_SPEAR_DBG_UART_BASE		@ Virtual base
-		.endm
-
-		.macro	senduart, rd, rx
-		strb	\rd, [\rx, #UART01x_DR]			@ ASC_TX_BUFFER
-		.endm
-
-		.macro	waituart, rd, rx
-1001:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
-		tst	\rd, #UART01x_FR_TXFF			@ TX_FULL
-		bne	1001b
-		.endm
-
-		.macro	busyuart, rd, rx
-1002:		ldr	\rd, [\rx, #UART01x_FR]			@ FLAG REGISTER
-		tst	\rd, #UART011_FR_TXFE			@ TX_EMPTY
-		beq	1002b
-		.endm
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index cf3a536..5cdc53d 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -39,7 +39,6 @@
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE		SPEAR_ICM1_UART_BASE
-#define VA_SPEAR_DBG_UART_BASE		VA_SPEAR_ICM1_UART_BASE
 
 /* Sysctl base for spear platform */
 #define SPEAR_SYS_CTRL_BASE		SPEAR_ICM3_SYS_CTRL_BASE
@@ -86,7 +85,6 @@
 
 /* Debug uart for linux, will be used for debug and uncompress messages */
 #define SPEAR_DBG_UART_BASE			UART_BASE
-#define VA_SPEAR_DBG_UART_BASE			VA_UART_BASE
 
 #endif /* SPEAR13XX */
 
-- 
1.7.4.4
