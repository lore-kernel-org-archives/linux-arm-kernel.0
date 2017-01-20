From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 08:29:47 +0100
Subject: [PATCH v3 7/7] ARM: gr8: Convert to CCU
In-Reply-To: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
References: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
Message-ID: <48e37e6289a1d255da9c28ac74b9e734282e6f91.1484897383.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for the GR8, we can convert our DT to it.

Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-gr8.dtsi | 520 +++-----------------------------
 1 file changed, 56 insertions(+), 464 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-gr8.dtsi b/arch/arm/boot/dts/sun5i-gr8.dtsi
index f83ae3fc6329..cb9b2aaf7297 100644
--- a/arch/arm/boot/dts/sun5i-gr8.dtsi
+++ b/arch/arm/boot/dts/sun5i-gr8.dtsi
@@ -42,9 +42,10 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
-#include <dt-bindings/clock/sun4i-a10-pll2.h>
+#include <dt-bindings/clock/sun5i-ccu.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/reset/sun5i-ccu.h>
 
 / {
 	interrupt-parent = <&intc>;
@@ -59,7 +60,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
-			clocks = <&cpu>;
+			clocks = <&ccu CLK_CPU>;
 		};
 	};
 
@@ -68,419 +69,19 @@
 		#size-cells = <1>;
 		ranges;
 
-		/*
-		 * This is a dummy clock, to be used as placeholder on
-		 * other mux clocks when a specific parent clock is not
-		 * yet implemented. It should be dropped when the driver
-		 * is complete.
-		 */
-		dummy: dummy {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-		};
-
 		osc24M: clk at 01c20050 {
 			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-osc-clk";
-			reg = <0x01c20050 0x4>;
+			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
 			clock-output-names = "osc24M";
 		};
 
-		osc3M: osc3M-clk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <8>;
-			clock-mult = <1>;
-			clocks = <&osc24M>;
-			clock-output-names = "osc3M";
-		};
-
 		osc32k: clk at 0 {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 			clock-output-names = "osc32k";
 		};
-
-		pll1: clk at 01c20000 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-pll1-clk";
-			reg = <0x01c20000 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll1";
-		};
-
-		pll2: clk at 01c20008 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun5i-a13-pll2-clk";
-			reg = <0x01c20008 0x8>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll2-1x", "pll2-2x",
-					     "pll2-4x", "pll2-8x";
-		};
-
-		pll3: clk at 01c20010 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-pll3-clk";
-			reg = <0x01c20010 0x4>;
-			clocks = <&osc3M>;
-			clock-output-names = "pll3";
-		};
-
-		pll3x2: pll3x2-clk {
-			compatible = "allwinner,sun4i-a10-pll3-2x-clk";
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <2>;
-			clocks = <&pll3>;
-			clock-output-names = "pll3-2x";
-		};
-
-		pll4: clk at 01c20018 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-pll1-clk";
-			reg = <0x01c20018 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll4";
-		};
-
-		pll5: clk at 01c20020 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-pll5-clk";
-			reg = <0x01c20020 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll5_ddr", "pll5_other";
-		};
-
-		pll6: clk at 01c20028 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-pll6-clk";
-			reg = <0x01c20028 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll6_sata", "pll6_other", "pll6";
-		};
-
-		pll7: clk at 01c20030 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-pll3-clk";
-			reg = <0x01c20030 0x4>;
-			clocks = <&osc3M>;
-			clock-output-names = "pll7";
-		};
-
-		pll7x2: pll7x2-clk {
-			compatible = "allwinner,sun4i-a10-pll3-2x-clk";
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <2>;
-			clocks = <&pll7>;
-			clock-output-names = "pll7-2x";
-		};
-
-		/* dummy is 200M */
-		cpu: cpu at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-cpu-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&dummy>;
-			clock-output-names = "cpu";
-		};
-
-		axi: axi at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-axi-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&cpu>;
-			clock-output-names = "axi";
-		};
-
-		ahb: ahb at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun5i-a13-ahb-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&axi>, <&cpu>, <&pll6 1>;
-			clock-output-names = "ahb";
-			/*
-			 * Use PLL6 as parent, instead of CPU/AXI
-			 * which has rate changes due to cpufreq
-			 */
-			assigned-clocks = <&ahb>;
-			assigned-clock-parents = <&pll6 1>;
-		};
-
-		apb0: apb0 at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb0-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&ahb>;
-			clock-output-names = "apb0";
-		};
-
-		apb1: clk at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
-			clock-output-names = "apb1";
-		};
-
-		axi_gates: clk at 01c2005c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-gates-clk";
-			reg = <0x01c2005c 0x4>;
-			clocks = <&axi>;
-			clock-indices = <0>;
-			clock-output-names = "axi_dram";
-		};
-
-		ahb_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun5i-a13-ahb-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb>;
-			clock-indices = <0>, <1>,
-					<2>, <5>, <6>,
-					<7>, <8>, <9>,
-					<10>, <13>,
-					<14>, <17>, <20>,
-					<21>, <22>,
-					<28>, <32>, <34>,
-					<36>, <40>, <44>,
-					<46>, <51>,
-					<52>;
-			clock-output-names = "ahb_usbotg", "ahb_ehci",
-					     "ahb_ohci", "ahb_ss", "ahb_dma",
-					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
-					     "ahb_mmc2", "ahb_nand",
-					     "ahb_sdram", "ahb_emac", "ahb_spi0",
-					     "ahb_spi1", "ahb_spi2",
-					     "ahb_hstimer", "ahb_ve", "ahb_tve",
-					     "ahb_lcd", "ahb_csi", "ahb_de_be",
-					     "ahb_de_fe", "ahb_iep",
-					     "ahb_mali400";
-		};
-
-		apb0_gates: clk at 01c20068 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-gates-clk";
-			reg = <0x01c20068 0x4>;
-			clocks = <&apb0>;
-			clock-indices = <0>, <3>,
-					<5>, <6>;
-			clock-output-names = "apb0_codec", "apb0_i2s0",
-					     "apb0_pio", "apb0_ir";
-		};
-
-		apb1_gates: clk at 01c2006c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-gates-clk";
-			reg = <0x01c2006c 0x4>;
-			clocks = <&apb1>;
-			clock-indices = <0>, <1>,
-					<2>, <17>,
-					<18>, <19>;
-			clock-output-names = "apb1_i2c0", "apb1_i2c1",
-					     "apb1_i2c2", "apb1_uart1",
-					     "apb1_uart2", "apb1_uart3";
-		};
-
-		nand_clk: clk at 01c20080 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c20080 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "nand";
-		};
-
-		ms_clk: clk at 01c20084 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c20084 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "ms";
-		};
-
-		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc0",
-					     "mmc0_output",
-					     "mmc0_sample";
-		};
-
-		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc1",
-					     "mmc1_output",
-					     "mmc1_sample";
-		};
-
-		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc2",
-					     "mmc2_output",
-					     "mmc2_sample";
-		};
-
-		ts_clk: clk at 01c20098 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c20098 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "ts";
-		};
-
-		ss_clk: clk at 01c2009c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c2009c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "ss";
-		};
-
-		spi0_clk: clk at 01c200a0 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200a0 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "spi0";
-		};
-
-		spi1_clk: clk at 01c200a4 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200a4 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "spi1";
-		};
-
-		spi2_clk: clk at 01c200a8 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200a8 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "spi2";
-		};
-
-		ir0_clk: clk at 01c200b0 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200b0 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "ir0";
-		};
-
-		i2s0_clk: clk at 01c200b8 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod1-clk";
-			reg = <0x01c200b8 0x4>;
-			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
-				 <&pll2 SUN4I_A10_PLL2_4X>,
-				 <&pll2 SUN4I_A10_PLL2_2X>,
-				 <&pll2 SUN4I_A10_PLL2_1X>;
-			clock-output-names = "i2s0";
-		};
-
-		spdif_clk: clk at 01c200c0 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod1-clk";
-			reg = <0x01c200c0 0x4>;
-			clocks = <&pll2 SUN4I_A10_PLL2_8X>,
-				 <&pll2 SUN4I_A10_PLL2_4X>,
-				 <&pll2 SUN4I_A10_PLL2_2X>,
-				 <&pll2 SUN4I_A10_PLL2_1X>;
-			clock-output-names = "spdif";
-		};
-
-		usb_clk: clk at 01c200cc {
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun5i-a13-usb-clk";
-			reg = <0x01c200cc 0x4>;
-			clocks = <&pll6 1>;
-			clock-output-names = "usb_ohci0", "usb_phy";
-		};
-
-		dram_gates: clk at 01c20100 {
-			#clock-cells = <1>;
-			compatible = "nextthing,gr8-dram-gates-clk",
-				     "allwinner,sun4i-a10-gates-clk";
-			reg = <0x01c20100 0x4>;
-			clocks = <&pll5 0>;
-			clock-indices = <0>,
-					<1>,
-					<25>,
-					<26>,
-					<29>,
-					<31>;
-			clock-output-names = "dram_ve",
-					     "dram_csi",
-					     "dram_de_fe",
-					     "dram_de_be",
-					     "dram_ace",
-					     "dram_iep";
-		};
-
-		de_be_clk: clk at 01c20104 {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-display-clk";
-			reg = <0x01c20104 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll5 1>;
-			clock-output-names = "de-be";
-		};
-
-		de_fe_clk: clk at 01c2010c {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-display-clk";
-			reg = <0x01c2010c 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll5 1>;
-			clock-output-names = "de-fe";
-		};
-
-		tcon_ch0_clk: clk at 01c20118 {
-			#clock-cells = <0>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
-			reg = <0x01c20118 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
-			clock-output-names = "tcon-ch0-sclk";
-		};
-
-		tcon_ch1_clk: clk at 01c2012c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
-			reg = <0x01c2012c 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
-			clock-output-names = "tcon-ch1-sclk";
-		};
-
-		codec_clk: clk at 01c20140 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-codec-clk";
-			reg = <0x01c20140 0x4>;
-			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
-			clock-output-names = "codec";
-		};
-
-		mbus_clk: clk at 01c2015c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun5i-a13-mbus-clk";
-			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mbus";
-		};
 	};
 
 	display-engine {
@@ -528,7 +129,7 @@
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <27>;
-			clocks = <&ahb_gates 6>;
+			clocks = <&ccu CLK_AHB_DMA>;
 			#dma-cells = <2>;
 		};
 
@@ -536,7 +137,7 @@
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <37>;
-			clocks = <&ahb_gates 13>, <&nand_clk>;
+			clocks = <&ccu CLK_AHB_NAND>, <&ccu CLK_NAND>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
 			dma-names = "rxtx";
@@ -549,7 +150,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <10>;
-			clocks = <&ahb_gates 20>, <&spi0_clk>;
+			clocks = <&ccu CLK_AHB_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
 			       <&dma SUN4I_DMA_DEDICATED 26>;
@@ -563,7 +164,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <11>;
-			clocks = <&ahb_gates 21>, <&spi1_clk>;
+			clocks = <&ccu CLK_AHB_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
 			       <&dma SUN4I_DMA_DEDICATED 8>;
@@ -576,8 +177,8 @@
 		tve0: tv-encoder at 01c0a000 {
 			compatible = "allwinner,sun4i-a10-tv-encoder";
 			reg = <0x01c0a000 0x1000>;
-			clocks = <&ahb_gates 34>;
-			resets = <&tcon_ch0_clk 0>;
+			clocks = <&ccu CLK_AHB_TVE>;
+			resets = <&ccu RST_TVE>;
 			status = "disabled";
 
 			port {
@@ -595,11 +196,11 @@
 			compatible = "allwinner,sun5i-a13-tcon";
 			reg = <0x01c0c000 0x1000>;
 			interrupts = <44>;
-			resets = <&tcon_ch0_clk 1>;
+			resets = <&ccu RST_LCD>;
 			reset-names = "lcd";
-			clocks = <&ahb_gates 36>,
-				 <&tcon_ch0_clk>,
-				 <&tcon_ch1_clk>;
+			clocks = <&ccu CLK_AHB_LCD>,
+				 <&ccu CLK_TCON_CH0>,
+				 <&ccu CLK_TCON_CH1>;
 			clock-names = "ahb",
 				      "tcon-ch0",
 				      "tcon-ch1";
@@ -637,14 +238,8 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu CLK_AHB_MMC0>, <&ccu CLK_MMC0>;
+			clock-names = "ahb", "mmc";
 			interrupts = <32>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -654,14 +249,8 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu CLK_AHB_MMC1>, <&ccu CLK_MMC1>;
+			clock-names = "ahb", "mmc";
 			interrupts = <33>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -671,14 +260,8 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu CLK_AHB_MMC2>, <&ccu CLK_MMC2>;
+			clock-names = "ahb", "mmc";
 			interrupts = <34>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -688,7 +271,7 @@
 		usb_otg: usb at 01c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
-			clocks = <&ahb_gates 0>;
+			clocks = <&ccu CLK_AHB_OTG>;
 			interrupts = <38>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -705,9 +288,9 @@
 			compatible = "allwinner,sun5i-a13-usb-phy";
 			reg = <0x01c13400 0x10 0x01c14800 0x4>;
 			reg-names = "phy_ctrl", "pmu1";
-			clocks = <&usb_clk 8>;
+			clocks = <&ccu CLK_USB_PHY0>;
 			clock-names = "usb_phy";
-			resets = <&usb_clk 0>, <&usb_clk 1>;
+			resets = <&ccu RST_USB_PHY0>, <&ccu RST_USB_PHY1>;
 			reset-names = "usb0_reset", "usb1_reset";
 			status = "disabled";
 		};
@@ -716,7 +299,7 @@
 			compatible = "allwinner,sun5i-a13-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <39>;
-			clocks = <&ahb_gates 1>;
+			clocks = <&ccu CLK_AHB_EHCI>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -726,7 +309,7 @@
 			compatible = "allwinner,sun5i-a13-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <40>;
-			clocks = <&usb_clk 6>, <&ahb_gates 2>;
+			clocks = <&ccu CLK_USB_OHCI>, <&ccu CLK_AHB_OHCI>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -736,7 +319,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <12>;
-			clocks = <&ahb_gates 22>, <&spi2_clk>;
+			clocks = <&ccu CLK_AHB_SPI2>, <&ccu CLK_SPI2>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
 			       <&dma SUN4I_DMA_DEDICATED 28>;
@@ -746,6 +329,15 @@
 			#size-cells = <0>;
 		};
 
+		ccu: clock at 01c20000 {
+			compatible = "nextthing,gr8-ccu";
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-a10-ic";
 			reg = <0x01c20400 0x400>;
@@ -757,7 +349,7 @@
 			compatible = "nextthing,gr8-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <28>;
-			clocks = <&apb0_gates 5>;
+			clocks = <&ccu CLK_APB0_PIO>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
@@ -876,7 +468,7 @@
 		pwm: pwm at 01c20e00 {
 			compatible = "allwinner,sun5i-a10s-pwm";
 			reg = <0x01c20e00 0xc>;
-			clocks = <&osc24M>;
+			clocks = <&ccu CLK_HOSC>;
 			#pwm-cells = <3>;
 			status = "disabled";
 		};
@@ -885,7 +477,7 @@
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0x90>;
 			interrupts = <22>;
-			clocks = <&osc24M>;
+			clocks = <&ccu CLK_HOSC>;
 		};
 
 		wdt: watchdog at 01c20c90 {
@@ -898,7 +490,7 @@
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
 			interrupts = <13>;
-			clocks = <&apb0_gates 1>, <&spdif_clk>;
+			clocks = <&ccu CLK_APB0_SPDIF>, <&ccu CLK_SPDIF>;
 			clock-names = "apb", "spdif";
 			dmas = <&dma SUN4I_DMA_NORMAL 2>,
 			       <&dma SUN4I_DMA_NORMAL 2>;
@@ -908,7 +500,7 @@
 
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&apb0_gates 6>, <&ir0_clk>;
+			clocks = <&ccu CLK_APB0_IR>, <&ccu CLK_IR>;
 			clock-names = "apb", "ir";
 			interrupts = <5>;
 			reg = <0x01c21800 0x40>;
@@ -920,7 +512,7 @@
 			compatible = "allwinner,sun4i-a10-i2s";
 			reg = <0x01c22400 0x400>;
 			interrupts = <16>;
-			clocks = <&apb0_gates 3>, <&i2s0_clk>;
+			clocks = <&ccu CLK_APB0_I2S>, <&ccu CLK_I2S>;
 			clock-names = "apb", "mod";
 			dmas = <&dma SUN4I_DMA_NORMAL 3>,
 			       <&dma SUN4I_DMA_NORMAL 3>;
@@ -940,7 +532,7 @@
 			compatible = "allwinner,sun4i-a10-codec";
 			reg = <0x01c22c00 0x40>;
 			interrupts = <30>;
-			clocks = <&apb0_gates 0>, <&codec_clk>;
+			clocks = <&ccu CLK_APB0_CODEC>, <&ccu CLK_CODEC>;
 			clock-names = "apb", "codec";
 			dmas = <&dma SUN4I_DMA_NORMAL 19>,
 			       <&dma SUN4I_DMA_NORMAL 19>;
@@ -961,7 +553,7 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 17>;
+			clocks = <&ccu CLK_APB1_UART1>;
 			status = "disabled";
 		};
 
@@ -971,7 +563,7 @@
 			interrupts = <3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 18>;
+			clocks = <&ccu CLK_APB1_UART2>;
 			status = "disabled";
 		};
 
@@ -981,7 +573,7 @@
 			interrupts = <4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 19>;
+			clocks = <&ccu CLK_APB1_UART3>;
 			status = "disabled";
 		};
 
@@ -989,7 +581,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
-			clocks = <&apb1_gates 0>;
+			clocks = <&ccu CLK_APB1_I2C0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -999,7 +591,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
-			clocks = <&apb1_gates 1>;
+			clocks = <&ccu CLK_APB1_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1009,7 +601,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
-			clocks = <&apb1_gates 2>;
+			clocks = <&ccu CLK_APB1_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1019,18 +611,18 @@
 			compatible = "allwinner,sun5i-a13-hstimer";
 			reg = <0x01c60000 0x1000>;
 			interrupts = <82>, <83>;
-			clocks = <&ahb_gates 28>;
+			clocks = <&ccu CLK_AHB_HSTIMER>;
 		};
 
 		fe0: display-frontend at 01e00000 {
 			compatible = "allwinner,sun5i-a13-display-frontend";
 			reg = <0x01e00000 0x20000>;
 			interrupts = <47>;
-			clocks = <&ahb_gates 46>, <&de_fe_clk>,
-				 <&dram_gates 25>;
+			clocks = <&ccu CLK_AHB_DE_FE>, <&ccu CLK_DE_FE>,
+				 <&ccu CLK_DRAM_DE_FE>;
 			clock-names = "ahb", "mod",
 				      "ram";
-			resets = <&de_fe_clk>;
+			resets = <&ccu RST_DE_FE>;
 			status = "disabled";
 
 			ports {
@@ -1053,14 +645,14 @@
 		be0: display-backend at 01e60000 {
 			compatible = "allwinner,sun5i-a13-display-backend";
 			reg = <0x01e60000 0x10000>;
-			clocks = <&ahb_gates 44>, <&de_be_clk>,
-				 <&dram_gates 26>;
+			clocks = <&ccu CLK_AHB_DE_BE>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_DRAM_DE_BE>;
 			clock-names = "ahb", "mod",
 				      "ram";
-			resets = <&de_be_clk>;
+			resets = <&ccu RST_DE_BE>;
 			status = "disabled";
 
-			assigned-clocks = <&de_be_clk>;
+			assigned-clocks = <&ccu CLK_DE_BE>;
 			assigned-clock-rates = <300000000>;
 
 			ports {
-- 
git-series 0.8.11
