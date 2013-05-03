From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 3 May 2013 11:49:52 +0800
Subject: [PATCH 2/5] ARM: imx: enable low-level debug support for imx6sl
In-Reply-To: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
References: <1367552995-31777-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1367552995-31777-3-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable low-level debug support for i.MX6 SoloLite by adding the debug
port definitions for the SoC.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug            |   13 +++++++++++--
 arch/arm/include/debug/imx-uart.h |   10 ++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 24aeef7..b025103 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -240,6 +240,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX6Q/DL.
 
+	config DEBUG_IMX6SL_UART
+		bool "i.MX6SL Debug UART"
+		depends on SOC_IMX6SL
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX6SL.
+
 	config DEBUG_MMP_UART2
 		bool "Kernel low-level debugging message via MMP UART2"
 		depends on ARCH_MMP
@@ -493,7 +500,8 @@ config DEBUG_IMX_UART_PORT
 						DEBUG_IMX35_UART || \
 						DEBUG_IMX51_UART || \
 						DEBUG_IMX53_UART || \
-						DEBUG_IMX6Q_UART
+						DEBUG_IMX6Q_UART || \
+						DEBUG_IMX6SL_UART
 	default 1
 	depends on ARCH_MXC
 	help
@@ -588,7 +596,8 @@ config DEBUG_LL_INCLUDE
 				 DEBUG_IMX35_UART || \
 				 DEBUG_IMX51_UART || \
 				 DEBUG_IMX53_UART ||\
-				 DEBUG_IMX6Q_UART
+				 DEBUG_IMX6Q_UART || \
+				 DEBUG_IMX6SL_UART
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
 	default "debug/mxs.S" if DEBUG_IMX23_UART || DEBUG_IMX28_UART
diff --git a/arch/arm/include/debug/imx-uart.h b/arch/arm/include/debug/imx-uart.h
index 91d38e3..29da84e 100644
--- a/arch/arm/include/debug/imx-uart.h
+++ b/arch/arm/include/debug/imx-uart.h
@@ -65,6 +65,14 @@
 #define IMX6Q_UART_BASE_ADDR(n)	IMX6Q_UART##n##_BASE_ADDR
 #define IMX6Q_UART_BASE(n)	IMX6Q_UART_BASE_ADDR(n)
 
+#define IMX6SL_UART1_BASE_ADDR	0x02020000
+#define IMX6SL_UART2_BASE_ADDR	0x02024000
+#define IMX6SL_UART3_BASE_ADDR	0x02034000
+#define IMX6SL_UART4_BASE_ADDR	0x02038000
+#define IMX6SL_UART5_BASE_ADDR	0x02018000
+#define IMX6SL_UART_BASE_ADDR(n) IMX6SL_UART##n##_BASE_ADDR
+#define IMX6SL_UART_BASE(n)	IMX6SL_UART_BASE_ADDR(n)
+
 #define IMX_DEBUG_UART_BASE(soc) soc##_UART_BASE(CONFIG_DEBUG_IMX_UART_PORT)
 
 #ifdef CONFIG_DEBUG_IMX1_UART
@@ -83,6 +91,8 @@
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX53)
 #elif defined(CONFIG_DEBUG_IMX6Q_UART)
 #define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6Q)
+#elif defined(CONFIG_DEBUG_IMX6SL_UART)
+#define UART_PADDR	IMX_DEBUG_UART_BASE(IMX6SL)
 #endif
 
 #endif /* __DEBUG_IMX_UART_H */
-- 
1.7.9.5
