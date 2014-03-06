From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 6 Mar 2014 09:45:56 -0800
Subject: [PATCH 3/6] ARM: BCM63XX: add low-level UART debug support
In-Reply-To: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
References: <1394127959-3159-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1394127959-3159-4-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Broadcom BCM63xx DSL SoCs have a different UART implementation for which
we need specially crafted low-level debug assembly code to support. Add
support for this using the standard definitions provided in
include/linux/serial_bcm63xx.h (shared with their MIPS counterparts).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/Kconfig.debug            | 18 ++++++++++++++++--
 arch/arm/include/debug/bcm63xxx.S | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/debug/bcm63xxx.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c23f52445308..a1a4281dc4b9 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -117,6 +117,11 @@ choice
 		  mobile SoCs in the Kona family of chips (e.g. bcm28155,
 		  bcm11351, etc...)
 
+	config DEBUG_BCM63XX
+		bool "Kernel low-level debugging on BCM63XX UART"
+		depends on ARCH_BCM_63XX
+		select DEBUG_UART_BCM63XX
+
 	config DEBUG_BERLIN_UART
 		bool "Marvell Berlin SoC Debug UART"
 		depends on ARCH_BERLIN
@@ -985,6 +990,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/vf.S" if DEBUG_VF_UART
 	default "debug/vt8500.S" if DEBUG_VT8500_UART0
 	default "debug/zynq.S" if DEBUG_ZYNQ_UART0 || DEBUG_ZYNQ_UART1
+	default "debug/bcm63xxx.S" if DEBUG_UART_BCM63XX
 	default "mach/debug-macro.S"
 
 # Compatibility options for PL01x
@@ -1004,6 +1010,10 @@ config DEBUG_UART_8250
 		ARCH_IOP33X || ARCH_IXP4XX || ARCH_KIRKWOOD || \
 		ARCH_LPC32XX || ARCH_MV78XX0 || ARCH_ORION5X || ARCH_RPC
 
+# Compatibility options for BCM63xx
+config DEBUG_UART_BCM63XX
+	def_bool ARCH_BCM_63XX
+
 config DEBUG_UART_PHYS
 	hex "Physical base address of debug UART"
 	default 0x01c20000 if DEBUG_DAVINCI_DMx_UART0
@@ -1059,10 +1069,12 @@ config DEBUG_UART_PHYS
 	default 0xffc02000 if DEBUG_SOCFPGA_UART
 	default 0xffd82340 if ARCH_IOP13XX
 	default 0xfff36000 if DEBUG_HIGHBANK_UART
+	default 0xfffe8600 if DEBUG_UART_BCM63XX
 	default 0xfffff700 if ARCH_IOP33X
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
 		DEBUG_LL_UART_EFM32 || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		DEBUG_UART_BCM63XX
 
 config DEBUG_UART_VIRT
 	hex "Virtual base address of debug UART"
@@ -1083,6 +1095,7 @@ config DEBUG_UART_VIRT
 	default 0xf8090000 if DEBUG_VEXPRESS_UART0_RS1
 	default 0xfb009000 if DEBUG_REALVIEW_STD_PORT
 	default 0xfb10c000 if DEBUG_REALVIEW_PB1176_PORT
+	default 0xfcfe8600 if DEBUG_UART_BCM63XX
 	default 0xfd000000 if ARCH_SPEAR3XX || ARCH_SPEAR6XX
 	default 0xfd000000 if ARCH_SPEAR13XX
 	default 0xfd012000 if ARCH_MV78XX0
@@ -1120,7 +1133,8 @@ config DEBUG_UART_VIRT
 	default 0xff003000 if DEBUG_U300_UART
 	default DEBUG_UART_PHYS if !MMU
 	depends on DEBUG_LL_UART_8250 || DEBUG_LL_UART_PL01X || \
-		DEBUG_UART_8250 || DEBUG_UART_PL01X
+		DEBUG_UART_8250 || DEBUG_UART_PL01X || \
+		DEBUG_UART_BCM63XX
 
 config DEBUG_UART_8250_SHIFT
 	int "Register offset shift for the 8250 debug UART"
diff --git a/arch/arm/include/debug/bcm63xxx.S b/arch/arm/include/debug/bcm63xxx.S
new file mode 100644
index 000000000000..a28fbd1bb5d8
--- /dev/null
+++ b/arch/arm/include/debug/bcm63xxx.S
@@ -0,0 +1,33 @@
+/*
+ * Broadcom BCM63xxx low-level UART debug
+ *
+ * Copyright (C) 2014 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/serial_bcm63xx.h>
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =CONFIG_DEBUG_UART_PHYS
+	ldr	\rv, =CONFIG_DEBUG_UART_VIRT
+	.endm
+
+	.macro	senduart, rd, rx
+	/* word access do not work */
+	strb	\rd, [\rx, #UART_FIFO_REG]
+	.endm
+
+	.macro	waituart, rd, rx
+1001:	ldr	\rd, [\rx, #UART_IR_REG]
+	tst	\rd, #(1 << UART_IR_TXEMPTY)
+	beq	1001b
+	.endm
+
+	.macro	busyuart, rd, rx
+1002:	ldr	\rd, [\rx, #UART_IR_REG]
+	tst	\rd, #(1 << UART_IR_TXTRESH)
+	beq	1002b
+	.endm
-- 
1.8.3.2
