From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Mar 2015 05:04:47 +0800
Subject: [PATCH 1/3] ARM: dts: sun6i: Set PLL6 as parent to AHB1 clock in AHB1
 clock node
In-Reply-To: <1427317489-708-1-git-send-email-wens@csie.org>
References: <1427317489-708-1-git-send-email-wens@csie.org>
Message-ID: <1427317489-708-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sun6i we already have PLL6 as AHB1 clock's parent. However this was
previously set in the dma controller node, which takes effect when the
dma controller is probed.

We want this to take effect as soon as possible, so hrtimer rate
calculation is correct, and to be sure the AHB1 clock rate remains as
stable as possible.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 2a37ee93265e..6d29eab5fe32 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -196,6 +196,14 @@
 			reg = <0x01c20054 0x4>;
 			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
 			clock-output-names = "ahb1";
+
+			/*
+			 * Clock AHB1 from PLL6, instead of CPU/AXI which
+			 * has rate changes due to cpufreq. Also the DMA
+			 * controller requires AHB1 clocked from PLL6.
+			 */
+			assigned-clocks = <&ahb1>;
+			assigned-clock-parents = <&pll6 0>;
 		};
 
 		ahb1_gates: clk at 01c20060 {
@@ -381,10 +389,6 @@
 			clocks = <&ahb1_gates 6>;
 			resets = <&ahb1_rst 6>;
 			#dma-cells = <1>;
-
-			/* DMA controller requires AHB1 clocked from PLL6 */
-			assigned-clocks = <&ahb1>;
-			assigned-clock-parents = <&pll6 0>;
 		};
 
 		mmc0: mmc at 01c0f000 {
-- 
2.1.4
