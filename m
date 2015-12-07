From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:33 +0200
Subject: [PATCH 2/8] ARM: dts: imx7d: cl-som-imx7: add usb otg support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-3-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for single USB OTG port.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 6fa6580..a8f52cf 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -21,6 +21,22 @@
 	memory {
 		reg = <0x80000000 0x10000000>; /* 256 MB - minimal configuration */
 	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg_usb_otg1_vbus: regulator at 0 {
+			compatible = "regulator-fixed";
+			reg = <0>;
+			regulator-name = "usb_otg1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
+	};
 };
 
 &cpu0 {
@@ -131,6 +147,13 @@
 	status = "okay";
 };
 
+&usbotg1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
 &iomuxc {
 	cl-som-imx7 {
 		pinctrl_i2c2: i2c2grp {
@@ -146,5 +169,11 @@
 				MX7D_PAD_UART1_RX_DATA__UART1_DCE_RX	0x79
 			>;
 		};
+
+		pinctrl_usbotg1: usbotg1grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14 /* OTG PWREN */
+			>;
+		};
 	};
 };
-- 
1.9.1
