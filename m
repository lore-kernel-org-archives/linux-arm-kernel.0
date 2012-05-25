From: b32955@freescale.com (Huang Shijie)
Date: Fri, 25 May 2012 17:25:35 +0800
Subject: [PATCH 1/2] ARM: mx28: add gpmi-nand support
Message-ID: <1337937936-2743-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add gpmi-nand device tree support.
add gpmi-nand pinctrl support.

Also enable the gpmi support for mx28-evk board.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---

add pinctrl for gpmi-nand.

---
 arch/arm/boot/dts/imx28-evk.dts |    6 ++++++
 arch/arm/boot/dts/imx28.dtsi    |   35 ++++++++++++++++++++++++++---------
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ee520a5..e53cf67 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -22,6 +22,12 @@
 
 	apb at 80000000 {
 		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				status = "okay";
+			};
+
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx28-mmc";
 				pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..2636339 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -68,15 +68,15 @@
 				status = "disabled";
 			};
 
-			bch at 8000a000 {
-				reg = <0x8000a000 2000>;
-				interrupts = <41>;
-				status = "disabled";
-			};
-
-			gpmi at 8000c000 {
-				reg = <0x8000c000 2000>;
-				interrupts = <42 88>;
+			gpmi-nand at 8000c000 {
+				compatible = "fsl,imx28-gpmi-nand";
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg-names = "gpmi-nand", "bch";
+				interrupts = <88>, <41>;
+				interrupt-names = "gpmi-dma", "bch";
+				fsl,gpmi-dma-channel = <4>;
 				status = "disabled";
 			};
 
@@ -167,6 +167,23 @@
 					fsl,pull-up = <0>;
 				};
 
+				gpmi_pins_a: gpmi-nand at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x0000 0x0010 0x0020
+						0x0030 0x0040 0x0050 0x0060
+						0x0070 0x0100 0x0110 0x0140
+						0x0150 0x0180 0x0190 0x01a0
+						0x01b0 0x01c0 >;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				gpmi_status_cfg: gpmi-status-cfg {
+					fsl,pinmux-ids = <0x0180 0x0190 0x01c0>;
+					fsl,drive-strength = <2>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x4000 0x4010 0x4020
-- 
1.7.0.4
