From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Apr 2016 09:58:33 +0200
Subject: [PATCH v3 05/11] arm64: dts: marvell: use new clock binding on Armada
 AP806
In-Reply-To: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1461657519-11939-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1461657519-11939-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit updates the Marvell AP806 Device Tree description to make
use of the accepted clock Device Tree binding.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 34 ++++++++++-----------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 9e2c1f9..38be192 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -179,7 +179,7 @@
 				#size-cells = <0>;
 				cell-index = <0>;
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 			};
 
@@ -190,7 +190,7 @@
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 			};
 
@@ -200,7 +200,7 @@
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 			};
 
@@ -210,29 +210,19 @@
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 
 			};
 
-			dfx-server at 6f8000 {
-				compatible = "simple-mfd", "syscon";
-				reg = <0x6f8000 0x70000>;
-
-				coreclk: clk at 204 {
-					compatible = "marvell,armada-ap806-core-clock";
-					#clock-cells = <1>;
-					clock-output-names = "ddr", "ring", "cpu";
-				};
-
-				ringclk: clk at 250 {
-					compatible = "marvell,armada-ap806-ring-clock";
-					#clock-cells = <1>;
-					clock-output-names = "ring-0", "ring-2",
-							     "ring-3", "ring-4",
-							     "ring-5";
-					clocks = <&coreclk 1>;
-				};
+			ap_syscon: system-controller at 6f4000 {
+				compatible = "marvell,ap806-system-controller",
+					     "syscon";
+				#clock-cells = <1>;
+				clock-output-names = "ap-cpu-cluster-0",
+						     "ap-cpu-cluster-1",
+						     "ap-fixed", "ap-mss";
+				reg = <0x6f4000 0x1000>;
 			};
 		};
 	};
-- 
2.6.4
