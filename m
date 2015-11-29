From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 29 Nov 2015 11:03:09 +0800
Subject: [PATCH v4 4/5] ARM: dts: sun9i: Add A80 PRCM clocks and reset control
 nodes
In-Reply-To: <1448766190-11345-1-git-send-email-wens@csie.org>
References: <1448766190-11345-1-git-send-email-wens@csie.org>
Message-ID: <1448766190-11345-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the supported PRCM clocks and reset controls to the A80 dtsi.
The DAUDIO module clocks are not supported yet.

Also update clock and reset phandles for r_uart.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 79 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 1118bf5cc4fb..a4ce348c0831 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -164,6 +164,14 @@
 					     "usb_phy2", "usb_hsic_12M";
 		};
 
+		pll3: clk at 06000008 {
+			/* placeholder until implemented */
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-rate = <0>;
+			clock-output-names = "pll3";
+		};
+
 		pll4: clk at 0600000c {
 			#clock-cells = <0>;
 			compatible = "allwinner,sun9i-a80-pll4-clk";
@@ -350,6 +358,68 @@
 					"apb1_uart2", "apb1_uart3",
 					"apb1_uart4", "apb1_uart5";
 		};
+
+		cpus_clk: clk at 08001410 {
+			compatible = "allwinner,sun9i-a80-cpus-clk";
+			reg = <0x08001410 0x4>;
+			#clock-cells = <0>;
+			clocks = <&osc32k>, <&osc24M>, <&pll4>, <&pll3>;
+			clock-output-names = "cpus";
+		};
+
+		ahbs: ahbs_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clocks = <&cpus_clk>;
+			clock-output-names = "ahbs";
+		};
+
+		apbs: clk at 0800141c {
+			compatible = "allwinner,sun8i-a23-apb0-clk";
+			reg = <0x0800141c 0x4>;
+			#clock-cells = <0>;
+			clocks = <&ahbs>;
+			clock-output-names = "apbs";
+		};
+
+		apbs_gates: clk at 08001428 {
+			compatible = "allwinner,sun9i-a80-apbs-gates-clk";
+			reg = <0x08001428 0x4>;
+			#clock-cells = <1>;
+			clocks = <&apbs>;
+			clock-indices = <0>, <1>,
+					<2>, <3>,
+					<4>, <5>,
+					<6>, <7>,
+					<12>, <13>,
+					<16>, <17>,
+					<18>, <20>;
+			clock-output-names = "apbs_pio", "apbs_ir",
+					"apbs_timer", "apbs_rsb",
+					"apbs_uart", "apbs_1wire",
+					"apbs_i2c0", "apbs_i2c1",
+					"apbs_ps2_0", "apbs_ps2_1",
+					"apbs_dma", "apbs_i2s0",
+					"apbs_i2s1", "apbs_twd";
+		};
+
+		r_1wire_clk: clk at 08001450 {
+			reg = <0x08001450 0x4>;
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			clocks = <&osc32k>, <&osc24M>;
+			clock-output-names = "r_1wire";
+		};
+
+		r_ir_clk: clk at 08001454 {
+			reg = <0x08001454 0x4>;
+			#clock-cells = <0>;
+			compatible = "allwinner,sun4i-a10-mod0-clk";
+			clocks = <&osc32k>, <&osc24M>;
+			clock-output-names = "r_ir";
+		};
 	};
 
 	soc {
@@ -764,13 +834,20 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		apbs_rst: reset at 080014b0 {
+			reg = <0x080014b0 0x4>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			#reset-cells = <1>;
+		};
+
 		r_uart: serial at 08002800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x08002800 0x400>;
 			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apbs_gates 4>;
+			resets = <&apbs_rst 4>;
 			status = "disabled";
 		};
 	};
-- 
2.6.2
