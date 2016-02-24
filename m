From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Feb 2016 16:16:46 +0100
Subject: [PATCH 2/3] arm64: marvell: update Armada AP806 clock description
In-Reply-To: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1456327007-31008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1456327007-31008-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following the review from the DT maintainers, the DT binding for the
clocks has changed, and we now use a DFX server node exposing a
syscon, with the clock nodes being subnodes of the DFX server
node. This commit therefore updates the AP806 Device Tree file to use
this new DT binding.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 37 +++++++++++++++------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 63f25ce..88e3348 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -179,23 +179,6 @@
 
 			};
 
-			coreclk: clk at 0x6F8204 {
-				compatible = "marvell,armada-ap806-core-clock";
-				reg = <0x6F8204 0x04>;
-				#clock-cells = <1>;
-				clock-output-names = "ddr", "ring", "cpu";
-			};
-
-			ringclk: clk at 0x6F8250 {
-				compatible = "marvell,armada-ap806-ring-clock";
-				reg = <0x6F8250 0x04>;
-				#clock-cells = <1>;
-				clock-output-names = "ring-0", "ring-2",
-						     "ring-3", "ring-4",
-						     "ring-5";
-				clocks = <&coreclk 1>;
-			};
-
 			xor0 at 400000 {
 				compatible = "marvell,mv-xor-v2";
 				reg = <0x400000 0x1000>,
@@ -227,6 +210,26 @@
 				msi-parent = <&gic_v2m0>;
 				dma-coherent;
 			};
+
+			dfx-server at 6f8000 {
+				compatible = "simple-mfd", "syscon";
+				reg = <0x6f8000 0x70000>;
+
+				coreclk: clk at 204 {
+					compatible = "marvell,armada-ap806-core-clock";
+					#clock-cells = <1>;
+					clock-output-names = "ddr", "ring", "cpu";
+				};
+
+				ringclk: clk at 250 {
+					compatible = "marvell,armada-ap806-ring-clock";
+					#clock-cells = <1>;
+					clock-output-names = "ring-0", "ring-2",
+							     "ring-3", "ring-4",
+							     "ring-5";
+					clocks = <&coreclk 1>;
+				};
+			};
 		};
 	};
 
-- 
2.6.4
