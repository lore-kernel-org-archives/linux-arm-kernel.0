From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Dec 2012 21:45:43 +0800
Subject: [PATCH 2/4] ARM: imx: support DEBUG_LL uart port selection for all
 i.MX SoCs
In-Reply-To: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1355319945-3199-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend imx6q DEBUG_LL uart port selection support to cover all i.MX
SoCs.  The 'range' of the Kconfig option gets dropped, as users
looking at the option must know the uart number on his board.  The
bottom line is that the build system will report an error if an
invalid port number is picked for given SoC.

The header arch/arm/include/debug/imx-uart.h is created to accommodate
all the uart base addresses.  And the header will also be used for
other low-level debug facility later.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug            |   13 ++++--
 arch/arm/include/debug/imx-uart.h |   88 +++++++++++++++++++++++++++++++++++++
 arch/arm/include/debug/imx.S      |   29 +-----------
 3 files changed, 98 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/include/debug/imx-uart.h

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index ae2ee04..05f83c8 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -457,11 +457,16 @@ choice
 
 endchoice
 
-config DEBUG_IMX6Q_UART_PORT
-	int "i.MX6Q Debug UART Port (1-5)" if DEBUG_IMX6Q_UART
-	range 1 5
+config DEBUG_IMX_UART_PORT
+	int "i.MX Debug UART Port Selection" if DEBUG_IMX1_UART || \
+						DEBUG_IMX25_UART || \
+						DEBUG_IMX21_IMX27_UART || \
+						DEBUG_IMX31_UART || \
+						DEBUG_IMX35_UART || \
+						DEBUG_IMX51_UART || \
+						DEBUG_IMX50_IMX53_UART || \
+						DEBUG_IMX6Q_UART
 	default 1
-	depends on SOC_IMX6Q
 	help
 	  Choose UART port on which kernel low-level debug messages
 	  should be output.
diff --git a/arch/arm/include/debug/imx-uart.h b/arch/arm/include/debug/imx-uart.h
new file mode 100644
index 0000000..a51b727
--- /dev/null
+++ b/arch/arm/include/debug/imx-uart.h
@@ -0,0 +1,88 @@
+/*
+ * Copyright (C) 2012 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __DEBUG_IMX_UART_H
+#define __DEBUG_IMX_UART_H
+
+#define IMX1_UART1_BASE_ADDR	0x00206000
+#define IMX1_UART2_BASE_ADDR	0x00207000
+#define IMX1_UART_BASE_ADDR(n)	IMX1_UART##n##_BASE_ADDR
+#define IMX1_UART_BASE(n)	IMX1_UART_BASE_ADDR(n)
+
+#define IMX21_UART1_BASE_ADDR	0x1000a000
+#define IMX21_UART2_BASE_ADDR	0x1000b000
+#define IMX21_UART3_BASE_ADDR	0x1000c000
+#define IMX21_UART4_BASE_ADDR	0x1000d000
+#define IMX21_UART_BASE_ADDR(n)	IMX21_UART##n##_BASE_ADDR
+#define IMX21_UART_BASE(n)	IMX21_UART_BASE_ADDR(n)
+
+#define IMX25_UART1_BASE_ADDR	0x43f90000
+#define IMX25_UART2_BASE_ADDR	0x43f94000
+#define IMX25_UART3_BASE_ADDR	0x5000c000
+#define IMX25_UART4_BASE_ADDR	0x50008000
+#define IMX25_UART5_BASE_ADDR	0x5002c000
+#define IMX25_UART_BASE_ADDR(n)	IMX25_UART##n##_BASE_ADDR
+#define IMX25_UART_BASE(n)	IMX25_UART_BASE_ADDR(n)
+
+#define IMX31_UART1_BASE_ADDR	0x43f90000
+#define IMX31_UART2_BASE_ADDR	0x43f94000
+#define IMX31_UART3_BASE_ADDR	0x5000c000
+#define IMX31_UART4_BASE_ADDR	0x43fb0000
+#define IMX31_UART5_BASE_ADDR	0x43fb4000
+#define IMX31_UART_BASE_ADDR(n)	IMX31_UART##n##_BASE_ADDR
+#define IMX31_UART_BASE(n)	IMX31_UART_BASE_ADDR(n)
+
+#define IMX35_UART1_BASE_ADDR	0x43f90000
+#define IMX35_UART2_BASE_ADDR	0x43f94000
+#define IMX35_UART3_BASE_ADDR	0x5000c000
+#define IMX35_UART_BASE_ADDR(n)	IMX35_UART##n##_BASE_ADDR
+#define IMX35_UART_BASE(n)	IMX35_UART_BASE_ADDR(n)
+
+#define IMX51_UART1_BASE_ADDR	0x73fbc000
+#define IMX51_UART2_BASE_ADDR	0x73fc0000
+#define IMX51_UART3_BASE_ADDR	0x7000c000
+#define IMX51_UART_BASE_ADDR(n)	IMX51_UART##n##_BASE_ADDR
+#define IMX51_UART_BASE(n)	IMX51_UART_BASE_ADDR(n)
+
+#define IMX53_UART1_BASE_ADDR	0x53fbc000
+#define IMX53_UART2_BASE_ADDR	0x53fc0000
+#define IMX53_UART3_BASE_ADDR	0x5000c000
+#define IMX53_UART4_BASE_ADDR	0x53ff0000
+#define IMX53_UART5_BASE_ADDR	0x63f90000
+#define IMX53_UART_BASE_ADDR(n)	IMX53_UART##n##_BASE_ADDR
+#define IMX53_UART_BASE(n)	IMX53_UART_BASE_ADDR(n)
+
+#define IMX6Q_UART1_BASE_ADDR	0x02020000
+#define IMX6Q_UART2_BASE_ADDR	0x021e8000
+#define IMX6Q_UART3_BASE_ADDR	0x021ec000
+#define IMX6Q_UART4_BASE_ADDR	0x021f0000
+#define IMX6Q_UART5_BASE_ADDR	0x021f4000
+#define IMX6Q_UART_BASE_ADDR(n)	IMX6Q_UART##n##_BASE_ADDR
+#define IMX6Q_UART_BASE(n)	IMX6Q_UART_BASE_ADDR(n)
+
+#define IMX_DEBUG_UART_BASE(soc) soc##_UART_BASE(CONFIG_DEBUG_IMX_UART_PORT)
+
+#ifdef CONFIG_DEBUG_IMX1_UART
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX1)
+#elif defined(CONFIG_DEBUG_IMX21_IMX27_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX21)
+#elif defined(CONFIG_DEBUG_IMX25_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX25)
+#elif defined(CONFIG_DEBUG_IMX31_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX31)
+#elif defined(CONFIG_DEBUG_IMX35_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX35)
+#elif defined(CONFIG_DEBUG_IMX51_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX51)
+#elif defined(CONFIG_DEBUG_IMX50_IMX53_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX53)
+#elif defined(CONFIG_DEBUG_IMX6Q_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6Q)
+#endif
+
+#endif /* __DEBUG_IMX_UART_H */
diff --git a/arch/arm/include/debug/imx.S b/arch/arm/include/debug/imx.S
index 0c4e17d..619d8cc 100644
--- a/arch/arm/include/debug/imx.S
+++ b/arch/arm/include/debug/imx.S
@@ -10,35 +10,8 @@
  * published by the Free Software Foundation.
  *
  */
-#define IMX6Q_UART1_BASE_ADDR	0x02020000
-#define IMX6Q_UART2_BASE_ADDR	0x021e8000
-#define IMX6Q_UART3_BASE_ADDR	0x021ec000
-#define IMX6Q_UART4_BASE_ADDR	0x021f0000
-#define IMX6Q_UART5_BASE_ADDR	0x021f4000
 
-/*
- * IMX6Q_UART_BASE_ADDR is put in the middle to force the expansion
- * of IMX6Q_UART##n##_BASE_ADDR.
- */
-#define IMX6Q_UART_BASE_ADDR(n)	IMX6Q_UART##n##_BASE_ADDR
-#define IMX6Q_UART_BASE(n)	IMX6Q_UART_BASE_ADDR(n)
-#define IMX6Q_DEBUG_UART_BASE	IMX6Q_UART_BASE(CONFIG_DEBUG_IMX6Q_UART_PORT)
-
-#ifdef CONFIG_DEBUG_IMX1_UART
-#define UART_PADDR	0x00206000
-#elif defined (CONFIG_DEBUG_IMX25_UART)
-#define UART_PADDR	0x43f90000
-#elif defined (CONFIG_DEBUG_IMX21_IMX27_UART)
-#define UART_PADDR	0x1000a000
-#elif defined (CONFIG_DEBUG_IMX31_IMX35_UART)
-#define UART_PADDR	0x43f90000
-#elif defined (CONFIG_DEBUG_IMX51_UART)
-#define UART_PADDR	0x73fbc000
-#elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
-#define UART_PADDR	0x53fbc000
-#elif defined (CONFIG_DEBUG_IMX6Q_UART)
-#define UART_PADDR	IMX6Q_DEBUG_UART_BASE
-#endif
+#include "imx-uart.h"
 
 /*
  * FIXME: This is a copy of IMX_IO_P2V in hardware.h, and needs to
-- 
1.7.9.5
