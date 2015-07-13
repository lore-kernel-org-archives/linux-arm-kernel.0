From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 13 Jul 2015 13:03:05 -0300
Subject: [PATCH v4] ARM: dts: imx6qdl-sabreauto: Allow HDMI and LVDS to work
 simultaneously
Message-ID: <1436803385-11025-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to have HDMI and LVDS working simultaneously,
because both ports try to use PLL5.

Move the LVDS clock parent to PLL3_USB_OTG, so that HDMI and LVDS can be
driven from independent sources.

With this change the LDB pixel clock goes to 68.57 MHz, which is still
within the valid range for the HSD100PXN1 LVDS panel.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v4:
- Apply against a clean tree

 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 6b17b85..8d52481 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -93,9 +93,13 @@
 &clks {
 	assigned-clocks = <&clks IMX6QDL_PLL4_BYPASS_SRC>,
 			  <&clks IMX6QDL_PLL4_BYPASS>,
-			  <&clks IMX6QDL_CLK_PLL4_POST_DIV>;
+			  <&clks IMX6QDL_CLK_PLL4_POST_DIV>,
+			  <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_LVDS2_IN>,
-				<&clks IMX6QDL_PLL4_BYPASS_SRC>;
+				 <&clks IMX6QDL_PLL4_BYPASS_SRC>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 	assigned-clock-rates = <0>, <0>, <24576000>;
 };
 
-- 
1.9.1
