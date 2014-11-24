From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 24 Nov 2014 12:08:28 +0100
Subject: [PATCH v4 2/2] ARM: add lolevel debug support for asm9260
In-Reply-To: <1416827308-16481-1-git-send-email-linux@rempel-privat.de>
References: <1415086486-10260-1-git-send-email-linux@rempel-privat.de>
 <1416827308-16481-1-git-send-email-linux@rempel-privat.de>
Message-ID: <1416827308-16481-3-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since there is no public documentation, this patch also provide register
offsets for different UART units on this SoC.

Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
---
 arch/arm/Kconfig.debug           | 28 ++++++++++++++++++++++++++--
 arch/arm/include/debug/asm9260.S | 29 +++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/debug/asm9260.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d8f6a2e..606865f 100644
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
@@ -1042,6 +1063,7 @@ config DEBUG_STI_UART
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/8250.S" if DEBUG_LL_UART_8250 || DEBUG_UART_8250
+	default "debug/asm9260.S" if DEBUG_ASM9260_UART
 	default "debug/clps711x.S" if DEBUG_CLPS711X_UART1 || DEBUG_CLPS711X_UART2
 	default "debug/meson.S" if DEBUG_MESON_UARTAO
 	default "debug/pl01x.S" if DEBUG_LL_UART_PL01X || DEBUG_UART_PL01X
@@ -1135,6 +1157,7 @@ config DEBUG_UART_PHYS
 	default 0x78000000 if DEBUG_CNS3XXX
 	default 0x7c0003f8 if FOOTBRIDGE
 	default 0x78000000 if DEBUG_CNS3XXX
+	default 0x80010000 if DEBUG_ASM9260_UART
 	default 0x80070000 if DEBUG_IMX23_UART
 	default 0x80074000 if DEBUG_IMX28_UART
 	default 0x80230000 if DEBUG_PICOXCELL_UART
@@ -1171,13 +1194,14 @@ config DEBUG_UART_PHYS
 		DEBUG_LL_UART_EFM32 || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
-		DEBUG_UART_BCM63XX
+		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
 	default 0xe0010fe0 if ARCH_RPC
 	default 0xe1000000 if DEBUG_MSM_UART
 	default 0xf0000be0 if ARCH_EBSA110
+	default 0xf0010000 if DEBUG_ASM9260_UART
 	default 0xf01fb000 if DEBUG_NOMADIK_UART
 	default 0xf0201000 if DEBUG_BCM2835
 	default 0xf1000300 if DEBUG_BCM_5301X
@@ -1244,7 +1268,7 @@ config DEBUG_UART_VIRT
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_UART_8250 || DEBUG_UART_PL01X || DEBUG_MESON_UARTAO || \
 		DEBUG_MSM_UART || DEBUG_QCOM_UARTDM || DEBUG_S3C24XX_UART || \
-		DEBUG_UART_BCM63XX
+		DEBUG_UART_BCM63XX || DEBUG_ASM9260_UART
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/asm9260.S b/arch/arm/include/debug/asm9260.S
new file mode 100644
index 0000000..292f85b
--- /dev/null
+++ b/arch/arm/include/debug/asm9260.S
@@ -0,0 +1,29 @@
+/* Debugging macro include header
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
