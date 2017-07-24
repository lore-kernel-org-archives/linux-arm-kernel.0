From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 24 Jul 2017 14:59:57 +0200
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabrelite: fix USB PHY reset
In-Reply-To: <20170724125958.11939-1-gary.bisson@boundarydevices.com>
References: <20170724085005.22101-1-gary.bisson@boundarydevices.com>
 <20170724125958.11939-1-gary.bisson@boundarydevices.com>
Message-ID: <20170724125958.11939-2-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declared as a regulator since the driver doesn't have a reset-gpios
property for this.

This ensures that the PHY is woken up, not depending on the state the
second stage bootloader leaves the pin.

This is a workaround until a proper mechanism is provided to reset such
devices like the pwrseq library [1] for instance.

[1] https://lkml.org/lkml/2017/2/10/779

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index afe7449c47da..756c5054f047 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -123,6 +123,18 @@
 			regulator-max-microvolt = <2800000>;
 			regulator-always-on;
 		};
+
+		reg_usb_h1_vbus: regulator at 7 {
+			compatible = "regulator-fixed";
+			reg = <7>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+		};
 	};
 
 	mipi_xclk: mipi_xclk {
@@ -610,6 +622,12 @@
 			>;
 		};
 
+		pinctrl_usbh1: usbh1grp {
+			fsl,pins = <
+				MX6QDL_PAD_GPIO_17__GPIO7_IO12		0x030b0
+			>;
+		};
+
 		pinctrl_usbotg: usbotggrp {
 			fsl,pins = <
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID		0x17059
@@ -705,6 +723,7 @@
 };
 
 &usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
 	status = "okay";
 };
 
-- 
2.11.0
