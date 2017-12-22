From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:48 +0100
Subject: [PATCH 10/37] ARM: dts: r8a7743: Add thermal device to DT
In-Reply-To: <cover.1513938145.git.horms+renesas@verge.net.au>
References: <cover.1513938145.git.horms+renesas@verge.net.au>
Message-ID: <6c76b4f7d89e89f0ae405dfc7a64c6d2b5d02813.1513938145.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

This patch instantiates the thermal sensor module with thermal-zone
support.

This patch is based on the commit cac68a56e34b
("ARM: dts: r8a7791: enable to use thermal-zone") by Kuninori Morimoto.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7743.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index fcdf620d6637..acf9ce2e4057 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -250,6 +250,38 @@
 			resets = <&cpg 407>;
 		};
 
+		thermal: thermal at e61f0000 {
+			compatible = "renesas,thermal-r8a7743",
+				     "renesas,rcar-gen2-thermal",
+				     "renesas,rcar-thermal";
+			reg = <0 0xe61f0000 0 0x10>, <0 0xe61f0100 0 0x38>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 522>;
+			power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
+			resets = <&cpg 522>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		thermal-zones {
+			cpu_thermal: cpu-thermal {
+				polling-delay-passive = <0>;
+				polling-delay = <0>;
+
+				thermal-sensors = <&thermal>;
+
+				trips {
+					cpu-crit {
+						temperature = <95000>;
+						hysteresis = <0>;
+						type = "critical";
+					};
+				};
+
+				cooling-maps {
+				};
+			};
+		};
+
 		timer {
 			compatible = "arm,armv7-timer";
 			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
-- 
2.11.0
