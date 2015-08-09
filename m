From: oliver@schinagl.nl (Olliver Schinagl)
Date: Sun,  9 Aug 2015 21:02:48 +0200
Subject: [PATCH] ARM: dts: sunxi: enable otg port on the
 sun7i-a20-olinuxino-lime2
In-Reply-To: <1439146968-9039-1-git-send-email-oliver@schinagl.nl>
References: <1439146968-9039-1-git-send-email-oliver@schinagl.nl>
Message-ID: <1439146968-9039-2-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olliver Schinagl <o.schinagl@ultimaker.com>

This patch enables the musb-otg USB controller on the Lime2. The Lime2
differs from the Lime1 series in pins used for usb0 power.

Tested on a OlinuXino Lime2-4GB.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 131 ++++++++++++++----------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 22cd052..efd9ebb 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -71,14 +71,6 @@
 			default-state = "on";
 		};
 	};
-
-	reg_axp_ipsout: axp_ipsout {
-		compatible = "regulator-fixed";
-		regulator-name = "axp-ipsout";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		regulator-always-on;
-	};
 };
 
 &ahci {
@@ -86,6 +78,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -112,57 +108,9 @@
 	status = "okay";
 
 	axp209: pmic at 34 {
-		compatible = "x-powers,axp209";
 		reg = <0x34>;
 		interrupt-parent = <&nmi_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-
-		interrupt-controller;
-		#interrupt-cells = <1>;
-
-		acin-supply = <&reg_axp_ipsout>;
-		vin2-supply = <&reg_axp_ipsout>;
-		vin3-supply = <&reg_axp_ipsout>;
-		ldo24in-supply = <&reg_axp_ipsout>;
-		ldo3in-supply = <&reg_axp_ipsout>;
-
-		regulators {
-			vdd_rtc: ldo1 {
-				regulator-min-microvolt = <1300000>;
-				regulator-max-microvolt = <1300000>;
-				regulator-always-on;
-			};
-
-			avcc: ldo2 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vcc_csi0: ldo3 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-always-on;
-			};
-
-			vcc_csi1: ldo4 {
-				regulator-min-microvolt = <1250000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-always-on;
-			};
-
-			vdd_cpu: dcdc2 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <2275000>;
-				regulator-always-on;
-			};
-
-			vdd_int: dcdc3 {
-				regulator-min-microvolt = <700000>;
-				regulator-max-microvolt = <3500000>;
-				regulator-always-on;
-			};
-		};
 	};
 };
 
@@ -196,6 +144,10 @@
 	status = "okay";
 };
 
+&otg_sram {
+	status = "okay";
+};
+
 &pio {
 	ahci_pwr_pin_olinuxinolime: ahci_pwr_pin at 1 {
 		allwinner,pins = "PC3";
@@ -210,6 +162,27 @@
 		allwinner,drive = <SUN4I_PINCTRL_20_MA>;
 		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
+
+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
+		allwinner,pins = "PH4";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
+	};
+
+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
+		allwinner,pins = "PH5";
+		allwinner,function = "gpio_in";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
+	};
+
+	usb0_vbus_pin_lime2: usb0_vbus_pin at 0 {
+		allwinner,pins = "PC17";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 };
 
 &reg_ahci_5v {
@@ -218,6 +191,42 @@
 	status = "okay";
 };
 
+#include "axp209.dtsi"
+
+&reg_dcdc2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1450000>;
+	regulator-name = "vdd-cpu";
+};
+
+&reg_dcdc3 {
+	regulator-always-on;
+	regulator-min-microvolt = <1000000>;
+	regulator-max-microvolt = <1400000>;
+	regulator-name = "vdd-int-dll";
+};
+
+&reg_ldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1300000>;
+	regulator-max-microvolt = <1300000>;
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
+&reg_usb0_vbus {
+	pinctrl-0 = <&usb0_vbus_pin_lime2>;
+	gpio = <&pio 2 17 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+
 &reg_usb1_vbus {
 	status = "okay";
 };
@@ -232,7 +241,17 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_id_detect_pin>, <&usb0_vbus_detect_pin>;
+	usb0_id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
+	usb0_vbus_det-gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
 	status = "okay";
-- 
2.1.4
