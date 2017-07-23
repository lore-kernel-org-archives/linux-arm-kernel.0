From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 23 Jul 2017 18:27:49 +0800
Subject: [PATCH 10/10] ARM: dts: sun8i: Add SY8106A regulator to Orange Pi PC
In-Reply-To: <20170723102749.17323-1-icenowy@aosc.io>
References: <20170723102749.17323-1-icenowy@aosc.io>
Message-ID: <20170723102749.17323-11-icenowy@aosc.io>
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
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 998b60f8d295..d855f8b6254e 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -98,6 +98,10 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_sy8106a>;
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -160,6 +164,21 @@
 	};
 };
 
+&r_i2c {
+	status = "okay";
+
+	reg_sy8106a: regulator at 65 {
+		compatible = "silergy,sy8106a";
+		reg = <0x65>;
+		regulator-name = "vdd-cpux";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1400000>;
+		regulator-ramp-delay = <200>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
+
 &r_pio {
 	leds_r_opc: led_pins at 0 {
 		pins = "PL10";
-- 
2.13.0
