From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 11:25:13 +0800
Subject: [PATCH 6/7] ARM: dts: sun8i: a83t: bananapi-m3: Add AXP813 regulator
 nodes
In-Reply-To: <20170929032514.31727-1-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
Message-ID: <20170929032514.31727-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes for all the regulators of the AXP813 PMIC.
References to the 3.3V dummy regulator are replaced, and it is disabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 134 ++++++++++++++++++++++++++-
 1 file changed, 132 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 2bafd7e99ef7..c7dae2e5a668 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -71,7 +71,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
 	cd-inverted;
@@ -81,7 +81,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -96,6 +96,10 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		fldoin-supply = <&reg_dcdc5>;
+		swin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 
 	ac100: codec at e89 {
@@ -123,6 +127,128 @@
 	};
 };
 
+#include "axp81x.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc18-csi2-dsi-efuse-hdmi";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd-drampll-vcc18-pll-adc-cpvdd-ldoin";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-pl-avcc";
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
+	regulator-name = "vdd-sys-vdd09-usb0-hdmi";
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
+	status = "okay";
+};
+
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
+	regulator-name = "vcc-rtc-vdd1v8-io-vdd18-lvds";
+};
+
+&reg_sw {
+	/*
+	 * The PHY requires 20ms after all voltages
+	 * are applied until core logic is ready and
+	 * 30ms after the reset pin is de-asserted.
+	 * Set a 100ms delay to account for PMIC
+	 * ramp time and board traces.
+	 */
+	regulator-enable-ramp-delay = <100000>;
+	regulator-name = "vcc-gmac";
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	status = "okay";
@@ -132,6 +258,10 @@
 	status = "disabled";
 };
 
+&reg_vcc3v3 {
+	status = "disabled";
+};
+
 &reg_vcc5v0 {
 	status = "disabled";
 };
-- 
2.14.2
