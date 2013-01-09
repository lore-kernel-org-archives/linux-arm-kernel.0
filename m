From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  9 Jan 2013 14:44:22 +0100
Subject: [PATCH 1/4] ARM i.MX53: Add UART2 for low-level debugging
In-Reply-To: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1357739065-9153-2-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This is needed for boards like the Garz & Fricke Vincell and
Vincell LT, that have the serial debugging console on UART2.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/Kconfig.debug       |   10 ++++++++++
 arch/arm/include/debug/imx.S |    7 ++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 661030d..8e84a24 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -450,6 +450,16 @@ choice
 
 endchoice
 
+config DEBUG_IMX50_IMX53_UART_PORT
+	int "i.MX50 and i.MX53 Debug UART Port (1-2)" if DEBUG_IMX50_IMX53_UART
+	range 1 2
+	default 1
+	depends on SOC_IMX50 || SOC_IMX53
+	help
+          Choose UART port on which kernel low-level debug messages
+          should be output. The default choice (UART1) is correct for
+	  e.g. the Freescale i.MX53 Quick Start Board.
+
 config DEBUG_IMX6Q_UART_PORT
 	int "i.MX6Q Debug UART Port (1-5)" if DEBUG_IMX6Q_UART
 	range 1 5
diff --git a/arch/arm/include/debug/imx.S b/arch/arm/include/debug/imx.S
index 0c4e17d..4069ea0 100644
--- a/arch/arm/include/debug/imx.S
+++ b/arch/arm/include/debug/imx.S
@@ -10,12 +10,17 @@
  * published by the Free Software Foundation.
  *
  */
+#define IMX50_IMX53_UART1_BASE_ADDR	0x53fbc000
+#define IMX50_IMX53_UART2_BASE_ADDR	0x53fc0000
 #define IMX6Q_UART1_BASE_ADDR	0x02020000
 #define IMX6Q_UART2_BASE_ADDR	0x021e8000
 #define IMX6Q_UART3_BASE_ADDR	0x021ec000
 #define IMX6Q_UART4_BASE_ADDR	0x021f0000
 #define IMX6Q_UART5_BASE_ADDR	0x021f4000
 
+#define IMX50_IMX53_UART_BASE_ADDR(n)	IMX50_IMX53_UART##n##_BASE_ADDR
+#define IMX50_IMX53_UART_BASE(n)	IMX50_IMX53_UART_BASE_ADDR(n)
+#define IMX50_IMX53_DEBUG_UART_BASE	IMX50_IMX53_UART_BASE(CONFIG_DEBUG_IMX50_IMX53_UART_PORT)
 /*
  * IMX6Q_UART_BASE_ADDR is put in the middle to force the expansion
  * of IMX6Q_UART##n##_BASE_ADDR.
@@ -35,7 +40,7 @@
 #elif defined (CONFIG_DEBUG_IMX51_UART)
 #define UART_PADDR	0x73fbc000
 #elif defined (CONFIG_DEBUG_IMX50_IMX53_UART)
-#define UART_PADDR	0x53fbc000
+#define UART_PADDR	IMX50_IMX53_DEBUG_UART_BASE
 #elif defined (CONFIG_DEBUG_IMX6Q_UART)
 #define UART_PADDR	IMX6Q_DEBUG_UART_BASE
 #endif
-- 
1.7.10.4
