From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Nov 2012 15:33:35 +0100
Subject: [PATCHv2] ARM: dts: cfa10049: Add PCA9555 GPIO expander to the device
 tree
In-Reply-To: <20121120144322.GE4882@S2100-06.ap.freescale.net>
References: <20121120144322.GE4882@S2100-06.ap.freescale.net>
Message-ID: <1353422015-4790-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GPIO expander found on the i2c1 bus, behind the muxer to the
device tree.

This gpio expander will be used to get tachymeters values and data ready
interruptions from the nuvoton NAU7802 ADCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index bdc80a4..7890acc 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -23,7 +23,8 @@
 		apbh at 80000000 {
 			pinctrl at 80018000 {
 				pinctrl-names = "default", "default";
-				pinctrl-1 = <&hog_pins_cfa10049>;
+				pinctrl-1 = <&hog_pins_cfa10049
+					&hog_pins_cfa10049_pullup>;
 
 				hog_pins_cfa10049: hog-10049 at 0 {
 					reg = <0>;
@@ -38,6 +39,16 @@
 					fsl,pull-up = <0>;
 				};
 
+				hog_pins_cfa10049_pullup: hog-10049-pullup at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2133 /* MX28_PAD_SSP2_D3__GPIO_2_19 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				spi3_pins_cfa10049: spi3-cfa10049 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -113,6 +124,19 @@
 
 				i2c@3 {
 					reg = <3>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					pca9555: pca9555 at 20 {
+						compatible = "nxp,pca9555";
+						interrupt-parent = <&gpio2>;
+						interrupts = <19 0x2>;
+						gpio-controller;
+						#gpio-cells = <2>;
+						interrupt-controller;
+						#interrupt-cells = <2>;
+						reg = <0x20>;
+					};
 				};
 			};
 
-- 
1.7.9.5
