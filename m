From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 26 Jun 2018 21:34:22 -0300
Subject: [PATCH v2] ARM: dts: imx53-qsb: Let the codec control MCLK pinctrl
Message-ID: <1530059662-20589-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The hog pinctrl hog is meant for pins that do not have an
associated driver.

The MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK pin is the one that
provides the MCLK signal to the SGTL5000 codec, so a
better represenation is to move it under the codec node.

While at it, change the pinctrl value from 0x80000000 to the
POR reset value of register IOMUXC_SW_PAD_CTL_PAD_GPIO_0.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Change since v1:
- Since the root cause of the pinctrl failure has been
fixed by commit bc3322bc166a ("pinctrl: devicetree: Fix pctldev pointer
overwrite") in 4.18-rc2 changed the commit log to inform that this is
a cleanup rather than a bug fix.

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
