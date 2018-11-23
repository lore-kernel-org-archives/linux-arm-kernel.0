From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 17:17:30 +0100
Subject: [PATCH v2 6/6] arm64: dts: marvell: add interrupt support to cp110
 thermal node
In-Reply-To: <20181123161730.11289-1-miquel.raynal@bootlin.com>
References: <20181123161730.11289-1-miquel.raynal@bootlin.com>
Message-ID: <20181123161730.11289-7-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt properties in the thermal node as well as a critical trip
point in the thermal-zone.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index b9d9f31e3ba1..4d6e4a097f72 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -28,12 +28,19 @@
 	 */
 	thermal-zones {
 		CP110_LABEL(thermal_ic): CP110_NODE_NAME(thermal-ic) {
-			polling-delay-passive = <1000>;
-			polling-delay = <1000>;
+			polling-delay-passive = <0>; /* Interrupt driven */
+			polling-delay = <0>; /* Interrupt driven */
 
 			thermal-sensors = <&CP110_LABEL(thermal) 0>;
 
-			trips {	};
+			trips {
+				CP110_LABEL(crit): crit {
+					temperature = <100000>; /* mC degrees */
+					hysteresis = <2000>; /* mC degrees */
+					type = "critical";
+				};
+			};
+
 			cooling-maps { };
 		};
 	};
@@ -259,6 +266,8 @@
 			CP110_LABEL(thermal): thermal-sensor at 70 {
 				compatible = "marvell,armada-cp110-thermal";
 				reg = <0x70 0x10>;
+				interrupts-extended =
+					<&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
 				#thermal-sensor-cells = <1>;
 			};
 		};
-- 
2.19.1
