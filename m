From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 12 Jun 2016 13:07:00 +0200
Subject: [PATCH v3 1/2] ARM: dts: sun6i: Add pmic / regulator nodes to Mele
 A1000G quad dts
Message-ID: <1465729621-27378-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pmic / regulator nodes to Mele A1000G quad dts.

Note both reg_usb1_vbus and reg_dldo4 need to be on for the hub attached
to usb1 to work, and we can list only one usb1_vbus-supply, so dldo4 is
marked as regulator-always-on.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Add a bit to the commit msg explaining why dldo4 is marked regulator-always-on
Changes in v3:
-Also add a comment explaining why dldo4 is marked regulator-always-on
---
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts | 93 +++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index e063dab..5faeae4 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
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
@@ -131,6 +149,78 @@
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
+/*
+ * Both reg_usb1_vbus and reg_dldo4 need to be on for the hub attached
+ * to usb1 to work, and we can list only one usb1_vbus-supply, so dldo4 is
+ * marked as regulator-always-on.
+ */
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
@@ -151,5 +241,6 @@
 
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
+	usb2_vbus-supply = <&reg_aldo1>;
 	status = "okay";
 };
-- 
2.7.4
