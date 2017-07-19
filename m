From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 20 Jul 2017 00:10:18 +0800
Subject: [PATCH 4/5] arm64: allwinner: a64: add AXP803 regulators support for
 SoPine
In-Reply-To: <20170719161019.62133-1-icenowy@aosc.io>
References: <20170719161019.62133-1-icenowy@aosc.io>
Message-ID: <20170719161019.62133-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoPine SoM has an AXP803 PMIC chip, and the regulators of this chip
are used both on the SoM itself and the baseboard.

Add regulators nodes to the SoPine DTSI and the SoPine baseboard DT.
Regulators used by the SoM itself are added to the SoPine DTSI, and
regulators left free for the baseboard are added to the baseboard DT.

The phy-handle of the emac node in baseboard DT is also fixed, with the
same reason of the fix on Pine64 DT.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 23 ++++++++
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 69 ++++++++++++++++++++++
 2 files changed, 92 insertions(+)

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
index ab9464dd50c5..7adfd013fd60 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -74,3 +74,72 @@
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
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
+	regulator-min-microvolt = <1000000>;
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
