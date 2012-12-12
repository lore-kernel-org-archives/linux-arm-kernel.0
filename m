From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Dec 2012 21:45:42 +0800
Subject: [PATCH 1/4] ARM: imx: use separated debug uart symbol for imx31 and
 imx35
In-Reply-To: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
References: <1355319945-3199-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1355319945-3199-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's improper to use combined symbol DEBUG_IMX31_IMX35_UART for
imx31 and imx35, because imx31 has 5 UARTs while imx35 only has 3.
So later when we add UART port selection for DEBUG_IMX31_IMX35_UART,
we will have problem.

Use separated Kconfig options for imx31 and imx35 debug uart selection.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/Kconfig.debug |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 661030d..ae2ee04 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -205,12 +205,19 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on i.MX28.
 
-	config DEBUG_IMX31_IMX35_UART
-		bool "i.MX31 and i.MX35 Debug UART"
-		depends on SOC_IMX31 || SOC_IMX35
+	config DEBUG_IMX31_UART
+		bool "i.MX31 Debug UART"
+		depends on SOC_IMX31
 		help
 		  Say Y here if you want kernel low-level debugging support
-		  on i.MX31 or i.MX35.
+		  on i.MX31.
+
+	config DEBUG_IMX35_UART
+		bool "i.MX35 Debug UART"
+		depends on SOC_IMX35
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on i.MX35.
 
 	config DEBUG_IMX51_UART
 		bool "i.MX51 Debug UART"
@@ -495,7 +502,8 @@ config DEBUG_LL_INCLUDE
 	default "debug/imx.S" if DEBUG_IMX1_UART || \
 				 DEBUG_IMX25_UART || \
 				 DEBUG_IMX21_IMX27_UART || \
-				 DEBUG_IMX31_IMX35_UART || \
+				 DEBUG_IMX31_UART || \
+				 DEBUG_IMX35_UART || \
 				 DEBUG_IMX51_UART || \
 				 DEBUG_IMX50_IMX53_UART ||\
 				 DEBUG_IMX6Q_UART
-- 
1.7.9.5
