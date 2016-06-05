From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  5 Jun 2016 15:38:00 +0200
Subject: [PATCH 2/2] ARM: dts: sun6i: Add pmic / regulator nodes to Mele M9 dts
In-Reply-To: <1465133880-22921-1-git-send-email-hdegoede@redhat.com>
References: <1465133880-22921-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1465133880-22921-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pmic / regulator nodes to Mele M9 dts.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 88 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 66d29b8..2d3cd9d 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -72,6 +72,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -85,6 +89,7 @@
 	pinctrl-0 = <&gmac_pins_mii_a>;
 	phy = <&phy1>;
 	phy-mode = "mii";
+	phy-supply = <&reg_dldo1>;
 	status = "okay";
 
 	phy1: ethernet-phy at 1 {
@@ -101,13 +106,26 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
-	vmmc-supply = <&reg_vcc3v3>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 22 GPIO_ACTIVE_HIGH>; /* PH22 */
 	cd-inverted;
 	status = "okay";
 };
 
+&p2wi {
+	status = "okay";
+
+	axp22x: pmic at 68 {
+		compatible = "x-powers,axp221";
+		reg = <0x68>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "axp22x.dtsi"
+
 &pio {
 	led_pins_m9: led_pins at 0 {
 		allwinner,pins = "PH13";
@@ -131,6 +149,73 @@
 	};
 };
 
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
+&reg_dc5ldo {
+	regulator-always-on;
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpus"; /* This is an educated guess */
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
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ethernet-phy";
+};
+
+&reg_dldo4 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-usb-hub";
+};
+
 &reg_usb1_vbus {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb1_vbus_pin_m9>;
@@ -146,5 +231,6 @@
 
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_aldo1>;
 	status = "okay";
 };
-- 
2.7.4
