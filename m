From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  7 Dec 2017 11:19:23 +0100
Subject: [PATCH 2/2] ARM: dts: r8a7743: move timer node out of bus
In-Reply-To: <20171207101923.19846-1-horms+renesas@verge.net.au>
References: <20171207101923.19846-1-horms+renesas@verge.net.au>
Message-ID: <20171207101923.19846-3-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer node does not have any register properties and thus shouldn't be
placed on the bus.

This problem is flagged by the compiler as follows:
$ make
  DTC     arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb
arch/arm/boot/dts/r8a7743-iwg20d-q7.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
  DTC     arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb
arch/arm/boot/dts/r8a7743-sk-rzg1m.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 2fe852bb10cd..f1c77f0b5e69 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -281,18 +281,6 @@
 			resets = <&cpg 407>;
 		};
 
-		timer {
-			compatible = "arm,armv7-timer";
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
-						  IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7743-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -1261,6 +1249,22 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13
+				       (GIC_CPU_MASK_SIMPLE(2) |
+				        IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14
+				       (GIC_CPU_MASK_SIMPLE(2) |
+				        IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11
+				       (GIC_CPU_MASK_SIMPLE(2) |
+				        IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10
+				       (GIC_CPU_MASK_SIMPLE(2) |
+				        IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	/* External USB clock - can be overridden by the board */
 	usb_extal_clk: usb_extal {
 		compatible = "fixed-clock";
-- 
2.11.0
