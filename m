From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu,  7 Jun 2018 19:21:32 +0530
Subject: [PATCH 2/3] ARM: dts: imx6q-icore-mipi: Add OV5640 Camera sensor
In-Reply-To: <20180607135133.3104-1-jagan@amarulasolutions.com>
References: <20180607135133.3104-1-jagan@amarulasolutions.com>
Message-ID: <20180607135133.3104-2-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OV5640 Camera sensor is connected in i.CoreM6 1.5 Quad/Dual MIPI
starter kit.

This patch also move MX6QDL_PAD_GPIO_0__CCM_CLKO1 pinctrl
from i2c3 to ov5640 pinctrl.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/imx6q-icore-mipi.dts |  8 ++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi   | 46 +++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-icore-mipi.dts b/arch/arm/boot/dts/imx6q-icore-mipi.dts
index acd3d33476d4..95b2efda17b4 100644
--- a/arch/arm/boot/dts/imx6q-icore-mipi.dts
+++ b/arch/arm/boot/dts/imx6q-icore-mipi.dts
@@ -20,6 +20,14 @@
 	status = "okay";
 };
 
+&mipi_csi {
+	status = "okay";
+};
+
+&ov5640 {
+	status = "okay";
+};
+
 &usdhc3 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 0a1574998fc6..be8aa55c973e 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -215,6 +215,29 @@
 	pinctrl-0 = <&pinctrl_i2c3>;
 	status = "okay";
 
+	ov5640: camera at 3c {
+		compatible = "ovti,ov5640";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ov5640>;
+		reg = <0x3c>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		clock-names = "xclk";
+		DOVDD-supply = <&reg_1p8v>;
+		AVDD-supply = <&reg_3p3v>;
+		DVDD-supply = <&reg_3p3v>;
+		powerdown-gpios = <&gpio5 30 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio5 31 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+
+		port {
+			ov5640_to_mipi_csi2: endpoint {
+				remote-endpoint = <&mipi_csi2_in>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+
 	sgtl5000: codec at a {
 		#sound-dai-cells = <0>;
 		compatible = "fsl,sgtl5000";
@@ -226,6 +249,20 @@
 	};
 };
 
+&mipi_csi {
+	status = "disabled";
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
+
 &pwm3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm3>;
@@ -353,7 +390,14 @@
 		fsl,pins = <
 			MX6QDL_PAD_GPIO_5__I2C3_SCL  0x4001b8b1
 			MX6QDL_PAD_EIM_D18__I2C3_SDA 0x4001b8b1
-			MX6QDL_PAD_GPIO_0__CCM_CLKO1	0x130b0
+		>;
+	};
+
+	pinctrl_ov5640: ov5640grp {
+		fsl,pins = <
+			MX6QDL_PAD_CSI0_DAT12__GPIO5_IO30 0x1b0b0
+			MX6QDL_PAD_CSI0_DAT13__GPIO5_IO31 0x1b0b0
+			MX6QDL_PAD_GPIO_0__CCM_CLKO1	  0x130b0
 		>;
 	};
 
-- 
2.14.3
