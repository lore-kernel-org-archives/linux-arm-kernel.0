From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  4 Jun 2018 21:56:49 -0300
Subject: [PATCH] ARM: dts: imx53-qsb: Let the codec control MCLK pinctrl
Message-ID: <1528160209-2849-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

sgtl5000 codec needs MCLK clock to be present so that it can
successfully read/write via I2C.

In the case of imx53-qsb, MCLK is provided via
MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK pad. 

Move the MCLK pinctrl from hog group to the codec group, so that the
codec clock can be present prior to reading the codec ID.

This avoids the following sgtl5000 probe error:

sgtl5000 1-000a: Error reading chip id -6

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx53-qsb-common.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index ef7658a..7423d46 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -153,7 +153,6 @@
 	imx53-qsb {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK 0x80000000
 				MX53_PAD_GPIO_8__GPIO1_8          0x80000000
 				MX53_PAD_PATA_DATA14__GPIO2_14    0x80000000
 				MX53_PAD_PATA_DATA15__GPIO2_15    0x80000000
@@ -180,6 +179,12 @@
 			>;
 		};
 
+		pinctrl_codec: codecgrp {
+			fsl,pins = <
+				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK	0x1c4
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				MX53_PAD_SD1_DATA0__ESDHC1_DAT0		0x1d5
@@ -310,6 +315,8 @@
 	sgtl5000: codec@a {
 		compatible = "fsl,sgtl5000";
 		reg = <0x0a>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_codec>;
 		#sound-dai-cells = <0>;
 		VDDA-supply = <&reg_3p2v>;
 		VDDIO-supply = <&reg_3p2v>;
-- 
2.7.4
