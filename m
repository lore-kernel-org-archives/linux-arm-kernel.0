From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 17:55:25 +0200
Subject: [PATCH 7/7] arm64: dts: marvell: use new binding for the system
 controller on cp110
In-Reply-To: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
References: <cover.737145f06ff0191d1a9210bcd141e679bf45fe5f.1495208533.git-series.gregory.clement@free-electrons.com>
Message-ID: <4139fcd6c66df1c3d3fa0a0a7cf7f8a8c601a16c.1495208533.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new binding for the system controller on cp110 moved the clock
controller into a subnode. This preliminary step will allow to add gpio
and pinctrl subnodes.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi | 41 ++++++-------
 arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi  | 35 +++++------
 2 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
index a0f57a8e5dcb..96a4ff75b3b0 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-master.dtsi
@@ -62,7 +62,7 @@
 			cpm_ethernet: ethernet at 0 {
 				compatible = "marvell,armada-7k-pp22";
 				reg = <0x0 0x100000>, <0x129000 0xb000>;
-				clocks = <&cpm_syscon0 1 3>, <&cpm_syscon0 1 9>, <&cpm_syscon0 1 5>;
+				clocks = <&cpm_clk 1 3>, <&cpm_clk 1 9>, <&cpm_clk 1 5>;
 				clock-names = "pp_clk", "gop_clk", "mg_clk";
 				status = "disabled";
 				dma-coherent;
@@ -97,10 +97,13 @@
 			};
 
 			cpm_syscon0: system-controller at 440000 {
-				compatible = "marvell,cp110-system-controller0",
-					     "syscon";
+				compatible = "syscon", "simple-mfd";
 				reg = <0x440000 0x1000>;
-				#clock-cells = <2>;
+
+				cpm_clk: clock {
+					compatible = "marvell,cp110-clock";
+					#clock-cells = <2>;
+				};
 			};
 
 			cpm_rtc: rtc at 284000 {
@@ -115,7 +118,7 @@
 					     "generic-ahci";
 				reg = <0x540000 0x30000>;
 				interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_syscon0 1 15>;
+				clocks = <&cpm_clk 1 15>;
 				status = "disabled";
 			};
 
@@ -125,7 +128,7 @@
 				reg = <0x500000 0x4000>;
 				dma-coherent;
 				interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_syscon0 1 22>;
+				clocks = <&cpm_clk 1 22>;
 				status = "disabled";
 			};
 
@@ -135,7 +138,7 @@
 				reg = <0x510000 0x4000>;
 				dma-coherent;
 				interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_syscon0 1 23>;
+				clocks = <&cpm_clk 1 23>;
 				status = "disabled";
 			};
 
@@ -145,7 +148,7 @@
 				      <0x6b0000 0x1000>;
 				dma-coherent;
 				msi-parent = <&gic_v2m0>;
-				clocks = <&cpm_syscon0 1 8>;
+				clocks = <&cpm_clk 1 8>;
 			};
 
 			cpm_xor1: xor at 6c0000 {
@@ -154,7 +157,7 @@
 				      <0x6d0000 0x1000>;
 				dma-coherent;
 				msi-parent = <&gic_v2m0>;
-				clocks = <&cpm_syscon0 1 7>;
+				clocks = <&cpm_clk 1 7>;
 			};
 
 			cpm_spi0: spi at 700600 {
@@ -163,7 +166,7 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
 				cell-index = <1>;
-				clocks = <&cpm_syscon0 1 21>;
+				clocks = <&cpm_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -173,7 +176,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				cell-index = <2>;
-				clocks = <&cpm_syscon0 1 21>;
+				clocks = <&cpm_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -183,7 +186,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_syscon0 1 21>;
+				clocks = <&cpm_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -193,7 +196,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_syscon0 1 21>;
+				clocks = <&cpm_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -201,7 +204,7 @@
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
 				interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cpm_syscon0 1 25>;
+				clocks = <&cpm_clk 1 25>;
 				status = "okay";
 			};
 
@@ -210,7 +213,7 @@
 				reg = <0x780000 0x300>;
 				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "core";
-				clocks = <&cpm_syscon0 1 4>;
+				clocks = <&cpm_clk 1 4>;
 				dma-coherent;
 				status = "disabled";
 			};
@@ -227,7 +230,7 @@
 					     <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-names = "mem", "ring0", "ring1",
 				"ring2", "ring3", "eip";
-				clocks = <&cpm_syscon0 1 26>;
+				clocks = <&cpm_clk 1 26>;
 				status = "disabled";
 			};
 		};
@@ -254,7 +257,7 @@
 			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			num-lanes = <1>;
-			clocks = <&cpm_syscon0 1 13>;
+			clocks = <&cpm_clk 1 13>;
 			status = "disabled";
 		};
 
@@ -281,7 +284,7 @@
 			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
-			clocks = <&cpm_syscon0 1 11>;
+			clocks = <&cpm_clk 1 11>;
 			status = "disabled";
 		};
 
@@ -308,7 +311,7 @@
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
-			clocks = <&cpm_syscon0 1 12>;
+			clocks = <&cpm_clk 1 12>;
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
index 9584bc8d8b3f..48a658aa5b32 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110-slave.dtsi
@@ -104,10 +104,13 @@
 			};
 
 			cps_syscon0: system-controller at 440000 {
-				compatible = "marvell,cp110-system-controller0",
-					     "syscon";
+				compatible = "syscon", "simple-mfd";
 				reg = <0x440000 0x1000>;
-				#clock-cells = <2>;
+
+				cps_clk: clock {
+					compatible = "marvell,cp110-clock";
+					#clock-cells = <2>;
+				};
 			};
 
 			cps_sata0: sata at 540000 {
@@ -115,7 +118,7 @@
 					     "generic-ahci";
 				reg = <0x540000 0x30000>;
 				interrupts = <GIC_SPI 287 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_syscon0 1 15>;
+				clocks = <&cps_clk 1 15>;
 				status = "disabled";
 			};
 
@@ -125,7 +128,7 @@
 				reg = <0x500000 0x4000>;
 				dma-coherent;
 				interrupts = <GIC_SPI 286 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_syscon0 1 22>;
+				clocks = <&cps_clk 1 22>;
 				status = "disabled";
 			};
 
@@ -135,7 +138,7 @@
 				reg = <0x510000 0x4000>;
 				dma-coherent;
 				interrupts = <GIC_SPI 285 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_syscon0 1 23>;
+				clocks = <&cps_clk 1 23>;
 				status = "disabled";
 			};
 
@@ -145,7 +148,7 @@
 				      <0x6b0000 0x1000>;
 				dma-coherent;
 				msi-parent = <&gic_v2m0>;
-				clocks = <&cps_syscon0 1 8>;
+				clocks = <&cps_clk 1 8>;
 			};
 
 			cps_xor1: xor at 6c0000 {
@@ -154,7 +157,7 @@
 				      <0x6d0000 0x1000>;
 				dma-coherent;
 				msi-parent = <&gic_v2m0>;
-				clocks = <&cps_syscon0 1 7>;
+				clocks = <&cps_clk 1 7>;
 			};
 
 			cps_spi0: spi at 700600 {
@@ -163,7 +166,7 @@
 				#address-cells = <0x1>;
 				#size-cells = <0x0>;
 				cell-index = <3>;
-				clocks = <&cps_syscon0 1 21>;
+				clocks = <&cps_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -173,7 +176,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				cell-index = <4>;
-				clocks = <&cps_syscon0 1 21>;
+				clocks = <&cps_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -183,7 +186,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 310 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_syscon0 1 21>;
+				clocks = <&cps_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -193,7 +196,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 311 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_syscon0 1 21>;
+				clocks = <&cps_clk 1 21>;
 				status = "disabled";
 			};
 
@@ -201,7 +204,7 @@
 				compatible = "marvell,armada-8k-rng", "inside-secure,safexcel-eip76";
 				reg = <0x760000 0x7d>;
 				interrupts = <GIC_SPI 312 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&cps_syscon0 1 25>;
+				clocks = <&cps_clk 1 25>;
 				status = "okay";
 			};
 
@@ -244,7 +247,7 @@
 			interrupt-map = <0 0 0 0 &gic 0 GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
 			num-lanes = <1>;
-			clocks = <&cps_syscon0 1 13>;
+			clocks = <&cps_clk 1 13>;
 			status = "disabled";
 		};
 
@@ -271,7 +274,7 @@
 			interrupts = <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
-			clocks = <&cps_syscon0 1 11>;
+			clocks = <&cps_clk 1 11>;
 			status = "disabled";
 		};
 
@@ -298,7 +301,7 @@
 			interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>;
 
 			num-lanes = <1>;
-			clocks = <&cps_syscon0 1 12>;
+			clocks = <&cps_clk 1 12>;
 			status = "disabled";
 		};
 	};
-- 
git-series 0.9.1
