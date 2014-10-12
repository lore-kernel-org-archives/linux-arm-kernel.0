From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 12 Oct 2014 17:40:25 +0800
Subject: [PATCH 5/5] ARM: dts: sun9i: Add basic clocks and reset controls
In-Reply-To: <1413106825-5777-1-git-send-email-wens@csie.org>
References: <1413106825-5777-1-git-send-email-wens@csie.org>
Message-ID: <1413106825-5777-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have driver support for the basic clocks, add them to the
dtsi and update existing peripherals. Also add reset controls to match.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 177 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 171 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 5e2ec4b..7bcab56 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -142,6 +142,135 @@
 			clock-frequency = <32768>;
 			clock-output-names = "osc32k";
 		};
+
+		pll4: clk at 0600000c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-pll4-clk";
+			reg = <0x0600000c 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll4";
+		};
+
+		pll12: clk at 0600002c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-pll4-clk";
+			reg = <0x0600002c 0x4>;
+			clocks = <&osc24M>;
+			clock-output-names = "pll12";
+		};
+
+		gt_clk: clk at 0600005c {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-gt-clk";
+			reg = <0x0600005c 0x4>;
+			clocks = <&osc24M>, <&pll4>, <&pll12>, <&pll12>;
+			clock-output-names = "gt";
+		};
+
+		ahb0: clk at 06000060 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-ahb-clk";
+			reg = <0x06000060 0x4>;
+			clocks = <&gt_clk>, <&pll4>, <&pll12>, <&pll12>;
+			clock-output-names = "ahb0";
+		};
+
+		ahb1: clk at 06000064 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-ahb-clk";
+			reg = <0x06000064 0x4>;
+			clocks = <&gt_clk>, <&pll4>, <&pll12>, <&pll12>;
+			clock-output-names = "ahb1";
+		};
+
+		ahb2: clk at 06000068 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-ahb-clk";
+			reg = <0x06000068 0x4>;
+			clocks = <&gt_clk>, <&pll4>, <&pll12>, <&pll12>;
+			clock-output-names = "ahb2";
+		};
+
+		apb0: clk at 06000070 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-apb0-clk";
+			reg = <0x06000070 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "apb0";
+		};
+
+		apb1: clk at 06000074 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-apb1-clk";
+			reg = <0x06000074 0x4>;
+			clocks = <&osc24M>, <&pll4>;
+			clock-output-names = "apb1";
+		};
+
+		cci400_clk: clk at 06000078 {
+			#clock-cells = <0>;
+			compatible = "allwinner,sun9i-a80-gt-clk";
+			reg = <0x06000078 0x4>;
+			clocks = <&osc24M>, <&pll4>, <&pll12>, <&pll12>;
+			clock-output-names = "cci400";
+		};
+
+		ahb0_gates: clk at 06000580 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-ahb0-gates-clk";
+			reg = <0x06000580 0x4>;
+			clocks = <&ahb0>;
+			clock-output-names = "ahb0_fd", "ahb0_ve", "ahb0_gpu",
+					"ahb0_ss", "ahb0_sd", "ahb0_nand1",
+					"ahb0_nand0", "ahb0_sdram",
+					"ahb0_mipi_hsi", "ahb0_sata", "ahb0_ts",
+					"ahb0_spi0","ahb0_spi1", "ahb0_spi2",
+					"ahb0_spi3";
+		};
+
+		ahb1_gates: clk at 06000584 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-ahb1-gates-clk";
+			reg = <0x06000584 0x4>;
+			clocks = <&ahb1>;
+			clock-output-names = "ahb1_usbotg", "ahb1_usbhci",
+					"ahb1_gmac", "ahb1_msgbox",
+					"ahb1_spinlock", "ahb1_hstimer",
+					"ahb1_dma";
+		};
+
+		ahb2_gates: clk at 06000588 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-ahb2-gates-clk";
+			reg = <0x06000588 0x4>;
+			clocks = <&ahb2>;
+			clock-output-names = "ahb2_lcd0", "ahb2_lcd1",
+					"ahb2_edp", "ahb2_csi", "ahb2_hdmi",
+					"ahb2_de", "ahb2_mp", "ahb2_mipi_dsi";
+		};
+
+		apb0_gates: clk at 06000590 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-apb0-gates-clk";
+			reg = <0x06000590 0x4>;
+			clocks = <&apb0>;
+			clock-output-names = "apb0_spdif", "apb0_pio",
+					"apb0_ac97", "apb0_i2s0", "apb0_i2s1",
+					"apb0_lradc", "apb0_gpadc", "apb0_twd",
+					"apb0_cirtx";
+		};
+
+		apb1_gates: clk at 06000594 {
+			#clock-cells = <1>;
+			compatible = "allwinner,sun9i-a80-apb1-gates-clk";
+			reg = <0x06000594 0x4>;
+			clocks = <&apb1>;
+			clock-output-names = "apb1_i2c0", "apb1_i2c1",
+					"apb1_i2c2", "apb1_i2c3", "apb1_i2c4",
+					"apb1_uart0", "apb1_uart1",
+					"apb1_uart2", "apb1_uart3",
+					"apb1_uart4", "apb1_uart5";
+		};
 	};
 
 	soc {
@@ -165,6 +294,36 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		ahb0_resets: reset at 060005a0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x060005a0 0x4>;
+		};
+
+		ahb1_resets: reset at 060005a4 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x060005a4 0x4>;
+		};
+
+		ahb2_resets: reset at 060005a8 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x060005a8 0x4>;
+		};
+
+		apb0_resets: reset at 060005b0 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x060005b0 0x4>;
+		};
+
+		apb1_resets: reset at 060005b4 {
+			#reset-cells = <1>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			reg = <0x060005b4 0x4>;
+		};
+
 		timer at 06000c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x06000c00 0xa0>;
@@ -184,7 +343,8 @@
 			interrupts = <0 0 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb1_gates 16>;
+			resets = <&apb1_resets 16>;
 			status = "disabled";
 		};
 
@@ -194,7 +354,8 @@
 			interrupts = <0 1 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb1_gates 17>;
+			resets = <&apb1_resets 17>;
 			status = "disabled";
 		};
 
@@ -204,7 +365,8 @@
 			interrupts = <0 2 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb1_gates 18>;
+			resets = <&apb1_resets 18>;
 			status = "disabled";
 		};
 
@@ -214,7 +376,8 @@
 			interrupts = <0 3 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb1_gates 19>;
+			resets = <&apb1_resets 19>;
 			status = "disabled";
 		};
 
@@ -224,7 +387,8 @@
 			interrupts = <0 4 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb1_gates 20>;
+			resets = <&apb1_resets 20>;
 			status = "disabled";
 		};
 
@@ -234,7 +398,8 @@
 			interrupts = <0 5 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb1_gates 21>;
+			resets = <&apb1_resets 21>;
 			status = "disabled";
 		};
 
-- 
2.1.1
