From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Feb 2016 08:52:59 +0900
Subject: [PATCH 10/19] ARM: dts: r8a73a4: Add L2 cache-controller nodes
In-Reply-To: <cover.1456443769.git.horms+renesas@verge.net.au>
References: <cover.1456443769.git.horms+renesas@verge.net.au>
Message-ID: <c86a4b621994dbe9361185362c4be6887f04b1a4.1456443769.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add device nodes for the L2 caches, and link the CPU node to its L2
cache node.

The L2 cache for the Cortex-A15 CPU cores is 1 MiB large (organized as
64 KiB x 16 ways), and located in PM domain A3SM.

The L2 cache for the Cortex-A7 CPU cores is 512 KiB large (organized as
64 KiB x 8 ways), and located in PM domain A3KM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 138414a7d170..6583a1dfca1f 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -29,6 +29,7 @@
 			reg = <0>;
 			clock-frequency = <1500000000>;
 			power-domains = <&pd_a2sl>;
+			next-level-cache = <&L2_CA15>;
 		};
 	};
 
@@ -45,6 +46,22 @@
 			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
+	L2_CA15: cache-controller at 0 {
+		compatible = "cache";
+		clocks = <&cpg_clocks R8A73A4_CLK_Z>;
+		power-domains = <&pd_a3sm>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
+	L2_CA7: cache-controller at 1 {
+		compatible = "cache";
+		clocks = <&cpg_clocks R8A73A4_CLK_Z2>;
+		power-domains = <&pd_a3km>;
+		cache-unified;
+		cache-level = <2>;
+	};
+
 	dbsc1: memory-controller at e6790000 {
 		compatible = "renesas,dbsc-r8a73a4";
 		reg = <0 0xe6790000 0 0x10000>;
-- 
2.7.0.rc3.207.g0ac5344
