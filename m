From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:54 +0100
Subject: [PATCH 16/37] ARM: dts: r8a7745: move timer node out of bus
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <7bee3795c8145678ec101f9dd033ef7f7f858f48.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer node does not have any register properties and thus shouldn't be
placed on the bus.

This problem is flagged by the compiler as follows:
$ make dtbs W=1
...
arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property
  DTC     arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb
arch/arm/boot/dts/r8a7745-sk-rzg1e.dtb: Warning (simple_bus_reg): Node /soc/timer missing or empty reg/ranges property

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7745.dtsi | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 8fa919a7476d..2be7485c4efe 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -247,18 +247,6 @@
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
 		cmt0: timer at ffca0000 {
 			compatible = "renesas,r8a7745-cmt0",
 				     "renesas,rcar-gen2-cmt0";
@@ -1255,6 +1243,14 @@
 		};
 	};
 
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
 	/* External USB clock - can be overridden by the board */
 	usb_extal_clk: usb_extal {
 		compatible = "fixed-clock";
-- 
2.11.0
