From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  8 May 2016 22:01:51 +0200
Subject: [PATCH 16/16] ARM: dt: sun8i: switch the H3 to the new CCU driver
In-Reply-To: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1462737711-10017-17-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a different clock representation, switch to it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 310 ++++++++--------------------------------
 1 file changed, 58 insertions(+), 252 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b0b0ed..f6ea192abcf6 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -42,8 +42,10 @@
 
 #include "skeleton.dtsi"
 
+#include <dt-bindings/clock/sun8i-h3.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
+#include <dt-bindings/reset/sun8i-h3.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -104,191 +106,6 @@
 			clock-output-names = "osc32k";
 		};
 
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
-		pll6d2: pll6d2_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-factor-clock";
-			clock-div = <2>;
-			clock-mult = <1>;
-			clocks = <&pll6 0>;
-			clock-output-names = "pll6d2";
-		};
-
-		/* dummy clock until pll6 can be reused */
-		pll8: pll8_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <1>;
-			clock-output-names = "pll8";
-		};
-
-		cpu: cpu_clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-cpu-clk";
-			reg = <0x01c20050 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll1>, <&pll1>;
-			clock-output-names = "cpu";
-		};
-
-		axi: axi_clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-axi-clk";
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
-		ahb2: ahb2_clk at 01c2005c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-h3-ahb2-clk";
-			reg = <0x01c2005c 0x4>;
-			clocks = <&ahb1>, <&pll6d2>;
-			clock-output-names = "ahb2";
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
-		apb2: apb2_clk at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc32k>, <&osc24M>, <&pll6 0>, <&pll6 0>;
-			clock-output-names = "apb2";
-		};
-
-		bus_gates: clk at 01c20060 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun8i-h3-bus-gates-clk";
-			reg = <0x01c20060 0x14>;
-			clocks = <&ahb1>, <&ahb2>, <&apb1>, <&apb2>;
-			clock-names = "ahb1", "ahb2", "apb1", "apb2";
-			clock-indices = <5>, <6>, <8>,
-					<9>, <10>, <13>,
-					<14>, <17>, <18>,
-					<19>, <20>,
-					<21>, <23>,
-					<24>, <25>,
-					<26>, <27>,
-					<28>, <29>,
-					<30>, <31>, <32>,
-					<35>, <36>, <37>,
-					<40>, <41>, <43>,
-					<44>, <52>, <53>,
-					<54>, <64>,
-					<65>, <69>, <72>,
-					<76>, <77>, <78>,
-					<96>, <97>, <98>,
-					<112>, <113>,
-					<114>, <115>,
-					<116>, <128>, <135>;
-			clock-output-names = "bus_ce", "bus_dma", "bus_mmc0",
-					     "bus_mmc1", "bus_mmc2", "bus_nand",
-					     "bus_sdram", "bus_gmac", "bus_ts",
-					     "bus_hstimer", "bus_spi0",
-					     "bus_spi1", "bus_otg",
-					     "bus_otg_ehci0", "bus_ehci1",
-					     "bus_ehci2", "bus_ehci3",
-					     "bus_otg_ohci0", "bus_ohci1",
-					     "bus_ohci2", "bus_ohci3", "bus_ve",
-					     "bus_lcd0", "bus_lcd1", "bus_deint",
-					     "bus_csi", "bus_tve", "bus_hdmi",
-					     "bus_de", "bus_gpu", "bus_msgbox",
-					     "bus_spinlock", "bus_codec",
-					     "bus_spdif", "bus_pio", "bus_ths",
-					     "bus_i2s0", "bus_i2s1", "bus_i2s2",
-					     "bus_i2c0", "bus_i2c1", "bus_i2c2",
-					     "bus_uart0", "bus_uart1",
-					     "bus_uart2", "bus_uart3",
-					     "bus_scr", "bus_ephy", "bus_dbg";
-		};
-
-		mmc0_clk: clk at 01c20088 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20088 0x4>;
-			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
-			clock-output-names = "mmc0",
-					     "mmc0_output",
-					     "mmc0_sample";
-		};
-
-		mmc1_clk: clk at 01c2008c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c2008c 0x4>;
-			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
-			clock-output-names = "mmc1",
-					     "mmc1_output",
-					     "mmc1_sample";
-		};
-
-		mmc2_clk: clk at 01c20090 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun4i-a10-mmc-clk";
-			reg = <0x01c20090 0x4>;
-			clocks = <&osc24M>, <&pll6 0>, <&pll8>;
-			clock-output-names = "mmc2",
-					     "mmc2_output",
-					     "mmc2_sample";
-		};
-
-		usb_clk: clk at 01c200cc {
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun8i-h3-usb-clk";
-			reg = <0x01c200cc 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "usb_phy0", "usb_phy1",
-					     "usb_phy2", "usb_phy3",
-					     "usb_ohci0", "usb_ohci1",
-					     "usb_ohci2", "usb_ohci3";
-		};
-
-		mbus_clk: clk at 01c2015c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun8i-a23-mbus-clk";
-			reg = <0x01c2015c 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
-			clock-output-names = "mbus";
-		};
-
 		apb0: apb0_clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;
@@ -327,23 +144,23 @@
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
 			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 6>;
-			resets = <&ahb_rst 6>;
+			clocks = <&ccu CLK_BUS_DMA>;
+			resets = <&ccu RST_BUS_DMA>;
 			#dma-cells = <1>;
 		};
 
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&bus_gates 8>,
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
-			resets = <&ahb_rst 8>;
+			resets = <&ccu RST_BUS_MMC0>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -354,15 +171,15 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&bus_gates 9>,
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
-			resets = <&ahb_rst 9>;
+			resets = <&ccu RST_BUS_MMC1>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -373,15 +190,15 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&bus_gates 10>,
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
-			resets = <&ahb_rst 10>;
+			resets = <&ccu RST_BUS_MMC2>;
 			reset-names = "ahb";
 			interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
@@ -401,18 +218,18 @@
 				    "pmu1",
 				    "pmu2",
 				    "pmu3";
-			clocks = <&usb_clk 8>,
-				 <&usb_clk 9>,
-				 <&usb_clk 10>,
-				 <&usb_clk 11>;
+			clocks = <&ccu CLK_USB_PHY0>,
+				 <&ccu CLK_USB_PHY1>,
+				 <&ccu CLK_USB_PHY2>,
+				 <&ccu CLK_USB_PHY3>;
 			clock-names = "usb0_phy",
 				      "usb1_phy",
 				      "usb2_phy",
 				      "usb3_phy";
-			resets = <&usb_clk 0>,
-				 <&usb_clk 1>,
-				 <&usb_clk 2>,
-				 <&usb_clk 3>;
+			resets = <&ccu RST_USB_PHY0>,
+				 <&ccu RST_USB_PHY1>,
+				 <&ccu RST_USB_PHY2>,
+				 <&ccu RST_USB_PHY3>;
 			reset-names = "usb0_reset",
 				      "usb1_reset",
 				      "usb2_reset",
@@ -425,8 +242,8 @@
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1b000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 25>, <&bus_gates 29>;
-			resets = <&ahb_rst 25>, <&ahb_rst 29>;
+			clocks = <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>;
+			resets = <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -436,9 +253,9 @@
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1b400 0x100>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 29>, <&bus_gates 25>,
-				 <&usb_clk 17>;
-			resets = <&ahb_rst 29>, <&ahb_rst 25>;
+			clocks = <&ccu CLK_BUS_EHCI1>, <&ccu CLK_BUS_OHCI1>,
+				 <&ccu CLK_USB_OHCI1>;
+			resets = <&ccu RST_BUS_EHCI1>, <&ccu RST_BUS_OHCI1>;
 			phys = <&usbphy 1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -448,8 +265,8 @@
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1c000 0x100>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 26>, <&bus_gates 30>;
-			resets = <&ahb_rst 26>, <&ahb_rst 30>;
+			clocks = <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>;
+			resets = <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -459,9 +276,9 @@
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1c400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 30>, <&bus_gates 26>,
-				 <&usb_clk 18>;
-			resets = <&ahb_rst 30>, <&ahb_rst 26>;
+			clocks = <&ccu CLK_BUS_EHCI2>, <&ccu CLK_BUS_OHCI2>,
+				 <&ccu CLK_USB_OHCI2>;
+			resets = <&ccu RST_BUS_EHCI2>, <&ccu RST_BUS_OHCI2>;
 			phys = <&usbphy 2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -471,8 +288,8 @@
 			compatible = "allwinner,sun8i-h3-ehci", "generic-ehci";
 			reg = <0x01c1d000 0x100>;
 			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 27>, <&bus_gates 31>;
-			resets = <&ahb_rst 27>, <&ahb_rst 31>;
+			clocks = <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>;
+			resets = <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;
 			phys = <&usbphy 3>;
 			phy-names = "usb";
 			status = "disabled";
@@ -482,20 +299,27 @@
 			compatible = "allwinner,sun8i-h3-ohci", "generic-ohci";
 			reg = <0x01c1d400 0x100>;
 			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 31>, <&bus_gates 27>,
-				 <&usb_clk 19>;
-			resets = <&ahb_rst 31>, <&ahb_rst 27>;
+			clocks = <&ccu CLK_BUS_EHCI3>, <&ccu CLK_BUS_OHCI3>,
+				 <&ccu CLK_USB_OHCI3>;
+			resets = <&ccu RST_BUS_EHCI3>, <&ccu RST_BUS_OHCI3>;
 			phys = <&usbphy 3>;
 			phy-names = "usb";
 			status = "disabled";
 		};
 
+		ccu: clock at 01c20000 {
+			compatible = "allwinner,sun8i-h3-ccu";
+			reg = <0x01c20000 0x400>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun8i-h3-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&bus_gates 69>;
+			clocks = <&ccu CLK_BUS_PIO>;
 			gpio-controller;
 			#gpio-cells = <3>;
 			interrupt-controller;
@@ -542,24 +366,6 @@
 			};
 		};
 
-		ahb_rst: reset at 01c202c0 {
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
@@ -580,8 +386,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&bus_gates 112>;
-			resets = <&apb2_rst 16>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			dmas = <&dma 6>, <&dma 6>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -593,8 +399,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&bus_gates 113>;
-			resets = <&apb2_rst 17>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
 			dmas = <&dma 7>, <&dma 7>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -606,8 +412,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&bus_gates 114>;
-			resets = <&apb2_rst 18>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
 			dmas = <&dma 8>, <&dma 8>;
 			dma-names = "rx", "tx";
 			status = "disabled";
@@ -619,8 +425,8 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&bus_gates 115>;
-			resets = <&apb2_rst 19>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
 			dmas = <&dma 9>, <&dma 9>;
 			dma-names = "rx", "tx";
 			status = "disabled";
-- 
2.8.2
