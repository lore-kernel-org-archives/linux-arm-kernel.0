From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 21 Jan 2014 18:13:31 +0200
Subject: [PATCH 3/4] ARM: dts: cm-fx6: add support for USB OTG
In-Reply-To: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1390320812-25100-4-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setup pin control, vbus regulator and the usb otg node
to enable the USB OTG support.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 07f90a5..039a155 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -32,7 +32,21 @@
 		};
 	};
 
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
+		reg_usb_otg_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_otg_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 22 0>;
+			enable-active-high;
+		};
+	};
 };
 
 &iomuxc {
@@ -48,6 +62,10 @@
 		pinctrl_uart4: uart4grp {
 			fsl,pins = <MX6QDL_UART4_PINGRP1>;
 		};
+
+		pinctrl_usbotg: usbotggrp {
+			fsl,pins = <MX6QDL_USBOTG_PINGRP2>;
+		};
 	};
 };
 
@@ -73,3 +91,11 @@
 &sata {
 	status = "okay";
 };
+
+&usbotg {
+	vbus-supply = <&reg_usb_otg_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg>;
+	dr_mode = "otg";
+	status = "okay";
+};
-- 
1.8.3.2
