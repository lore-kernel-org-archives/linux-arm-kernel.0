From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  9 Jan 2013 14:44:24 +0100
Subject: [PATCH 3/4] ARM i.MX53: add dts for the TQ tqma53 module
In-Reply-To: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1357739065-9153-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The tqma53 is an embedded module that has some features on board (e.g. emmc),
but mostly just provides access to them on its interface.
Going along with the imx53.dtsi, the tqma53.dtsi specifies the existing
devices and their pinctrl for this module. All devices that are not on the
module are disabled by default and need to be enabled in a baseboard DT.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/imx53-tqma53.dtsi |  176 +++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-tqma53.dtsi

diff --git a/arch/arm/boot/dts/imx53-tqma53.dtsi b/arch/arm/boot/dts/imx53-tqma53.dtsi
new file mode 100644
index 0000000..012a52f
--- /dev/null
+++ b/arch/arm/boot/dts/imx53-tqma53.dtsi
@@ -0,0 +1,176 @@
+/*
+ * Copyright 2012 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
+ * Copyright 2012 Steffen Trumtrar <s.trumtrar@pengutronix.de>, Pengutronix
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/include/ "imx53.dtsi"
+
+/ {
+	model = "TQ TQMa53";
+	compatible = "tq,tqma53", "fsl,imx53";
+
+	memory {
+		reg = <0x70000000 0x40000000>; /* Up to 1GiB */
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+};
+
+&esdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc2_1>;
+	wp-gpios = <&gpio1 2 0>;
+	cd-gpios = <&gpio1 4 0>;
+	status = "disabled";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3_2>;
+	status = "disabled";
+};
+
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1_1>;
+	fsl,spi-num-chipselects = <4>;
+	cs-gpios = <&gpio2 30 0>, <&gpio3 19 0>,
+		   <&gpio3 24 0>, <&gpio3 25 0>;
+	status = "disabled";
+};
+
+&esdhc3 { /* EMMC */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc3_1>;
+	vmmc-supply = <&reg_3p3v>;
+	non-removable;
+	bus-width = <8>;
+	status = "okay";
+};
+
+&wdog1 {
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	i2s {
+		pinctrl_i2s_1: i2s-grp1 {
+			fsl,pins = <
+				 1   0x10000	/* I2S_MCLK */
+				 10  0x10000	/* I2S_SCLK */
+				 17  0x10000	/* I2S_DOUT */
+				 23  0x10000	/* I2S_LRCLK*/
+				 30  0x10000	/* I2S_DIN  */
+			>;
+		};
+	};
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				 610  0x10000	/* MX53_PAD_EIM_CS1__IPU_DI1_PIN6 (VSYNC)*/
+				 711  0x10000	/* MX53_PAD_EIM_DA15__IPU_DI1_PIN4 (HSYNC)*/
+				 873  0x10000	/* MX53_PAD_PATA_DA_1__GPIO7_7 (LCD_BLT_EN)*/
+				 878  0x10000	/* MX53_PAD_PATA_DA_2__GPIO7_8 (LCD_RESET)*/
+				 922  0x10000	/* MX53_PAD_PATA_DATA5__GPIO2_5 (LCD_POWER)*/
+				 928  0x10000	/* MX53_PAD_PATA_DATA6__GPIO2_6 (PMIC_INT)*/
+				 982  0x10000	/* MX53_PAD_PATA_DATA14__GPIO2_14 (CSI_RST)*/
+				 989  0x10000	/* MX53_PAD_PATA_DATA15__GPIO2_15 (CSI_PWDN)*/
+				 1069 0x10000	/* MX53_PAD_GPIO_0__GPIO1_0 (SYSTEM_DOWN)*/
+				 1093 0x10000	/* MX53_PAD_GPIO_3__GPIO1_3 */
+			>;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_2>;
+	fsl,uart-has-rtscts;
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2_1>;
+	status = "disabled";
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can1_2>;
+	status = "disabled";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_can2_1>;
+	status = "disabled";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3_1>;
+	status = "disabled";
+};
+
+&cspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cspi_1>;
+	fsl,spi-num-chipselects = <3>;
+	cs-gpios = <&gpio1 18 0>, <&gpio1 19 0>,
+		   <&gpio1 21 0>;
+	status = "disabled";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_1>;
+	status = "okay";
+
+	pmic: mc34708 at 8 {
+		compatible = "fsl,mc34708";
+		reg = <0x8>;
+		fsl,mc13xxx-uses-rtc;
+		interrupt-parent = <&gpio2>;
+		interrupts = <6 8>; /* PDATA_DATA6, low active */
+	};
+
+	sensor1: lm75 at 48 {
+		compatible = "lm75";
+		reg = <0x48>;
+	};
+
+	eeprom: 24c64 at 50 {
+		compatible = "at,24c64";
+		pagesize = <32>;
+		reg = <0x50>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+	phy-mode = "rmii";
+	status = "disabled";
+};
-- 
1.7.10.4
