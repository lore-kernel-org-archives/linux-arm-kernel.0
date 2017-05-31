From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 31 May 2017 16:07:28 +0200
Subject: [PATCH v2 7/7] arm64: dts: marvell: use new binding for the system
 controller on ap806
In-Reply-To: <cover.21754b3184e2122d1c83a664477ed26ec562b3e9.1496239589.git-series.gregory.clement@free-electrons.com>
References: <cover.21754b3184e2122d1c83a664477ed26ec562b3e9.1496239589.git-series.gregory.clement@free-electrons.com>
Message-ID: <e12e9b027462646e16cb51783d6e14660a019ba6.1496239589.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new binding for the system controller on ap806 moved the clock into a
subnode. This preliminary step will allow to add gpio and pinctrl
subnodes

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index 0c25ec62a2a3..205037e3e7dc 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -193,7 +193,7 @@
 				#size-cells = <0>;
 				cell-index = <0>;
 				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&ap_syscon 3>;
+				clocks = <&ap_clk 3>;
 				status = "disabled";
 			};
 
@@ -204,7 +204,7 @@
 				#size-cells = <0>;
 				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
 				timeout-ms = <1000>;
-				clocks = <&ap_syscon 3>;
+				clocks = <&ap_clk 3>;
 				status = "disabled";
 			};
 
@@ -214,7 +214,7 @@
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
-				clocks = <&ap_syscon 3>;
+				clocks = <&ap_clk 3>;
 				status = "disabled";
 			};
 
@@ -224,7 +224,7 @@
 				reg-shift = <2>;
 				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				reg-io-width = <1>;
-				clocks = <&ap_syscon 3>;
+				clocks = <&ap_clk 3>;
 				status = "disabled";
 
 			};
@@ -234,17 +234,20 @@
 				reg = <0x6e0000 0x300>;
 				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 				clock-names = "core";
-				clocks = <&ap_syscon 4>;
+				clocks = <&ap_clk 4>;
 				dma-coherent;
 				marvell,xenon-phy-slow-mode;
 				status = "disabled";
 			};
 
 			ap_syscon: system-controller at 6f4000 {
-				compatible = "marvell,ap806-system-controller",
-					     "syscon";
-				#clock-cells = <1>;
+				compatible = "syscon", "simple-mfd";
 				reg = <0x6f4000 0x1000>;
+
+				ap_clk: clock {
+					compatible = "marvell,ap806-clock";
+					#clock-cells = <1>;
+				};
 			};
 		};
 	};
-- 
git-series 0.9.1
