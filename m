From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 17:12:54 +0200
Subject: [PATCH 26/27] arm64: dts: marvell: add interrupt support to ap806
 thermal node
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <20180421151255.29929-27-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt properties in the thermal node as well as a critical trip
point in the thermal-zone.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index a6fee3ccbc11..d5a7448896b2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -273,6 +273,8 @@
 
 				ap_thermal: ap-thermal {
 					compatible = "marvell,armada-ap806-thermal";
+					interrupt-parent = <&sei_wired_controller>;
+					interrupts = <18>;
 					#thermal-sensor-cells = <1>;
 				};
 			};
@@ -283,16 +285,26 @@
 	 * The thermal IP features one internal sensor plus, if applicable, one
 	 * remote channel wired to one sensor per CPU.
 	 *
+	 * Only one thermal zone per AP/CP may trigger interrupts at a time, the
+	 * first one that will have a critical trip point will be chosen.
+	 *
 	 * The cooling maps are always empty as there are no cooling devices.
 	 */
 	thermal-zones {
 		ap_thermal_ic: ap-thermal-ic {
-			polling-delay-passive = <1000>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>; /* Interrupt driven */
+			polling-delay = <0>; /* Interrupt driven */
 
 			thermal-sensors = <&ap_thermal 0>;
 
-			trips {	};
+			trips {
+				ap_crit: ap-crit {
+					temperature = <100000>; /* mC degrees */
+					hysteresis = <2000>; /* mC degrees */
+					type = "critical";
+				};
+			};
+
 			cooling-maps { };
 		};
 
-- 
2.14.1
