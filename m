From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sun, 12 Mar 2017 19:10:01 +0000
Subject: [PATCH RFC 3/3] ARM: dts: dove: hook up etnaviv cooling device
Message-ID: <E1cn8sT-0002w9-J1@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wire up the GC600 as a cooling device for when the SoC gets hot.  The
GC600 is reportedly responsible for 20-30% of the SoC dissipation, so
reducing the GC600 clock rate should result in some cooling.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
This patch requires the patch to add the etnaviv cooling device to be
in place.

 arch/arm/boot/dts/dove.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 00f5971cd039..d86f951a7978 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -2,6 +2,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/thermal/thermal.h>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
@@ -791,6 +792,7 @@
 			};
 
 			gpu: gpu@840000 {
+				#cooling-cells = <2>;
 				clocks = <&divider_clk 1>;
 				clock-names = "core";
 				compatible = "vivante,gc";
@@ -810,12 +812,34 @@
 			thermal-sensors = <&thermal>;
 
 			soc_trips: trips {
+				soc_trip_maximum: soc-passive {
+					temperature = <95000>; /* ?mC */
+					hysteresis = <2000>; /* ?mC */
+					type = "passive";
+				};
+				soc_trip_hot: soc-hot {
+					temperature = <105000>; /* ?mC */
+					hysteresis = <2000>; /* ?mC */
+					type = "hot";
+				};
 				soc_trip_crit: soc-crit {
 					temperature = <120000>; /* ?mC */
 					hysteresis = <2000>; /* ?mC */
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				/*
+				 * Jon Nettleton says that he found the GPU
+				 * accounted for 20%-30% of heat production.
+				 */
+				gpu {
+					cooling-device =
+						<&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					trip = <&soc_trip_maximum>;
+				};
+			};
 		};
 	};
 };
-- 
2.7.4
