From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Fri, 3 Oct 2014 16:18:53 +0300
Subject: [PATCH v4 1/4] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
In-Reply-To: <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1412342336-25700-1-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <1412342336-25700-2-git-send-email-d.lavnikevich@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since pins and frequency are specific to module (pfla02), not base board
(pbab02), it is better to be initialized in corresponding dts file.

This patch fixes i2c2, i2c3 pin configuration which caused messages:

imx6q-pinctrl 20e0000.iomuxc: no groups defined in /soc/aips-bus at 02000000/iomuxc at 020e0000/i2c2grp
imx6q-pinctrl 20e0000.iomuxc: no groups defined in /soc/aips-bus at 02000000/iomuxc at 020e0000/i2c3grp
imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c2grp
imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c3grp

Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 22 ----------------------
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 584721264121..f1bdcae5b97d 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -28,9 +28,6 @@
 };
 
 &i2c2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	clock-frequency = <100000>;
 	status = "okay";
 
 	tlv320 at 18 {
@@ -55,9 +52,6 @@
 };
 
 &i2c3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	clock-frequency = <100000>;
 	status = "okay";
 };
 
@@ -84,19 +78,3 @@
 &usdhc3 {
 	status = "okay";
 };
-
-&iomuxc {
-	pinctrl_i2c2: i2c2grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
-		>;
-	};
-
-	pinctrl_i2c3: i2c3grp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
-			MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
-		>;
-	};
-};
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 0e50bb0a6b94..aa2275671d2c 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -162,6 +162,18 @@
 	};
 };
 
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	clock-frequency = <100000>;
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	clock-frequency = <100000>;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
@@ -235,6 +247,20 @@
 			>;
 		};
 
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_EB2__I2C2_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D16__I2C2_SDA		0x4001b8b1
+			>;
+		};
+
+		pinctrl_i2c3: i2c3grp {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D17__I2C3_SCL		0x4001b8b1
+				MX6QDL_PAD_EIM_D18__I2C3_SDA		0x4001b8b1
+			>;
+		};
+
 		pinctrl_uart3: uart3grp {
 			fsl,pins = <
 				MX6QDL_PAD_EIM_D24__UART3_TX_DATA	0x1b0b1
-- 
2.1.1
