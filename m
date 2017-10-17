From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 11:06:28 +0200
Subject: [PATCH 21/23] arm: dts: sun8i: a711: Add regulator support
In-Reply-To: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
Message-ID: <4d3de5b4c36ea67135d898d982891a7913478d9d.1508231063.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 163 +++++++++++++++++++++--
 1 file changed, 154 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 723641f56a74..98dc0c22160b 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -43,7 +43,8 @@
 
 /dts-v1/;
 #include "sun8i-a83t.dtsi"
-#include "sunxi-common-regulators.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "TBS A711 Tablet";
@@ -105,7 +106,7 @@
 };
 
 &mmc0 {
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
@@ -117,8 +118,8 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dldo1>;
+	vqmmc-supply = <&reg_dldo1>;
 	non-removable;
 	wakeup-source;
 	status = "okay";
@@ -135,8 +136,8 @@
 &mmc2 {
 	pinctrl-0 = <&mmc2_8bit_emmc_pins>;
 	pinctrl-names = "default";
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
+	vqmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -147,10 +148,11 @@
 	status = "okay";
 
 	axp813: pmic at 3a3 {
-		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		swin-supply = <&reg_dcdc1>;
+		x-powers,drive-vbus-en;
 	};
 
 	ac100: codec at e89 {
@@ -179,6 +181,149 @@
 
 };
 
+#include "axp813.dtsi"
+
+&reg_aldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-1.8";
+};
+
+&reg_aldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-always-on;
+	regulator-name = "vdd-drampll";
+};
+
+&reg_aldo3 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-always-on;
+	regulator-name = "avcc";
+};
+
+&reg_dcdc1 {
+	regulator-min-microvolt = <3100000>;
+	regulator-max-microvolt = <3100000>;
+	regulator-always-on;
+	regulator-name = "vcc-io";
+};
+
+&reg_dcdc2 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-always-on;
+	regulator-name = "vdd-cpu-A";
+};
+
+&reg_dcdc3 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-always-on;
+	regulator-name = "vdd-cpu-B";
+};
+
+&reg_dcdc4 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-gpu";
+};
+
+&reg_dcdc5 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1500000>;
+	regulator-always-on;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dcdc6 {
+	regulator-min-microvolt = <900000>;
+	regulator-max-microvolt = <900000>;
+	regulator-always-on;
+	regulator-name = "vdd-sys";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <3100000>;
+	regulator-max-microvolt = <3100000>;
+	regulator-name = "vcc-wifi-io";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <4200000>;
+	regulator-name = "vcc-mipi";
+};
+
+&reg_dldo3 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vdd-csi";
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
+&reg_drivevbus {
+	regulator-name = "usb0-vbus";
+	status = "okay";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-csi-r";
+};
+
+&reg_eldo2 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-dsi";
+};
+
+&reg_eldo3 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "dvdd-csi-f";
+};
+
+&reg_fldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vcc-hsic";
+};
+
+&reg_fldo2 {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-always-on;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3100000>;
+	regulator-max-microvolt = <3100000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
+&reg_ldo_io1 {
+	regulator-min-microvolt = <3100000>;
+	regulator-max-microvolt = <3100000>;
+	regulator-name = "vcc-vb";
+	status = "okay";
+};
+
+&reg_sw {
+	regulator-min-microvolt = <3100000>;
+	regulator-max-microvolt = <3100000>;
+	regulator-name = "vcc-lcd";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
@@ -193,7 +338,7 @@
 };
 
 &usbphy {
-	usb1_vbus_supply = <&reg_vcc5v0>;
-	usb2_vbus_supply = <&reg_vcc5v0>;
+	usb1_vbus_supply = <&reg_vmain>;
+	usb2_vbus_supply = <&reg_vmain>;
 	status = "okay";
 };
-- 
git-series 0.9.1
