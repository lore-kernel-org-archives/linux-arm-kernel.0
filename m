From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 11:25:12 +0800
Subject: [PATCH 5/7] ARM: dts: sun8i: a83t: cubietruck-plus: Add AXP818
 regulator nodes
In-Reply-To: <20170929032514.31727-1-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
Message-ID: <20170929032514.31727-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes for all the regulators of the AXP818 PMIC.
References to the 3.3V dummy regulator are replaced, and it is disabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 150 ++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index 716a205c6dbb..7e1b1f6ca5f4 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -127,7 +127,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
 	cd-inverted;
@@ -137,7 +137,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -152,6 +152,9 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		swin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 
 	ac100: codec at e89 {
@@ -179,6 +182,145 @@
 	};
 };
 
+#include "axp81x.dtsi"
+
+&reg_aldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc18-csi2-dsi-efuse-hdmi-d4dp";
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
+};
+
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
+	regulator-name = "vdd-sys-vdd09-usb0-hdmi";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-mipi-3v3-d4dpio";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vcc-pd-vdd25-ephy";
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
+	regulator-name = "vdd33-ephy";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd12-d4dp-1";
+};
+
+&reg_eldo2 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vdd12-d4dp-2";
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
+	regulator-name = "vcc-rtc-vdd1v8-io-vdd18-lvds";
+};
+
+&reg_sw {
+	regulator-name = "vcc-wifi-io";
+};
+
 &reg_usb1_vbus {
 	gpio = <&pio 3 29 GPIO_ACTIVE_HIGH>; /* PD29 */
 	status = "okay";
@@ -193,6 +335,10 @@
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
