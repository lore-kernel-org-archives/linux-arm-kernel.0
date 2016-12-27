From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Tue, 27 Dec 2016 11:22:38 +0100
Subject: [PATCH] ARM: dts: sunxi: Use axp209.dtsi for Olinuxino Lime2
Message-ID: <20161227102238.20110-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use axp209.dtsi in sun7i-a20-olinuxino-lime2.dts and correct
some regulators.

DCDC2 is used for vdd-cpu so it should never be bellow 1V and above 1.4V
DCDC3 is used for VDD_INT so same as above.
LD01 is used for the RTC, and should have a typical value of 1.3V
LD02 is used for AVCC and should have a typical value of 3.0V
LD03/4 are used for Port-E/Port-G Power pin, and the schematics recommands
to set them to 2.8V as they can be used for CSI0/1.

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 90 ++++++++++++-------------
 1 file changed, 42 insertions(+), 48 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d5c796c8d16f..5311dbce6fd9 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -112,57 +112,9 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		acin-supply = <&reg_axp_ipsout>;
-		vin2-supply = <&reg_axp_ipsout>;
-		vin3-supply = <&reg_axp_ipsout>;
-		ldo24in-supply = <&reg_axp_ipsout>;
-		ldo3in-supply = <&reg_axp_ipsout>;
-
-		regulators {
-			vdd_rtc: ldo1 {
-				regulator-min-microvolt = <1300000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-			};
-
-			avcc: ldo2 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vcc_csi0: ldo3 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-always-on;
-			};
-
-			vcc_csi1: ldo4 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_cpu: dcdc2 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <2275000>;
-				regulator-always-on;
-			};
-
-			vdd_int: dcdc3 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-always-on;
-			};
-		};
 	};
 };
 
@@ -243,6 +195,48 @@
 	status = "okay";
 };
 
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1300000>;
+	regulator-max-microvolt = <1300000>;
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
+&reg_ldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vddio-csi0";
+};
+
+&reg_ldo4 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vddio-csi1";
+};
+
 &reg_usb0_vbus {
 	pinctrl-0 = <&usb0_vbus_pin_lime2>;
 	gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
-- 
2.11.0
