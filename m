From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 27 Mar 2016 11:40:34 +0200
Subject: [PATCH 2/4] arm64: dts: marvell: use new clock binding on Armada AP806
In-Reply-To: <1459071636-27687-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1459071636-27687-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1459071636-27687-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 34 ++++++++-------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 556a92b..e5da7bd 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -175,7 +175,7 @@
 				#size-cells = <0>;
 				cell-index = <0>;
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 			};
 
@@ -186,7 +186,7 @@
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 			};
 
@@ -196,7 +196,7 @@
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
-				clocks = <&ringclk 2>;
+				clocks = <&ap_syscon 3>;
 				status = "disabled";
 			};
 
@@ -206,32 +206,18 @@
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
+				compatible = "marvell,ap806-system-controller", "syscon";
+				#clock-cells = <1>;
+				clock-output-names = "ap-cpu-cluster-0", "ap-cpu-cluster-1",
+						     "ap-fixed", "ap-mss";
+				reg = <0x6f4000 0x1000>;
 			};
 		};
 	};
-
 };
-
-- 
2.6.4
