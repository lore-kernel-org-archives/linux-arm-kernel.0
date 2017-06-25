From: plaes@plaes.org (Priit Laes)
Date: Sun, 25 Jun 2017 23:45:47 +0300
Subject: [PATCH v4 6/6] ARM: sun4i: Convert to CCU
In-Reply-To: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
References: <cover.24b2b13ec5a68552e186ba1637f1328363c3886e.1498422562.git-series.plaes@plaes.org>
Message-ID: <f4b2bbc20ca8afa9cc918ba8f781bd69ec3c6d00.1498422562.git-series.plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert sun4i-a10.dtsi to new CCU driver.

Tested on Gemei G9 tablet.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 643 +++-----------------------------
 1 file changed, 72 insertions(+), 571 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 41c2579..c79d3bc 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -45,7 +45,6 @@
 
 #include <dt-bindings/thermal/thermal.h>
 
-#include <dt-bindings/clock/sun4i-a10-pll2.h>
 #include <dt-bindings/dma/sun4i-a10.h>
 
 / {
@@ -64,9 +63,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>, <&de_be0_clk>,
-				 <&tcon0_ch1_clk>, <&dram_gates 26>;
+			clocks = <&ccu 56>, <&ccu 60>,
+				 <&ccu 62>, <&ccu 144>,
+				 <&ccu 155>, <&ccu 140>;
 			status = "disabled";
 		};
 
@@ -74,10 +73,11 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-hdmi";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
-				 <&ahb_gates 44>, <&ahb_gates 46>,
-				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch1_clk>,
-				 <&dram_gates 25>, <&dram_gates 26>;
+			clocks = <&ccu 56>, <&ccu 60>,
+				 <&ccu 62>, <&ccu 64>,
+				 <&ccu 144>, <&ccu 146>,
+				 <&ccu 155>, <&ccu 164>,
+				 <&ccu 139>, <&ccu 140>;
 			status = "disabled";
 		};
 
@@ -85,9 +85,10 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0";
-			clocks = <&ahb_gates 36>, <&ahb_gates 44>, <&ahb_gates 46>,
-				 <&de_be0_clk>, <&de_fe0_clk>, <&tcon0_ch0_clk>,
-				 <&dram_gates 25>, <&dram_gates 26>;
+			clocks = <&ccu 56>, <&ccu 62>,
+				 <&ccu 64>, <&ccu 144>,
+				 <&ccu 146>, <&ccu 149>,
+				 <&ccu 139>, <&ccu 140>;
 			status = "disabled";
 		};
 
@@ -95,11 +96,11 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_fe0-de_be0-lcd0-tve0";
-			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
-				 <&ahb_gates 44>, <&ahb_gates 46>,
-				 <&de_be0_clk>, <&de_fe0_clk>,
-				 <&tcon0_ch1_clk>, <&dram_gates 5>,
-				 <&dram_gates 25>, <&dram_gates 26>;
+			clocks = <&ccu 54>, <&ccu 56>,
+				 <&ccu 62>, <&ccu 64>,
+				 <&ccu 144>, <&ccu 146>,
+				 <&ccu 155>, <&ccu 135>,
+				 <&ccu 139>, <&ccu 140>;
 			status = "disabled";
 		};
 	};
@@ -111,7 +112,7 @@
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
-			clocks = <&cpu>;
+			clocks = <&ccu 20>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
 				/* kHz	  uV */
@@ -167,18 +168,6 @@
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
 			compatible = "allwinner,sun4i-a10-osc-clk";
@@ -187,487 +176,12 @@
 			clock-output-names = "osc24M";
 		};
 
-		osc3M: osc3M_clk {
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
-			compatible = "allwinner,sun4i-a10-pll2-clk";
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
-		pll3x2: pll3x2_clk {
-			compatible = "fixed-factor-clock";
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
-		pll7x2: pll7x2_clk {
-			compatible = "fixed-factor-clock";
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
-		axi_gates: clk at 01c2005c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-axi-gates-clk";
-			reg = <0x01c2005c 0x4>;
-			clocks = <&axi>;
-			clock-indices = <0>;
-			clock-output-names = "axi_dram";
-		};
-
-		ahb: ahb at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-ahb-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&axi>;
-			clock-output-names = "ahb";
-		};
-
-		ahb_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-ahb-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb>;
-			clock-indices = <0>, <1>,
-					<2>, <3>,
-					<4>, <5>, <6>,
-					<7>, <8>, <9>,
-					<10>, <11>, <12>,
-					<13>, <14>, <16>,
-					<17>, <18>, <20>,
-					<21>, <22>, <23>,
-					<24>, <25>, <26>,
-					<32>, <33>, <34>,
-					<35>, <36>, <37>,
-					<40>, <41>, <43>,
-					<44>, <45>,
-					<46>, <47>,
-					<50>, <52>;
-			clock-output-names = "ahb_usb0", "ahb_ehci0",
-					     "ahb_ohci0", "ahb_ehci1",
-					     "ahb_ohci1", "ahb_ss", "ahb_dma",
-					     "ahb_bist", "ahb_mmc0", "ahb_mmc1",
-					     "ahb_mmc2", "ahb_mmc3", "ahb_ms",
-					     "ahb_nand", "ahb_sdram", "ahb_ace",
-					     "ahb_emac", "ahb_ts", "ahb_spi0",
-					     "ahb_spi1", "ahb_spi2", "ahb_spi3",
-					     "ahb_pata", "ahb_sata", "ahb_gps",
-					     "ahb_ve", "ahb_tvd", "ahb_tve0",
-					     "ahb_tve1", "ahb_lcd0", "ahb_lcd1",
-					     "ahb_csi0", "ahb_csi1", "ahb_hdmi",
-					     "ahb_de_be0", "ahb_de_be1",
-					     "ahb_de_fe0", "ahb_de_fe1",
-					     "ahb_mp", "ahb_mali400";
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
-		apb0_gates: clk at 01c20068 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-apb0-gates-clk";
-			reg = <0x01c20068 0x4>;
-			clocks = <&apb0>;
-			clock-indices = <0>, <1>,
-					<2>, <3>,
-					<5>, <6>,
-					<7>, <10>;
-			clock-output-names = "apb0_codec", "apb0_spdif",
-					     "apb0_ac97", "apb0_iis",
-					     "apb0_pio", "apb0_ir0",
-					     "apb0_ir1", "apb0_keypad";
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
-		apb1_gates: clk at 01c2006c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-apb1-gates-clk";
-			reg = <0x01c2006c 0x4>;
-			clocks = <&apb1>;
-			clock-indices = <0>, <1>,
-					<2>, <4>,
-					<5>, <6>,
-					<7>, <16>,
-					<17>, <18>,
-					<19>, <20>,
-					<21>, <22>,
-					<23>;
-			clock-output-names = "apb1_i2c0", "apb1_i2c1",
-					     "apb1_i2c2", "apb1_can",
-					     "apb1_scr", "apb1_ps20",
-					     "apb1_ps21", "apb1_uart0",
-					     "apb1_uart1", "apb1_uart2",
-					     "apb1_uart3", "apb1_uart4",
-					     "apb1_uart5", "apb1_uart6",
-					     "apb1_uart7";
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
-		mmc3_clk: clk at 01c20094 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20094 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "mmc3",
-					     "mmc3_output",
-					     "mmc3_sample";
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
-		pata_clk: clk at 01c200ac {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200ac 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "pata";
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
-		ir1_clk: clk at 01c200b4 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200b4 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "ir1";
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
-			compatible = "allwinner,sun4i-a10-usb-clk";
-			reg = <0x01c200cc 0x4>;
-			clocks = <&pll6 1>;
-			clock-output-names = "usb_ohci0", "usb_ohci1",
-					     "usb_phy";
-		};
-
-		spi3_clk: clk at 01c200d4 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200d4 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5 1>;
-			clock-output-names = "spi3";
-		};
-
-		dram_gates: clk at 01c20100 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-dram-gates-clk";
-			reg = <0x01c20100 0x4>;
-			clocks = <&pll5 0>;
-			clock-indices = <0>,
-					<1>, <2>,
-					<3>,
-					<4>,
-					<5>, <6>,
-					<15>,
-					<24>, <25>,
-					<26>, <27>,
-					<28>, <29>;
-			clock-output-names = "dram_ve",
-					     "dram_csi0", "dram_csi1",
-					     "dram_ts",
-					     "dram_tvd",
-					     "dram_tve0", "dram_tve1",
-					     "dram_output",
-					     "dram_de_fe1", "dram_de_fe0",
-					     "dram_de_be0", "dram_de_be1",
-					     "dram_de_mp", "dram_ace";
-		};
-
-		de_be0_clk: clk at 01c20104 {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-display-clk";
-			reg = <0x01c20104 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll5 1>;
-			clock-output-names = "de-be0";
-		};
-
-		de_be1_clk: clk at 01c20108 {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-display-clk";
-			reg = <0x01c20108 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll5 1>;
-			clock-output-names = "de-be1";
-		};
-
-		de_fe0_clk: clk at 01c2010c {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-display-clk";
-			reg = <0x01c2010c 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll5 1>;
-			clock-output-names = "de-fe0";
-		};
-
-		de_fe1_clk: clk at 01c20110 {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-display-clk";
-			reg = <0x01c20110 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll5 1>;
-			clock-output-names = "de-fe1";
-		};
-
-
-		tcon0_ch0_clk: clk at 01c20118 {
-			#clock-cells = <0>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
-			reg = <0x01c20118 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
-			clock-output-names = "tcon0-ch0-sclk";
-
-		};
-
-		tcon1_ch0_clk: clk at 01c2011c {
-			#clock-cells = <0>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
-			reg = <0x01c2011c 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
-			clock-output-names = "tcon1-ch0-sclk";
-
-		};
-
-		tcon0_ch1_clk: clk at 01c2012c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-tcon-ch0-clk";
-			reg = <0x01c2012c 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
-			clock-output-names = "tcon0-ch1-sclk";
-
-		};
-
-		tcon1_ch1_clk: clk at 01c20130 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-tcon-ch1-clk";
-			reg = <0x01c20130 0x4>;
-			clocks = <&pll3>, <&pll7>, <&pll3x2>, <&pll7x2>;
-			clock-output-names = "tcon1-ch1-sclk";
-
-		};
-
-		ve_clk: clk at 01c2013c {
-			#clock-cells = <0>;
-			#reset-cells = <0>;
-			compatible = "allwinner,sun4i-a10-ve-clk";
-			reg = <0x01c2013c 0x4>;
-			clocks = <&pll4>;
-			clock-output-names = "ve";
-		};
-
-		codec_clk: clk at 01c20140 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-codec-clk";
-			reg = <0x01c20140 0x4>;
-			clocks = <&pll2 SUN4I_A10_PLL2_1X>;
-			clock-output-names = "codec";
-		};
 	};
 
 	soc at 01c00000 {
@@ -716,7 +230,7 @@
 			compatible = "allwinner,sun4i-a10-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <27>;
-			clocks = <&ahb_gates 6>;
+			clocks = <&ccu 32>;
 			#dma-cells = <2>;
 		};
 
@@ -724,7 +238,7 @@
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <37>;
-			clocks = <&ahb_gates 13>, <&nand_clk>;
+			clocks = <&ccu 39>, <&ccu 96>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 3>;
 			dma-names = "rxtx";
@@ -737,7 +251,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c05000 0x1000>;
 			interrupts = <10>;
-			clocks = <&ahb_gates 20>, <&spi0_clk>;
+			clocks = <&ccu 44>, <&ccu 112>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
 			       <&dma SUN4I_DMA_DEDICATED 26>;
@@ -751,7 +265,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c06000 0x1000>;
 			interrupts = <11>;
-			clocks = <&ahb_gates 21>, <&spi1_clk>;
+			clocks = <&ccu 45>, <&ccu 113>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
 			       <&dma SUN4I_DMA_DEDICATED 8>;
@@ -765,7 +279,7 @@
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
 			interrupts = <55>;
-			clocks = <&ahb_gates 17>;
+			clocks = <&ccu 42>;
 			allwinner,sram = <&emac_sram 1>;
 			status = "disabled";
 		};
@@ -781,14 +295,8 @@
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu 34>, <&ccu 98>;
+			clock-names = "ahb", "mmc";
 			interrupts = <32>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -798,14 +306,8 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu 35>, <&ccu 101>;
+			clock-names = "ahb", "mmc";
 			interrupts = <33>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -815,14 +317,8 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu 36>, <&ccu 104>;
+			clock-names = "ahb", "mmc";
 			interrupts = <34>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -832,14 +328,8 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun4i-a10-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb_gates 11>,
-				 <&mmc3_clk 0>,
-				 <&mmc3_clk 1>,
-				 <&mmc3_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
+			clocks = <&ccu 37>, <&ccu 107>;
+			clock-names = "ahb", "mmc";
 			interrupts = <35>;
 			status = "disabled";
 			#address-cells = <1>;
@@ -849,7 +339,7 @@
 		usb_otg: usb at 01c13000 {
 			compatible = "allwinner,sun4i-a10-musb";
 			reg = <0x01c13000 0x0400>;
-			clocks = <&ahb_gates 0>;
+			clocks = <&ccu 26>;
 			interrupts = <38>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -864,9 +354,11 @@
 			compatible = "allwinner,sun4i-a10-usb-phy";
 			reg = <0x01c13400 0x10 0x01c14800 0x4 0x01c1c800 0x4>;
 			reg-names = "phy_ctrl", "pmu1", "pmu2";
-			clocks = <&usb_clk 8>;
+			clocks = <&ccu 125>;
 			clock-names = "usb_phy";
-			resets = <&usb_clk 0>, <&usb_clk 1>, <&usb_clk 2>;
+			resets = <&ccu 1>,
+				 <&ccu 2>,
+				 <&ccu 3>;
 			reset-names = "usb0_reset", "usb1_reset", "usb2_reset";
 			status = "disabled";
 		};
@@ -875,7 +367,7 @@
 			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
 			reg = <0x01c14000 0x100>;
 			interrupts = <39>;
-			clocks = <&ahb_gates 1>;
+			clocks = <&ccu 27>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -885,7 +377,7 @@
 			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 			reg = <0x01c14400 0x100>;
 			interrupts = <64>;
-			clocks = <&usb_clk 6>, <&ahb_gates 2>;
+			clocks = <&ccu 123>, <&ccu 28>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -895,7 +387,7 @@
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <86>;
-			clocks = <&ahb_gates 5>, <&ss_clk>;
+			clocks = <&ccu 31>, <&ccu 111>;
 			clock-names = "ahb", "mod";
 		};
 
@@ -903,7 +395,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c17000 0x1000>;
 			interrupts = <12>;
-			clocks = <&ahb_gates 22>, <&spi2_clk>;
+			clocks = <&ccu 46>, <&ccu 114>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
 			       <&dma SUN4I_DMA_DEDICATED 28>;
@@ -917,7 +409,7 @@
 			compatible = "allwinner,sun4i-a10-ahci";
 			reg = <0x01c18000 0x1000>;
 			interrupts = <56>;
-			clocks = <&pll6 0>, <&ahb_gates 25>;
+			clocks = <&ccu 49>, <&ccu 122>;
 			status = "disabled";
 		};
 
@@ -925,7 +417,7 @@
 			compatible = "allwinner,sun4i-a10-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <40>;
-			clocks = <&ahb_gates 3>;
+			clocks = <&ccu 29>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -935,7 +427,7 @@
 			compatible = "allwinner,sun4i-a10-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <65>;
-			clocks = <&usb_clk 7>, <&ahb_gates 4>;
+			clocks = <&ccu 124>, <&ccu 30>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -945,7 +437,7 @@
 			compatible = "allwinner,sun4i-a10-spi";
 			reg = <0x01c1f000 0x1000>;
 			interrupts = <50>;
-			clocks = <&ahb_gates 23>, <&spi3_clk>;
+			clocks = <&ccu 47>, <&ccu 127>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma SUN4I_DMA_DEDICATED 31>,
 			       <&dma SUN4I_DMA_DEDICATED 30>;
@@ -955,6 +447,15 @@
 			#size-cells = <0>;
 		};
 
+		ccu: clock at 01c20000 {
+			compatible = "allwinner,sun4i-a10-ccu";
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
@@ -966,7 +467,7 @@
 			compatible = "allwinner,sun4i-a10-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <28>;
-			clocks = <&apb0_gates 5>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu 74>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -1143,7 +644,7 @@
 			compatible = "allwinner,sun4i-a10-spdif";
 			reg = <0x01c21000 0x400>;
 			interrupts = <13>;
-			clocks = <&apb0_gates 1>, <&spdif_clk>;
+			clocks = <&ccu 70>, <&ccu 120>;
 			clock-names = "apb", "spdif";
 			dmas = <&dma SUN4I_DMA_NORMAL 2>,
 			       <&dma SUN4I_DMA_NORMAL 2>;
@@ -1153,7 +654,7 @@
 
 		ir0: ir at 01c21800 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&apb0_gates 6>, <&ir0_clk>;
+			clocks = <&ccu 75>, <&ccu 116>;
 			clock-names = "apb", "ir";
 			interrupts = <5>;
 			reg = <0x01c21800 0x40>;
@@ -1162,7 +663,7 @@
 
 		ir1: ir at 01c21c00 {
 			compatible = "allwinner,sun4i-a10-ir";
-			clocks = <&apb0_gates 7>, <&ir1_clk>;
+			clocks = <&ccu 76>, <&ccu 117>;
 			clock-names = "apb", "ir";
 			interrupts = <6>;
 			reg = <0x01c21c00 0x40>;
@@ -1181,7 +682,7 @@
 			compatible = "allwinner,sun4i-a10-codec";
 			reg = <0x01c22c00 0x40>;
 			interrupts = <30>;
-			clocks = <&apb0_gates 0>, <&codec_clk>;
+			clocks = <&ccu 69>, <&ccu 160>;
 			clock-names = "apb", "codec";
 			dmas = <&dma SUN4I_DMA_NORMAL 19>,
 			       <&dma SUN4I_DMA_NORMAL 19>;
@@ -1207,7 +708,7 @@
 			interrupts = <1>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 16>;
+			clocks = <&ccu 88>;
 			status = "disabled";
 		};
 
@@ -1217,7 +718,7 @@
 			interrupts = <2>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 17>;
+			clocks = <&ccu 89>;
 			status = "disabled";
 		};
 
@@ -1227,7 +728,7 @@
 			interrupts = <3>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 18>;
+			clocks = <&ccu 90>;
 			status = "disabled";
 		};
 
@@ -1237,7 +738,7 @@
 			interrupts = <4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 19>;
+			clocks = <&ccu 91>;
 			status = "disabled";
 		};
 
@@ -1247,7 +748,7 @@
 			interrupts = <17>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 20>;
+			clocks = <&ccu 92>;
 			status = "disabled";
 		};
 
@@ -1257,7 +758,7 @@
 			interrupts = <18>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 21>;
+			clocks = <&ccu 93>;
 			status = "disabled";
 		};
 
@@ -1267,7 +768,7 @@
 			interrupts = <19>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 22>;
+			clocks = <&ccu 94>;
 			status = "disabled";
 		};
 
@@ -1277,7 +778,7 @@
 			interrupts = <20>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 23>;
+			clocks = <&ccu 95>;
 			status = "disabled";
 		};
 
@@ -1285,7 +786,7 @@
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a000 0x400>;
 			interrupts = <62>;
-			clocks = <&apb1_gates 6>;
+			clocks = <&ccu 85>;
 			status = "disabled";
 		};
 
@@ -1293,7 +794,7 @@
 			compatible = "allwinner,sun4i-a10-ps2";
 			reg = <0x01c2a400 0x400>;
 			interrupts = <63>;
-			clocks = <&apb1_gates 7>;
+			clocks = <&ccu 86>;
 			status = "disabled";
 		};
 
@@ -1301,7 +802,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
-			clocks = <&apb1_gates 0>;
+			clocks = <&ccu 79>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1311,7 +812,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
-			clocks = <&apb1_gates 1>;
+			clocks = <&ccu 80>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1321,7 +822,7 @@
 			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
-			clocks = <&apb1_gates 2>;
+			clocks = <&ccu 81>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -1331,7 +832,7 @@
 			compatible = "allwinner,sun4i-a10-can";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <26>;
-			clocks = <&apb1_gates 4>;
+			clocks = <&ccu 83>;
 			status = "disabled";
 		};
 	};
-- 
git-series 0.9.1
