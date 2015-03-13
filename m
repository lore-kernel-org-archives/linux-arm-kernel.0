From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Mar 2015 14:21:43 +0800
Subject: [PATCH v2 2/3] ARM: imx6qdl-sabreauto.dtsi: enable USB support
In-Reply-To: <1426227704-26294-1-git-send-email-peter.chen@freescale.com>
References: <1426227704-26294-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426227704-26294-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USBOTG and USB host 1 support

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 46b2fed..0bedd5d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -28,6 +28,32 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_h1_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+
+		reg_usb_otg_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
+
 	sound-spdif {
 		compatible = "fsl,imx-audio-spdif",
 			   "fsl,imx-sabreauto-spdif";
@@ -319,6 +345,12 @@
 			>;
 		};
 
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <
+				MX6QDL_PAD_ENET_RX_ER__USB_OTG_ID 0x17059
+			>;
+		};
+
 		pinctrl_usdhc3: usdhc3grp {
 			fsl,pins = <
 				MX6QDL_PAD_SD3_CMD__SD3_CMD		0x17059
@@ -463,6 +495,18 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	status = "okay";
+};
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc3>;
-- 
1.9.1
