From: silvio.maillist@gmail.com (Silvio F)
Date: Wed,  6 Nov 2013 22:04:42 +0100
Subject: [PATCH 2/2] ARM: dts: imx6: Add support for imx6q dmo edmqmx6
In-Reply-To: <1383771882-1447-1-git-send-email-silvio.fricke@gmail.com>
References: <1383771882-1447-1-git-send-email-silvio.fricke@gmail.com>
Message-ID: <1383771882-1447-3-git-send-email-silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Silvio F <silvio.fricke@gmail.com>
---
 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts | 182 ++++++++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5468d2d..3159ab6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -143,6 +143,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
 	imx6q-cm-fx6.dtb \
+	imx6q-dmo-edmqmx6.dtb \
 	imx6q-gw51xx.dtb \
 	imx6q-gw52xx.dtb \
 	imx6q-gw53xx.dtb \
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
new file mode 100644
index 0000000..77b045a
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -0,0 +1,182 @@
+/*
+ * Copyright 2013 Data Modul AG
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+
+#include "imx6q.dtsi"
+
+/ {
+	model = "Data Modul eDM-QMX6 Board";
+	compatible = "dmo,imx6q-edmqmx6", "fsl,imx6q";
+
+	aliases {
+		gpio7 = &stmpe_gpio_1;
+		gpio8 = &stmpe_gpio_2;
+	};
+
+	memory {
+		reg = <0x10000000 0x80000000>;
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
+		reg_usb_otg_vbus: usb_otg_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio7 12 0>;
+		};
+
+		reg_usb_host1: usb_host1_en {
+			compatible = "regulator-fixed";
+			regulator-name = "usb_host1_en";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 31 0>;
+			enable-active-high;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 23 0>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2
+		     &pinctrl_stmpe_1
+		     &pinctrl_stmpe_2>;
+	status = "okay";
+
+	rtc: m41t62 at 68 {
+		compatible = "stm,m41t62";
+		reg = <0x68>;
+	};
+	stmpe1: stmpe1601 at 40 {
+		compatible = "st,stmpe1601";
+		reg = <0x40>;
+		interrupts = <30 0>;
+		interrupt-parent = <&gpio3>;
+
+		stmpe_gpio_1: stmpe_gpio {
+			compatible = "st,stmpe-gpio";
+		};
+	};
+
+	stmpe2: stmpe1601 at 44 {
+		compatible = "st,stmpe1601";
+		reg = <0x44>;
+		interrupts = <2 0>;
+		interrupt-parent = <&gpio5>;
+
+		stmpe_gpio_2: stmpe_gpio {
+			compatible = "st,stmpe-gpio";
+		};
+	};
+
+	temp1: ad7414 at 4c {
+		compatible = "ad,ad7414";
+		reg = <0x4c>;
+	};
+
+	temp2: ad7414 at 4d {
+		compatible = "ad,ad7414";
+		reg = <0x4d>;
+	};
+};
+
+&iomuxc {
+	pinctrl_enet: enetgrp {
+		fsl,pins = <MX6QDL_ENET_PINGRP1>;
+	};
+
+	pinctrl_i2c2: i2c2grp {
+		fsl,pins = <MX6QDL_I2C2_PINGRP3>;
+	};
+
+	stmpe1 {
+		pinctrl_stmpe_1: stmpe1grp-1 {
+			fsl,pins = <MX6QDL_PAD_EIM_D30__GPIO3_IO30 0x80000000>;
+		};
+	};
+
+	stmpe2 {
+		pinctrl_stmpe_2: stmpe2grp-1 {
+			fsl,pins = <MX6QDL_PAD_EIM_A25__GPIO5_IO02 0x80000000>;
+		};
+	};
+
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <MX6QDL_UART1_PINGRP2>;
+	};
+
+	pinctrl_uart2: uart1grp {
+		fsl,pins = <MX6QDL_UART2_PINGRP1>;
+	};
+
+	pinctrl_usbotg: usbotggrp {
+		fsl,pins = <MX6QDL_USBOTG_PINGRP1>;
+	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <MX6QDL_USDHC3_PINGRP2>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&usbh1 {
+	vbus-supply = <&reg_usb_host1>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	disable-over-current;
+	status = "okay";
+};
+
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	vmmc-supply = <&reg_3p3v>;
+	status = "okay";
+};
+
-- 
1.8.4.2
