From: b32955@freescale.com (Huang Shijie)
Date: Tue, 3 Jul 2012 12:58:13 +0800
Subject: [PATCH] ARM: dts: mx23: add gpmi nand support
Message-ID: <1341291493-30707-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT node for gpmi nand.
Also add pinctrl for gpmi nand.

Enable the gpmi-nand in mx23-evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/boot/dts/imx23-evk.dts |    6 ++++
 arch/arm/boot/dts/imx23.dtsi    |   49 ++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 9d674ca..e3486f4 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -22,6 +22,12 @@
 
 	apb at 80000000 {
 		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_pins_fixup>;
+				status = "okay";
+			};
+
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx23-mmc";
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 7662134..a874dbf 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -59,13 +59,15 @@
 				status = "disabled";
 			};
 
-			bch at 8000a000 {
-				reg = <0x8000a000 2000>;
-				status = "disabled";
-			};
-
 			gpmi-nand at 8000c000 {
-				reg = <0x8000c000 2000>;
+				compatible = "fsl,imx23-gpmi-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg-names = "gpmi-nand", "bch";
+				interrupts = <13>, <56>;
+				interrupt-names = "gpmi-dma", "bch";
+				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -138,6 +140,41 @@
 					fsl,pull-up = <0>;
 				};
 
+				gpmi_pins_a: gpmi-nand at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0000 /* MX23_PAD_GPMI_D00__GPMI_D00 */
+						0x0010 /* MX23_PAD_GPMI_D01__GPMI_D01 */
+						0x0020 /* MX23_PAD_GPMI_D02__GPMI_D02 */
+						0x0030 /* MX23_PAD_GPMI_D03__GPMI_D03 */
+						0x0040 /* MX23_PAD_GPMI_D04__GPMI_D04 */
+						0x0050 /* MX23_PAD_GPMI_D05__GPMI_D05 */
+						0x0060 /* MX23_PAD_GPMI_D06__GPMI_D06 */
+						0x0070 /* MX23_PAD_GPMI_D07__GPMI_D07 */
+						0x0100 /* MX23_PAD_GPMI_CLE__GPMI_CLE */
+						0x0110 /* MX23_PAD_GPMI_ALE__GPMI_ALE */
+						0x0130 /* MX23_PAD_GPMI_RDY0__GPMI_RDY0 */
+						0x0140 /* MX23_PAD_GPMI_RDY1__GPMI_RDY1 */
+						0x0170 /* MX23_PAD_GPMI_WPN__GPMI_WPN */
+						0x0180 /* MX23_PAD_GPMI_WRN__GPMI_WRN */
+						0x0190 /* MX23_PAD_GPMI_RDN__GPMI_RDN */
+						0x21b0 /* MX23_PAD_GPMI_CE1N__GPMI_CE1N */
+						0x21c0 /* MX23_PAD_GPMI_CE0N__GPMI_CE0N	*/
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				gpmi_pins_fixup: gpmi-pins-fixup {
+					fsl,pinmux-ids = <
+						0x0170 /* MX23_PAD_GPMI_WPN__GPMI_WPN */
+						0x0180 /* MX23_PAD_GPMI_WRN__GPMI_WRN */
+						0x0190 /* MX23_PAD_GPMI_RDN__GPMI_RDN */
+					>;
+					fsl,drive-strength = <2>;
+				};
+
 				mmc0_4bit_pins_a: mmc0-4bit at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.0.4
