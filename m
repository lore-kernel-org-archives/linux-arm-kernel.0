From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 29 Sep 2017 11:25:14 +0800
Subject: [PATCH 7/7] ARM: dts: sun8i: a83t: allwinner-h8homlet-v2: Add AXP818
 regulator nodes
In-Reply-To: <20170929032514.31727-1-wens@csie.org>
References: <20170929032514.31727-1-wens@csie.org>
Message-ID: <20170929032514.31727-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device nodes for all the regulators of the AXP818 PMIC.
References to the 3V dummy regulator are replaced, and it is disabled.
The 3.3V and 5V are also disabled.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  | 126 ++++++++++++++++++++-
 1 file changed, 124 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index 1f0d60afb25b..1c7371d6bbb2 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -65,7 +65,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_HIGH>; /* PF6 */
 	bus-width = <4>;
 	cd-inverted;
@@ -75,7 +75,8 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -104,6 +105,8 @@
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+		swin-supply = <&reg_dcdc1>;
 	};
 
 	ac100: codec at e89 {
@@ -131,6 +134,125 @@
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
+	regulator-name = "vcc-mipi-3v3";
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
+	regulator-name = "vdd33-pd-ave-ephy";
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
+	regulator-name = "vcc-wifi";
+};
+
+&reg_vcc3v0 {
+	status = "disabled";
+};
+
+&reg_vcc3v3 {
+	status = "disabled";
+};
+
+&reg_vcc5v0 {
+	status = "disabled";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.14.2
