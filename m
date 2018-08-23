From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 23 Aug 2018 14:43:05 +0100
Subject: [PATCH 6/9] arm64: dts: renesas: r8a774a1: Add Cortex-A53 CPU cores
In-Reply-To: <1535031788-19907-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1535031788-19907-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1535031788-19907-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch adds definitions for L2 cache for the Cortex-A53 CPU
cores (512 KiB in size, organized as 32 KiB x 16 ways), adds
Cortex-A53 CPU cores (setting a total of 6 cores, 2 x Cortex-A57
+ 4 x Cortex-A53), and finally enables the performance monitor
unit for the Cortex-A53 cores on the R8A774A1 SoC.

Based on work done for r8a7796 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 66 ++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 856bd37..1d847cf 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -79,12 +79,59 @@
 			clocks =<&cpg CPG_CORE 0>;
 		};
 
+		a53_0: cpu at 100 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x100>;
+			device_type = "cpu";
+			power-domains = <&sysc 5>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE 1>;
+		};
+
+		a53_1: cpu at 101 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x101>;
+			device_type = "cpu";
+			power-domains = <&sysc 6>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE 1>;
+		};
+
+		a53_2: cpu at 102 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x102>;
+			device_type = "cpu";
+			power-domains = <&sysc 7>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE 1>;
+		};
+
+		a53_3: cpu at 103 {
+			compatible = "arm,cortex-a53", "arm,armv8";
+			reg = <0x103>;
+			device_type = "cpu";
+			power-domains = <&sysc 8>;
+			next-level-cache = <&L2_CA53>;
+			enable-method = "psci";
+			clocks =<&cpg CPG_CORE 1>;
+		};
+
 		L2_CA57: cache-controller-0 {
 			compatible = "cache";
 			power-domains = <&sysc 12>;
 			cache-unified;
 			cache-level = <2>;
 		};
+
+		L2_CA53: cache-controller-1 {
+			compatible = "cache";
+			power-domains = <&sysc 21>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	extal_clk: extal {
@@ -108,6 +155,15 @@
 		clock-frequency = <0>;
 	};
 
+	pmu_a53 {
+		compatible = "arm,cortex-a53-pmu";
+		interrupts-extended = <&gic GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&a53_0>, <&a53_1>, <&a53_2>, <&a53_3>;
+	};
+
 	pmu_a57 {
 		compatible = "arm,cortex-a57-pmu";
 		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
@@ -852,7 +908,7 @@
 			      <0x0 0xf1040000 0 0x20000>,
 			      <0x0 0xf1060000 0 0x20000>;
 			interrupts = <GIC_PPI 9
-					(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+					(GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
 			clocks = <&cpg CPG_MOD 408>;
 			clock-names = "clk";
 			power-domains = <&sysc 32>;
@@ -912,10 +968,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
-				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts-extended = <&gic GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
+				      <&gic GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	/* External USB clocks - can be overridden by the board */
-- 
2.7.4
