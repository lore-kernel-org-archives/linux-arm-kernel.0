From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 10 May 2014 12:47:35 -0300
Subject: [PATCH v5 1/2] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Add CAN
 support
Message-ID: <1399736856-9489-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add support for CAN based on a MCP2515 connected to ECSPI1.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v4:
- Fix the SPI clock to 10MHz
- Use CAN_RST as the regulator name
Changes since v3:
- Provide a fixed-clock for CAN
- Separate escpi from CAN control pin groups
- Use vdd-supply for mcp2515
- Fix typo on commit log

Changes since v2:
- None
Changes since v1:
- Use active low for spi chipselect
- Remove unused GPIOs for CAN
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 8b1098e..75e66c9 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -24,6 +24,14 @@
 	model = "Eukrea CPUIMX51";
 	compatible = "eukrea,mbimxsd51","eukrea,cpuimx51", "fsl,imx51";
 
+	clocks {
+		clk24M: can_clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+		};
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -50,6 +58,23 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_can: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "CAN_RST";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio4 15 GPIO_ACTIVE_HIGH>;
+			startup-delay-us = <20000>;
+			enable-active-high;
+		};
+	};
+
 	sound {
 		compatible = "eukrea,asoc-tlv320";
 		eukrea,model = "imx51-eukrea-tlv320aic23";
@@ -86,6 +111,26 @@
 	status = "okay";
 };
 
+&ecspi1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi1>;
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+	status = "okay";
+
+	can0: can at 0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can>;
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		clocks = <&clk24M>;
+		spi-max-frequency = <10000000>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		vdd-supply = <&reg_can>;
+	};
+};
+
 &i2c1 {
 	tlv320aic23: codec at 1a {
 		compatible = "ti,tlv320aic23";
@@ -104,6 +149,23 @@
 			>;
 		};
 
+
+		pinctrl_can: cangrp {
+			fsl,pins = <
+				MX51_PAD_CSI2_PIXCLK__GPIO4_15		0x80000000	/* nReset */
+				MX51_PAD_GPIO1_1__GPIO1_1		0x80000000	/* IRQ */
+			>;
+		};
+
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <
+				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
+				MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
+				MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
+				MX51_PAD_CSPI1_SS0__GPIO4_24		0x80000000 	/* CS0 */
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
-- 
1.8.3.2
