From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Mon, 24 Jul 2017 10:50:05 +0200
Subject: [PATCH 2/2] ARM: dts: imx6qdl-nitrogen6x: fix USB PHY reset
In-Reply-To: <20170724085005.22101-1-gary.bisson@boundarydevices.com>
References: <20170724085005.22101-1-gary.bisson@boundarydevices.com>
Message-ID: <20170724085005.22101-3-gary.bisson@boundarydevices.com>
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
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index f22e5879340b..989376643cf6 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -108,6 +108,19 @@
 			startup-delay-us = <70000>;
 			enable-active-high;
 		};
+
+		reg_usb_h1_vbus: regulator at 5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usbh1>;
+			regulator-name = "usb_h1_vbus";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
+			enable-active-high;
+			regulator-always-on;
+		};
 	};
 
 	gpio-keys {
@@ -515,6 +528,12 @@
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
 				MX6QDL_PAD_GPIO_1__USB_OTG_ID	0x17059
@@ -629,6 +648,7 @@
 };
 
 &usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
 	status = "okay";
 };
 
-- 
2.11.0
