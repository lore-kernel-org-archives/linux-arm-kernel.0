From: stefan@agner.ch (Stefan Agner)
Date: Tue, 19 Dec 2017 19:10:37 +0100
Subject: [PATCH v3 8/9] ARM: dts: imx7-colibri: add MCP2515 CAN controller
In-Reply-To: <20171219181038.1369-1-stefan@agner.ch>
References: <20171219181038.1369-1-stefan@agner.ch>
Message-ID: <20171219181038.1369-8-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri Evaluation Carrier Board provides a MCP2515 CAN
controller connected via SPI. Note that the i.MX 7 provides
an internal CAN controller which is much better suited for CAN
operations. Using the MCP2515 with a Colibri iMX7 module is
mainly useful to test the SPI interface.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Changed label and node name for MCP2515
- Drop num-cs from ecspi3

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx7-colibri.dtsi         | 13 ++++++++++++-
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 87c23b769a08..e2b99bb48250 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -45,6 +45,13 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	/* fixed crystal dedicated to mpc258x */
+	clk16m: clk16m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+	};
+
 	panel: panel {
 		compatible = "edt,et057090dhu";
 		backlight = <&bl>;
@@ -99,6 +106,24 @@
 	status = "okay";
 };
 
+&ecspi3 {
+	status = "okay";
+
+	mcp2515: can at 0 {
+		compatible = "microchip,mcp2515";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can_int>;
+		reg = <0>;
+		clocks = <&clk16m>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&reg_3v3>;
+		xceiver-supply = <&reg_5v0>;
+		status = "okay";
+	};
+};
+
 &fec1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 689ff6822634..c28a483b786d 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -92,6 +92,12 @@
 	cpu-supply = <&reg_DCDC2>;
 };
 
+&ecspi3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3 &pinctrl_ecspi3_cs>;
+	cs-gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>;
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
@@ -313,7 +319,6 @@
 		fsl,pins = <
 			MX7D_PAD_ENET1_RGMII_RD3__GPIO7_IO3	0x74 /* SODIMM 55 */
 			MX7D_PAD_ENET1_RGMII_RD2__GPIO7_IO2	0x74 /* SODIMM 63 */
-			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
 			MX7D_PAD_SAI1_RX_SYNC__GPIO6_IO16	0x14 /* SODIMM 77 */
 			MX7D_PAD_EPDC_DATA09__GPIO2_IO9		0x14 /* SODIMM 89 */
 			MX7D_PAD_EPDC_DATA08__GPIO2_IO8		0x74 /* SODIMM 91 */
@@ -400,6 +405,12 @@
 		>;
 	};
 
+	pinctrl_can_int: can-int-grp {
+		fsl,pins = <
+			MX7D_PAD_SD1_RESET_B__GPIO5_IO2		0X14 /* SODIMM 73 */
+		>;
+	};
+
 	pinctrl_enet1: enet1grp {
 		fsl,pins = <
 			MX7D_PAD_ENET1_CRS__GPIO7_IO14			0x14
-- 
2.15.1
