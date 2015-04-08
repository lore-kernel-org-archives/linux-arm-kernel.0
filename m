From: harald@ccbib.org (Harald Geyer)
Date: Wed,  8 Apr 2015 17:45:00 +0000
Subject: [PATCH] ARM: dts: imx23-olinuxino: Add i2c support
Message-ID: <1428515100-1496-1-git-send-email-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx23-olinuxino board has an i2c interface exposed on UEXT connector.
This patch provides the necessary devicetree code.
Tested with MOD-LCD1x9 from Olimex.

This patch is based on work by Fadil Berisha with his permission. However
all bugs are mine.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |    6 +++++
 arch/arm/boot/dts/imx23.dtsi          |   40 ++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index 7e6eef2..85718df 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -73,6 +73,12 @@
 				status = "okay";
 			};
 
+			i2c: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c_pins_b>;
+				status = "okay";
+			};
+
 			duart: serial at 80070000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&duart_pins_a>;
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
