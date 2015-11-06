From: plaes@plaes.org (Priit Laes)
Date: Fri,  6 Nov 2015 19:54:44 +0200
Subject: [PATCH v3 1/3] ARM: dts: sun4i: gemei-g9: Convert to use axp209
 regulator nodes
In-Reply-To: <1446832486-32319-1-git-send-email-plaes@plaes.org>
References: <1446832486-32319-1-git-send-email-plaes@plaes.org>
Message-ID: <1446832486-32319-2-git-send-email-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add regulator nodes for axp209 using the axp209.dtsi include.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
Changes in v3:
 - Drop the ohci0 node. It's not needed.

Changes in v2:
 - Add the ohci0 node.


 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts | 35 ++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
index 3f0aeb8..6b4c29d 100644
--- a/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
+++ b/arch/arm/boot/dts/sun4i-a10-gemei-g9.dts
@@ -72,6 +72,10 @@
  *   Touchscreen - gt801_2plus1 @ i2c adapter 2 @ 0x48
  */
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -86,15 +90,13 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupts = <0>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
 	};
 };
 
+#include "axp209.dtsi"
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
@@ -146,6 +148,31 @@
 	status = "okay";
 };
 
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1250000>;
+	regulator-max-microvolt = <1250000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
-- 
2.6.3
