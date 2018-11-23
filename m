From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 17:17:29 +0100
Subject: [PATCH v2 5/6] arm64: dts: marvell: add interrupt support to ap806
 thermal node
In-Reply-To: <20181123161730.11289-1-miquel.raynal@bootlin.com>
References: <20181123161730.11289-1-miquel.raynal@bootlin.com>
Message-ID: <20181123161730.11289-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt properties in the thermal node as well as a critical trip
point in the thermal-zone.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 073610ac0a53..70b244a4c4c2 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -293,6 +293,8 @@
 				ap_thermal: thermal-sensor at 80 {
 					compatible = "marvell,armada-ap806-thermal";
 					reg = <0x80 0x10>;
+					interrupt-parent = <&sei>;
+					interrupts = <18>;
 					#thermal-sensor-cells = <1>;
 				};
 			};
@@ -303,16 +305,26 @@
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
2.19.1
