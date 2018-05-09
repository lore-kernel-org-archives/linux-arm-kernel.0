From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  9 May 2018 17:23:22 +0200
Subject: [PATCH v2 1/2] arm64: dts: renesas: r8a77970: Add secondary CA53 CPU
 core
In-Reply-To: <1525879403-12207-1-git-send-email-geert+renesas@glider.be>
References: <1525879403-12207-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1525879403-12207-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a device node for the second Cortex-A53 CPU core on the Renesas
R-Car V3M (r8a77970) SoC, and adjust the interrupt delivery masks for
ARM Generic Interrupt Controller and Architectured Timer.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Adjust GIC_CPU_MASK_SIMPLE(),
  - Use symbolic core clock and power domain indices.
---
 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77970.dtsi b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
index 6ed2e95eb53dbb15..ccc955e89cea4d32 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77970.dtsi
@@ -41,6 +41,16 @@
 			enable-method = "psci";
 		};
 
+		a53_1: cpu at 1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <1>;
+			clocks = <&cpg CPG_CORE R8A77970_CLK_Z2>;
+			power-domains = <&sysc R8A77970_PD_CA53_CPU1>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+		};
+
 		L2_CA53: cache-controller {
 			compatible = "cache";
 			power-domains = <&sysc R8A77970_PD_CA53_SCU>;
@@ -603,7 +613,7 @@
 			      <0 0xf1020000 0 0x20000>,
 			      <0 0xf1040000 0 0x20000>,
 			      <0 0xf1060000 0 0x20000>;
-			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(1) |
+			interrupts = <GIC_PPI 9	(GIC_CPU_MASK_SIMPLE(2) |
 				      IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
@@ -694,9 +704,9 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 };
-- 
2.7.4
