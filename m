From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 22:48:58 +0800
Subject: [PATCH v2 3/5] ARM: dts: sun6i: hummingbird: Use axp22x.dtsi for
 AXP221 regulators
In-Reply-To: <1444488540-11263-1-git-send-email-wens@csie.org>
References: <1444488540-11263-1-git-send-email-wens@csie.org>
Message-ID: <1444488540-11263-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have axp22x.dtsi describing common axp22x hardware, use
it and reference the nodes instead of declaring the whole tree.

Also drop the "always-on" from the vdd-gpu regulator, since we don't
support the GPU anyway.

And add a regulator reference for cpu0.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts | 113 ++++++++++++++--------------
 1 file changed, 56 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index e25d4924dbe7..a9b87ae89855 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -69,6 +69,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -121,7 +125,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_hummingbird>;
-	vmmc-supply = <&vcc_3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
 	cd-inverted;
@@ -136,7 +140,7 @@
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins_a>, <&wifi_reset_pin_hummingbird>;
-	vmmc-supply = <&vcc_wifi>;
+	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	non-removable;
@@ -173,68 +177,63 @@
 &p2wi {
 	status = "okay";
 
-	axp221: pmic at 68 {
+	axp22x: pmic at 68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		regulators {
-			x-powers,dcdc-freq = <3000>;
-
-			vcc_3v0: dcdc1 {
-				regulator-always-on;
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-name = "vcc-3v0";
-			};
-
-			vdd_gpu: dcdc2 {
-				regulator-always-on;
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1320000>;
-				regulator-name = "vdd-gpu";
-			};
-
-			vdd_cpu: dcdc3 {
-				regulator-always-on;
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <1320000>;
-				regulator-name = "vdd-cpu";
-			};
-
-			vdd_sys_dll: dcdc4 {
-				regulator-always-on;
-				regulator-min-microvolt = <1100000>;
-				regulator-max-microvolt = <1100000>;
-				regulator-name = "vdd-sys-dll";
-			};
-
-			vcc_dram: dcdc5 {
-				regulator-always-on;
-				regulator-min-microvolt = <1500000>;
-				regulator-max-microvolt = <1500000>;
-				regulator-name = "vcc-dram";
-			};
-
-			vcc_wifi: aldo1 {
-				regulator-min-microvolt = <3300000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-name = "vcc_wifi";
-			};
-
-			avcc: aldo3 {
-				regulator-always-on;
-				regulator-min-microvolt = <3000000>;
-				regulator-max-microvolt = <3000000>;
-				regulator-name = "avcc";
-			};
-		};
 	};
 };
 
+#include "axp22x.dtsi"
+
+&reg_aldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "avcc";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v0";
+};
+
+&reg_dcdc2 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-gpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc4 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-sys-dll";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 7 24 GPIO_ACTIVE_HIGH>; /* PH24 */
 	status = "okay";
-- 
2.5.3
