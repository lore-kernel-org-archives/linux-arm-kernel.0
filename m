From: mail@maciej.szmigiero.name (Maciej S. Szmigiero)
Date: Sat, 16 Apr 2016 00:27:23 +0200
Subject: [PATCH v2] ARM: dts: imx6qdl-udoo: add 7 inch LCD touchscreen panel
 support
Message-ID: <57116ACB.8030309@maciej.szmigiero.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The official UDOO board kit has 7 and 15.6 inch touchscreen LCD panels
as options.

This patch adds support for 7 inch panel only, but the 15.6 inch one
should be easy to add using the same regulator, backlight device and
LVDS channel.

Since this panel is an option for UDOO board it is disabled by default
and can be enabled (for example) by the following U-Boot commands:
fdt set backlight status okay
fdt set panelchan status okay
fdt set panel7 status okay
fdt set touchscreenp7 status okay

The LVDS channels is also disabled by default to avoid warning from its
driver.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
Changes from v1: make "compatible" property the first one where it exists,
order new labels and pinctrl entries alphabetically.

 arch/arm/boot/dts/imx6qdl-udoo.dtsi | 96 +++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
index d3e54e40a017..0dd5aa1b45e0 100644
--- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
@@ -10,14 +10,49 @@
  */
 
 / {
+	aliases {
+		backlight = &backlight;
+		panelchan = &panelchan;
+		panel7 = &panel7;
+		touchscreenp7 = &touchscreenp7;
+	};
+
 	chosen {
 		stdout-path = &uart2;
 	};
 
+	backlight: backlight {
+		compatible = "gpio-backlight";
+		gpios = <&gpio1 4 0>;
+		default-on;
+		status = "disabled";
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
 
+	panel7: panel7 {
+		/*
+		 * in reality it is a -20t (parallel) model,
+		 * but with LVDS bridge chip attached,
+		 * so it is equivalent to -19t model in drive
+		 * characteristics
+		 */
+		compatible = "urt,umsh-8596md-19t";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_panel>;
+		power-supply = <&reg_panel>;
+		backlight = <&backlight>;
+		status = "disabled";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -33,6 +68,14 @@
 			startup-delay-us = <2>; /* USB2415 requires a POR of 1 us minimum */
 			gpio = <&gpio7 12 0>;
 		};
+
+		reg_panel: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "lcd_panel";
+			enable-active-high;
+			gpio = <&gpio1 2 0>;
+		};
 	};
 
 	sound {
@@ -67,6 +110,24 @@
 	status = "okay";
 };
 
+&i2c3 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	touchscreenp7: touchscreenp7 at 55 {
+		compatible = "sitronix,st1232";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touchscreenp7>;
+		reg = <0x55>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <13 8>;
+		gpios = <&gpio1 15 0>;
+		status = "disabled";
+	};
+};
+
 &iomuxc {
 	imx6q-udoo {
 		pinctrl_enet: enetgrp {
@@ -97,6 +158,27 @@
 			>;
 		};
 
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_5__I2C3_SCL		0x4001f8b1
+				MX6QDL_PAD_GPIO_6__I2C3_SDA		0x4001f8b1
+			>;
+		};
+
+		pinctrl_panel: panelgrp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x70
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04		0x70
+			>;
+		};
+
+		pinctrl_touchscreenp7: touchscreenp7grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_DAT0__GPIO1_IO15		0x70
+				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13		0x1b0b0
+			>;
+		};
+
 		pinctrl_uart2: uart2grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D26__UART2_TX_DATA	0x1b0b1
@@ -154,6 +236,20 @@
 	};
 };
 
+&ldb {
+	status = "okay";
+
+	panelchan: lvds-channel at 0 {
+		port@4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
