From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Oct 2015 00:32:22 +0800
Subject: [PATCH 6/6] ARM: dts: sun8i: sinlinx-sina33: Add AXP223 PMIC device
 and regulator nodes
In-Reply-To: <1444840342-9233-1-git-send-email-wens@csie.org>
References: <1444840342-9233-1-git-send-email-wens@csie.org>
Message-ID: <1444840342-9233-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board has a X-Powers AXP223 PMIC connected via RSB. It's regulators
provide power to various parts of the SoC and the board.

Also update the regulator supply phandles.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 79 +++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 13ce68f06dd6..91a0fde47fdd 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -68,7 +68,7 @@
 };
 
 &lradc {
-	vref-supply = <&reg_vcc3v0>;
+	vref-supply = <&reg_dcdc1>;
 	status = "okay";
 
 	button at 200 {
@@ -96,7 +96,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_sina33>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 1 4 GPIO_ACTIVE_HIGH>; /* PB4 */
 	cd-inverted;
@@ -106,7 +106,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_pins>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
@@ -132,6 +132,79 @@
 
 &r_rsb {
 	status = "okay";
+
+	axp22x: pmic at 3e3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3e3>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+	};
+};
+
+#include "axp22x.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-io";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2350000>;
+	regulator-max-microvolt = <2650000>;
+	regulator-name = "vdd-dll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2700000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pll-avcc";
+};
+
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpus";
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
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_rtc_ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-rtc";
 };
 
 &uart0 {
-- 
2.6.1
