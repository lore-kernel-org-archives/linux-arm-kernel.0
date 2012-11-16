From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 Nov 2012 22:20:26 +0100
Subject: [PATCH 5/7] ARM: sunxi: Add earlyprintk support
In-Reply-To: <1353100828-9218-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1353100828-9218-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1353100828-9218-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Stefan Roese <sr@denx.de>
---
 arch/arm/Kconfig.debug         |    8 ++++++++
 arch/arm/include/debug/sunxi.S |   24 ++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm/include/debug/sunxi.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0f3857..f12bc3a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -345,6 +345,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA based platforms.
 
+	config DEBUG_SUNXI_UART1
+		bool "Kernel low-level debugging messages via sunXi UART1"
+		depends on ARCH_SUNXI
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Allwinner A1X based platforms on the UART1.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -416,6 +423,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
+	default "debug/sunxi.S" if DEBUG_SUNXI_UART1
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "mach/debug-macro.S"
diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
new file mode 100644
index 0000000..3bf61ca
--- /dev/null
+++ b/arch/arm/include/debug/sunxi.S
@@ -0,0 +1,24 @@
+/*
+ * Early serial output macro for Allwinner A1X SoCs
+ *
+ * Copyright (C) 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifdef CONFIG_DEBUG_SUNXI_UART1
+#define SUNXI_UART_DEBUG_PHYS_BASE 0x01c28400
+#define SUNXI_UART_DEBUG_VIRT_BASE 0xf1c28400
+#endif
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =SUNXI_UART_DEBUG_PHYS_BASE
+	ldr	\rv, =SUNXI_UART_DEBUG_VIRT_BASE
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
-- 
1.7.9.5
