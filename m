From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:23:16 +0900
Subject: [PATCH 44/47] ARM: dts: sh73a0: Correct interrupt type for ARM TWD
In-Reply-To: <cover.1459732726.git.horms+renesas@verge.net.au>
References: <cover.1459732726.git.horms+renesas@verge.net.au>
Message-ID: <eaf2be722f632d02055c63a85e966fc05a26ff33.1459732726.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The ARM TWD interrupt is a private peripheral interrupt (PPI), and per
the ARM GIC documentation, whether the type for PPIs can be set is
IMPLEMENTATION DEFINED.

For SH-Mobile AG5 devices the PPI type cannot be set, and so when we
attempt to set the type for the ARM TWD interrupt it fails.  This has
gone unnoticed because it fails silently, and because we cannot
re-configure the type it has had no impact. Nevertheless fix the type
for the TWD interrupt so that it matches the hardware configuration.

Based on patches by Jon Hunter for Tegra20/30 and OMAP4.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index bf825ca4f6f7..3d41fb97689e 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -43,7 +43,7 @@
 	timer at f0000600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0xf0000600 0x20>;
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
 		clocks = <&twd_clk>;
 	};
 
-- 
2.1.4
