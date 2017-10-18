From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Oct 2017 16:31:34 +0800
Subject: [PATCH v2 4/8] ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813
 regulator nodes
In-Reply-To: <20171018083138.14517-1-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
Message-ID: <20171018083138.14517-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes for all the regulators of the AXP813 PMIC.
Sunxi common regulators are removed, and USB VBUS regulators are added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 141 +++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 2bafd7e99ef7..78036b2f2ab4 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -44,7 +44,6 @@
 
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
-#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 
@@ -59,6 +58,16 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb1_vbus: reg-usb1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb1-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	};
 };
 
 &ehci0 {
@@ -71,7 +80,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
 	cd-inverted;
@@ -81,7 +90,8 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -96,6 +106,10 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		fldoin-supply = <&reg_dcdc5>;
+		swin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 
 	ac100: codec at e89 {
@@ -123,17 +137,126 @@
 	};
 };
 
-&reg_usb1_vbus {
-	gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
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
+	/* schematics says 3.1V but FEX file says 3.3V */
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-3v3";
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
+};
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
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
+&reg_dldo1 {
+	/*
+	 * This powers both the WiFi/BT module's main power, I/O supply,
+	 * and external pull-ups on all the data lines. It should be set
+	 * to the same voltage as the I/O supply (DCDC1 in this case) to
+	 * avoid any leakage or mismatch.
+	 */
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vcc-pd";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
 	status = "okay";
 };
 
-&reg_vcc3v0 {
-	status = "disabled";
+&reg_fldo1 {
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
+	/*
+	 * The PHY requires 20ms after all voltages
+	 * are applied until core logic is ready and
+	 * 30ms after the reset pin is de-asserted.
+	 * Set a 100ms delay to account for PMIC
+	 * ramp time and board traces.
+	 */
+	regulator-enable-ramp-delay = <100000>;
+	regulator-name = "vcc-ephy";
 };
 
 &uart0 {
-- 
2.14.2
