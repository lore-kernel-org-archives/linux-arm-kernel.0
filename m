From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Aug 2015 16:44:34 +0200
Subject: [PATCH 3/6] ARM: dts: sun7i: Add regulator configuration to the
 pcduino3 dts file
In-Reply-To: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1439563477-12295-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jelle van der Waa <jelle@vdwaa.nl>

Add regulator configuration to the pcduino3 dts file.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts | 39 ++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
index afc9ece..99e238b 100644
--- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
+++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
@@ -111,6 +111,10 @@
 	allwinner,pins = "PH2";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -137,16 +141,14 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
 	};
 };
 
+#include "axp209.dtsi"
+
 &ir0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir0_rx_pins_a>;
@@ -192,6 +194,31 @@
 	status = "okay";
 };
 
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-pll";
+};
+
+&reg_ldo1 {
+	regulator-name = "vdd-rtc";
+};
+
+&reg_ldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -206,6 +233,10 @@
 	status = "okay";
 };
 
+&usb_power_supply {
+	status = "okay";
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
-- 
2.4.3
