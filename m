From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 25 Jun 2015 11:17:09 -0300
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to work
 simultaneously
Message-ID: <1435241830-20187-1-git-send-email-fabio.estevam@freescale.com>
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
Changes since v1:
- Move the clock assignment inside &clks as suggested by Philipp

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a626e6d..cca847e 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -141,6 +141,13 @@
 	status = "okay";
 };
 
+&clks {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+};
+
 &ecspi1 {
 	fsl,spi-num-chipselects = <1>;
 	cs-gpios = <&gpio4 9 0>;
-- 
1.9.1
