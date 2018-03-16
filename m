From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Mar 2018 15:50:37 +0100
Subject: [PATCH 07/69] arm64: dts: renesas: r8a77970: move node which has no
 reg property out of bus
In-Reply-To: <cover.1521206129.git.horms+renesas@verge.net.au>
References: <cover.1521206129.git.horms+renesas@verge.net.au>
Message-ID: <7569d1ee01c75b8581521bc67e595a575a7eafce.1521206129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move timer node from soc node to root node.  The node that have been moved
do not have any register properties and thus shouldn't be placed on the
bus.

This problem is flagged by the compiler as follows:
$ make W=1
...
  DTC     arch/arm64/boot/dts/renesas/r8a77970-eagle.dtb
arch/arm64/boot/dts/renesas/r8a77970-eagle.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
  DTC     arch/arm64/boot/dts/renesas/r8a77970-v3msk.dtb
arch/arm64/boot/dts/renesas/r8a77970-v3msk.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index c35a117fc447..566a7f704830 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -92,18 +92,6 @@
 			resets = <&cpg 408>;
 		};
 
-		timer {
-			compatible = "arm,armv8-timer";
-			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_LOW)>,
-				     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) |
-						  IRQ_TYPE_LEVEL_LOW)>;
-		};
-
 		rwdt: watchdog at e6020000 {
 			compatible = "renesas,r8a77970-wdt",
 				     "renesas,rcar-gen3-wdt";
@@ -442,4 +430,12 @@
 			#size-cells = <0>;
 		};
 	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+	};
 };
-- 
2.11.0
