From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2018 13:54:05 +0100
Subject: [PATCH 03/16] ARM: dts: r8a77470: Add SDHI0 support
In-Reply-To: <cover.1543236456.git.horms+renesas@verge.net.au>
References: <cover.1543236456.git.horms+renesas@verge.net.au>
Message-ID: <62e0db655706518abea80b21c551d58661e145bd.1543236456.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

RZ/G1C comes with two different types of IP for the SDHI
interfaces, SDHI0 and SDHI2 share the same IP type, and
such an IP is also compatible with the one found in R-Car
Gen2. SDHI1 IP on the other hand is compatible with R-Car
Gen3 with internal DMA.
This patch completes the SDHI support of the R-Car Gen2
compatible IPs, including fixing the max-frequency
definition of SDHI2, as it turns out there is a bug in
Section 1.3.9 of the RZ/G1C Hardware User's Manual (Rev.
1.00 Oct. 2017).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 9611a936e1b8..ab2e0223f8a1 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -490,6 +490,21 @@
 			status = "disabled";
 		};
 
+		sdhi0: sd at ee100000 {
+			compatible = "renesas,sdhi-r8a77470",
+				     "renesas,rcar-gen2-sdhi";
+			reg = <0 0xee100000 0 0x328>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 314>;
+			dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
+			       <&dmac1 0xcd>, <&dmac1 0xce>;
+			dma-names = "tx", "rx", "tx", "rx";
+			max-frequency = <156000000>;
+			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
+			resets = <&cpg 314>;
+			status = "disabled";
+		};
+
 		sdhi2: sd at ee160000 {
 			compatible = "renesas,sdhi-r8a77470",
 				     "renesas,rcar-gen2-sdhi";
@@ -499,7 +514,7 @@
 			dmas = <&dmac0 0xd3>, <&dmac0 0xd4>,
 			       <&dmac1 0xd3>, <&dmac1 0xd4>;
 			dma-names = "tx", "rx", "tx", "rx";
-			max-frequency = <97500000>;
+			max-frequency = <78000000>;
 			power-domains = <&sysc R8A77470_PD_ALWAYS_ON>;
 			resets = <&cpg 312>;
 			status = "disabled";
-- 
2.11.0
