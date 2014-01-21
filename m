From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 21 Jan 2014 18:13:32 +0200
Subject: [PATCH 4/4] ARM: dts: cm-fx6: add support for USB host port 1
In-Reply-To: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1390320812-25100-5-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup pin control, vbus regulator and the usb host port 1 node
to enable the USB host port 1 support.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 039a155..cf4c186 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -46,6 +46,16 @@
 			gpio = <&gpio3 22 0>;
 			enable-active-high;
 		};
+
+		reg_usb_h1_vbus: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio7 8 0>;
+			enable-active-high;
+		};
 	};
 };
 
@@ -66,6 +76,12 @@
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <MX6QDL_USBOTG_PINGRP2>;
 		};
+
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD3_RST__GPIO7_IO08 0x80000000
+			>;
+		};
 	};
 };
 
@@ -99,3 +115,10 @@
 	dr_mode = "otg";
 	status = "okay";
 };
+
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbh1>;
+	status = "okay";
+};
-- 
1.8.3.2
