From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  7 May 2018 20:29:42 +0800
Subject: [PATCH v4 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to Orange
 Pi PC
In-Reply-To: <20180507122942.25758-1-icenowy@aosc.io>
References: <20180507122942.25758-1-icenowy@aosc.io>
Message-ID: <20180507122942.25758-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
Orange Pi PC, then set the power supply of the ARM cores to this
regulator, in order to enable DVFS.

Signed-off-by: Ondrej Jirman <megous@megous.com>
[Icenowy: Enable DVFS in this patch, slight changes and change commit
 message]
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
[wens at csie.org: Rename regulator label]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
No changes in v4.

Changes in v3:
- Renamed regulator label (by Chen-Yu Tsai).
- Added the fixed mode voltage number.

Changes in v2:
- Reduce maximum voltage to 1.3V.
- Slightly changed the comment at 1.0V minimum voltage for taking BSP
  DVFS table instead of Armbian one.

 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index cea4d647ecbf..46240334128f 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -113,6 +113,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -182,6 +186,30 @@
 	};
 };
 
+&r_i2c {
+	status = "okay";
+
+	reg_vdd_cpux: regulator at 65 {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "vdd-cpux";
+		silergy,fixed-microvolt = <1200000>;
+		/*
+		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
+		 * however both the Armbian DVFS table and the official one
+		 * have operating points with voltage under 1.1V, and both
+		 * DVFS table are known to work properly at the lowest
+		 * operating point.
+		 *
+		 * Use 1.0V as the minimum voltage instead.
+		 */
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &r_pio {
 	leds_r_opc: led_pins {
 		pins = "PL10";
-- 
2.17.0
