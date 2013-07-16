From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jul 2013 17:46:13 +0100
Subject: [PATCH RFC v2 13/14] ARM: debug: move davinci debug to generic 8250
 code
In-Reply-To: <20130716163243.GY21614@n2100.arm.linux.org.uk>
References: <20130716163243.GY21614@n2100.arm.linux.org.uk>
Message-ID: <E1Uz8OD-00048N-Be@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Davinci's debugging is just a copy of the old 8250_32 code with a
different base address.  Incorporate this into the generic 8250
debug code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug                           |   16 +++++-
 arch/arm/mach-davinci/include/mach/debug-macro.S |   65 ----------------------
 2 files changed, 15 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/debug-macro.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c147e07..4cfed9d 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -119,6 +119,7 @@ choice
 	config DEBUG_DAVINCI_DA8XX_UART1
 		bool "Kernel low-level debugging on DaVinci DA8XX using UART1"
 		depends on ARCH_DAVINCI_DA8XX
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART1 serial port on DaVinci DA8XX devices.
@@ -126,6 +127,7 @@ choice
 	config DEBUG_DAVINCI_DA8XX_UART2
 		bool "Kernel low-level debugging on DaVinci DA8XX using UART2"
 		depends on ARCH_DAVINCI_DA8XX
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART2 serial port on DaVinci DA8XX devices.
@@ -133,6 +135,7 @@ choice
 	config DEBUG_DAVINCI_DMx_UART0
 		bool "Kernel low-level debugging on DaVinci DMx using UART0"
 		depends on ARCH_DAVINCI_DMx
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART0 serial port on DaVinci DMx devices.
@@ -140,6 +143,7 @@ choice
 	config DEBUG_DAVINCI_TNETV107X_UART1
 		bool "Kernel low-level debugging on DaVinci TNETV107x using UART1"
 		depends on ARCH_DAVINCI_TNETV107X
+		select DEBUG_UART_8250
 		help
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART1 serial port on DaVinci TNETV107X
@@ -901,11 +905,15 @@ config DEBUG_UART_8250
 
 config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
+	default 0x01c20000 if DEBUG_DAVINCI_DMx_UART0
 	default 0x01c28000 if DEBUG_SUNXI_UART0
 	default 0x01c28400 if DEBUG_SUNXI_UART1
+	default 0x01d0c000 if DEBUG_DAVINCI_DA8XX_UART1
+	default 0x01d0d000 if DEBUG_DAVINCI_DA8XX_UART2
 	default 0x02530c00 if DEBUG_KEYSTONE_UART0
 	default 0x02531000 if DEBUG_KEYSTONE_UART1
 	default 0x03010fe0 if ARCH_RPC
+	default 0x08108300 if DEBUG_DAVINCI_TNETV107X_UART1
 	default 0x10009000 if DEBUG_REALVIEW_STD_PORT || DEBUG_CNS3XXX || \
 				DEBUG_VEXPRESS_UART0_CA9
 	default 0x1010c000 if DEBUG_REALVIEW_PB1176_PORT
@@ -982,9 +990,13 @@ config DEBUG_UART_VIRT
 	default 0xfed64000 if DEBUG_RK29_UART1 || DEBUG_RK3X_UART2
 	default 0xfed68000 if DEBUG_RK29_UART2 || DEBUG_RK3X_UART3
 	default 0xfec02000 if DEBUG_SOCFPGA_UART
+	default 0xfec20000 if DEBUG_DAVINCI_DMx_UART0
+	default 0xfed0c000 if DEBUG_DAVINCI_DA8XX_UART1
+	default 0xfed0d000 if DEBUG_DAVINCI_DA8XX_UART2
 	default 0xfed12000 if ARCH_KIRKWOOD
 	default 0xfedc0000 if ARCH_EP93XX
 	default 0xfee003f8 if FOOTBRIDGE
+	default 0xfee08300 if DEBUG_DAVINCI_TNETV107X_UART1
 	default 0xfee20000 if DEBUG_NSPIRE_CLASSIC_UART || DEBUG_NSPIRE_CX_UART
 	default 0xfee36000 if DEBUG_HIGHBANK_UART
 	default 0xfee82340 if ARCH_IOP13XX
@@ -1007,7 +1019,9 @@ config DEBUG_UART_8250_WORD
 	depends on DEBUG_LL_UART_8250 || DEBUG_UART_8250
 	depends on DEBUG_UART_8250_SHIFT >= 2
 	default y if DEBUG_PICOXCELL_UART || DEBUG_SOCFPGA_UART || \
-		ARCH_KEYSTONE
+		ARCH_KEYSTONE || \
+		DEBUG_DAVINCI_DMx_UART0 || DEBUG_DAVINCI_DA8XX_UART1 || \
+		DEBUG_DAVINCI_DA8XX_UART2 || DEBUG_DAVINCI_TNETV107X_UART1
 
 config DEBUG_UART_8250_FLOW_CONTROL
 	bool "Enable flow control for 8250 UART"
diff --git a/arch/arm/mach-davinci/include/mach/debug-macro.S b/arch/arm/mach-davinci/include/mach/debug-macro.S
deleted file mode 100644
index b18b8eb..0000000
--- a/arch/arm/mach-davinci/include/mach/debug-macro.S
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * Debugging macro for DaVinci
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-/* Modifications
- * Jan 2009	Chaithrika U S	Added senduart, busyuart, waituart
- *				macros, based on debug-8250.S file
- *				but using 32-bit accesses required for
- *                              some davinci devices.
- */
-
-#include <linux/serial_reg.h>
-
-#include <mach/serial.h>
-
-#define UART_SHIFT	2
-
-#if defined(CONFIG_DEBUG_DAVINCI_DMx_UART0)
-#define UART_BASE	DAVINCI_UART0_BASE
-#elif defined(CONFIG_DEBUG_DAVINCI_DA8XX_UART1)
-#define UART_BASE	DA8XX_UART1_BASE
-#elif defined(CONFIG_DEBUG_DAVINCI_DA8XX_UART2)
-#define UART_BASE	DA8XX_UART2_BASE
-#elif defined(CONFIG_DEBUG_DAVINCI_TNETV107X_UART1)
-#define UART_BASE	TNETV107X_UART2_BASE
-#define UART_VIRTBASE	TNETV107X_UART2_VIRT
-#else
-#error "Select a specifc port for DEBUG_LL"
-#endif
-
-#ifndef UART_VIRTBASE
-#define UART_VIRTBASE	IO_ADDRESS(UART_BASE)
-#endif
-
-		.macro addruart, rp, rv, tmp
-		ldr	\rp, =UART_BASE
-		ldr	\rv, =UART_VIRTBASE
-		.endm
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
-		.macro	waituart,rd,rx
-#ifdef FLOW_CONTROL
-1001:		ldr	\rd, [\rx, #UART_MSR << UART_SHIFT]
-		tst	\rd, #UART_MSR_CTS
-		beq	1001b
-#endif
-		.endm
-
-- 
1.7.4.4
