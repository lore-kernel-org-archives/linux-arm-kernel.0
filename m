From: harald@ccbib.org (Harald Geyer)
Date: Fri, 17 Apr 2015 14:43:24 +0000
Subject: [PATCHv2 1/2] ARM: dts: imx23: Add i2c support
Message-ID: <1429281806-7934-1-git-send-email-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx23-olinuxino board has an i2c interface exposed on UEXT connector.
This patch provides the generic devicetree infrastructure for a follow-up
patch to add support to the actual board files.
Tested all three possible pin groups with MOD-LCD1x9 from Olimex.

This patch is based on work by Fadil Berisha with his permission. However
all bugs are mine.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
changes since v1:
split in generic and board specific patches
 arch/arm/boot/dts/imx23.dtsi |   40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index bbcfb5a..c892d58 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -308,6 +308,39 @@
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
 					fsl,pull-up = <MXS_PULL_ENABLE>;
 				};
+
+				i2c_pins_a: i2c at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX23_PAD_I2C_SCL__I2C_SCL
+						MX23_PAD_I2C_SDA__I2C_SDA
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
+				i2c_pins_b: i2c at 1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX23_PAD_LCD_ENABLE__I2C_SCL
+						MX23_PAD_LCD_HSYNC__I2C_SDA
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
+
+				i2c_pins_c: i2c at 2 {
+					reg = <2>;
+					fsl,pinmux-ids = <
+						MX23_PAD_SSP1_DATA1__I2C_SCL
+						MX23_PAD_SSP1_DATA2__I2C_SDA
+					>;
+					fsl,drive-strength = <MXS_DRIVE_8mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_ENABLE>;
+				};
 			};
 
 			digctl at 8001c000 {
@@ -444,8 +477,13 @@
 				status = "disabled";
 			};
 
-			i2c at 80058000 {
+			i2c: i2c at 80058000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx23-i2c";
 				reg = <0x80058000 0x2000>;
+				interrupts = <27>;
+				clock-frequency = <100000>;
 				dmas = <&dma_apbx 3>;
 				dma-names = "rx-tx";
 				status = "disabled";
-- 
1.7.10.4
