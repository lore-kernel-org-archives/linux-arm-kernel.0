From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Apr 2016 14:27:32 +1000
Subject: [PATCH 14/22] ARM: dts: r8a7779: Correct interrupt type for ARM TWD
In-Reply-To: <cover.1461558315.git.horms+renesas@verge.net.au>
References: <cover.1461558315.git.horms+renesas@verge.net.au>
Message-ID: <e6c2488251b1c7e62f3e43907ca3f6fd016b1353.1461558315.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The ARM TWD interrupt is a private peripheral interrupt (PPI), and per
the ARM GIC documentation, whether the type for PPIs can be set is
IMPLEMENTATION DEFINED.

For R-Car H1 devices the PPI type cannot be set, and so when we attempt
to set the type for the ARM TWD interrupt it fails.  This has gone
unnoticed because it fails silently, and because we cannot re-configure
the type it has had no impact. Nevertheless fix the type for the TWD
interrupt so that it matches the hardware configuration.

Based on patches by Jon Hunter for Tegra20/30 and OMAP4.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 60bc1e66bba9..5c1d48d712a1 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -67,7 +67,7 @@
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
 		interrupts = <GIC_PPI 13
-			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&cpg_clocks R8A7779_CLK_ZS>;
 	};
 
-- 
2.7.0.rc3.207.g0ac5344
