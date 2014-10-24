From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 24 Oct 2014 17:55:26 +0100
Subject: [PATCH 1/4] ARM: dts: hummingboard: Split HummingBoard DT to support
 s/dl and d/q
Message-ID: <E1Xhi98-0005pH-D5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabeeh Khoury <rabeeh@solid-run.com>
To: Shawn Guo <shawn.guo@linaro.org>

Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/Makefile                  |   1 +
 arch/arm/boot/dts/imx6dl-hummingboard.dts   | 203 +---------------------------
 arch/arm/boot/dts/imx6q-hummingboard.dts    |  13 ++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 200 +++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 198 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-hummingboard.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3ddeb9..bef8619536ae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -223,6 +223,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-gw53xx.dtb \
 	imx6q-gw5400-a.dtb \
 	imx6q-gw54xx.dtb \
+	imx6q-hummingboard.dtb \
 	imx6q-nitrogen6x.dtb \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-rex-pro.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index 71598546087f..44a0e6736bb1 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -1,206 +1,13 @@
 /*
- * Copyright (C) 2013,2014 Russell King
+ * Copyright (C) 2014 Rabeeh Khoury (rabeeh at solid-run.com)
+ * Based on dt work by Russell King
  */
 /dts-v1/;
 
 #include "imx6dl.dtsi"
-#include "imx6qdl-microsom.dtsi"
-#include "imx6qdl-microsom-ar8035.dtsi"
+#include "imx6qdl-hummingboard.dtsi"
 
 / {
-	model = "SolidRun HummingBoard DL/Solo";
-	compatible = "solidrun,hummingboard", "fsl,imx6dl";
-
-	chosen {
-		stdout-path = &uart1;
-	};
-
-	ir_recv: ir-receiver {
-		compatible = "gpio-ir-receiver";
-		gpios = <&gpio1 2 1>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_hummingboard_gpio1_2>;
-	};
-
-	regulators {
-		compatible = "simple-bus";
-
-		reg_3p3v: 3p3v {
-			compatible = "regulator-fixed";
-			regulator-name = "3P3V";
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-always-on;
-		};
-
-		reg_usbh1_vbus: usb-h1-vbus {
-			compatible = "regulator-fixed";
-			enable-active-high;
-			gpio = <&gpio1 0 0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_hummingboard_usbh1_vbus>;
-			regulator-name = "usb_h1_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
-
-		reg_usbotg_vbus: usb-otg-vbus {
-			compatible = "regulator-fixed";
-			enable-active-high;
-			gpio = <&gpio3 22 0>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&pinctrl_hummingboard_usbotg_vbus>;
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-		};
-	};
-
-	sound-spdif {
-		compatible = "fsl,imx-audio-spdif";
-		model = "On-board SPDIF";
-		/* IMX6 doesn't implement this yet */
-		spdif-controller = <&spdif>;
-		spdif-out;
-	};
-};
-
-&can1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hummingboard_flexcan1>;
-	status = "okay";
-};
-
-&hdmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hummingboard_hdmi>;
-	ddc-i2c-bus = <&i2c2>;
-	status = "okay";
-};
-
-&i2c1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hummingboard_i2c1>;
-
-	/*
-	 * Not fitted on Carrier-1 board... yet
-	status = "okay";
-
-	rtc: pcf8523 at 68 {
-		compatible = "nxp,pcf8523";
-		reg = <0x68>;
-	};
-	 */
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hummingboard_i2c2>;
-	status = "okay";
-};
-
-&iomuxc {
-	hummingboard {
-		pinctrl_hummingboard_flexcan1: hummingboard-flexcan1 {
-			fsl,pins = <
-				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x80000000
-				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX 0x80000000
-			>;
-		};
-
-		pinctrl_hummingboard_gpio1_2: hummingboard-gpio1_2 {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
-			>;
-		};
-
-		pinctrl_hummingboard_hdmi: hummingboard-hdmi {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
-			>;
-		};
-
-		pinctrl_hummingboard_i2c1: hummingboard-i2c1 {
-			fsl,pins = <
-				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
-				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
-			>;
-		};
-
-		pinctrl_hummingboard_i2c2: hummingboard-i2c2 {
-			fsl,pins = <
-				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
-				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
-			>;
-		};
-
-		pinctrl_hummingboard_spdif: hummingboard-spdif {
-			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
-		};
-
-		pinctrl_hummingboard_usbh1_vbus: hummingboard-usbh1-vbus {
-			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0>;
-		};
-
-		pinctrl_hummingboard_usbotg_id: hummingboard-usbotg-id {
-			/*
-			 * Similar to pinctrl_usbotg_2, but we want it
-			 * pulled down for a fixed host connection.
-			 */
-			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
-		};
-
-		pinctrl_hummingboard_usbotg_vbus: hummingboard-usbotg-vbus {
-			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b0>;
-		};
-
-		pinctrl_hummingboard_usdhc2_aux: hummingboard-usdhc2-aux {
-			fsl,pins = <
-				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
-			>;
-		};
-
-		pinctrl_hummingboard_usdhc2: hummingboard-usdhc2 {
-			fsl,pins = <
-				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
-				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
-				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
-				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
-				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
-				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
-			>;
-		};
-	};
-};
-
-&spdif {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hummingboard_spdif>;
-	status = "okay";
-};
-
-&usbh1 {
-	disable-over-current;
-	vbus-supply = <&reg_usbh1_vbus>;
-	status = "okay";
-};
-
-&usbotg {
-	disable-over-current;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_hummingboard_usbotg_id>;
-	vbus-supply = <&reg_usbotg_vbus>;
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <
-		&pinctrl_hummingboard_usdhc2_aux
-		&pinctrl_hummingboard_usdhc2
-	>;
-	vmmc-supply = <&reg_3p3v>;
-	cd-gpios = <&gpio1 4 0>;
-	status = "okay";
+	model = "SolidRun HummingBoard Solo/DualLite";
+	compatible = "solidrun,hummingboard/dl", "fsl,imx6dl";
 };
diff --git a/arch/arm/boot/dts/imx6q-hummingboard.dts b/arch/arm/boot/dts/imx6q-hummingboard.dts
new file mode 100644
index 000000000000..0a3574105165
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-hummingboard.dts
@@ -0,0 +1,13 @@
+/*
+ * Copyright (C) 2014 Rabeeh Khoury (rabeeh at solid-run.com)
+ * Based on dt work by Russell King
+ */
+/dts-v1/;
+
+#include "imx6q.dtsi"
+#include "imx6qdl-hummingboard.dtsi"
+
+/ {
+	model = "SolidRun HummingBoard Dual/Quad";
+	compatible = "solidrun,hummingboard/q", "fsl,imx6q";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
new file mode 100644
index 000000000000..bf38072a2779
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -0,0 +1,200 @@
+/*
+ * Copyright (C) 2013,2014 Russell King
+ */
+#include "imx6qdl-microsom.dtsi"
+#include "imx6qdl-microsom-ar8035.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	ir_recv: ir-receiver {
+		compatible = "gpio-ir-receiver";
+		gpios = <&gpio1 2 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_hummingboard_gpio1_2>;
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
+
+		reg_usbh1_vbus: usb-h1-vbus {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio1 0 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_hummingboard_usbh1_vbus>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
+
+		reg_usbotg_vbus: usb-otg-vbus {
+			compatible = "regulator-fixed";
+			enable-active-high;
+			gpio = <&gpio3 22 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_hummingboard_usbotg_vbus>;
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+		};
+	};
+
+	sound-spdif {
+		compatible = "fsl,imx-audio-spdif";
+		model = "On-board SPDIF";
+		/* IMX6 doesn't implement this yet */
+		spdif-controller = <&spdif>;
+		spdif-out;
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_flexcan1>;
+	status = "okay";
+};
+
+&hdmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_hdmi>;
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_i2c1>;
+
+	/*
+	 * Not fitted on Carrier-1 board... yet
+	status = "okay";
+
+	rtc: pcf8523 at 68 {
+		compatible = "nxp,pcf8523";
+		reg = <0x68>;
+	};
+	 */
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_i2c2>;
+	status = "okay";
+};
+
+&iomuxc {
+	hummingboard {
+		pinctrl_hummingboard_flexcan1: hummingboard-flexcan1 {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_CLK__FLEXCAN1_RX 0x80000000
+				MX6QDL_PAD_SD3_CMD__FLEXCAN1_TX 0x80000000
+			>;
+		};
+
+		pinctrl_hummingboard_gpio1_2: hummingboard-gpio1_2 {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02 0x80000000
+			>;
+		};
+
+		pinctrl_hummingboard_hdmi: hummingboard-hdmi {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_ROW2__HDMI_TX_CEC_LINE 0x1f8b0
+			>;
+		};
+
+		pinctrl_hummingboard_i2c1: hummingboard-i2c1 {
+			fsl,pins = <
+				MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
+				MX6QDL_PAD_EIM_D28__I2C1_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_hummingboard_i2c2: hummingboard-i2c2 {
+			fsl,pins = <
+				MX6QDL_PAD_KEY_COL3__I2C2_SCL 0x4001b8b1
+				MX6QDL_PAD_KEY_ROW3__I2C2_SDA 0x4001b8b1
+			>;
+		};
+
+		pinctrl_hummingboard_spdif: hummingboard-spdif {
+			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
+		};
+
+		pinctrl_hummingboard_usbh1_vbus: hummingboard-usbh1-vbus {
+			fsl,pins = <MX6QDL_PAD_GPIO_0__GPIO1_IO00 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard_usbotg_id: hummingboard-usbotg-id {
+			/*
+			 * Similar to pinctrl_usbotg_2, but we want it
+			 * pulled down for a fixed host connection.
+			 */
+			fsl,pins = <MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059>;
+		};
+
+		pinctrl_hummingboard_usbotg_vbus: hummingboard-usbotg-vbus {
+			fsl,pins = <MX6QDL_PAD_EIM_D22__GPIO3_IO22 0x1b0b0>;
+		};
+
+		pinctrl_hummingboard_usdhc2_aux: hummingboard-usdhc2-aux {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_4__GPIO1_IO04    0x1f071
+			>;
+		};
+
+		pinctrl_hummingboard_usdhc2: hummingboard-usdhc2 {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x17059
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x10059
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x17059
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x17059
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x17059
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
+			>;
+		};
+	};
+};
+
+&spdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_spdif>;
+	status = "okay";
+};
+
+&usbh1 {
+	disable-over-current;
+	vbus-supply = <&reg_usbh1_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	disable-over-current;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hummingboard_usbotg_id>;
+	vbus-supply = <&reg_usbotg_vbus>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <
+		&pinctrl_hummingboard_usdhc2_aux
+		&pinctrl_hummingboard_usdhc2
+	>;
+	vmmc-supply = <&reg_3p3v>;
+	cd-gpios = <&gpio1 4 0>;
+	status = "okay";
+};
-- 
1.8.3.1
