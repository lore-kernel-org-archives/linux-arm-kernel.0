From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Mar 2016 08:39:36 +0100
Subject: [PATCH 1/2] ARM: dts: sun8i: Add pmic nodes to sun8i-a23-gt90h-v4
Message-ID: <1457854777-15825-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the axp223 pmic and its regulators as found on
a23-gt90h-v4 tablets.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts | 89 ++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
index 1aeb06c..6a22ee3 100644
--- a/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
+++ b/arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts
@@ -123,12 +123,100 @@
 	};
 };
 
+&r_rsb {
+	status = "okay";
+
+	axp22x: pmic at 3a3 {
+		compatible = "x-powers,axp223";
+		reg = <0x3a3>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		eldoin-supply = <&reg_dcdc1>;
+	};
+};
+
 &r_uart {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_uart_pins_a>;
 	status = "okay";
 };
 
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
+&reg_dc1sw {
+	regulator-name = "vcc-lcd";
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
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
+
+&simplefb_lcd {
+	vcc-lcd-supply = <&reg_dc1sw>;
+};
+
 /*
  * FIXME for now we only support host mode and rely on u-boot to have
  * turned on Vbus which is controlled by the axp223 pmic on the board.
@@ -141,5 +229,6 @@
 };
 
 &usbphy {
+	usb1_vbus-supply = <&reg_dldo1>;
 	status = "okay";
 };
-- 
2.7.2
