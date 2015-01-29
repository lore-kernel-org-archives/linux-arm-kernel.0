From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Thu, 29 Jan 2015 21:57:45 +0530
Subject: [PATCH V2] ARM: vf-colibri: add SPI support and enable MCP2515 CAN
Message-ID: <1422548865-23039-1-git-send-email-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MCP2515 CAN controller is available on Colibri Evaluation board.
Hence enable MCP2515 CAN.

Acked-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 31 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf-colibri.dtsi         | 15 +++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
index 36cafbf..606753e 100644
--- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
@@ -12,6 +12,12 @@
 		bootargs = "console=ttyLP0,115200";
 	};
 
+	clk16m: clk16m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <16000000>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -47,6 +53,21 @@
 	status  = "okay";
 };
 
+&dspi1 {
+	status = "okay";
+
+	mcp2515can: can at 0 {
+		compatible = "microchip,mcp2515";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_can_int>;
+		reg = <0>;
+		clocks = <&clk16m>;
+		spi-max-frequency = <10000000>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <11 GPIO_ACTIVE_LOW>;
+	};
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
@@ -94,3 +115,13 @@
 &usbh1 {
 	vbus-supply = <&usbh_vbus_reg>;
 };
+
+&iomuxc {
+	vf610-colibri {
+		pinctrl_can_int: can_int {
+			fsl,pins = <
+				VF610_PAD_PTB21__GPIO_43	0x22ed
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index 5c2b732..fbef082 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -23,6 +23,12 @@
 	status = "okay";
 };
 
+&dspi1 {
+	bus-num = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_dspi1>;
+};
+
 &edma0 {
 	status = "okay";
 };
@@ -107,6 +113,15 @@
 			>;
 		};
 
+		pinctrl_dspi1: dspi1grp {
+			fsl,pins = <
+				VF610_PAD_PTD5__DSPI1_CS0		0x33e2
+				VF610_PAD_PTD6__DSPI1_SIN		0x33e1
+				VF610_PAD_PTD7__DSPI1_SOUT		0x33e2
+				VF610_PAD_PTD8__DSPI1_SCK		0x33e2
+			>;
+		};
+
 		pinctrl_esdhc1: esdhc1grp {
 			fsl,pins = <
 				VF610_PAD_PTA24__ESDHC1_CLK	0x31ef
-- 
2.2.2
