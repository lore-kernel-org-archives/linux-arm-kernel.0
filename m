From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:19 -0800
Subject: [PATCH 12/29] ARM: shmobile: r8a7793: Add thermal device to DT
In-Reply-To: <cover.1447981420.git.horms+renesas@verge.net.au>
References: <cover.1447981420.git.horms+renesas@verge.net.au>
Message-ID: <0fddfb5b609f3b037006bcd467c540a7968a2dc7.1447981420.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate the thermal sensor in the r8a7793 device tree.

Based on very similar work for the r8a7790 by Magnus Damm.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index fcafa87616fa..6c7bae4318c9 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -53,6 +53,14 @@
 		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	thermal at e61f0000 {
+		compatible = "renesas,thermal-r8a7793", "renesas,rcar-thermal";
+		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
+		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp5_clks R8A7793_CLK_THERMAL>;
+		power-domains = <&cpg_clocks>;
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
@@ -329,6 +337,14 @@
 			clock-indices = <R8A7793_CLK_IRQC>;
 			clock-output-names = "irqc";
 		};
+		mstp5_clks: mstp5_clks at e6150144 {
+			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
+			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
+			clocks = <&extal_clk>;
+			#clock-cells = <1>;
+			clock-indices = <R8A7793_CLK_THERMAL>;
+			clock-output-names = "thermal";
+		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7793-mstp-clocks",
 				     "renesas,cpg-mstp-clocks";
-- 
2.1.4
