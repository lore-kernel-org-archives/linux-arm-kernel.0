From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 15 Nov 2012 23:46:23 +0100
Subject: [PATCH 4/6] ARM: sunxi: Add earlyprintk support
In-Reply-To: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1353019586-21043-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/Kconfig.debug         |    8 ++++++++
 arch/arm/include/debug/sunxi.S |   22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 arch/arm/include/debug/sunxi.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b0f3857..6672b02 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -345,6 +345,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on SOCFPGA based platforms.
 
+	config DEBUG_SUNXI_UART
+		bool "Kernel low-level debugging messages via sunXi UART"
+		depends on ARCH_SUNXI
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Allwinner A1X based platforms.
+
 	config DEBUG_VEXPRESS_UART0_DETECT
 		bool "Autodetect UART0 on Versatile Express Cortex-A core tiles"
 		depends on ARCH_VEXPRESS && CPU_CP15_MMU
@@ -416,6 +423,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
+	default "debug/sunxi.S" if DEBUG_SUNXI_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "mach/debug-macro.S"
diff --git a/arch/arm/include/debug/sunxi.S b/arch/arm/include/debug/sunxi.S
new file mode 100644
index 0000000..ffd101f
--- /dev/null
+++ b/arch/arm/include/debug/sunxi.S
@@ -0,0 +1,22 @@
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
+#define SUNXI_UART1_PHYS_BASE	0x01c28400
+#define SUNXI_UART1_VIRT_BASE	0xf1c28400
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =SUNXI_UART1_PHYS_BASE
+	ldr	\rv, =SUNXI_UART1_VIRT_BASE
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
-- 
1.7.9.5
