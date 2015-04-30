From: wens@csie.org (Chen-Yu Tsai)
Date: Fri,  1 May 2015 00:10:05 +0800
Subject: [PATCH v2 4/5] ARM: dts: sun9i: Add A80 PRCM clocks and reset control
 nodes
In-Reply-To: <1430410206-4410-1-git-send-email-wens@csie.org>
References: <1430410206-4410-1-git-send-email-wens@csie.org>
Message-ID: <1430410206-4410-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PRCM clocks and reset controls to the A80 dtsi.

The list of apbs clock gates is incomplete. Tests show that bits 0~20
are mutable. We will need documents from Allwinner to complete the
support.

Also update clock and reset phandles for r_uart.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 64 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d3dece2eea72..f0869ff8006f 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -169,6 +169,14 @@
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
@@ -751,13 +759,67 @@
 			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		prcm at 08001400 {
+			compatible = "allwinner,sun9i-a80-prcm";
+			reg = <0x08001400 0x200>;
+
+			cpus_clk: cpus_clk {
+				compatible = "allwinner,sun9i-a80-cpus-clk";
+				#clock-cells = <0>;
+				clocks = <&osc32k>, <&osc24M>, <&pll4>, <&pll3>;
+				clock-output-names = "cpus";
+			};
+
+			ahbs: ahbs_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&cpus_clk>;
+				clock-output-names = "ahbs";
+			};
+
+			apbs: apbs_clk {
+				compatible = "allwinner,sun8i-a23-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahbs>;
+				clock-output-names = "apbs";
+			};
+
+			apbs_gates: apbs_gates_clk {
+				compatible = "allwinner,sun9i-a80-apbs-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apbs>;
+				clock-output-names = "apbs_pio", "apbs_ir",
+						"apbs_timer", "apbs_rsb",
+						"apbs_uart", "apbs_1wire",
+						"apbs_i2c0", "apbs_i2c1",
+						"apbs_ps2_0", "apbs_ps2_1",
+						"apbs_dma", "apbs_i2s0",
+						"apbs_i2s1", "apbs_twd";
+			};
+
+			r_ir_clk: r_ir_clk {
+				#clock-cells = <0>;
+				compatible = "allwinner,sun4i-a10-mod0-clk";
+				clocks = <&osc32k>, <&osc24M>;
+				clock-output-names = "r_ir";
+			};
+
+			apbs_rst: apbs_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
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
2.1.4
