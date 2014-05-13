From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 13 May 2014 22:12:14 +0800
Subject: [PATCH 1/6] ARM: imx: add low-level debug support for imx6sx
In-Reply-To: <1399990339-12677-1-git-send-email-shawn.guo@freescale.com>
References: <1399990339-12677-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1399990339-12677-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable low-level debug support for i.MX6 SoloX by adding the debug
port definitions for the SoC.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/Kconfig.debug            | 13 +++++++++++--
 arch/arm/include/debug/imx-uart.h | 11 +++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 00c6950..4dd565f 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -317,6 +317,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6SL.
 
+	config DEBUG_IMX6SX_UART
+		bool "i.MX6SX Debug UART"
+		depends on SOC_IMX6SX
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX6SX.
+
 	config DEBUG_KEYSTONE_UART0
 		bool "Kernel low-level debugging on KEYSTONE2 using UART0"
 		depends on ARCH_KEYSTONE
@@ -935,7 +942,8 @@ config DEBUG_IMX_UART_PORT
 						DEBUG_IMX51_UART || \
 						DEBUG_IMX53_UART || \
 						DEBUG_IMX6Q_UART || \
-						DEBUG_IMX6SL_UART
+						DEBUG_IMX6SL_UART || \
+						DEBUG_IMX6SX_UART
 	default 1
 	depends on ARCH_MXC
 	help
@@ -979,7 +987,8 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX51_UART || \
 				 DEBUG_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART || \
-				 DEBUG_IMX6SL_UART
+				 DEBUG_IMX6SL_UART || \
+				 DEBUG_IMX6SX_UART
 	default "debug/msm.S" if DEBUG_MSM_UART
 	default "debug/omap2plus.S" if DEBUG_OMAP2PLUS_UART
 	default "debug/sirf.S" if DEBUG_SIRFPRIMA2_UART1 || DEBUG_SIRFMARCO_UART1
diff --git a/arch/arm/include/debug/imx-uart.h b/arch/arm/include/debug/imx-uart.h
index 42b823c..032a316 100644
--- a/arch/arm/include/debug/imx-uart.h
+++ b/arch/arm/include/debug/imx-uart.h
@@ -81,6 +81,15 @@
 #define IMX6SL_UART_BASE_ADDR(n) IMX6SL_UART##n##_BASE_ADDR
 #define IMX6SL_UART_BASE(n)	IMX6SL_UART_BASE_ADDR(n)
 
+#define IMX6SX_UART1_BASE_ADDR	0x02020000
+#define IMX6SX_UART2_BASE_ADDR	0x021e8000
+#define IMX6SX_UART3_BASE_ADDR	0x021ec000
+#define IMX6SX_UART4_BASE_ADDR	0x021f0000
+#define IMX6SX_UART5_BASE_ADDR	0x021f4000
+#define IMX6SX_UART6_BASE_ADDR	0x022a0000
+#define IMX6SX_UART_BASE_ADDR(n) IMX6SX_UART##n##_BASE_ADDR
+#define IMX6SX_UART_BASE(n)	IMX6SX_UART_BASE_ADDR(n)
+
 #define IMX_DEBUG_UART_BASE(soc) soc##_UART_BASE(CONFIG_DEBUG_IMX_UART_PORT)
 
 #ifdef CONFIG_DEBUG_IMX1_UART
@@ -103,6 +112,8 @@
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6Q)
 #elif defined(CONFIG_DEBUG_IMX6SL_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SL)
+#elif defined(CONFIG_DEBUG_IMX6SX_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SX)
 #endif
 
 #endif /* __DEBUG_IMX_UART_H */
-- 
1.8.3.2
