From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 30 Dec 2013 11:25:47 +0800
Subject: [PATCH v2 2/4] ARM: dts: sun7i: external clock outputs
In-Reply-To: <1388373949-28506-1-git-send-email-wens@csie.org>
References: <1388373949-28506-1-git-send-email-wens@csie.org>
Message-ID: <1388373949-28506-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the two external clock outputs available on A20 to
its device tree. A dummy fixed factor clock is also added to serve as
the first input of the clock outputs, which according to AW's A20 user
manual, is the 24MHz oscillator divided by 750.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4c25f81..f255a49 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -302,6 +302,33 @@
 			clocks = <&osc24M>, <&pll6 2>, <&pll5 1>;
 			clock-output-names = "mbus";
 		};
+
+		/*
+		 * Dummy clock used by output clocks
+		 */
+		osc24M_32k: osc24M_32k {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <750>;
+			clock-mult = <1>;
+			clocks = <&osc24M>;
+		};
+
+		clk_out_a: clk at 01c201f0 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-out-clk";
+			reg = <0x01c201f0 0x4>;
+			clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
+			clock-output-names = "clk_out_a";
+		};
+
+		clk_out_b: clk at 01c201f4 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun7i-a20-out-clk";
+			reg = <0x01c201f4 0x4>;
+			clocks = <&osc24M_32k>, <&osc32k>, <&osc24M>;
+			clock-output-names = "clk_out_b";
+		};
 	};
 
 	soc at 01c00000 {
-- 
1.8.5.2
