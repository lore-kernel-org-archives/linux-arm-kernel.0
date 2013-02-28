From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Thu, 28 Feb 2013 15:19:20 +0800
Subject: [PATCH 1/7] ARM: debug: support debug ll on hisilicon soc
Message-ID: <1362035966-17628-1-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support UART0 debug ll on hisilicon Hi3620 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig.debug             |   15 +++++++++++++++
 arch/arm/include/debug/hisilicon.S |   30 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/include/debug/hisilicon.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index acdddda..32958a6 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -240,6 +240,20 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6Q.
 
+	config DEBUG_HI3620_UART
+		bool "Hisilicon HI3620 Debug UART"
+		depends on ARCH_HS
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3620 UART.
+
+	config DEBUG_HI3716_UART
+		bool "Hisilicon Hi3716 Debug UART"
+		depends on ARCH_HS
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3716 UART.
+
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
 		depends on ARCH_MMP
@@ -589,6 +603,7 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
+	default "debug/hisilicon.S" if DEBUG_HI3620_UART || DEBUG_HI3716_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
diff --git a/arch/arm/include/debug/hisilicon.S b/arch/arm/include/debug/hisilicon.S
new file mode 100644
index 0000000..e719545
--- /dev/null
+++ b/arch/arm/include/debug/hisilicon.S
@@ -0,0 +1,30 @@
+/*
+ * Early serial output macro for Hisilicon SoC
+ *
+ * Copyright (C) 2012-2013 Linaro Ltd.
+ * Copyright (C) 2012-2013 Hisilicon Ltd.
+ *
+ * Haojian Zhuang <haojian.zhuang@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#if defined(CONFIG_DEBUG_HI3620_UART)
+#define HS_UART_PHYS_BASE	0xfcb00000
+#define HS_UART_VIRT_BASE	0xfeb00000
+#elif defined(CONFIG_DEBUG_HI3716_UART)
+#define HS_UART_PHYS_BASE	0xf8b00000
+#define HS_UART_VIRT_BASE	0xfeb00000
+#endif
+
+#if defined(CONFIG_DEBUG_HI3620_UART) || defined(CONFIG_DEBUG_HI3716_UART)
+		.macro	addruart,rp,rv,tmp
+		ldr	\rp, =HS_UART_PHYS_BASE
+		ldr	\rv, =HS_UART_VIRT_BASE
+		.endm
+
+#include <asm/hardware/debug-pl01x.S>
+
+#endif
-- 
1.7.10.4
