From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat, 22 Jul 2017 10:18:43 +0800
Subject: [PATCH v2 2/2] arm64: allwinner: a64: add AXP803 PMIC support to
 SoPine and the baseboard
In-Reply-To: <20170722021843.6768-1-icenowy@aosc.io>
References: <20170722021843.6768-1-icenowy@aosc.io>
Message-ID: <20170722021843.6768-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoPine SoM has an AXP803 PMIC connected to the RSB bus of the A64
SoC, and the regulators of the PMIC are used both on the SoM itself and
on the official baseboard

Add related device tree parts to the SoPine SoM DTSI file and the
baseboard DT.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Squashed AXP803 enabling patch and AXP803 regulators patch together.
- Change the min voltage of vdd-cpux to 1.04V.
- Added constraints for FLDO1 (vcc-1v2-hsic), as it's connected to the SoC
  (although HSIC function is not used).

 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 23 ++++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 86 ++++++++++++++++++++++
 2 files changed, 109 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 17eb1cc5bf6b..834a5d249bb2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -81,6 +81,7 @@
 	pinctrl-0 = <&rgmii_pins>;
 	phy-mode = "rgmii";
 	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_dc1sw>;
 	status = "okay";
 };
 
@@ -110,6 +111,28 @@
 	status = "okay";
 };
 
+&reg_dc1sw {
+	regulator-name = "vcc-phy";
+};
+
+&reg_dldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-hdmi";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-mipi";
+};
+
+&reg_dldo4 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 475518b031dd..a5da18a6f286 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -63,3 +63,89 @@
 	bus-width = <4>;
 	status = "okay";
 };
+
+&r_rsb {
+	status = "okay";
+
+	axp803: pmic at 3a3 {
+		compatible = "x-powers,axp803";
+		reg = <0x3a3>;
+		interrupt-parent = <&r_intc>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
+#include "axp803.dtsi"
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pl";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-pll-avcc";
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
+	regulator-min-microvolt = <1040000>;
+	regulator-max-microvolt = <1300000>;
+	regulator-name = "vdd-cpux";
+};
+
+/* DCDC3 is polyphased with DCDC2 */
+
+&reg_dcdc5 {
+	regulator-always-on;
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vcc-dram";
+};
+
+&reg_dcdc6 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-sys";
+};
+
+&reg_eldo1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd-1v8-lpddr";
+};
+
+&reg_fldo1 {
+	regulator-min-microvolt = <1200000>;
+	regulator-max-microvolt = <1200000>;
+	regulator-name = "vcc-1v2-hsic";
+};
+
+/*
+ * The A64 chip cannot work without this regulator off, although
+ * it seems to be only driving the AR100 core.
+ * Maybe we don't still know well about CPUs domain.
+ */
+&reg_fldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <1100000>;
+	regulator-max-microvolt = <1100000>;
+	regulator-name = "vdd-cpus";
+};
+
+&reg_rtc_ldo {
+	regulator-name = "vcc-rtc";
+};
-- 
2.13.0
