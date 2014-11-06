From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  6 Nov 2014 19:56:49 +0800
Subject: [PATCH] ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required by
 dma controller
Message-ID: <1415275009-415-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma controller requires that the ahb1 bus clock be driven by pll6
for peripheral access to work. Previously this was done in the dma
controller driver, but was since removed as part of a series to unify
the ahb1_mux and ahb1 clock drivers, in

    14e0e28 dmaengine: sun6i: Remove obsolete clk muxing code

Unfortunately the rest of that series did not make it, leaving us with
broken dma on sun6i.

This patch reparents ahb1_mux to pll6 using the DT assigned-clocks
properties in the dma controller node.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Hi Maxime,

This is for 3.18 to fix broken dma. I have verified the clock register
bits on my A31 Hummingbird. Though I do not have actual hardware to test
dma peripherals, since this does return things to the way they were, it
is a proper fix.

Sorry for the breakage.

ChenYu
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index e80288e..4c4792f 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -361,6 +361,10 @@
 			clocks = <&ahb1_gates 6>;
 			resets = <&ahb1_rst 6>;
 			#dma-cells = <1>;
+
+			/* DMA controller requires AHB1 clocked from PLL6 */
+			assigned-clocks = <&ahb1_mux>;
+			assigned-clock-parents = <&pll6>;
 		};
 
 		mmc0: mmc at 01c0f000 {
-- 
2.1.1
