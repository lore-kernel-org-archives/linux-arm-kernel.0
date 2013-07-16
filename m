From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:45:13 +0100
Subject: [PATCH RFC v2 12/14] ARM: debug: move keystone debug to generic 8250
 code
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8NF-00048J-8B@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone's debugging is just a copy of the old 8250_32 code with a
different base address.  Incorporate this into the generic 8250
debug code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug            |   11 +++++++--
 arch/arm/include/debug/keystone.S |   43 -------------------------------------
 2 files changed, 8 insertions(+), 46 deletions(-)
 delete mode 100644 arch/arm/include/debug/keystone.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 605bfa8..c147e07 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -266,6 +266,7 @@ choice
 	config DEBUG_KEYSTONE_UART0
 		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
 		depends on ARCH_KEYSTONE
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART0 serial port on KEYSTONE2 devices.
@@ -273,6 +274,7 @@ choice
 	config DEBUG_KEYSTONE_UART1
 		bool "Kernel low-level debugging on KEYSTONE2 using UART1"
 		depends on ARCH_KEYSTONE
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART1 serial port on KEYSTONE2 devices.
@@ -873,8 +875,6 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART || \
 				 DEBUG_IMX6SL_UART
-	default "debug/keystone.S" if DEBUG_KEYSTONE_UART0 || \
-				      DEBUG_KEYSTONE_UART1
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/sti.S" if DEBUG_STI_UART
@@ -903,6 +903,8 @@ config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
 	default 0x01c28000 if DEBUG_SUNXI_UART0
 	default 0x01c28400 if DEBUG_SUNXI_UART1
+	default 0x02530c00 if DEBUG_KEYSTONE_UART0
+	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
 	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || DEBUG_CNS3XXX || \
 				DEBUG_VEXPRESS_UART0_CA9
@@ -973,6 +975,8 @@ config DEBUG_UART_VIRT
 	default 0xfe800000 if ARCH_IOP32X
 	default 0xfeb24000 if DEBUG_RK3X_UART0
 	default 0xfeb26000 if DEBUG_RK3X_UART1
+	default 0xfeb30c00 if DEBUG_KEYSTONE_UART0
+	default 0xfeb31000 if DEBUG_KEYSTONE_UART1
 	default 0xfec12000 if DEBUG_MVEBU_UART || DEBUG_MVEBU_UART_ALTERNATE
 	default 0xfed60000 if DEBUG_RK29_UART0
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
@@ -1002,7 +1006,8 @@ config DEBUG_UART_8250_WORD
 	bool "Use 32-bit accesses for 8250 UART"
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
-	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART
+	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
+		ARCH_KEYSTONE
 
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
diff --git a/arch/arm/include/debug/keystone.S b/arch/arm/include/debug/keystone.S
deleted file mode 100644
index 9aef9ba..0000000
--- a/arch/arm/include/debug/keystone.S
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Early serial debug output macro for Keystone SOCs
- *
- * Copyright 2013 Texas Instruments, Inc.
- *	Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * Based on RMKs low level debug code.
- *  Copyright (C) 1994-1999 Russell King
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/serial_reg.h>
-
-#define UART_SHIFT 2
-#if defined(CONFIG_DEBUG_KEYSTONE_UART0)
-#define UART_PHYS		0x02530c00
-#define UART_VIRT		0xfeb30c00
-#elif defined(CONFIG_DEBUG_KEYSTONE_UART1)
-#define UART_PHYS		0x02531000
-#define UART_VIRT		0xfeb31000
-#endif
-
-	.macro	addruart, rp, rv, tmp
-	ldr	\rv, =UART_VIRT			@ physical base address
-	ldr	\rp, =UART_PHYS			@ virtual base address
-	.endm
-
-	.macro	senduart,rd,rx
-	str	\rd, [\rx, #UART_TX << UART_SHIFT]
-	.endm
-
-	.macro	busyuart,rd,rx
-1002:	ldr	\rd, [\rx, #UART_LSR << UART_SHIFT]
-	and	\rd, \rd, #UART_LSR_TEMT | UART_LSR_THRE
-	teq	\rd, #UART_LSR_TEMT | UART_LSR_THRE
-	bne	1002b
-	.endm
-
-	.macro	waituart,rd,rx
-	.endm
-- 
1.7.4.4
