From: o.schinagl@ultimaker.com (Olliver Schinagl)
Date: Wed,  9 Sep 2015 15:26:44 +0200
Subject: [PATCH v2 1/1] ARM: dts: sun7i: Enable axp209 driver on olinuxino
 lime2
In-Reply-To: <1441805204-6037-1-git-send-email-o.schinagl@ultimaker.com>
References: <1441805204-6037-1-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <1441805204-6037-2-git-send-email-o.schinagl@ultimaker.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Olimex OLinuXino Lime2 uses the same AXP209 as was recently
introduced this driver for its power regulation.

Signed-off-by: Olliver Schinagl <o.schinagl@ultimaker.com>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 87 +++++++++----------------
 1 file changed, 31 insertions(+), 56 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index d5c796c..dd90a1d 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -71,14 +71,6 @@
 			default-state = "on";
 		};
 	};
-
-	reg_axp_ipsout: axp_ipsout {
-		compatible = "regulator-fixed";
-		regulator-name = "axp-ipsout";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
 };
 
 &ahci {
@@ -86,6 +78,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -112,57 +108,9 @@
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
 
@@ -243,6 +191,33 @@
 	status = "okay";
 };
 
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
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
 &reg_usb0_vbus {
 	pinctrl-0 = <&usb0_vbus_pin_lime2>;
 	gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
-- 
2.1.4
