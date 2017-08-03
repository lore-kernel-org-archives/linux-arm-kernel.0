From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Aug 2017 16:14:10 +0800
Subject: [PATCH 7/8] ARM: sun8i: a83t: cubietruck-plus: Enable onboard USB
 peripherals
In-Reply-To: <20170803081411.22389-1-wens@csie.org>
References: <20170803081411.22389-1-wens@csie.org>
Message-ID: <20170803081411.22389-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck-plus has a GL830 USB-to-SATA bridge connected to EHCI0,
and a USB3503 HSIC USB 2.0 hub connected to EHCI1. The USB3503's I2C
control interface is not connected.

This patch enables both EHCI controllers, adds a device node for the
USB hub, and includes sunxi-common-regulators.dtsi for the VBUS
regulators. The existing reg_vcc3v3 is dropped as it is also available
in the set of common regulators. Other unused regulators are disabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 49 +++++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index f583e5b9a1c8..716a205c6dbb 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -44,6 +44,7 @@
 
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
+#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -83,11 +84,15 @@
 		};
 	};
 
-	reg_vcc3v3: vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+	usb-hub {
+		/* I2C is not connected */
+		compatible = "smsc,usb3503";
+		initial-mode = <1>; /* initialize in HUB mode */
+		disabled-ports = <1>;
+		intn-gpios = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+		reset-gpios = <&pio 4 16 GPIO_ACTIVE_HIGH>; /* PE16 */
+		connect-gpios = <&pio 4 17 GPIO_ACTIVE_HIGH>; /* PE17 */
+		refclk-frequency = <19200000>;
 	};
 
 	sound {
@@ -109,6 +114,16 @@
 	};
 };
 
+&ehci0 {
+	/* GL830 USB-to-SATA bridge here */
+	status = "okay";
+};
+
+&ehci1 {
+	/* USB3503 HSIC USB 2.0 hub here */
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -164,6 +179,24 @@
 	};
 };
 
+&reg_usb1_vbus {
+	gpio = <&pio 3 29 GPIO_ACTIVE_HIGH>; /* PD29 */
+	status = "okay";
+};
+
+&reg_usb2_vbus {
+	gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	status = "okay";
+};
+
+&reg_vcc3v0 {
+	status = "disabled";
+};
+
+&reg_vcc5v0 {
+	status = "disabled";
+};
+
 &spdif {
 	status = "okay";
 };
@@ -173,3 +206,9 @@
 	pinctrl-0 = <&uart0_pb_pins>;
 	status = "okay";
 };
+
+&usbphy {
+	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_usb2_vbus>;
+	status = "okay";
+};
-- 
2.13.3
