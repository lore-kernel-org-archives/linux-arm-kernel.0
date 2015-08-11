From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 11 Aug 2015 13:32:57 +0800
Subject: [PATCH 3/3] ARM: dts: sun6i: Add security system crypto engine clock
 and device nodes
In-Reply-To: <1439271177-26523-1-git-send-email-wens@csie.org>
References: <1439271177-26523-1-git-send-email-wens@csie.org>
Message-ID: <1439271177-26523-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A31/A31s have the same "Security System" crypto engine as A10/A20,
but with a separate reset control.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 39953e76bbfc..7afb80f07dad 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -346,6 +346,14 @@
 					     "mmc3_sample";
 		};
 
+		ss_clk: clk at 01c2009c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			reg = <0x01c2009c 0x4>;
+			clocks = <&osc24M>, <&pll6 0>;
+			clock-output-names = "ss";
+		};
+
 		spi0_clk: clk at 01c200a0 {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun4i-a10-mod0-clk";
@@ -882,6 +890,16 @@
 			#size-cells = <0>;
 		};
 
+		crypto: crypto-engine at 01c15000 {
+			compatible = "allwinner,sun4i-a10-crypto";
+			reg = <0x01c15000 0x1000>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ahb1_gates 5>, <&ss_clk>;
+			clock-names = "ahb", "mod";
+			resets = <&ahb1_rst 5>;
+			reset-names = "ahb";
+		};
+
 		timer at 01c60000 {
 			compatible = "allwinner,sun6i-a31-hstimer",
 				     "allwinner,sun7i-a20-hstimer";
-- 
2.5.0
