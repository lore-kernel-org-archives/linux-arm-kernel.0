From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  3 Jun 2016 14:50:50 +0800
Subject: [PATCH v3 1/2] ARM: dts: sun9i: a80-optimus: Drop
 sunxi-common-regulators.dtsi
In-Reply-To: <1464936651-25911-1-git-send-email-wens@csie.org>
References: <1464936651-25911-1-git-send-email-wens@csie.org>
Message-ID: <1464936651-25911-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sunxi-common-regulators.dtsi provided dummy regulators vcc3v0, vcc3v3,
vcc5v0. 3.0V/3.3V and 5.0V are commonly used voltages in Allwinner
devices. These dummy regulators provide a stand-in when bindings that
require one, but the real regulator is not supported yet.

Since these are no longer needed, we can drop the include file by
copying over reg_usb1_vbus.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 6cfc02194035..78fddd9152a5 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -44,7 +44,6 @@
 
 /dts-v1/;
 #include "sun9i-a80.dtsi"
-#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
@@ -85,6 +84,17 @@
 		};
 	};
 
+	reg_usb1_vbus: usb1-vbus {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb1_vbus_pin_optimus>;
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		enable-active-high;
+		gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	};
+
 	reg_usb3_vbus: usb3-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -172,12 +182,6 @@
 	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 };
 
-&reg_usb1_vbus {
-	pinctrl-0 = <&usb1_vbus_pin_optimus>;
-	gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
-	status = "okay";
-};
-
 &r_ir {
 	status = "okay";
 };
-- 
2.8.1
