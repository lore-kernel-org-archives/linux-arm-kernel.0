From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 23 Feb 2017 07:55:39 +0100
Subject: [PATCH] ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2
Message-ID: <20170223065539.47985-1-manu@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the needed node for DFVS on Sinovoip BPI-M2.
This add the axp221 under the p2wi node, the regulators and
the cpu-supply property for cpu0.

Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts | 57 ++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index db7fa13f5425..48cf5eb1f042 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -86,6 +86,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc3>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -151,6 +155,17 @@
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
 &pio {
 	gmac_phy_reset_pin_bpi_m2: gmac_phy_reset_pin at 0 {
 		allwinner,pins = "PA21";
@@ -183,6 +198,48 @@
 	};
 };
 
+#include "axp22x.dtsi"
+
+&reg_dc5ldo {
+	regulator-min-microvolt = <700000>;
+	regulator-max-microvolt = <1320000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_dcdc1 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vdd-3v0";
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
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.11.0
