From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  1 Feb 2015 14:49:47 +0100
Subject: [PATCH 03/30] ARM: sun5i: a10s: Move to the common sun5i DTSI
In-Reply-To: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1422798614-3581-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1422798614-3581-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a common DTSI for the sun5i family, move the A10s to use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-a10s.dtsi | 582 ++++----------------------------------
 arch/arm/boot/dts/sun5i.dtsi      |  15 +
 2 files changed, 63 insertions(+), 534 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 3733fc1ed4c7..ef516db5852d 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -49,6 +49,8 @@
 
 #include "skeleton.dtsi"
 
+#include "sun5i.dtsi"
+
 #include <dt-bindings/dma/sun4i-a10.h>
 #include <dt-bindings/pinctrl/sun4i-a10.h>
 
@@ -81,113 +83,7 @@
 		};
 	};
 
-	cpus {
-		cpu at 0 {
-			compatible = "arm,cortex-a8";
-		};
-	};
-
-	memory {
-		reg = <0x40000000 0x20000000>;
-	};
-
 	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
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
-		osc24M: clk at 01c20050 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-osc-clk";
-			reg = <0x01c20050 0x4>;
-			clock-frequency = <24000000>;
-			clock-output-names = "osc24M";
-		};
-
-		osc32k: clk at 0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			clock-output-names = "osc32k";
-		};
-
-		pll1: clk at 01c20000 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-pll1-clk";
-			reg = <0x01c20000 0x4>;
-			clocks = <&osc24M>;
-			clock-output-names = "pll1";
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
 		ahb_gates: clk at 01c20060 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a10s-ahb-gates-clk";
@@ -202,14 +98,6 @@
 				"ahb_de_be", "ahb_de_fe", "ahb_iep", "ahb_mali400";
 		};
 
-		apb0: apb0 at 01c20054 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb0-clk";
-			reg = <0x01c20054 0x4>;
-			clocks = <&ahb>;
-			clock-output-names = "apb0";
-		};
-
 		apb0_gates: clk at 01c20068 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a10s-apb0-gates-clk";
@@ -219,14 +107,6 @@
 				"apb0_ir", "apb0_keypad";
 		};
 
-		apb1: clk at 01c20058 {
-			#clock-cells = <0>;
-			compatible = "allwinner,sun4i-a10-apb1-clk";
-			reg = <0x01c20058 0x4>;
-			clocks = <&osc24M>, <&pll6 1>, <&osc32k>;
-			clock-output-names = "apb1";
-		};
-
 		apb1_gates: clk at 01c2006c {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun5i-a10s-apb1-gates-clk";
@@ -236,161 +116,9 @@
 				"apb1_i2c2", "apb1_uart0", "apb1_uart1",
 				"apb1_uart2", "apb1_uart3";
 		};
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
-		usb_clk: clk at 01c200cc {
-			#clock-cells = <1>;
-		        #reset-cells = <1>;
-			compatible = "allwinner,sun5i-a13-usb-clk";
-			reg = <0x01c200cc 0x4>;
-			clocks = <&pll6 1>;
-			clock-output-names = "usb_ohci0", "usb_phy";
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
 
 	soc at 01c00000 {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		dma: dma-controller at 01c02000 {
-			compatible = "allwinner,sun4i-a10-dma";
-			reg = <0x01c02000 0x1000>;
-			interrupts = <27>;
-			clocks = <&ahb_gates 6>;
-			#dma-cells = <2>;
-		};
-
-		spi0: spi at 01c05000 {
-			compatible = "allwinner,sun4i-a10-spi";
-			reg = <0x01c05000 0x1000>;
-			interrupts = <10>;
-			clocks = <&ahb_gates 20>, <&spi0_clk>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 27>,
-			       <&dma SUN4I_DMA_DEDICATED 26>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		spi1: spi at 01c06000 {
-			compatible = "allwinner,sun4i-a10-spi";
-			reg = <0x01c06000 0x1000>;
-			interrupts = <11>;
-			clocks = <&ahb_gates 21>, <&spi1_clk>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 9>,
-			       <&dma SUN4I_DMA_DEDICATED 8>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
 		emac: ethernet at 01c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
@@ -407,214 +135,6 @@
 			#size-cells = <0>;
 		};
 
-		mmc0: mmc at 01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c0f000 0x1000>;
-			clocks = <&ahb_gates 8>,
-				 <&mmc0_clk 0>,
-				 <&mmc0_clk 1>,
-				 <&mmc0_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			interrupts = <32>;
-			status = "disabled";
-		};
-
-		mmc1: mmc at 01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c10000 0x1000>;
-			clocks = <&ahb_gates 9>,
-				 <&mmc1_clk 0>,
-				 <&mmc1_clk 1>,
-				 <&mmc1_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			interrupts = <33>;
-			status = "disabled";
-		};
-
-		mmc2: mmc at 01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
-			reg = <0x01c11000 0x1000>;
-			clocks = <&ahb_gates 10>,
-				 <&mmc2_clk 0>,
-				 <&mmc2_clk 1>,
-				 <&mmc2_clk 2>;
-			clock-names = "ahb",
-				      "mmc",
-				      "output",
-				      "sample";
-			interrupts = <34>;
-			status = "disabled";
-		};
-
-		usbphy: phy at 01c13400 {
-			#phy-cells = <1>;
-			compatible = "allwinner,sun5i-a13-usb-phy";
-			reg = <0x01c13400 0x10 0x01c14800 0x4>;
-			reg-names = "phy_ctrl", "pmu1";
-			clocks = <&usb_clk 8>;
-			clock-names = "usb_phy";
-			resets = <&usb_clk 0>, <&usb_clk 1>;
-			reset-names = "usb0_reset", "usb1_reset";
-			status = "disabled";
-		};
-
-		ehci0: usb at 01c14000 {
-			compatible = "allwinner,sun5i-a10s-ehci", "generic-ehci";
-			reg = <0x01c14000 0x100>;
-			interrupts = <39>;
-			clocks = <&ahb_gates 1>;
-			phys = <&usbphy 1>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		ohci0: usb at 01c14400 {
-			compatible = "allwinner,sun5i-a10s-ohci", "generic-ohci";
-			reg = <0x01c14400 0x100>;
-			interrupts = <40>;
-			clocks = <&usb_clk 6>, <&ahb_gates 2>;
-			phys = <&usbphy 1>;
-			phy-names = "usb";
-			status = "disabled";
-		};
-
-		spi2: spi at 01c17000 {
-			compatible = "allwinner,sun4i-a10-spi";
-			reg = <0x01c17000 0x1000>;
-			interrupts = <12>;
-			clocks = <&ahb_gates 22>, <&spi2_clk>;
-			clock-names = "ahb", "mod";
-			dmas = <&dma SUN4I_DMA_DEDICATED 29>,
-			       <&dma SUN4I_DMA_DEDICATED 28>;
-			dma-names = "rx", "tx";
-			status = "disabled";
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-
-		intc: interrupt-controller at 01c20400 {
-			compatible = "allwinner,sun4i-a10-ic";
-			reg = <0x01c20400 0x400>;
-			interrupt-controller;
-			#interrupt-cells = <1>;
-		};
-
-		pio: pinctrl at 01c20800 {
-			compatible = "allwinner,sun5i-a10s-pinctrl";
-			reg = <0x01c20800 0x400>;
-			interrupts = <28>;
-			clocks = <&apb0_gates 5>;
-			gpio-controller;
-			interrupt-controller;
-			#interrupt-cells = <2>;
-			#size-cells = <0>;
-			#gpio-cells = <3>;
-
-			uart0_pins_a: uart0 at 0 {
-				allwinner,pins = "PB19", "PB20";
-				allwinner,function = "uart0";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			uart2_pins_a: uart2 at 0 {
-				allwinner,pins = "PC18", "PC19";
-				allwinner,function = "uart2";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			uart3_pins_a: uart3 at 0 {
-				allwinner,pins = "PG9", "PG10";
-				allwinner,function = "uart3";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			emac_pins_a: emac0 at 0 {
-				allwinner,pins = "PA0", "PA1", "PA2",
-						"PA3", "PA4", "PA5", "PA6",
-						"PA7", "PA8", "PA9", "PA10",
-						"PA11", "PA12", "PA13", "PA14",
-						"PA15", "PA16";
-				allwinner,function = "emac";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			i2c0_pins_a: i2c0 at 0 {
-				allwinner,pins = "PB0", "PB1";
-				allwinner,function = "i2c0";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			i2c1_pins_a: i2c1 at 0 {
-				allwinner,pins = "PB15", "PB16";
-				allwinner,function = "i2c1";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			i2c2_pins_a: i2c2 at 0 {
-				allwinner,pins = "PB17", "PB18";
-				allwinner,function = "i2c2";
-				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc0_pins_a: mmc0 at 0 {
-				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
-				allwinner,function = "mmc0";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-
-			mmc1_pins_a: mmc1 at 0 {
-				allwinner,pins = "PG3","PG4","PG5","PG6","PG7","PG8";
-				allwinner,function = "mmc1";
-				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
-				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-			};
-		};
-
-		timer at 01c20c00 {
-			compatible = "allwinner,sun4i-a10-timer";
-			reg = <0x01c20c00 0x90>;
-			interrupts = <22>;
-			clocks = <&osc24M>;
-		};
-
-		wdt: watchdog at 01c20c90 {
-			compatible = "allwinner,sun4i-a10-wdt";
-			reg = <0x01c20c90 0x10>;
-		};
-
-		lradc: lradc at 01c22800 {
-			compatible = "allwinner,sun4i-a10-lradc-keys";
-			reg = <0x01c22800 0x100>;
-			interrupts = <31>;
-			status = "disabled";
-		};
-
-		sid: eeprom at 01c23800 {
-			compatible = "allwinner,sun4i-a10-sid";
-			reg = <0x01c23800 0x10>;
-		};
-
-		rtp: rtp at 01c25000 {
-			compatible = "allwinner,sun4i-a10-ts";
-			reg = <0x01c25000 0x100>;
-			interrupts = <29>;
-			#thermal-sensor-cells = <0>;
-		};
-
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
@@ -625,16 +145,6 @@
 			status = "disabled";
 		};
 
-		uart1: serial at 01c28400 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28400 0x400>;
-			interrupts = <2>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb1_gates 17>;
-			status = "disabled";
-		};
-
 		uart2: serial at 01c28800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28800 0x400>;
@@ -644,52 +154,56 @@
 			clocks = <&apb1_gates 18>;
 			status = "disabled";
 		};
+	};
+};
 
-		uart3: serial at 01c28c00 {
-			compatible = "snps,dw-apb-uart";
-			reg = <0x01c28c00 0x400>;
-			interrupts = <4>;
-			reg-shift = <2>;
-			reg-io-width = <4>;
-			clocks = <&apb1_gates 19>;
-			status = "disabled";
-		};
+&ehci0 {
+	compatible = "allwinner,sun5i-a10s-ehci", "generic-ehci";
+};
 
-		i2c0: i2c at 01c2ac00 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "allwinner,sun5i-a10s-i2c", "allwinner,sun4i-a10-i2c";
-			reg = <0x01c2ac00 0x400>;
-			interrupts = <7>;
-			clocks = <&apb1_gates 0>;
-			status = "disabled";
-		};
+&ohci0 {
+	compatible = "allwinner,sun5i-a10s-ohci", "generic-ohci";
+};
 
-		i2c1: i2c at 01c2b000 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "allwinner,sun5i-a10s-i2c", "allwinner,sun4i-a10-i2c";
-			reg = <0x01c2b000 0x400>;
-			interrupts = <8>;
-			clocks = <&apb1_gates 1>;
-			status = "disabled";
-		};
+&pio {
+	compatible = "allwinner,sun5i-a10s-pinctrl";
 
-		i2c2: i2c at 01c2b400 {
-			#address-cells = <1>;
-			#size-cells = <0>;
-			compatible = "allwinner,sun5i-a10s-i2c", "allwinner,sun4i-a10-i2c";
-			reg = <0x01c2b400 0x400>;
-			interrupts = <9>;
-			clocks = <&apb1_gates 2>;
-			status = "disabled";
-		};
+	uart0_pins_a: uart0 at 0 {
+		allwinner,pins = "PB19", "PB20";
+		allwinner,function = "uart0";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
 
-		timer at 01c60000 {
-			compatible = "allwinner,sun5i-a13-hstimer";
-			reg = <0x01c60000 0x1000>;
-			interrupts = <82>, <83>;
-			clocks = <&ahb_gates 28>;
-		};
+	uart2_pins_a: uart2 at 0 {
+		allwinner,pins = "PC18", "PC19";
+		allwinner,function = "uart2";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	uart3_pins_a: uart3 at 0 {
+		allwinner,pins = "PG9", "PG10";
+		allwinner,function = "uart3";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	emac_pins_a: emac0 at 0 {
+		allwinner,pins = "PA0", "PA1", "PA2",
+				"PA3", "PA4", "PA5", "PA6",
+				"PA7", "PA8", "PA9", "PA10",
+				"PA11", "PA12", "PA13", "PA14",
+				"PA15", "PA16";
+		allwinner,function = "emac";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
+	mmc1_pins_a: mmc1 at 0 {
+		allwinner,pins = "PG3","PG4","PG5","PG6","PG7","PG8";
+		allwinner,function = "mmc1";
+		allwinner,drive = <SUN4I_PINCTRL_30_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 09a7df5107ee..e42cbb03620f 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -349,6 +349,21 @@
 			status = "disabled";
 		};
 
+		mmc1: mmc at 01c10000 {
+			compatible = "allwinner,sun5i-a13-mmc";
+			reg = <0x01c10000 0x1000>;
+			clocks = <&ahb_gates 9>,
+				 <&mmc1_clk 0>,
+				 <&mmc1_clk 1>,
+				 <&mmc1_clk 2>;
+			clock-names = "ahb",
+				      "mmc",
+				      "output",
+				      "sample";
+			interrupts = <33>;
+			status = "disabled";
+		};
+
 		mmc2: mmc at 01c11000 {
 			compatible = "allwinner,sun5i-a13-mmc";
 			reg = <0x01c11000 0x1000>;
-- 
2.2.2
