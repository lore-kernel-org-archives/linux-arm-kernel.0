From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:56 +0900
Subject: [PATCH 07/19] ARM: dts: r8a7790: enable to use thermal-zone
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <a8b805f3606f7af7f2b44763d3d6cf05f7c15afd.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch enables to use thermal-zone on r8a7790.
This thermal sensor can measure temperature from -40000 to 125000,
but over 117000 can be critical on this chip.
Thus, default critical temperature is now set as 115000 (this driver
is using 5000 steps) (Current critical temperature is using it as
90000, but there is no big reason about it)

And it doesn't check thermal zone periodically (same as current
behavior). You can exchange it by modifying polling-delay[-passive]
property.

You can set trip temp if your kernel has CONFIG_THERMAL_WRITABLE_TRIPS,
but you need to take care to use it, since it will call
orderly_poweroff() it it reaches to the value.
echo $temp > /sys/class/thermal/thermal_zone0/trip_point_0_temp

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 76ddf5c6cca7..24b773ae133a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -112,6 +112,25 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive	= <0>;
+			polling-delay		= <0>;
+
+			thermal-sensors = <&thermal>;
+
+			trips {
+				cpu-crit {
+					temperature	= <115000>;
+					hysteresis	= <0>;
+					type		= "critical";
+				};
+			};
+			cooling-maps {
+			};
+		};
+	};
+
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,gic-400";
 		#interrupt-cells = <3>;
@@ -202,12 +221,15 @@
 		power-domains = <&cpg_clocks>;
 	};
 
-	thermal at e61f0000 {
-		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
+	thermal: thermal at e61f0000 {
+		compatible =	"renesas,thermal-r8a7790",
+				"renesas,rcar-gen2-thermal",
+				"renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
 		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
 		power-domains = <&cpg_clocks>;
+		#thermal-sensor-cells = <0>;
 	};
 
 	timer {
-- 
2.7.0.rc3.207.g0ac5344
