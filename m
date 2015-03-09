From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Mar 2015 17:28:07 +0800
Subject: [PATCH 2/3] ARM: imx6qdl-sabreauto.dtsi: enable USB support
In-Reply-To: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
References: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1425893288-1517-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USBOTG and USB host 1 support

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 51acfec..33f228c 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -35,6 +35,32 @@
 		#reset-cells = <0>;
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
@@ -327,6 +353,12 @@
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
@@ -471,6 +503,18 @@
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
