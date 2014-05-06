From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 6 May 2014 16:21:03 -0300
Subject: [PATCH v3 1/2] ARM: dts: imx51-eukrea-mbimxsd51-baseboard: Add CAN
 support
Message-ID: <1399404064-29128-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for CAN based on a MPC2515 connected to ECSPI1.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- None
Changes since v1:
- Use active low for spi chipselect
- Remove unused GPIOs for CAN

 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
index 8b1098e..c8ad934 100644
--- a/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
+++ b/arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts
@@ -86,6 +86,23 @@
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
+		compatible = "microchip,mcp2515";
+		reg = <0>;
+		clocks = <&clks IMX5_CLK_OSC>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &i2c1 {
 	tlv320aic23: codec at 1a {
 		compatible = "ti,tlv320aic23";
@@ -104,6 +121,17 @@
 			>;
 		};
 
+		pinctrl_ecspi1: ecspi1grp {
+			fsl,pins = <
+				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
+				MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
+				MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
+				MX51_PAD_CSPI1_SS0__GPIO4_24		0x80000000 	/* CS0 */
+				MX51_PAD_CSI2_PIXCLK__GPIO4_15		0x80000000	/* nReset */
+				MX51_PAD_GPIO1_1__GPIO1_1		0x80000000	/* IRQ */
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
-- 
1.8.3.2
