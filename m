From: david@lechnology.com (David Lechner)
Date: Sat, 20 Jan 2018 11:14:20 -0600
Subject: [PATCH v6 41/41] ARM: dts: da850: Add clocks
In-Reply-To: <1516468460-4908-1-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
Message-ID: <1516468460-4908-42-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds clock provider nodes for da850 and wires them up to all of the
devices.

Signed-off-by: David Lechner <david@lechnology.com>
---

v6 changes:
- updated for device tree bindings changes earlier in this series
- use single async2 clock instead of duplicate fixed factor clocks
- add clock-names property to mdio node

 arch/arm/boot/dts/da850.dtsi | 162 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c66cf78..7f4acd7 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -21,6 +21,36 @@
 			#interrupt-cells = <1>;
 			ti,intc-size = <101>;
 			reg = <0xfffee000 0x2000>;
+			clocks = <&psc0 6>;
+		};
+	};
+	clocks: clocks {
+		ref_clk: ref_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <24000000>;
+			clock-output-names = "ref_clk";
+		};
+		sata_refclk: sata_refclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "sata_refclk";
+			status = "disabled";
+		};
+		usb_refclkin: usb_refclkin {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+			clock-output-names = "usb_refclkin";
+			status = "disabled";
+		};
+		async2_clk: async2 {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clocks = <&pll0_auxclk>;
 		};
 	};
 	dsp: dsp at 11800000 {
@@ -33,6 +63,7 @@
 		reg-names = "l2sram", "l1pram", "l1dram", "host1cfg", "chipsig";
 		interrupt-parent = <&intc>;
 		interrupts = <28>;
+		clocks = <&psc0 15>;
 		status = "disabled";
 	};
 	soc at 1c00000 {
@@ -43,6 +74,36 @@
 		ranges = <0x0 0x01c00000 0x400000>;
 		interrupt-parent = <&intc>;
 
+		psc0: clock-controller at 10000 {
+			compatible = "ti,da850-psc0";
+			reg = <0x10000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&pll0_sysclk 1>, <&pll0_sysclk 2>,
+				 <&pll0_sysclk 4>, <&pll0_sysclk 6>,
+				 <&async1_clk>;
+			clock_names = "pll0_sysclk1", "pll0_sysclk2",
+				      "pll0_sysclk4", "pll0_sysclk6",
+				      "async1";
+		};
+		pll0: clock-controller at 11000 {
+			compatible = "ti,da850-pll0";
+			reg = <0x11000 0x1000>;
+			clocks = <&ref_clk>, <&pll1_sysclk 3>;
+			clock-names = "clksrc", "extclksrc";
+
+			pll0_pllout: pllout {
+				#clock-cells = <0>;
+			};
+			pll0_sysclk: sysclk {
+				#clock-cells = <1>;
+			};
+			pll0_auxclk: auxclk {
+				#clock-cells = <0>;
+			};
+			pll0_obsclk: obsclk {
+				#clock-cells = <0>;
+			};
+		};
 		pmx_core: pinmux at 14120 {
 			compatible = "pinctrl-single";
 			reg = <0x14120 0x50>;
@@ -264,8 +325,43 @@
 			usb_phy: usb-phy {
 				compatible = "ti,da830-usb-phy";
 				#phy-cells = <1>;
+				clocks = <&usb_phy_clk 0>, <&usb_phy_clk 1>;
+				clock-names = "usb20_phy", "usb11_phy";
 				status = "disabled";
 			};
+			usb_phy_clk: usb-phy-clocks {
+				compatible = "ti,da830-usb-phy-clocks";
+				#clock-cells = <1>;
+				clocks = <&psc1 1>, <&usb_refclkin>,
+					 <&pll0_auxclk>;
+				clock-names = "fck", "usb_refclkin", "auxclk";
+			};
+			ehrpwm_tbclk: ehrpwm_tbclk {
+				compatible = "ti,da830-tbclksync";
+				#clock-cells = <0>;
+				clocks = <&psc1 17>;
+				clock-names = "fck";
+			};
+			div4p5_clk: div4.5 {
+				compatible = "ti,da830-div4p5ena";
+				#clock-cells = <0>;
+				clocks = <&pll0_pllout>;
+				clock-names = "pll0_pllout";
+			};
+			async1_clk: async1 {
+				compatible = "ti,da850-async1-clksrc";
+				#clock-cells = <0>;
+				clocks = <&pll0_sysclk 3>, <&div4p5_clk>;
+				clock-names = "pll0_sysclk3", "div4.5";
+			};
+			async3_clk: async3 {
+				compatible = "ti,da850-async3-clksrc";
+				#clock-cells = <0>;
+				clocks = <&pll0_sysclk 2>, <&pll1_sysclk 2>;
+				clock-names = "pll0_sysclk2", "pll1_sysclk2";
+				assigned-clocks = <&async3_clk>;
+				assigned-clock-parents = <&pll1_sysclk 2>;
+			};
 		};
 		edma0: edma at 0 {
 			compatible = "ti,edma3-tpcc";
@@ -277,18 +373,21 @@
 			#dma-cells = <2>;
 
 			ti,tptcs = <&edma0_tptc0 7>, <&edma0_tptc1 0>;
+			clocks = <&psc0 0>;
 		};
 		edma0_tptc0: tptc at 8000 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x8000 0x400>;
 			interrupts = <13>;
 			interrupt-names = "edm3_tcerrint";
+			clocks = <&psc0 1>;
 		};
 		edma0_tptc1: tptc at 8400 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x8400 0x400>;
 			interrupts = <32>;
 			interrupt-names = "edm3_tcerrint";
+			clocks = <&psc0 2>;
 		};
 		edma1: edma at 230000 {
 			compatible = "ti,edma3-tpcc";
@@ -300,12 +399,14 @@
 			#dma-cells = <2>;
 
 			ti,tptcs = <&edma1_tptc0 7>;
+			clocks = <&psc1 0>;
 		};
 		edma1_tptc0: tptc at 238000 {
 			compatible = "ti,edma3-tptc";
 			reg =	<0x238000 0x400>;
 			interrupts = <95>;
 			interrupt-names = "edm3_tcerrint";
+			clocks = <&psc1 21>;
 		};
 		serial0: serial at 42000 {
 			compatible = "ti,da830-uart", "ns16550a";
@@ -313,6 +414,7 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <25>;
+			clocks = <&psc0 9>;
 			status = "disabled";
 		};
 		serial1: serial at 10c000 {
@@ -321,6 +423,7 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <53>;
+			clocks = <&psc1 12>;
 			status = "disabled";
 		};
 		serial2: serial at 10d000 {
@@ -329,6 +432,7 @@
 			reg-io-width = <4>;
 			reg-shift = <2>;
 			interrupts = <61>;
+			clocks = <&psc1 13>;
 			status = "disabled";
 		};
 		rtc0: rtc at 23000 {
@@ -344,6 +448,7 @@
 			interrupts = <15>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&async2_clk>;
 			status = "disabled";
 		};
 		i2c1: i2c at 228000 {
@@ -352,11 +457,18 @@
 			interrupts = <51>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			clocks = <&psc1 11>;
 			status = "disabled";
 		};
+		clocksource: timer at 20000 {
+			compatible = "ti,davinci-timer";
+			reg = <0x20000 0x1000>;
+			clocks = <&async2_clk>;
+		};
 		wdt: wdt at 21000 {
 			compatible = "ti,davinci-wdt";
 			reg = <0x21000 0x1000>;
+			clocks = <&async2_clk>;
 			status = "disabled";
 		};
 		mmc0: mmc at 40000 {
@@ -367,12 +479,14 @@
 			interrupts = <16>;
 			dmas = <&edma0 16 0>, <&edma0 17 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc0 5>;
 			status = "disabled";
 		};
 		vpif: video at 217000 {
 			compatible = "ti,da850-vpif";
 			reg = <0x217000 0x1000>;
 			interrupts = <92>;
+			clocks = <&psc1 9>;
 			status = "disabled";
 
 			/* VPIF capture port */
@@ -395,6 +509,7 @@
 			interrupts = <72>;
 			dmas = <&edma1 28 0>, <&edma1 29 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc1 18>;
 			status = "disabled";
 		};
 		ehrpwm0: pwm at 300000 {
@@ -402,6 +517,8 @@
 				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x300000 0x2000>;
+			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
 		ehrpwm1: pwm at 302000 {
@@ -409,6 +526,8 @@
 				     "ti,am33xx-ehrpwm";
 			#pwm-cells = <3>;
 			reg = <0x302000 0x2000>;
+			clocks = <&psc1 17>, <&ehrpwm_tbclk>;
+			clock-names = "fck", "tbclk";
 			status = "disabled";
 		};
 		ecap0: ecap at 306000 {
@@ -416,6 +535,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x306000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		ecap1: ecap at 307000 {
@@ -423,6 +544,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x307000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		ecap2: ecap at 308000 {
@@ -430,6 +553,8 @@
 				     "ti,am33xx-ecap";
 			#pwm-cells = <3>;
 			reg = <0x308000 0x80>;
+			clocks = <&psc1 20>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		spi0: spi at 41000 {
@@ -442,6 +567,7 @@
 			interrupts = <20>;
 			dmas = <&edma0 14 0>, <&edma0 15 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc0 4>;
 			status = "disabled";
 		};
 		spi1: spi at 30e000 {
@@ -454,6 +580,7 @@
 			interrupts = <56>;
 			dmas = <&edma0 18 0>, <&edma0 19 0>;
 			dma-names = "rx", "tx";
+			clocks = <&psc1 10>;
 			status = "disabled";
 		};
 		usb0: usb at 200000 {
@@ -465,6 +592,7 @@
 			dr_mode = "otg";
 			phys = <&usb_phy 0>;
 			phy-names = "usb-phy";
+			clocks = <&psc1 1>;
 			status = "disabled";
 
 			#address-cells = <1>;
@@ -488,6 +616,7 @@
 				interrupts = <58>;
 				#dma-cells = <2>;
 				#dma-channels = <4>;
+				clocks = <&psc1 1>;
 				status = "okay";
 			};
 		};
@@ -495,13 +624,30 @@
 			compatible = "ti,da850-ahci";
 			reg = <0x218000 0x2000>, <0x22c018 0x4>;
 			interrupts = <67>;
+			clocks = <&psc1 8>, <&sata_refclk>;
+			clock-names = "fck", "refclk";
 			status = "disabled";
 		};
+		pll1: clock-controller at 21a000 {
+			compatible = "ti,da850-pll1";
+			reg = <0x21a000 0x1000>;
+			clocks = <&ref_clk>;
+			clock-names = "clksrc";
+
+			pll1_sysclk: sysclk {
+				#clock-cells = <1>;
+			};
+			pll1_obsclk: obsclk {
+				#clock-cells = <0>;
+			};
+		};
 		mdio: mdio at 224000 {
 			compatible = "ti,davinci_mdio";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x224000 0x1000>;
+			clocks = <&psc1 5>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 		eth0: ethernet at 220000 {
@@ -517,6 +663,7 @@
 					35
 					36
 					>;
+			clocks = <&psc1 5>;
 			status = "disabled";
 		};
 		usb1: usb at 225000 {
@@ -525,6 +672,7 @@
 			interrupts = <59>;
 			phys = <&usb_phy 1>;
 			phy-names = "usb-phy";
+			clocks = <&psc1 2>;
 			status = "disabled";
 		};
 		gpio: gpio at 226000 {
@@ -542,6 +690,16 @@
 			status = "disabled";
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&psc1 3>;
+			clock-names = "gpio";
+		};
+		psc1: clock-controller at 227000 {
+			compatible = "ti,da850-psc1";
+			reg = <0x227000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&pll0_sysclk 2>, <&pll0_sysclk 4>,
+				 <&async3_clk>;
+			clock_names = "pll0_sysclk2", "pll0_sysclk4", "async3";
 		};
 		pinconf: pin-controller at 22c00c {
 			compatible = "ti,da850-pupd";
@@ -560,6 +718,7 @@
 			dmas = <&edma0 1 1>,
 				<&edma0 0 1>;
 			dma-names = "tx", "rx";
+			clocks = <&psc1 7>;
 		};
 
 		lcdc: display at 213000 {
@@ -567,6 +726,8 @@
 			reg = <0x213000 0x1000>;
 			interrupts = <52>;
 			max-pixelclock = <37500>;
+			clocks = <&psc1 16>;
+			clock-names = "fck";
 			status = "disabled";
 		};
 	};
@@ -578,6 +739,7 @@
 		reg = <0x68000000 0x00008000>;
 		ranges = <0 0 0x60000000 0x08000000
 			  1 0 0x68000000 0x00008000>;
+		clocks = <&psc0 3>;
 		status = "disabled";
 	};
 	memctrl: memory-controller at b0000000 {
-- 
2.7.4
