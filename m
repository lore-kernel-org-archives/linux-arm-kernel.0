From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 16:31:33 +0800
Subject: [PATCH v2 3/8] ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818
 regulator nodes
In-Reply-To: <20171018083138.14517-1-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
Message-ID: <20171018083138.14517-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes for all the regulators of the AXP818 PMIC.
Sunxi common regulators are removed, and USB VBUS regulators are added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 167 +++++++++++++++++++++--
 1 file changed, 155 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 716a205c6dbb..bd53e5748991 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -44,7 +44,6 @@
 
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
-#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -95,6 +94,26 @@
 		refclk-frequency = <19200000>;
 	};
 
+	reg_usb1_vbus: reg-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 3 29 GPIO_ACTIVE_HIGH>; /* PD29 */
+	};
+
+	reg_usb2_vbus: reg-usb2-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb2-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+	};
+
 	sound {
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "On-board SPDIF";
@@ -127,7 +146,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
 	cd-inverted;
@@ -137,7 +156,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -152,6 +171,9 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		swin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 
 	ac100: codec at e89 {
@@ -179,22 +201,143 @@
 	};
 };
 
-&reg_usb1_vbus {
-	gpio = <&pio 3 29 GPIO_ACTIVE_HIGH>; /* PD29 */
-	status = "okay";
+#include "axp81x.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-1v8";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dram-pll";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
+&reg_dcdc1 {
+	/*
+	 * The schematics say this should be 3.3V, but the FEX file says
+	 * it should be 3V. The latter makes sense, as the WiFi module's
+	 * I/O is indirectly powered from DCDC1, through SW. It is rated
+	 * at 2.98V maximum.
+	 */
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-3v";
+};
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-cpua";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-cpub";
+};
+
+&reg_dcdc4 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-gpu";
 };
 
-&reg_usb2_vbus {
-	gpio = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1500000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dcdc6 {
+	regulator-always-on;
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <900000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "dp-pwr";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "ephy-io";
+};
+
+&reg_dldo4 {
+	/*
+	 * The PHY requires 20ms after all voltages are applied until core
+	 * logic is ready and 30ms after the reset pin is de-asserted.
+	 * Set a 100ms delay to account for PMIC ramp time and board traces.
+	 */
+	regulator-enable-ramp-delay = <100000>;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "ephy";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
 	status = "okay";
 };
 
-&reg_vcc3v0 {
-	status = "disabled";
+&reg_eldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "dp-bridge-1";
+};
+
+&reg_eldo2 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "dp-bridge-2";
+};
+
+&reg_fldo1 {
+	/* TODO should be handled by USB PHY */
+	regulator-always-on;
+	regulator-min-microvolt = <1080000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd12-hsic";
+};
+
+&reg_fldo2 {
+	/*
+	 * Despite the embedded CPUs core not being used in any way,
+	 * this must remain on or the system will hang.
+	 */
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
 };
 
-&reg_vcc5v0 {
-	status = "disabled";
+&reg_sw {
+	regulator-name = "vcc-wifi-io";
 };
 
 &spdif {
-- 
2.14.2
