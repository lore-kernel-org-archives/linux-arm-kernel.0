From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 12 Jun 2017 11:23:59 -0700
Subject: [PATCH 06/11] ARM: dts: imx6-sabrelite: add OV5642 and OV5640 camera
 sensors
In-Reply-To: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
References: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1497291844-14632-7-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds the OV5642 parallel-bus sensor, and the OV5640 MIPI CSI-2 sensor.
Both hang off the same i2c2 bus, so they require different (and non-
default) i2c slave addresses.

The OV5642 connects to the parallel-bus mux input port on ipu1_csi0_mux.

The OV5640 connects to the input port on the MIPI CSI-2 receiver on
mipi_csi.

The OV5642 node is disabled temporarily while the subdev driver is
cleaned up and submitted later.

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6dl-sabrelite.dts   |   5 ++
 arch/arm/boot/dts/imx6q-sabrelite.dts    |   5 ++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 148 +++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-sabrelite.dts b/arch/arm/boot/dts/imx6dl-sabrelite.dts
index 2f90452..3304076 100644
--- a/arch/arm/boot/dts/imx6dl-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6dl-sabrelite.dts
@@ -48,3 +48,8 @@
 	model = "Freescale i.MX6 DualLite SABRE Lite Board";
 	compatible = "fsl,imx6dl-sabrelite", "fsl,imx6dl";
 };
+
+&ipu1_csi1_from_ipu1_csi1_mux {
+	clock-lanes = <0>;
+	data-lanes = <1 2>;
+};
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index 02a7cdf..dc51262e 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -52,3 +52,8 @@
 &sata {
 	status = "okay";
 };
+
+&ipu1_csi1_from_mipi_vc1 {
+	clock-lanes = <0>;
+	data-lanes = <1 2>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 89dce27..afe7449 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -39,6 +39,8 @@
  *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
+
+#include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 
@@ -94,6 +96,42 @@
 			pinctrl-0 = <&pinctrl_can_xcvr>;
 			gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
 		};
+
+		reg_1p5v: regulator at 4 {
+			compatible = "regulator-fixed";
+			reg = <4>;
+			regulator-name = "1P5V";
+			regulator-min-microvolt = <1500000>;
+			regulator-max-microvolt = <1500000>;
+			regulator-always-on;
+		};
+
+		reg_1p8v: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "1P8V";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		reg_2p8v: regulator at 6 {
+			compatible = "regulator-fixed";
+			reg = <6>;
+			regulator-name = "2P8V";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-always-on;
+		};
+	};
+
+	mipi_xclk: mipi_xclk {
+		compatible = "pwm-clock";
+		#clock-cells = <0>;
+		clock-frequency = <22000000>;
+		clock-output-names = "mipi_pwm3";
+		pwms = <&pwm3 0 45>; /* 1 / 45 ns = 22 MHz */
+		status = "okay";
 	};
 
 	gpio-keys {
@@ -220,6 +258,22 @@
 	};
 };
 
+&ipu1_csi0_from_ipu1_csi0_mux {
+	bus-width = <8>;
+	data-shift = <12>; /* Lines 19:12 used */
+	hsync-active = <1>;
+	vync-active = <1>;
+};
+
+&ipu1_csi0_mux_from_parallel_sensor {
+	remote-endpoint = <&ov5642_to_ipu1_csi0_mux>;
+};
+
+&ipu1_csi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ipu1_csi0>;
+};
+
 &audmux {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
@@ -298,6 +352,53 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c2>;
 	status = "okay";
+
+	ov5640: camera at 40 {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+		reg = <0x40>;
+		clocks = <&mipi_xclk>;
+		clock-names = "xclk";
+		DOVDD-supply = <&reg_1p8v>;
+		AVDD-supply = <&reg_2p8v>;
+		DVDD-supply = <&reg_1p5v>;
+		reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>; /* NANDF_D5 */
+		powerdown-gpios = <&gpio6 9 GPIO_ACTIVE_HIGH>; /* NANDF_WP_B */
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ov5640_to_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi2_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+
+	ov5642: camera at 42 {
+		compatible = "ovti,ov5642";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5642>;
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
+		clock-names = "xclk";
+		reg = <0x42>;
+		reset-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		powerdown-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
+		gp-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+
+		port {
+			ov5642_to_ipu1_csi0_mux: endpoint {
+				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+				bus-width = <8>;
+				hsync-active = <1>;
+				vsync-active = <1>;
+			};
+		};
+	};
 };
 
 &i2c3 {
@@ -411,6 +512,23 @@
 			>;
 		};
 
+		pinctrl_ipu1_csi0: ipu1csi0grp {
+			fsl,pins = <
+				MX6QDL_PAD_CSI0_DAT12__IPU1_CSI0_DATA12    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT13__IPU1_CSI0_DATA13    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT14__IPU1_CSI0_DATA14    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT15__IPU1_CSI0_DATA15    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT16__IPU1_CSI0_DATA16    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT17__IPU1_CSI0_DATA17    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT18__IPU1_CSI0_DATA18    0x1b0b0
+				MX6QDL_PAD_CSI0_DAT19__IPU1_CSI0_DATA19    0x1b0b0
+				MX6QDL_PAD_CSI0_PIXCLK__IPU1_CSI0_PIXCLK   0x1b0b0
+				MX6QDL_PAD_CSI0_MCLK__IPU1_CSI0_HSYNC      0x1b0b0
+				MX6QDL_PAD_CSI0_VSYNC__IPU1_CSI0_VSYNC     0x1b0b0
+				MX6QDL_PAD_CSI0_DATA_EN__IPU1_CSI0_DATA_EN 0x1b0b0
+			>;
+		};
+
 		pinctrl_j15: j15grp {
 			fsl,pins = <
 				MX6QDL_PAD_DI0_DISP_CLK__IPU1_DI0_DISP_CLK 0x10
@@ -444,6 +562,22 @@
 			>;
 		};
 
+		pinctrl_ov5640: ov5640grp {
+			fsl,pins = <
+				MX6QDL_PAD_NANDF_D5__GPIO2_IO05   0x000b0
+				MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09 0x0b0b0
+			>;
+		};
+
+		pinctrl_ov5642: ov5642grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD1_DAT0__GPIO1_IO16 0x1b0b0
+				MX6QDL_PAD_GPIO_6__GPIO1_IO06   0x1b0b0
+				MX6QDL_PAD_GPIO_8__GPIO1_IO08   0x130b0
+				MX6QDL_PAD_GPIO_3__CCM_CLKO2    0x000b0
+			>;
+		};
+
 		pinctrl_pwm1: pwm1grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD1_DAT3__PWM1_OUT 0x1b0b1
@@ -598,3 +732,17 @@
 	vmmc-supply = <&reg_3p3v>;
 	status = "okay";
 };
+
+&mipi_csi {
+	status = "okay";
+
+	port at 0 {
+		reg = <0>;
+
+		mipi_csi2_in: endpoint {
+			remote-endpoint = <&ov5640_to_mipi_csi2>;
+			clock-lanes = <0>;
+			data-lanes = <1 2>;
+		};
+	};
+};
-- 
2.7.4
