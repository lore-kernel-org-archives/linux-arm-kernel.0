From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Dec 2017 22:50:44 +0100
Subject: [PATCH 2/2] ARM: dts: r8a7745: move timer node out of bus
In-Reply-To: <20171218215044.13088-1-horms+renesas@verge.net.au>
References: <20171218215044.13088-1-horms+renesas@verge.net.au>
Message-ID: <20171218215044.13088-3-horms+renesas@verge.net.au>
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
---
 arch/arm/boot/dts/r8a7745.dtsi | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 65d92076bdde..612de9eeb7e2 100644
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
 		cpg: clock-controller at e6150000 {
 			compatible = "renesas,r8a7745-cpg-mssr";
 			reg = <0 0xe6150000 0 0x1000>;
@@ -1143,6 +1131,14 @@
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
