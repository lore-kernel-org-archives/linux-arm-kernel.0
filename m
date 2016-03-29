From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 29 Mar 2016 17:22:30 +0800
Subject: [PATCH resend v2 7/9] ARM: dts: sun9i: cubieboard4: Add AXP809 PMIC
 device node and regulators
In-Reply-To: <1459243352-23344-1-git-send-email-wens@csie.org>
References: <1459243352-23344-1-git-send-email-wens@csie.org>
Message-ID: <1459243352-23344-8-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP809 PMIC is the primary PMIC. It provides various supply voltages
for the SoC and other peripherals. The PMIC's interrupt line is connected
to NMI pin of the SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 131 +++++++++++++++++++++++++++-
 1 file changed, 129 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index eb2ccd0a3bd5..8d8af1189d87 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -98,7 +98,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>, <&mmc0_cd_pin_cubieboard4>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH18 */
 	cd-inverted;
@@ -108,7 +108,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_8bit_pins>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <8>;
 	non-removable;
 	cap-mmc-hw-reset;
@@ -126,8 +126,135 @@
 
 &r_rsb {
 	status = "okay";
+
+	axp809: pmic at 3a3 {
+		reg = <0x3a3>;
+		interrupt-parent = <&nmi_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+
+		regulators {
+			reg_aldo1: aldo1 {
+				/*
+				 * TODO: This should be handled by the
+				 * USB PHY driver.
+				 */
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc33-usbh";
+			};
+
+			reg_aldo2: aldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pb-io-cam";
+			};
+
+			aldo3 {
+				/* unused */
+			};
+
+			reg_dc5ldo: dc5ldo {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpus-09-usbh";
+			};
+
+			reg_dcdc1: dcdc1 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-3v";
+			};
+
+			reg_dcdc2: dcdc2 {
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-gpu";
+			};
+
+			reg_dcdc3: dcdc3 {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-cpua";
+			};
+
+			reg_dcdc4: dcdc4 {
+				regulator-always-on;
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <1100000>;
+				regulator-name = "vdd-sys-usb0-hdmi";
+			};
+
+			reg_dcdc5: dcdc5 {
+				regulator-always-on;
+				regulator-min-microvolt = <1425000>;
+				regulator-max-microvolt = <1575000>;
+				regulator-name = "vcc-dram";
+			};
+
+			reg_dldo1: dldo1 {
+				/*
+				 * The WiFi chip supports a wide range
+				 * (3.0 ~ 4.8V) of voltages, and so does
+				 * this regulator (3.0 ~ 4.2V), but
+				 * Allwinner SDK always sets it to 3.3V.
+				 */
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc-wifi";
+			};
+
+			reg_dldo2: dldo2 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-pl";
+			};
+
+			reg_eldo1: eldo1 {
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc-dvdd-cam";
+			};
+
+			reg_eldo2: eldo2 {
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc-pe";
+			};
+
+			reg_eldo3: eldo3 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-pm-codec-io1";
+			};
+
+			reg_ldo_io0: ldo_io0 {
+				regulator-always-on;
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3000000>;
+				regulator-name = "vcc-pg";
+			};
+
+			reg_ldo_io1: ldo_io1 {
+				regulator-min-microvolt = <2500000>;
+				regulator-max-microvolt = <2500000>;
+				regulator-name = "vcc-pa-gmac-2v5";
+			};
+
+			reg_rtc_ldo: rtc_ldo {
+				regulator-name = "vcc-rtc-vdd1v8-io";
+			};
+		};
+	};
 };
 
+#include "axp809.dtsi"
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.7.0
