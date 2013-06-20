From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Fri, 21 Jun 2013 01:31:10 +0200
Subject: [PATCH v6 2/3] arm: add debug uarts for rockchip rk29xx and rk3xxx
 series
In-Reply-To: <201306210129.54629.heiko@sntech.de>
References: <201306210129.54629.heiko@sntech.de>
Message-ID: <201306210131.11224.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uarts on all recent Rockchip SoCs are Synopsis DesignWare 8250 types.
Only their addresses vary very much.

This patch adds the necessary definitions to use any of the uart ports
for early debug purposes.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/Kconfig.debug            |   34 ++++++++++++++++++++++++++++++
 arch/arm/include/debug/rockchip.S |   42 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/include/debug/rockchip.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 003f371..0e88bc8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -399,6 +399,13 @@ choice
 		  their output to the standard serial port on the RealView
 		  PB1176 platform.
 
+	config DEBUG_ROCKCHIP_UART
+		bool "Kernel low-level debugging messages via Rockchip UART"
+		depends on ARCH_ROCKCHIP
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on Rockchip based platforms.
+
 	config DEBUG_S3C_UART0
 		depends on PLAT_SAMSUNG
 		select DEBUG_EXYNOS_UART if ARCH_EXYNOS
@@ -643,6 +650,32 @@ endchoice
 
 choice
 	prompt "Low-level debug console UART"
+	depends on DEBUG_ROCKCHIP_UART
+
+	config DEBUG_RK29_UART0
+		bool "RK29 UART0"
+
+	config DEBUG_RK29_UART1
+		bool "RK29 UART1"
+
+	config DEBUG_RK29_UART2
+		bool "RK29 UART2"
+
+	config DEBUG_RK3X_UART0
+		bool "RK3X UART0"
+
+	config DEBUG_RK3X_UART1
+		bool "RK3X UART1"
+
+	config DEBUG_RK3X_UART2
+		bool "RK3X UART2"
+
+	config DEBUG_RK3X_UART3
+		bool "RK3X UART3"
+endchoice
+
+choice
+	prompt "Low-level debug console UART"
 	depends on DEBUG_LL && DEBUG_TEGRA_UART
 
 	config TEGRA_DEBUG_UART_AUTO_ODMDATA
@@ -697,6 +730,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/pxa.S" if DEBUG_PXA_UART1 || DEBUG_MMP_UART2 || \
 				 DEBUG_MMP_UART3
+	default "debug/rockchip.S" if DEBUG_ROCKCHIP_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/sunxi.S" if DEBUG_SUNXI_UART0 || DEBUG_SUNXI_UART1
diff --git a/arch/arm/include/debug/rockchip.S b/arch/arm/include/debug/rockchip.S
new file mode 100644
index 0000000..cfd883e
--- /dev/null
+++ b/arch/arm/include/debug/rockchip.S
@@ -0,0 +1,42 @@
+/*
+ * Early serial output macro for Rockchip SoCs
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
+#if defined(CONFIG_DEBUG_RK29_UART0)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20060000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed60000
+#elif defined(CONFIG_DEBUG_RK29_UART1)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20064000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed64000
+#elif defined(CONFIG_DEBUG_RK29_UART2)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20068000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed68000
+#elif defined(CONFIG_DEBUG_RK3X_UART0)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x10124000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfeb24000
+#elif defined(CONFIG_DEBUG_RK3X_UART1)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x10126000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfeb26000
+#elif defined(CONFIG_DEBUG_RK3X_UART2)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20064000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed64000
+#elif defined(CONFIG_DEBUG_RK3X_UART3)
+#define ROCKCHIP_UART_DEBUG_PHYS_BASE 0x20068000
+#define ROCKCHIP_UART_DEBUG_VIRT_BASE 0xfed68000
+#endif
+
+	.macro	addruart, rp, rv, tmp
+	ldr	\rp, =ROCKCHIP_UART_DEBUG_PHYS_BASE
+	ldr	\rv, =ROCKCHIP_UART_DEBUG_VIRT_BASE
+	.endm
+
+#define UART_SHIFT	2
+#include <asm/hardware/debug-8250.S>
-- 
1.7.10.4
