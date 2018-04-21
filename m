From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 17:12:50 +0200
Subject: [PATCH 22/27] arm64: dts: marvell: move AP806/CP110 thermal nodes
 into a new syscon
In-Reply-To: <20180421151255.29929-1-miquel.raynal@bootlin.com>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
Message-ID: <20180421151255.29929-23-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

New bindings impose to declare the thermal IP from within a new syscon.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 11 +++++++----
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 15 +++++++++------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 71208aba4468..b173d21f2216 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -266,10 +266,13 @@
 				};
 			};
 
-			ap_thermal: thermal at 6f808c {
-				compatible = "marvell,armada-ap806-thermal";
-				reg = <0x6f808c 0x4>,
-				      <0x6f8084 0x8>;
+			ap_syscon1: system-controller at 6f8000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x6f8000 0x1000>;
+
+				ap_thermal: ap-thermal {
+					compatible = "marvell,armada-ap806-thermal";
+				};
 			};
 		};
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 8e989c721b4c..514780980847 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -170,12 +170,6 @@
 			interrupts = <77 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		CP110_LABEL(thermal): thermal at 400078 {
-			compatible = "marvell,armada-cp110-thermal";
-			reg = <0x400078 0x4>,
-			<0x400070 0x8>;
-		};
-
 		CP110_LABEL(syscon0): system-controller at 440000 {
 			compatible = "syscon", "simple-mfd";
 			reg = <0x440000 0x2000>;
@@ -216,6 +210,15 @@
 			};
 		};
 
+		CP110_LABEL(syscon1): system-controller at 400000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0x400000 0x1000>;
+
+			CP110_LABEL(thermal): thermal at 400070 {
+				compatible = "marvell,armada-cp110-thermal";
+			};
+		};
+
 		CP110_LABEL(usb3_0): usb3 at 500000 {
 			compatible = "marvell,armada-8k-xhci",
 			"generic-xhci";
-- 
2.14.1
