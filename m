From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 17:12:55 +0200
Subject: [PATCH 27/27] arm64: dts: marvell: add interrupt support to cp110
 thermal node
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <20180421151255.29929-28-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt properties in the thermal node as well as a critical trip
point in the thermal-zone.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 8d0fc1bfe291..06f265d61352 100644
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
@@ -177,7 +184,7 @@
 				compatible = "marvell,cp110-icu-sei";
 				#interrupt-cells = <2>;
 				interrupt-controller;
-				msi-parent = <&sei>;
+				msi-parent = <&sei_msi_controller>;
 			};
 		};
 
@@ -234,6 +241,8 @@
 
 			CP110_LABEL(thermal): thermal at 400070 {
 				compatible = "marvell,armada-cp110-thermal";
+				interrupts-extended =
+					<&CP110_LABEL(icu_sei) 116 IRQ_TYPE_LEVEL_HIGH>;
 				#thermal-sensor-cells = <1>;
 			};
 		};
-- 
2.14.1
