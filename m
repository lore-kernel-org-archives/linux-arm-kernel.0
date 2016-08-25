From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 Aug 2016 14:22:00 +0800
Subject: [PATCH v3 6/6] ARM: dts: sun6i: switch A31/A31s to new CCU clock
 bindings
In-Reply-To: <20160825062200.17206-1-wens@csie.org>
References: <20160825062200.17206-1-wens@csie.org>
Message-ID: <20160825062200.17206-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a different clock representation, switch to it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2: none
Changes since v1: none
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 424 +++++++++------------------------------
 1 file changed, 97 insertions(+), 327 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 1867af24ff52..6a84fe7e9ab2 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -47,7 +47,9 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
 
+#include <dt-bindings/clock/sun6i-a31-ccu.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/reset/sun6i-a31-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -65,7 +67,10 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&pll6 0>;
+			clocks = <&ccu CLK_AHB1_BE0>, <&ccu CLK_AHB1_LCD0>,
+				 <&ccu CLK_AHB1_HDMI>, <&ccu CLK_DRAM_BE0>,
+				 <&ccu CLK_IEP_DRC0>, <&ccu CLK_BE0>,
+				 <&ccu CLK_LCD0_CH1>, <&ccu CLK_HDMI>;
 			status = "disabled";
 		};
 
@@ -73,7 +78,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6 0>;
+			clocks = <&ccu CLK_AHB1_BE0>, <&ccu CLK_AHB1_LCD0>,
+				 <&ccu CLK_DRAM_BE0>, <&ccu CLK_IEP_DRC0>,
+				 <&ccu CLK_BE0>, <&ccu CLK_LCD0_CH0>;
 			status = "disabled";
 		};
 	};
@@ -97,7 +104,7 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
-			clocks = <&cpu>;
+			clocks = <&ccu CLK_CPU>;
 			clock-latency = <244144>; /* 8 32k periods */
 			operating-points = <
 				/* kHz	  uV */
@@ -192,235 +199,6 @@
 			clock-output-names = "osc32k";
 		};
 
-		pll1: clk@01c20000 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-pll1-clk";
-			reg = <0x01c20000 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll1";
-		};
-
-		pll6: clk at 01c20028 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun6i-a31-pll6-clk";
-			reg = <0x01c20028 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll6", "pll6x2";
-		};
-
-		cpu: cpu at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-cpu-clk";
-			reg = <0x01c20050 0x4>;
-
-			/*
-			 * PLL1 is listed twice here.
-			 * While it looks suspicious, it's actually documented
-			 * that way both in the datasheet and in the code from
-			 * Allwinner.
-			 */
-			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
-			clock-output-names = "cpu";
-		};
-
-		axi: axi at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-axi-clk";
-			reg = <0x01c20050 0x4>;
-			clocks = <&cpu>;
-			clock-output-names = "axi";
-		};
-
-		ahb1: ahb1 at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-ahb1-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
-			clock-output-names = "ahb1";
-
-			/*
-			 * Clock AHB1 from PLL6, instead of CPU/AXI which
-			 * has rate changes due to cpufreq. Also the DMA
-			 * controller requires AHB1 clocked from PLL6.
-			 */
-			assigned-clocks = <&ahb1>;
-			assigned-clock-parents = <&pll6 0>;
-		};
-
-		ahb1_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun6i-a31-ahb1-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb1>;
-			clock-indices = <1>, <5>,
-					<6>, <8>, <9>,
-					<10>, <11>, <12>,
-					<13>, <14>,
-					<17>, <18>, <19>,
-					<20>, <21>, <22>,
-					<23>, <24>, <26>,
-					<27>, <29>,
-					<30>, <31>, <32>,
-					<36>, <37>, <40>,
-					<43>, <44>, <45>,
-					<46>, <47>, <50>,
-					<52>, <55>, <56>,
-					<57>, <58>;
-			clock-output-names = "ahb1_mipidsi", "ahb1_ss",
-					"ahb1_dma", "ahb1_mmc0", "ahb1_mmc1",
-					"ahb1_mmc2", "ahb1_mmc3", "ahb1_nand1",
-					"ahb1_nand0", "ahb1_sdram",
-					"ahb1_gmac", "ahb1_ts", "ahb1_hstimer",
-					"ahb1_spi0", "ahb1_spi1", "ahb1_spi2",
-					"ahb1_spi3", "ahb1_otg", "ahb1_ehci0",
-					"ahb1_ehci1", "ahb1_ohci0",
-					"ahb1_ohci1", "ahb1_ohci2", "ahb1_ve",
-					"ahb1_lcd0", "ahb1_lcd1", "ahb1_csi",
-					"ahb1_hdmi", "ahb1_de0", "ahb1_de1",
-					"ahb1_fe0", "ahb1_fe1", "ahb1_mp",
-					"ahb1_gpu", "ahb1_deu0", "ahb1_deu1",
-					"ahb1_drc0", "ahb1_drc1";
-		};
-
-		apb1: apb1 at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb0-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&ahb1>;
-			clock-output-names = "apb1";
-		};
-
-		apb1_gates: clk at 01c20068 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun6i-a31-apb1-gates-clk";
-			reg = <0x01c20068 0x4>;
-			clocks = <&apb1>;
-			clock-indices = <0>, <4>,
-					<5>, <12>,
-					<13>;
-			clock-output-names = "apb1_codec", "apb1_digital_mic",
-					"apb1_pio", "apb1_daudio0",
-					"apb1_daudio1";
-		};
-
-		apb2: clk at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
-			clock-output-names = "apb2";
-		};
-
-		apb2_gates: clk at 01c2006c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun6i-a31-apb2-gates-clk";
-			reg = <0x01c2006c 0x4>;
-			clocks = <&apb2>;
-			clock-indices = <0>, <1>,
-					<2>, <3>, <16>,
-					<17>, <18>, <19>,
-					<20>, <21>;
-			clock-output-names = "apb2_i2c0", "apb2_i2c1",
-					     "apb2_i2c2", "apb2_i2c3",
-					     "apb2_uart0", "apb2_uart1",
-					     "apb2_uart2", "apb2_uart3",
-					     "apb2_uart4", "apb2_uart5";
-		};
-
-		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc0",
-					     "mmc0_output",
-					     "mmc0_sample";
-		};
-
-		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc1",
-					     "mmc1_output",
-					     "mmc1_sample";
-		};
-
-		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc2",
-					     "mmc2_output",
-					     "mmc2_sample";
-		};
-
-		mmc3_clk: clk at 01c20094 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20094 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "mmc3",
-					     "mmc3_output",
-					     "mmc3_sample";
-		};
-
-		ss_clk: clk at 01c2009c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c2009c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "ss";
-		};
-
-		spi0_clk: clk at 01c200a0 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200a0 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "spi0";
-		};
-
-		spi1_clk: clk at 01c200a4 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200a4 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "spi1";
-		};
-
-		spi2_clk: clk at 01c200a8 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200a8 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "spi2";
-		};
-
-		spi3_clk: clk at 01c200ac {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c200ac 0x4>;
-			clocks = <&osc24M>, <&pll6 0>;
-			clock-output-names = "spi3";
-		};
-
-		usb_clk: clk at 01c200cc {
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-usb-clk";
-			reg = <0x01c200cc 0x4>;
-			clocks = <&osc24M>;
-			clock-indices = <8>, <9>, <10>,
-					<16>, <17>,
-					<18>;
-			clock-output-names = "usb_phy0", "usb_phy1", "usb_phy2",
-					     "usb_ohci0", "usb_ohci1",
-					     "usb_ohci2";
-		};
-
 		/*
 		 * The following two are dummy clocks, placeholders
 		 * used in the gmac_tx clock. The gmac driver will
@@ -463,23 +241,23 @@
 			compatible = "allwinner,sun6i-a31-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 6>;
-			resets = <&ahb1_rst 6>;
+			clocks = <&ccu CLK_AHB1_DMA>;
+			resets = <&ccu RST_AHB1_DMA>;
 			#dma-cells = <1>;
 		};
 
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb1_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
+			clocks = <&ccu CLK_AHB1_MMC0>,
+				 <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 8>;
+			resets = <&ccu RST_AHB1_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -490,15 +268,15 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb1_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
+			clocks = <&ccu CLK_AHB1_MMC1>,
+				 <&ccu CLK_MMC1>,
+				 <&ccu CLK_MMC1_OUTPUT>,
+				 <&ccu CLK_MMC1_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 9>;
+			resets = <&ccu RST_AHB1_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -509,15 +287,15 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb1_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
+			clocks = <&ccu CLK_AHB1_MMC2>,
+				 <&ccu CLK_MMC2>,
+				 <&ccu CLK_MMC2_OUTPUT>,
+				 <&ccu CLK_MMC2_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 10>;
+			resets = <&ccu RST_AHB1_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -528,15 +306,15 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&ahb1_gates 11>,
-				 <&mmc3_clk 0>,
-				 <&mmc3_clk 1>,
-				 <&mmc3_clk 2>;
+			clocks = <&ccu CLK_AHB1_MMC3>,
+				 <&ccu CLK_MMC3>,
+				 <&ccu CLK_MMC3_OUTPUT>,
+				 <&ccu CLK_MMC3_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 11>;
+			resets = <&ccu RST_AHB1_MMC3>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -547,8 +325,8 @@
 		usb_otg: usb at 01c19000 {
 			compatible = "allwinner,sun6i-a31-musb";
 			reg = <0x01c19000 0x0400>;
-			clocks = <&ahb1_gates 24>;
-			resets = <&ahb1_rst 24>;
+			clocks = <&ccu CLK_AHB1_OTG>;
+			resets = <&ccu RST_AHB1_OTG>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -565,15 +343,15 @@
 			reg-names = "phy_ctrl",
 				    "pmu1",
 				    "pmu2";
-			clocks = <&usb_clk 8>,
-				 <&usb_clk 9>,
-				 <&usb_clk 10>;
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>,
+				 <&ccu CLK_USB_PHY2>;
 			clock-names = "usb0_phy",
 				      "usb1_phy",
 				      "usb2_phy";
-			resets = <&usb_clk 0>,
-				 <&usb_clk 1>,
-				 <&usb_clk 2>;
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>,
+				 <&ccu RST_USB_PHY2>;
 			reset-names = "usb0_reset",
 				      "usb1_reset",
 				      "usb2_reset";
@@ -585,8 +363,8 @@
 			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 26>;
-			resets = <&ahb1_rst 26>;
+			clocks = <&ccu CLK_AHB1_EHCI0>;
+			resets = <&ccu RST_AHB1_EHCI0>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -596,8 +374,8 @@
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 29>, <&usb_clk 16>;
-			resets = <&ahb1_rst 29>;
+			clocks = <&ccu CLK_AHB1_OHCI0>, <&ccu CLK_USB_OHCI0>;
+			resets = <&ccu RST_AHB1_OHCI0>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -607,8 +385,8 @@
 			compatible = "allwinner,sun6i-a31-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 27>;
-			resets = <&ahb1_rst 27>;
+			clocks = <&ccu CLK_AHB1_EHCI1>;
+			resets = <&ccu RST_AHB1_EHCI1>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -618,8 +396,8 @@
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 30>, <&usb_clk 17>;
-			resets = <&ahb1_rst 30>;
+			clocks = <&ccu CLK_AHB1_OHCI1>, <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_AHB1_OHCI1>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -629,11 +407,20 @@
 			compatible = "allwinner,sun6i-a31-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 31>, <&usb_clk 18>;
-			resets = <&ahb1_rst 31>;
+			clocks = <&ccu CLK_AHB1_OHCI2>, <&ccu CLK_USB_OHCI2>;
+			resets = <&ccu RST_AHB1_OHCI2>;
 			status = "disabled";
 		};
 
+		ccu: clock at 01c20000 {
+			compatible = "allwinner,sun6i-a31-ccu";
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
@@ -641,7 +428,7 @@
 				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 5>;
+			clocks = <&ccu CLK_APB1_PIO>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
@@ -762,24 +549,6 @@
 			};
 		};
 
-		ahb1_rst: reset at 01c202c0 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-ahb1-reset";
-			reg = <0x01c202c0 0xc>;
-		};
-
-		apb1_rst: reset at 01c202d0 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x01c202d0 0x4>;
-		};
-
-		apb2_rst: reset at 01c202d8 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x01c202d8 0x4>;
-		};
-
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-a10-timer";
 			reg = <0x01c20c00 0xa0>;
@@ -816,8 +585,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 16>;
-			resets = <&apb2_rst 16>;
+			clocks = <&ccu CLK_APB2_UART0>;
+			resets = <&ccu RST_APB2_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -829,8 +598,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 17>;
-			resets = <&apb2_rst 17>;
+			clocks = <&ccu CLK_APB2_UART1>;
+			resets = <&ccu RST_APB2_UART1>;
 			dmas = <&dma 7>, <&dma 7>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -842,8 +611,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 18>;
-			resets = <&apb2_rst 18>;
+			clocks = <&ccu CLK_APB2_UART2>;
+			resets = <&ccu RST_APB2_UART2>;
 			dmas = <&dma 8>, <&dma 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -855,8 +624,8 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 19>;
-			resets = <&apb2_rst 19>;
+			clocks = <&ccu CLK_APB2_UART3>;
+			resets = <&ccu RST_APB2_UART3>;
 			dmas = <&dma 9>, <&dma 9>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -868,8 +637,8 @@
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 20>;
-			resets = <&apb2_rst 20>;
+			clocks = <&ccu CLK_APB2_UART4>;
+			resets = <&ccu RST_APB2_UART4>;
 			dmas = <&dma 10>, <&dma 10>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -881,8 +650,8 @@
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 21>;
-			resets = <&apb2_rst 21>;
+			clocks = <&ccu CLK_APB2_UART5>;
+			resets = <&ccu RST_APB2_UART5>;
 			dmas = <&dma 22>, <&dma 22>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -892,8 +661,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 0>;
-			resets = <&apb2_rst 0>;
+			clocks = <&ccu CLK_APB2_I2C0>;
+			resets = <&ccu RST_APB2_I2C0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -903,8 +672,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 1>;
-			resets = <&apb2_rst 1>;
+			clocks = <&ccu CLK_APB2_I2C1>;
+			resets = <&ccu RST_APB2_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -914,8 +683,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 2>;
-			resets = <&apb2_rst 2>;
+			clocks = <&ccu CLK_APB2_I2C2>;
+			resets = <&ccu RST_APB2_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -925,8 +694,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 3>;
-			resets = <&apb2_rst 3>;
+			clocks = <&ccu CLK_APB2_I2C3>;
+			resets = <&ccu RST_APB2_I2C3>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -937,9 +706,9 @@
 			reg = <0x01c30000 0x1054>;
 			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
-			clocks = <&ahb1_gates 17>, <&gmac_tx_clk>;
+			clocks = <&ccu CLK_AHB1_EMAC>, <&gmac_tx_clk>;
 			clock-names = "stmmaceth", "allwinner_gmac_tx";
-			resets = <&ahb1_rst 17>;
+			resets = <&ccu RST_AHB1_EMAC>;
 			reset-names = "stmmaceth";
 			snps,pbl = <2>;
 			snps,fixed-burst;
@@ -953,9 +722,9 @@
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 5>, <&ss_clk>;
+			clocks = <&ccu CLK_AHB1_SS>, <&ccu CLK_SS>;
 			clock-names = "ahb", "mod";
-			resets = <&ahb1_rst 5>;
+			resets = <&ccu RST_AHB1_SS>;
 			reset-names = "ahb";
 		};
 
@@ -967,19 +736,19 @@
 				     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 19>;
-			resets = <&ahb1_rst 19>;
+			clocks = <&ccu CLK_AHB1_HSTIMER>;
+			resets = <&ccu RST_AHB1_HSTIMER>;
 		};
 
 		spi0: spi at 01c68000 {
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c68000 0x1000>;
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 20>, <&spi0_clk>;
+			clocks = <&ccu CLK_AHB1_SPI0>, <&ccu CLK_SPI0>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 23>, <&dma 23>;
 			dma-names = "rx", "tx";
-			resets = <&ahb1_rst 20>;
+			resets = <&ccu RST_AHB1_SPI0>;
 			status = "disabled";
 		};
 
@@ -987,11 +756,11 @@
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c69000 0x1000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 21>, <&spi1_clk>;
+			clocks = <&ccu CLK_AHB1_SPI1>, <&ccu CLK_SPI1>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 24>, <&dma 24>;
 			dma-names = "rx", "tx";
-			resets = <&ahb1_rst 21>;
+			resets = <&ccu RST_AHB1_SPI1>;
 			status = "disabled";
 		};
 
@@ -999,11 +768,11 @@
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c6a000 0x1000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 22>, <&spi2_clk>;
+			clocks = <&ccu CLK_AHB1_SPI2>, <&ccu CLK_SPI2>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 25>, <&dma 25>;
 			dma-names = "rx", "tx";
-			resets = <&ahb1_rst 22>;
+			resets = <&ccu RST_AHB1_SPI2>;
 			status = "disabled";
 		};
 
@@ -1011,11 +780,11 @@
 			compatible = "allwinner,sun6i-a31-spi";
 			reg = <0x01c6b000 0x1000>;
 			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 23>, <&spi3_clk>;
+			clocks = <&ccu CLK_AHB1_SPI3>, <&ccu CLK_SPI3>;
 			clock-names = "ahb", "mod";
 			dmas = <&dma 26>, <&dma 26>;
 			dma-names = "rx", "tx";
-			resets = <&ahb1_rst 23>;
+			resets = <&ccu RST_AHB1_SPI3>;
 			status = "disabled";
 		};
 
@@ -1052,8 +821,9 @@
 			ar100: ar100_clk {
 				compatible = "allwinner,sun6i-a31-ar100-clk";
 				#clock-cells = <0>;
-				clocks = <&osc32k>, <&osc24M>, <&pll6 0>,
-					 <&pll6 0>;
+				clocks = <&osc32k>, <&osc24M>,
+					 <&ccu CLK_PLL_PERIPH>,
+					 <&ccu CLK_PLL_PERIPH>;
 				clock-output-names = "ar100";
 			};
 
-- 
2.9.3
