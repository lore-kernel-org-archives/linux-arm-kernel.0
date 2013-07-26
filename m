From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Fri, 26 Jul 2013 12:32:13 +0800
Subject: [PATCH v6 2/4] ARM: debug: support debug ll on hisilicon soc
In-Reply-To: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1374813135-16238-3-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support UART0 debug ll on hisilicon Hi3620 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/Kconfig.debug             | 15 +++++++++++++++
 arch/arm/include/debug/hisilicon.S | 30 ++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 arch/arm/include/debug/hisilicon.S

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index e401a76..289a248 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -272,6 +272,20 @@ choice
 		  Say Y here if you want the debug print routines to direct
 		  their output to UART1 serial port on KEYSTONE2 devices.
 
+	config DEBUG_HI3620_UART
+		bool "Hisilicon HI3620 Debug UART"
+		depends on ARCH_HI3xxx
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3620 UART.
+
+	config DEBUG_HI3716_UART
+		bool "Hisilicon Hi3716 Debug UART"
+		depends on ARCH_HI3xxx
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on HI3716 UART.
+
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
 		depends on ARCH_MMP
@@ -765,6 +779,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/cns3xxx.S" if DEBUG_CNS3XXX
 	default "debug/exynos.S" if DEBUG_EXYNOS_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
+	default "debug/hisilicon.S" if DEBUG_HI3620_UART || DEBUG_HI3716_UART
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
diff --git a/arch/arm/include/debug/hisilicon.S b/arch/arm/include/debug/hisilicon.S
new file mode 100644
index 0000000..47ad019
--- /dev/null
+++ b/arch/arm/include/debug/hisilicon.S
@@ -0,0 +1,30 @@
+/*
+ * Early serial output macro for Hisilicon SoC
+ *
+ * Copyright (C) 2012-2013 Hisilicon Technologies Co., Ltd.
+ * Copyright (C) 2012-2013 Linaro Ltd.
+ *
+ * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
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
1.8.1.2
