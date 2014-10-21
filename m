From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 21 Oct 2014 09:14:24 +0200
Subject: [PATCH v7 02/10] ARM: add lolevel debug support for asm9260
In-Reply-To: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
References: <1413875672-7894-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1413875672-7894-3-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/Kconfig.debug           | 33 ++++++++++++++++++++++++++++++---
 arch/arm/include/debug/asm9260.S | 31 +++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/debug/asm9260.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b11ad54..6190f94 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -93,6 +93,27 @@ choice
 	prompt "Kernel low-level debugging port"
 	depends on DEBUG_LL
 
+	config DEBUG_ASM9260_UART
+		bool "Kernel low-level debugging via asm9260 UART"
+		depends on MACH_ASM9260
+		help
+		  Say Y here if you want the debug print routines to direct
+		  their output to an UART or USART port on asm9260 based
+		  machines.
+
+		    DEBUG_UART_PHYS | DEBUG_UART_VIRT
+
+		    0x80000000      | 0xf0000000     | UART0
+		    0x80004000      | 0xf0004000     | UART1
+		    0x80008000      | 0xf0008000     | UART2
+		    0x8000c000      | 0xf000c000     | UART3
+		    0x80010000      | 0xf0010000     | UART4
+		    0x80014000      | 0xf0014000     | UART5
+		    0x80018000      | 0xf0018000     | UART6
+		    0x8001c000      | 0xf001c000     | UART7
+		    0x80020000      | 0xf0020000     | UART8
+		    0x80024000      | 0xf0024000     | UART9
+
 	config AT91_DEBUG_LL_DBGU0
 		bool "Kernel low-level debugging on rm9200, 9260/9g20, 9261/9g10 and 9rl"
 		depends on HAVE_AT91_DBGU0
@@ -1010,6 +1031,7 @@ config DEBUG_STI_UART
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/asm9260.S" if DEBUG_ASM9260_UART
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
@@ -1094,6 +1116,7 @@ config DEBUG_UART_PHYS
 	default 0x50008000 if DEBUG_S3C24XX_UART && (DEBUG_S3C_UART2 || \
 				DEBUG_S3C2410_UART2)
 	default 0x7c0003f8 if FOOTBRIDGE
+	default 0x80010000 if DEBUG_ASM9260_UART
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
@@ -1126,7 +1149,8 @@ config DEBUG_UART_PHYS
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
-		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
+		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || \
+		DEBUG_S3C24XX_UART || DEBUG_ASM9260_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1134,6 +1158,7 @@ config DEBUG_UART_VIRT
 	default 0xe1000000 if DEBUG_MSM_UART
 	default 0xf0000be0 if ARCH_EBSA110
 	default 0xf0009000 if DEBUG_CNS3XXX
+	default 0xf0010000 if DEBUG_ASM9260_UART
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835
 	default 0xf1000300 if DEBUG_BCM_5301X
@@ -1194,7 +1219,8 @@ config DEBUG_UART_VIRT
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
-		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART
+		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || \
+		DEBUG_S3C24XX_UART || DEBUG_ASM9260_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
@@ -1236,7 +1262,8 @@ config DEBUG_UNCOMPRESS
 config UNCOMPRESS_INCLUDE
 	string
 	default "debug/uncompress.h" if ARCH_MULTIPLATFORM || ARCH_MSM || \
-					PLAT_SAMSUNG || ARCH_EFM32
+					PLAT_SAMSUNG || ARCH_EFM32 || \
+					MACH_ASM9260
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/include/debug/asm9260.S b/arch/arm/include/debug/asm9260.S
new file mode 100644
index 0000000..c70d51f
--- /dev/null
+++ b/arch/arm/include/debug/asm9260.S
@@ -0,0 +1,31 @@
+/* arch/arm/mach-imx/include/mach/debug-macro.S
+ *
+ * Debugging macro include header
+ *
+ *  Copyright (C) 1994-1999 Russell King
+ *  Moved from linux/arch/arm/kernel/debug.S by Ben Dooks
+ *  Modified for ASM9260 by Oleksij Remepl <linux@rempel-privat.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+		.macro	addruart, rp, rv, tmp
+		ldr	\rp, = CONFIG_DEBUG_UART_PHYS
+		ldr	\rv, = CONFIG_DEBUG_UART_VIRT
+		.endm
+
+		.macro	waituart,rd,rx
+		.endm
+
+		.macro	senduart,rd,rx
+		str	\rd, [\rx, #0x50]	@ TXDATA
+		.endm
+
+		.macro	busyuart,rd,rx
+1002:		ldr	\rd, [\rx, #0x60]	@ STAT
+		tst	\rd, #1 << 27		@ TXEMPTY
+		beq	1002b			@ wait until transmit done
+		.endm
-- 
1.9.1
