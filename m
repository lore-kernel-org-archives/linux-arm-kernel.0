From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Jan 2017 10:32:30 +0800
Subject: [PATCH 11/11] ARM: dts: sun9i: Switch to new clock bindings
In-Reply-To: <20170124023230.3990-1-wens@csie.org>
References: <20170124023230.3990-1-wens@csie.org>
Message-ID: <20170124023230.3990-12-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a full clock driver for sun9i, switch to it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 404 +++++++++++----------------------------
 1 file changed, 107 insertions(+), 297 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 18b35fc23f46..b763c61cacba 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -46,6 +46,13 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
+#include <dt-bindings/clock/sun9i-a80-ccu.h>
+#include <dt-bindings/clock/sun9i-a80-de.h>
+#include <dt-bindings/clock/sun9i-a80-usb.h>
+#include <dt-bindings/reset/sun9i-a80-ccu.h>
+#include <dt-bindings/reset/sun9i-a80-de.h>
+#include <dt-bindings/reset/sun9i-a80-usb.h>
+
 / {
 	interrupt-parent = <&gic>;
 
@@ -157,228 +164,13 @@
 			clock-output-names = "osc32k";
 		};
 
-		usb_mod_clk: clk at 00a08000 {
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun9i-a80-usb-mod-clk";
-			reg = <0x00a08000 0x4>;
-			clocks = <&ahb1_gates 1>;
-			clock-output-names = "usb0_ahb", "usb_ohci0",
-					     "usb1_ahb", "usb_ohci1",
-					     "usb2_ahb", "usb_ohci2";
-		};
-
-		usb_phy_clk: clk at 00a08004 {
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			compatible = "allwinner,sun9i-a80-usb-phy-clk";
-			reg = <0x00a08004 0x4>;
-			clocks = <&ahb1_gates 1>;
-			clock-output-names = "usb_phy0", "usb_hsic1_480M",
-					     "usb_phy1", "usb_hsic2_480M",
-					     "usb_phy2", "usb_hsic_12M";
-		};
-
-		pll3: clk at 06000008 {
-			/* placeholder until implemented */
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-rate = <0>;
-			clock-output-names = "pll3";
-		};
-
-		pll4: clk at 0600000c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-pll4-clk";
-			reg = <0x0600000c 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll4";
-		};
-
-		pll12: clk at 0600002c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-pll4-clk";
-			reg = <0x0600002c 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll12";
-		};
-
-		gt_clk: clk at 0600005c {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-gt-clk";
-			reg = <0x0600005c 0x4>;
-			clocks = <&osc24M>, <&pll4>, <&pll12>, <&pll12>;
-			clock-output-names = "gt";
-		};
-
-		ahb0: clk at 06000060 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-ahb-clk";
-			reg = <0x06000060 0x4>;
-			clocks = <&gt_clk>, <&pll4>, <&pll12>, <&pll12>;
-			clock-output-names = "ahb0";
-		};
-
-		ahb1: clk at 06000064 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-ahb-clk";
-			reg = <0x06000064 0x4>;
-			clocks = <&gt_clk>, <&pll4>, <&pll12>, <&pll12>;
-			clock-output-names = "ahb1";
-		};
-
-		ahb2: clk at 06000068 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-ahb-clk";
-			reg = <0x06000068 0x4>;
-			clocks = <&gt_clk>, <&pll4>, <&pll12>, <&pll12>;
-			clock-output-names = "ahb2";
-		};
-
-		apb0: clk at 06000070 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-apb0-clk";
-			reg = <0x06000070 0x4>;
-			clocks = <&osc24M>, <&pll4>;
-			clock-output-names = "apb0";
-		};
-
-		apb1: clk at 06000074 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-apb1-clk";
-			reg = <0x06000074 0x4>;
-			clocks = <&osc24M>, <&pll4>;
-			clock-output-names = "apb1";
-		};
-
-		cci400_clk: clk at 06000078 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun9i-a80-gt-clk";
-			reg = <0x06000078 0x4>;
-			clocks = <&osc24M>, <&pll4>, <&pll12>, <&pll12>;
-			clock-output-names = "cci400";
-		};
-
-		mmc0_clk: clk at 06000410 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-mmc-clk";
-			reg = <0x06000410 0x4>;
-			clocks = <&osc24M>, <&pll4>;
-			clock-output-names = "mmc0", "mmc0_output",
-					     "mmc0_sample";
-		};
-
-		mmc1_clk: clk at 06000414 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-mmc-clk";
-			reg = <0x06000414 0x4>;
-			clocks = <&osc24M>, <&pll4>;
-			clock-output-names = "mmc1", "mmc1_output",
-					     "mmc1_sample";
-		};
-
-		mmc2_clk: clk at 06000418 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-mmc-clk";
-			reg = <0x06000418 0x4>;
-			clocks = <&osc24M>, <&pll4>;
-			clock-output-names = "mmc2", "mmc2_output",
-					     "mmc2_sample";
-		};
-
-		mmc3_clk: clk at 0600041c {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-mmc-clk";
-			reg = <0x0600041c 0x4>;
-			clocks = <&osc24M>, <&pll4>;
-			clock-output-names = "mmc3", "mmc3_output",
-					     "mmc3_sample";
-		};
-
-		ahb0_gates: clk at 06000580 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-ahb0-gates-clk";
-			reg = <0x06000580 0x4>;
-			clocks = <&ahb0>;
-			clock-indices = <0>, <1>, <3>,
-					<5>, <8>, <12>,
-					<13>, <14>,
-					<15>, <16>, <18>,
-					<20>, <21>, <22>,
-					<23>;
-			clock-output-names = "ahb0_fd", "ahb0_ve", "ahb0_gpu",
-					"ahb0_ss", "ahb0_sd", "ahb0_nand1",
-					"ahb0_nand0", "ahb0_sdram",
-					"ahb0_mipi_hsi", "ahb0_sata", "ahb0_ts",
-					"ahb0_spi0", "ahb0_spi1", "ahb0_spi2",
-					"ahb0_spi3";
-		};
-
-		ahb1_gates: clk at 06000584 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-ahb1-gates-clk";
-			reg = <0x06000584 0x4>;
-			clocks = <&ahb1>;
-			clock-indices = <0>, <1>,
-					<17>, <21>,
-					<22>, <23>,
-					<24>;
-			clock-output-names = "ahb1_usbotg", "ahb1_usbhci",
-					"ahb1_gmac", "ahb1_msgbox",
-					"ahb1_spinlock", "ahb1_hstimer",
-					"ahb1_dma";
-		};
-
-		ahb2_gates: clk at 06000588 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-ahb2-gates-clk";
-			reg = <0x06000588 0x4>;
-			clocks = <&ahb2>;
-			clock-indices = <0>, <1>,
-					<2>, <4>, <5>,
-					<7>, <8>, <11>;
-			clock-output-names = "ahb2_lcd0", "ahb2_lcd1",
-					"ahb2_edp", "ahb2_csi", "ahb2_hdmi",
-					"ahb2_de", "ahb2_mp", "ahb2_mipi_dsi";
-		};
-
-		apb0_gates: clk at 06000590 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-apb0-gates-clk";
-			reg = <0x06000590 0x4>;
-			clocks = <&apb0>;
-			clock-indices = <1>, <5>,
-					<11>, <12>, <13>,
-					<15>, <17>, <18>,
-					<19>;
-			clock-output-names = "apb0_spdif", "apb0_pio",
-					"apb0_ac97", "apb0_i2s0", "apb0_i2s1",
-					"apb0_lradc", "apb0_gpadc", "apb0_twd",
-					"apb0_cirtx";
-		};
-
-		apb1_gates: clk at 06000594 {
-			#clock-cells = <1>;
-			compatible = "allwinner,sun9i-a80-apb1-gates-clk";
-			reg = <0x06000594 0x4>;
-			clocks = <&apb1>;
-			clock-indices = <0>, <1>,
-					<2>, <3>, <4>,
-					<16>, <17>,
-					<18>, <19>,
-					<20>, <21>;
-			clock-output-names = "apb1_i2c0", "apb1_i2c1",
-					"apb1_i2c2", "apb1_i2c3", "apb1_i2c4",
-					"apb1_uart0", "apb1_uart1",
-					"apb1_uart2", "apb1_uart3",
-					"apb1_uart4", "apb1_uart5";
-		};
-
 		cpus_clk: clk at 08001410 {
 			compatible = "allwinner,sun9i-a80-cpus-clk";
 			reg = <0x08001410 0x4>;
 			#clock-cells = <0>;
-			clocks = <&osc32k>, <&osc24M>, <&pll4>, <&pll3>;
+			clocks = <&osc32k>, <&osc24M>,
+				 <&ccu CLK_PLL_PERIPH0>,
+				 <&ccu CLK_PLL_AUDIO>;
 			clock-output-names = "cpus";
 		};
 
@@ -451,8 +243,8 @@
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a00000 0x100>;
 			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_mod_clk 1>;
-			resets = <&usb_mod_clk 17>;
+			clocks = <&usb_clocks CLK_BUS_HCI0>;
+			resets = <&usb_clocks RST_USB0_HCI>;
 			phys = <&usbphy1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -462,8 +254,9 @@
 			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
 			reg = <0x00a00400 0x100>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_mod_clk 1>, <&usb_mod_clk 2>;
-			resets = <&usb_mod_clk 17>;
+			clocks = <&usb_clocks CLK_BUS_HCI0>,
+				 <&usb_clocks CLK_USB_OHCI0>;
+			resets = <&usb_clocks RST_USB0_HCI>;
 			phys = <&usbphy1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -472,9 +265,9 @@
 		usbphy1: phy at 00a00800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a00800 0x4>;
-			clocks = <&usb_phy_clk 1>;
+			clocks = <&usb_clocks CLK_USB0_PHY>;
 			clock-names = "phy";
-			resets = <&usb_phy_clk 17>;
+			resets = <&usb_clocks RST_USB0_PHY>;
 			reset-names = "phy";
 			status = "disabled";
 			#phy-cells = <0>;
@@ -484,8 +277,8 @@
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a01000 0x100>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_mod_clk 3>;
-			resets = <&usb_mod_clk 18>;
+			clocks = <&usb_clocks CLK_BUS_HCI1>;
+			resets = <&usb_clocks RST_USB1_HCI>;
 			phys = <&usbphy2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -494,11 +287,16 @@
 		usbphy2: phy at 00a01800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a01800 0x4>;
-			clocks = <&usb_phy_clk 2>, <&usb_phy_clk 10>,
-				 <&usb_phy_clk 3>;
-			clock-names = "hsic_480M", "hsic_12M", "phy";
-			resets = <&usb_phy_clk 18>, <&usb_phy_clk 19>;
-			reset-names = "hsic", "phy";
+			clocks = <&usb_clocks CLK_USB1_HSIC>,
+				 <&usb_clocks CLK_USB_HSIC>,
+				 <&usb_clocks CLK_USB1_PHY>;
+			clock-names = "hsic_480M",
+				      "hsic_12M",
+				      "phy";
+			resets = <&usb_clocks RST_USB1_HSIC>,
+				 <&usb_clocks RST_USB1_PHY>;
+			reset-names = "hsic",
+				      "phy";
 			status = "disabled";
 			#phy-cells = <0>;
 			/* usb1 is always used with HSIC */
@@ -509,8 +307,8 @@
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a02000 0x100>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_mod_clk 5>;
-			resets = <&usb_mod_clk 19>;
+			clocks = <&usb_clocks CLK_BUS_HCI2>;
+			resets = <&usb_clocks RST_USB2_HCI>;
 			phys = <&usbphy3>;
 			phy-names = "usb";
 			status = "disabled";
@@ -520,8 +318,9 @@
 			compatible = "allwinner,sun9i-a80-ohci", "generic-ohci";
 			reg = <0x00a02400 0x100>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&usb_mod_clk 5>, <&usb_mod_clk 6>;
-			resets = <&usb_mod_clk 19>;
+			clocks = <&usb_clocks CLK_BUS_HCI2>,
+				 <&usb_clocks CLK_USB_OHCI2>;
+			resets = <&usb_clocks RST_USB2_HCI>;
 			phys = <&usbphy3>;
 			phy-names = "usb";
 			status = "disabled";
@@ -530,20 +329,35 @@
 		usbphy3: phy at 00a02800 {
 			compatible = "allwinner,sun9i-a80-usb-phy";
 			reg = <0x00a02800 0x4>;
-			clocks = <&usb_phy_clk 4>, <&usb_phy_clk 10>,
-				 <&usb_phy_clk 5>;
-			clock-names = "hsic_480M", "hsic_12M", "phy";
-			resets = <&usb_phy_clk 20>, <&usb_phy_clk 21>;
-			reset-names = "hsic", "phy";
+			clocks = <&usb_clocks CLK_USB2_HSIC>,
+				 <&usb_clocks CLK_USB_HSIC>,
+				 <&usb_clocks CLK_USB2_PHY>;
+			clock-names = "hsic_480M",
+				      "hsic_12M",
+				      "phy";
+			resets = <&usb_clocks RST_USB2_HSIC>,
+				 <&usb_clocks RST_USB2_PHY>;
+			reset-names = "hsic",
+				      "phy";
 			status = "disabled";
 			#phy-cells = <0>;
 		};
 
+		usb_clocks: clock at 00a08000 {
+			compatible = "allwinner,sun9i-a80-usb-clks";
+			reg = <0x00a08000 0x8>;
+			clocks = <&ccu CLK_BUS_USB>, <&osc24M>;
+			clock-names = "bus", "hosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
 		mmc0: mmc at 01c0f000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c0f000 0x1000>;
-			clocks = <&mmc_config_clk 0>, <&mmc0_clk 0>,
-				 <&mmc0_clk 1>, <&mmc0_clk 2>;
+			clocks = <&mmc_config_clk 0>, <&ccu CLK_MMC0>,
+				 <&ccu CLK_MMC0_OUTPUT>,
+				 <&ccu CLK_MMC0_SAMPLE>;
 			clock-names = "ahb", "mmc", "output", "sample";
 			resets = <&mmc_config_clk 0>;
 			reset-names = "ahb";
@@ -556,8 +370,9 @@
 		mmc1: mmc at 01c10000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c10000 0x1000>;
-			clocks = <&mmc_config_clk 1>, <&mmc1_clk 0>,
-				 <&mmc1_clk 1>, <&mmc1_clk 2>;
+			clocks = <&mmc_config_clk 1>, <&ccu CLK_MMC1>,
+				 <&ccu CLK_MMC1_OUTPUT>,
+				 <&ccu CLK_MMC1_SAMPLE>;
 			clock-names = "ahb", "mmc", "output", "sample";
 			resets = <&mmc_config_clk 1>;
 			reset-names = "ahb";
@@ -570,8 +385,9 @@
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c11000 0x1000>;
-			clocks = <&mmc_config_clk 2>, <&mmc2_clk 0>,
-				 <&mmc2_clk 1>, <&mmc2_clk 2>;
+			clocks = <&mmc_config_clk 2>, <&ccu CLK_MMC2>,
+				 <&ccu CLK_MMC2_OUTPUT>,
+				 <&ccu CLK_MMC2_SAMPLE>;
 			clock-names = "ahb", "mmc", "output", "sample";
 			resets = <&mmc_config_clk 2>;
 			reset-names = "ahb";
@@ -584,8 +400,9 @@
 		mmc3: mmc at 01c12000 {
 			compatible = "allwinner,sun9i-a80-mmc";
 			reg = <0x01c12000 0x1000>;
-			clocks = <&mmc_config_clk 3>, <&mmc3_clk 0>,
-				 <&mmc3_clk 1>, <&mmc3_clk 2>;
+			clocks = <&mmc_config_clk 3>, <&ccu CLK_MMC3>,
+				 <&ccu CLK_MMC3_OUTPUT>,
+				 <&ccu CLK_MMC3_SAMPLE>;
 			clock-names = "ahb", "mmc", "output", "sample";
 			resets = <&mmc_config_clk 3>;
 			reset-names = "ahb";
@@ -598,9 +415,9 @@
 		mmc_config_clk: clk at 01c13000 {
 			compatible = "allwinner,sun9i-a80-mmc-config-clk";
 			reg = <0x01c13000 0x10>;
-			clocks = <&ahb0_gates 8>;
+			clocks = <&ccu CLK_BUS_MMC>;
 			clock-names = "ahb";
-			resets = <&ahb0_resets 8>;
+			resets = <&ccu RST_BUS_MMC>;
 			reset-names = "ahb";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -619,34 +436,27 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
-		ahb0_resets: reset at 060005a0 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x060005a0 0x4>;
-		};
-
-		ahb1_resets: reset at 060005a4 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x060005a4 0x4>;
-		};
-
-		ahb2_resets: reset at 060005a8 {
-			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x060005a8 0x4>;
-		};
-
-		apb0_resets: reset at 060005b0 {
+		de_clocks: clock at 03000000 {
+			compatible = "allwinner,sun9i-a80-de-clks";
+			reg = <0x03000000 0x30>;
+			clocks = <&ccu CLK_DE>,
+				 <&ccu CLK_SDRAM>,
+				 <&ccu CLK_BUS_DE>;
+			clock-names = "mod",
+				      "dram",
+				      "bus";
+			resets = <&ccu RST_BUS_DE>;
+			#clock-cells = <1>;
 			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x060005b0 0x4>;
 		};
 
-		apb1_resets: reset at 060005b4 {
+		ccu: clock at 06000000 {
+			compatible = "allwinner,sun9i-a80-ccu";
+			reg = <0x06000000 0x800>;
+			clocks = <&osc24M>, <&osc32k>;
+			clock-names = "hosc", "losc";
+			#clock-cells = <1>;
 			#reset-cells = <1>;
-			compatible = "allwinner,sun6i-a31-clock-reset";
-			reg = <0x060005b4 0x4>;
 		};
 
 		timer at 06000c00 {
@@ -676,7 +486,7 @@
 				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb0_gates 5>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -732,8 +542,8 @@
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 16>;
-			resets = <&apb1_resets 16>;
+			clocks = <&ccu CLK_BUS_UART0>;
+			resets = <&ccu RST_BUS_UART0>;
 			status = "disabled";
 		};
 
@@ -743,8 +553,8 @@
 			interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 17>;
-			resets = <&apb1_resets 17>;
+			clocks = <&ccu CLK_BUS_UART1>;
+			resets = <&ccu RST_BUS_UART1>;
 			status = "disabled";
 		};
 
@@ -754,8 +564,8 @@
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 18>;
-			resets = <&apb1_resets 18>;
+			clocks = <&ccu CLK_BUS_UART2>;
+			resets = <&ccu RST_BUS_UART2>;
 			status = "disabled";
 		};
 
@@ -765,8 +575,8 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 19>;
-			resets = <&apb1_resets 19>;
+			clocks = <&ccu CLK_BUS_UART3>;
+			resets = <&ccu RST_BUS_UART3>;
 			status = "disabled";
 		};
 
@@ -776,8 +586,8 @@
 			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 20>;
-			resets = <&apb1_resets 20>;
+			clocks = <&ccu CLK_BUS_UART4>;
+			resets = <&ccu RST_BUS_UART4>;
 			status = "disabled";
 		};
 
@@ -787,8 +597,8 @@
 			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&apb1_gates 21>;
-			resets = <&apb1_resets 21>;
+			clocks = <&ccu CLK_BUS_UART5>;
+			resets = <&ccu RST_BUS_UART5>;
 			status = "disabled";
 		};
 
@@ -796,8 +606,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07002800 0x400>;
 			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 0>;
-			resets = <&apb1_resets 0>;
+			clocks = <&ccu CLK_BUS_I2C0>;
+			resets = <&ccu RST_BUS_I2C0>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -807,8 +617,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07002c00 0x400>;
 			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 1>;
-			resets = <&apb1_resets 1>;
+			clocks = <&ccu CLK_BUS_I2C1>;
+			resets = <&ccu RST_BUS_I2C1>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -818,8 +628,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003000 0x400>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 2>;
-			resets = <&apb1_resets 2>;
+			clocks = <&ccu CLK_BUS_I2C2>;
+			resets = <&ccu RST_BUS_I2C2>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -829,8 +639,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003400 0x400>;
 			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 3>;
-			resets = <&apb1_resets 3>;
+			clocks = <&ccu CLK_BUS_I2C3>;
+			resets = <&ccu RST_BUS_I2C3>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -840,8 +650,8 @@
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x07003800 0x400>;
 			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb1_gates 4>;
-			resets = <&apb1_resets 4>;
+			clocks = <&ccu CLK_BUS_I2C4>;
+			resets = <&ccu RST_BUS_I2C4>;
 			status = "disabled";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.11.0
