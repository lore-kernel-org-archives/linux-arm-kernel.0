From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 2 Apr 2013 22:31:17 +0800
Subject: [PATCH 4/6] ARM: dts: imx: make sabreauto and sabresd common
In-Reply-To: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
References: <1364913079-26039-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1364913079-26039-5-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sabreauto and sabresd boards are common for imx6q and imx6dl.
Create imx6qdl-sabreauto.dtsip and imx6qdl-sabresd.dtsip for those
common parts.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6q-sabreauto.dtsp    |   27 +--------
 arch/arm/boot/dts/imx6q-sabresd.dtsp      |   78 +-------------------------
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsip |   38 +++++++++++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsip   |   87 +++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 100 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabreauto.dtsip
 create mode 100644 arch/arm/boot/dts/imx6qdl-sabresd.dtsip

diff --git a/arch/arm/boot/dts/imx6q-sabreauto.dtsp b/arch/arm/boot/dts/imx6q-sabreauto.dtsp
index 23c602a..99ba364 100644
--- a/arch/arm/boot/dts/imx6q-sabreauto.dtsp
+++ b/arch/arm/boot/dts/imx6q-sabreauto.dtsp
@@ -11,15 +11,13 @@
  */
 
 /dts-v1/;
+
 #include "imx6q.dtsip"
+#include "imx6qdl-sabreauto.dtsip"
 
 / {
 	model = "Freescale i.MX6 Quad SABRE Automotive Board";
 	compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
-
-	memory {
-		reg = <0x10000000 0x80000000>;
-	};
 };
 
 &iomuxc {
@@ -35,24 +33,3 @@
 		};
 	};
 };
-
-&uart4 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart4_1>;
-	status = "okay";
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_2>;
-	phy-mode = "rgmii";
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3_1>;
-	cd-gpios = <&gpio6 15 0>;
-	wp-gpios = <&gpio1 13 0>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6q-sabresd.dtsp b/arch/arm/boot/dts/imx6q-sabresd.dtsp
index 5534a6f..05f6fbd 100644
--- a/arch/arm/boot/dts/imx6q-sabresd.dtsp
+++ b/arch/arm/boot/dts/imx6q-sabresd.dtsp
@@ -11,50 +11,13 @@
  */
 
 /dts-v1/;
+
 #include "imx6q.dtsip"
+#include "imx6qdl-sabresd.dtsip"
 
 / {
-	model = "Freescale i.MX6Q SABRE Smart Device Board";
+	model = "Freescale i.MX6 Quad SABRE Smart Device Board";
 	compatible = "fsl,imx6q-sabresd", "fsl,imx6q";
-
-	memory {
-		reg = <0x10000000 0x40000000>;
-	};
-
-	regulators {
-		compatible = "simple-bus";
-
-		reg_usb_otg_vbus: usb_otg_vbus {
-			compatible = "regulator-fixed";
-			regulator-name = "usb_otg_vbus";
-			regulator-min-microvolt = <5000000>;
-			regulator-max-microvolt = <5000000>;
-			gpio = <&gpio3 22 0>;
-			enable-active-high;
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-
-		volume-up {
-			label = "Volume Up";
-			gpios = <&gpio1 4 0>;
-			linux,code = <115>; /* KEY_VOLUMEUP */
-		};
-
-		volume-down {
-			label = "Volume Down";
-			gpios = <&gpio1 5 0>;
-			linux,code = <114>; /* KEY_VOLUMEDOWN */
-		};
-	};
-};
-
-&uart1 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1_1>;
-	status = "okay";
 };
 
 &iomuxc {
@@ -74,38 +37,3 @@
 		};
 	};
 };
-
-&usbotg {
-	vbus-supply = <&reg_usb_otg_vbus>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usbotg_2>;
-	disable-over-current;
-	status = "okay";
-};
-
-&usbh1 {
-	status = "okay";
-};
-
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet_1>;
-	phy-mode = "rgmii";
-	status = "okay";
-};
-
-&usdhc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc2_1>;
-	cd-gpios = <&gpio2 2 0>;
-	wp-gpios = <&gpio2 3 0>;
-	status = "okay";
-};
-
-&usdhc3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_usdhc3_1>;
-	cd-gpios = <&gpio2 0 0>;
-	wp-gpios = <&gpio2 1 0>;
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsip b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsip
new file mode 100644
index 0000000..4d237cf
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsip
@@ -0,0 +1,38 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_2>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4_1>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	cd-gpios = <&gpio6 15 0>;
+	wp-gpios = <&gpio1 13 0>;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsip b/arch/arm/boot/dts/imx6qdl-sabresd.dtsip
new file mode 100644
index 0000000..e21f6a8
--- /dev/null
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsip
@@ -0,0 +1,87 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ * Copyright 2011 Linaro Ltd.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/ {
+	memory {
+		reg = <0x10000000 0x40000000>;
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		volume-up {
+			label = "Volume Up";
+			gpios = <&gpio1 4 0>;
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+
+		volume-down {
+			label = "Volume Down";
+			gpios = <&gpio1 5 0>;
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg_2>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2_1>;
+	cd-gpios = <&gpio2 2 0>;
+	wp-gpios = <&gpio2 3 0>;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	cd-gpios = <&gpio2 0 0>;
+	wp-gpios = <&gpio2 1 0>;
+	status = "okay";
+};
-- 
1.7.9.5
