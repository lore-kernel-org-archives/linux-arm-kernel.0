From: breno.lima@nxp.com (Breno Lima)
Date: Mon, 23 Jan 2017 18:26:52 -0200
Subject: [PATCH v3 1/3] ARM: dts: udoo_neo: Add UDOO Neo USB OTG1 and OTG2
 support
Message-ID: <1485203214-29608-1-git-send-email-breno.lima@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for micro USB (OTG1) and USB Host (OTG2) for UDOO Neo board.

Tested on a UDOO Neo Full board by mounting a mass storage device
on both ports.

Signed-off-by: Breno Lima <breno.lima@nxp.com>
---
Changes since v2:
- Fixed regulators renamed.

 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index d1ce9af..99e1aea 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -75,6 +75,28 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 	};
+
+	reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_otg1_reg>;
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio1 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reg_usb_otg2_vbus: regulator-usb-otg2-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_otg2_reg>;
+		regulator-name = "usb_otg2_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio4 12 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &cpu0 {
@@ -242,6 +264,28 @@
 			<MX6SX_PAD_CSI_DATA07__UART6_CTS_B	0x1b0b1>;
 	};
 
+	pinctrl_otg1_reg: otg1grp {
+		fsl,pins =
+			<MX6SX_PAD_GPIO1_IO09__GPIO1_IO_9        0x10b0>;
+	};
+
+
+	pinctrl_otg2_reg: otg2grp {
+		fsl,pins =
+			<MX6SX_PAD_NAND_RE_B__GPIO4_IO_12        0x10b0>;
+	};
+
+	pinctrl_usb_otg1: usbotg1grp {
+		fsl,pins =
+			<MX6SX_PAD_GPIO1_IO10__ANATOP_OTG1_ID    0x17059>,
+			<MX6SX_PAD_GPIO1_IO08__USB_OTG1_OC       0x10b0>;
+	};
+
+	pinctrl_usb_otg2: usbot2ggrp {
+		fsl,pins =
+			<MX6SX_PAD_QSPI1A_DATA0__USB_OTG2_OC     0x10b0>;
+	};
+
 	pinctrl_usdhc2: usdhc2grp {
 		fsl,pins =
 			<MX6SX_PAD_SD2_CMD__USDHC2_CMD		0x17059>,
@@ -281,6 +325,21 @@
 	status = "disabled";
 };
 
+&usbotg1 { /* J2 micro USB port */
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg1>;
+	status = "okay";
+};
+
+&usbotg2 { /* J3 host USB port */
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_otg2>;
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-- 
2.7.4
