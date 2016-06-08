From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:41 +0900
Subject: [PATCH 11/30] ARM: dts: r8a73a4: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <b0da45c60d2f7b08128a6cd1216ac0ac7d8954c7.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /cache-controller at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /cache-controller at 1 has a unit name, but no reg property

Move the cache-controller nodes under the cpus node, and make their
unit names and reg properties match the MPIDR values.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6954912a3753..ca8672778fe0 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -31,6 +31,24 @@
 			power-domains = <&pd_a2sl>;
 			next-level-cache = <&L2_CA15>;
 		};
+
+		L2_CA15: cache-controller at 0 {
+			compatible = "cache";
+			reg = <0>;
+			clocks = <&cpg_clocks R8A73A4_CLK_Z>;
+			power-domains = <&pd_a3sm>;
+			cache-unified;
+			cache-level = <2>;
+		};
+
+		L2_CA7: cache-controller at 100 {
+			compatible = "cache";
+			reg = <0x100>;
+			clocks = <&cpg_clocks R8A73A4_CLK_Z2>;
+			power-domains = <&pd_a3km>;
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	ptm {
@@ -46,22 +64,6 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	L2_CA15: cache-controller at 0 {
-		compatible = "cache";
-		clocks = <&cpg_clocks R8A73A4_CLK_Z>;
-		power-domains = <&pd_a3sm>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
-	L2_CA7: cache-controller at 1 {
-		compatible = "cache";
-		clocks = <&cpg_clocks R8A73A4_CLK_Z2>;
-		power-domains = <&pd_a3km>;
-		cache-unified;
-		cache-level = <2>;
-	};
-
 	dbsc1: memory-controller at e6790000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe6790000 0 0x10000>;
-- 
2.1.4
