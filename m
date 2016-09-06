From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 Sep 2016 14:18:37 +0200
Subject: [PATCH v2 7/7] ARM: sun8i: Convert the A23 and A33 to the CCU
In-Reply-To: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
References: <20160906121837.7517-1-maxime.ripard@free-electrons.com>
Message-ID: <20160906121837.7517-8-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have support for the CCU driver in sunxi-ng, convert the A23
and A33 DTs to that driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 257 ++++++++---------------------------
 arch/arm/boot/dts/sun8i-a23.dtsi     |  51 ++-----
 arch/arm/boot/dts/sun8i-a33.dtsi     |  73 ++--------
 3 files changed, 75 insertions(+), 306 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 6d6509c71009..7246663bacdd 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -46,7 +46,9 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include <dt-bindings/clock/sun8i-a23-a33-ccu.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/reset/sun8i-a23-a33-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -60,7 +62,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0";
-			clocks = <&pll6 0>;
+			clocks = <&ccu CLK_BUS_LCD>, <&ccu CLK_BUS_DE_BE>,
+				 <&ccu CLK_LCD_CH0>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_DRAM_DE_BE>, <&ccu CLK_DRC>;
 			status = "disabled";
 		};
 	};
@@ -111,151 +115,6 @@
 			clock-frequency = <32768>;
 			clock-output-names = "osc32k";
 		};
-
-		pll1: clk at 01c20000 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-pll1-clk";
-			reg = <0x01c20000 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll1";
-		};
-
-		/* dummy clock until actually implemented */
-		pll5: pll5_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-			clock-output-names = "pll5";
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
-		cpu: cpu_clk at 01c20050 {
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
-		axi: axi_clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-axi-clk";
-			reg = <0x01c20050 0x4>;
-			clocks = <&cpu>;
-			clock-output-names = "axi";
-		};
-
-		ahb1: ahb1_clk at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun6i-a31-ahb1-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&axi>, <&pll6 0>;
-			clock-output-names = "ahb1";
-		};
-
-		apb1: apb1_clk at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb0-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&ahb1>;
-			clock-output-names = "apb1";
-		};
-
-		apb1_gates: clk at 01c20068 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a23-apb1-gates-clk";
-			reg = <0x01c20068 0x4>;
-			clocks = <&apb1>;
-			clock-indices = <0>, <5>,
-					<12>, <13>;
-			clock-output-names = "apb1_codec", "apb1_pio",
-					"apb1_daudio0",	"apb1_daudio1";
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
-			compatible = "allwinner,sun8i-a23-apb2-gates-clk";
-			reg = <0x01c2006c 0x4>;
-			clocks = <&apb2>;
-			clock-indices = <0>, <1>,
-					<2>, <16>,
-					<17>, <18>,
-					<19>, <20>;
-			clock-output-names = "apb2_i2c0", "apb2_i2c1",
-					"apb2_i2c2", "apb2_uart0",
-					"apb2_uart1", "apb2_uart2",
-					"apb2_uart3", "apb2_uart4";
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
-		nand_clk: clk at 01c20080 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-mod0-clk";
-			reg = <0x01c20080 0x4>;
-			clocks = <&osc24M>, <&pll6 1>;
-			clock-output-names = "nand";
-		};
-
-		usb_clk: clk at 01c200cc {
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun8i-a23-usb-clk";
-			reg = <0x01c200cc 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "usb_phy0", "usb_phy1", "usb_hsic",
-					     "usb_hsic_12M", "usb_ohci0";
-		};
 	};
 
 	soc at 01c00000 {
@@ -268,23 +127,23 @@
 			compatible = "allwinner,sun8i-a23-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 6>;
-			resets = <&ahb1_rst 6>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
 			#dma-cells = <1>;
 		};
 
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb1_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
+			clocks = <&ccu CLK_BUS_MMC0>,
+				 <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 8>;
+			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -295,15 +154,15 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb1_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
+			clocks = <&ccu CLK_BUS_MMC1>,
+				 <&ccu CLK_MMC1>,
+				 <&ccu CLK_MMC1_OUTPUT>,
+				 <&ccu CLK_MMC1_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 9>;
+			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -314,15 +173,15 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb1_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
+			clocks = <&ccu CLK_BUS_MMC2>,
+				 <&ccu CLK_MMC2>,
+				 <&ccu CLK_MMC2_OUTPUT>,
+				 <&ccu CLK_MMC2_SAMPLE>;
 			clock-names = "ahb",
 				      "mmc",
 				      "output",
 				      "sample";
-			resets = <&ahb1_rst 10>;
+			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -334,9 +193,9 @@
 			compatible = "allwinner,sun4i-a10-nand";
 			reg = <0x01c03000 0x1000>;
 			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 13>, <&nand_clk>;
+			clocks = <&ccu CLK_BUS_NAND>, <&ccu CLK_NAND>;
 			clock-names = "ahb", "mod";
-			resets = <&ahb1_rst 13>;
+			resets = <&ccu RST_BUS_NAND>;
 			reset-names = "ahb";
 			status = "disabled";
 			#address-cells = <1>;
@@ -347,8 +206,8 @@
 			compatible = "allwinner,sun8i-a23-ehci", "generic-ehci";
 			reg = <0x01c1a000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 26>;
-			resets = <&ahb1_rst 26>;
+			clocks = <&ccu CLK_BUS_EHCI>;
+			resets = <&ccu RST_BUS_EHCI>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -358,18 +217,26 @@
 			compatible = "allwinner,sun8i-a23-ohci", "generic-ohci";
 			reg = <0x01c1a400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 29>, <&usb_clk 16>;
-			resets = <&ahb1_rst 29>;
+			clocks = <&ccu CLK_BUS_OHCI>, <&ccu CLK_USB_OHCI>;
+			resets = <&ccu RST_BUS_OHCI>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
 		};
 
+		ccu: clock at 01c20000 {
+			reg = <0x01c20000 0x400>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
 			/* interrupts get set in SoC specific dtsi file */
-			clocks = <&apb1_gates 5>;
+			clocks = <&ccu CLK_BUS_PIO>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
@@ -437,24 +304,6 @@
 			};
 		};
 
-		ahb1_rst: reset at 01c202c0 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
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
@@ -490,8 +339,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 16>;
-			resets = <&apb2_rst 16>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -503,8 +352,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 17>;
-			resets = <&apb2_rst 17>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
 			dmas = <&dma 7>, <&dma 7>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -516,8 +365,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 18>;
-			resets = <&apb2_rst 18>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
 			dmas = <&dma 8>, <&dma 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -529,8 +378,8 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 19>;
-			resets = <&apb2_rst 19>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
 			dmas = <&dma 9>, <&dma 9>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -542,8 +391,8 @@
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb2_gates 20>;
-			resets = <&apb2_rst 20>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
 			dmas = <&dma 10>, <&dma 10>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -553,8 +402,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 0>;
-			resets = <&apb2_rst 0>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -564,8 +413,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 1>;
-			resets = <&apb2_rst 1>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -575,8 +424,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb2_gates 2>;
-			resets = <&apb2_rst 2>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 92e6616979ea..a915feb3a494 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -49,47 +49,12 @@
 		reg = <0x40000000 0x40000000>;
 	};
 
-	clocks {
-		ahb1_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a23-ahb1-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb1>;
-			clock-indices = <1>, <6>,
-					<8>, <9>, <10>,
-					<13>, <14>,
-					<19>, <20>,
-					<21>, <24>, <26>,
-					<29>, <32>, <36>,
-					<40>, <44>, <46>,
-					<52>, <53>,
-					<54>, <57>;
-			clock-output-names = "ahb1_mipidsi", "ahb1_dma",
-					"ahb1_mmc0", "ahb1_mmc1", "ahb1_mmc2",
-					"ahb1_nand", "ahb1_sdram",
-					"ahb1_hstimer", "ahb1_spi0",
-					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
-					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
-					"ahb1_csi", "ahb1_be",	"ahb1_fe",
-					"ahb1_gpu", "ahb1_msgbox",
-					"ahb1_spinlock", "ahb1_drc";
-		};
-
-		mbus_clk: clk at 01c2015c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-mbus-clk";
-			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
-			clock-output-names = "mbus";
-		};
-	};
-
 	soc at 01c00000 {
 		usb_otg: usb at 01c19000 {
 			compatible = "allwinner,sun6i-a31-musb";
 			reg = <0x01c19000 0x0400>;
-			clocks = <&ahb1_gates 24>;
-			resets = <&ahb1_rst 24>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -104,12 +69,12 @@
 			      <0x01c1a800 0x4>;
 			reg-names = "phy_ctrl",
 				    "pmu1";
-			clocks = <&usb_clk 8>,
-				 <&usb_clk 9>;
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>;
 			clock-names = "usb0_phy",
 				      "usb1_phy";
-			resets = <&usb_clk 0>,
-				 <&usb_clk 1>;
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
 			reset-names = "usb0_reset",
 				      "usb1_reset";
 			status = "disabled";
@@ -118,6 +83,10 @@
 	};
 };
 
+&ccu {
+	compatible = "allwinner,sun8i-a23-ccu";
+};
+
 &pio {
 	compatible = "allwinner,sun8i-a23-pinctrl";
 	interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 001d8402ca18..f3d91d2c96ef 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -63,75 +63,22 @@
 		reg = <0x40000000 0x80000000>;
 	};
 
-	clocks {
-		/* Dummy clock for pll11 (DDR1) until actually implemented */
-		pll11: pll11_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <0>;
-			clock-output-names = "pll11";
-		};
-
-		ahb1_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-a33-ahb1-gates-clk";
-			reg = <0x01c20060 0x8>;
-			clocks = <&ahb1>;
-			clock-indices = <1>, <5>,
-				        <6>, <8>, <9>,
-				        <10>, <13>, <14>,
-					<19>, <20>,
-					<21>, <24>, <26>,
-					<29>, <32>, <36>,
-					<40>, <44>, <46>,
-					<52>, <53>,
-					<54>, <57>,
-					<58>;
-			clock-output-names = "ahb1_mipidsi", "ahb1_ss",
-					"ahb1_dma","ahb1_mmc0", "ahb1_mmc1",
-					"ahb1_mmc2", "ahb1_nand", "ahb1_sdram",
-					"ahb1_hstimer", "ahb1_spi0",
-					"ahb1_spi1", "ahb1_otg", "ahb1_ehci",
-					"ahb1_ohci", "ahb1_ve", "ahb1_lcd",
-					"ahb1_csi", "ahb1_be",	"ahb1_fe",
-					"ahb1_gpu", "ahb1_msgbox",
-					"ahb1_spinlock", "ahb1_drc",
-					"ahb1_sat";
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
-		mbus_clk: clk at 01c2015c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-mbus-clk";
-			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5>, <&pll11>;
-			clock-output-names = "mbus";
-		};
-	};
-
 	soc at 01c00000 {
 		crypto: crypto-engine at 01c15000 {
 			compatible = "allwinner,sun4i-a10-crypto";
 			reg = <0x01c15000 0x1000>;
 			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ahb1_gates 5>, <&ss_clk>;
+			clocks = <&ccu CLK_BUS_SS>, <&ccu CLK_SS>;
 			clock-names = "ahb", "mod";
-			resets = <&ahb1_rst 5>;
+			resets = <&ccu RST_BUS_SS>;
 			reset-names = "ahb";
 		};
 
 		usb_otg: usb at 01c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-			clocks = <&ahb1_gates 24>;
-			resets = <&ahb1_rst 24>;
+			clocks = <&ccu CLK_BUS_OTG>;
+			resets = <&ccu RST_BUS_OTG>;
 			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "mc";
 			phys = <&usbphy 0>;
@@ -146,12 +93,12 @@
 			      <0x01c1a800 0x4>;
 			reg-names = "phy_ctrl",
 				    "pmu1";
-			clocks = <&usb_clk 8>,
-				 <&usb_clk 9>;
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>;
 			clock-names = "usb0_phy",
 				      "usb1_phy";
-			resets = <&usb_clk 0>,
-				 <&usb_clk 1>;
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>;
 			reset-names = "usb0_reset",
 				      "usb1_reset";
 			status = "disabled";
@@ -160,6 +107,10 @@
 	};
 };
 
+&ccu {
+	compatible = "allwinner,sun8i-a33-ccu";
+};
+
 &pio {
 	compatible = "allwinner,sun8i-a33-pinctrl";
 	interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.9.3
