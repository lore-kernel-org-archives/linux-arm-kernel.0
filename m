From: embed3d@gmail.com (Philipp Rossak)
Date: Fri,  9 Feb 2018 18:52:36 +0100
Subject: [PATCH 3/3] arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators
In-Reply-To: <20180209175236.21215-1-embed3d@gmail.com>
References: <20180209175236.21215-1-embed3d@gmail.com>
Message-ID: <20180209175236.21215-4-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a bootproblem with the Bananapi M2 board. Since there
are some regulators missing we add them right now. Those values come
from the schematic, below you can find a small overview:

* reg_aldo1:  3,3V, powers the wifi
* reg_aldo2:  2,5V, powers the IO of the RTL8211E
* reg_aldo3:  3,3V, powers the audio

* reg_dldo1:  3,0V, powers the RTL8211E
* reg_dldo2:  2,8V, powers the analog part of the csi
* reg_dldo3:  3,3V, powers misc
* reg_eldo1:  1,8V, powers the csi
* reg_ldo_io1:1,8V, powers the gpio

* reg_dc5ldo: needs to be always on

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 56 ++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 51e6f1d21c32..01fcfe0649ad 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -99,6 +99,7 @@
 	pinctrl-0 = <&gmac_pins_rgmii_a>, <&gmac_phy_reset_pin_bpi_m2>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
+	phy-supply = <&reg_dldo1>;
 	snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>; /* PA21 */
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 30000>;
@@ -193,7 +194,28 @@
 
 #include "axp22x.dtsi"
 
+&reg_aldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vcc-gmac";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &reg_dc5ldo {
+	regulator-always-on;
 	regulator-min-microvolt = <700000>;
 	regulator-max-microvolt = <1320000>;
 	regulator-name = "vdd-cpus";
@@ -233,6 +255,40 @@
 	regulator-name = "vcc-dram";
 };
 
+&reg_dldo1 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-mac";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pb";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd-csi";
+	status = "okay";
+};
+
+&reg_ldo_io1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pm-cpus";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.11.0
