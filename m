From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  9 Jun 2013 12:55:48 +0200
Subject: [PATCH 2/2] ARM: nomadik: add the new clocks to the device tree
In-Reply-To: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1370775348-7440-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This revamps the device tree to fit with the new clock
implementation and brings it quite a bit closer to how
the hardware actually works.

After this the clock implementation knows about all
clock gates and will gate off all unused clocks at
boot time and save a bit of power.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    |   6 +
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 501 ++++++++++++++++++++++++++---
 2 files changed, 470 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 638ec8d..fd573d2 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -14,6 +14,12 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
 	};
 
+	src at 101e0000 {
+		/* These chrystal drivers are not used on this board */
+		disable-sxtalo;
+		disable-mxtalo;
+	};
+
 	pinctrl {
 		/* Hog CD pins */
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index dbf476b..a3acfa7 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -168,37 +168,464 @@
 	src: src at 101e0000 {
 		compatible = "stericsson,nomadik-src";
 		reg = <0x101e0000 0x1000>;
-		clocks {
-			/*
-			 * Dummy clock for primecells
-			 */
-			pclk: pclk at 0 {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <0>;
-			};
-			/*
-			 * The 2.4 MHz TIMCLK reference clock is active at
-			 * boot time, this is actually the MXTALCLK @19.2 MHz
-			 * divided by 8. This clock is used by the timers and
-			 * watchdog. See page 105 ff.
-			 */
-			timclk: timclk at 2.4M {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <2400000>;
-			};
-			/*
-			 * At boot time, PLL2 is set to generate a set of
-			 * fixed clocks, one of them is CLK48, the 48 MHz
-			 * clock, routed to the UART, MMC/SD, I2C, IrDA,
-			 * USB and SSP blocks.
-			 */
-			clk48: clk48 at 48M {
-				#clock-cells = <0>;
-				compatible = "fixed-clock";
-				clock-frequency = <48000000>;
-			};
+		disable-sxtalo;
+		disable-mxtalo;
+
+		/*
+		 * MXTAL "Main Chrystal" is a chrystal oscillator @19.2 MHz
+		 * that is parent of TIMCLK, PLL1 and PLL2
+		 */
+		mxtal: mxtal at 19.2M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <19200000>;
+		};
+
+		/*
+		 * The 2.4 MHz TIMCLK reference clock is active at
+		 * boot time, this is actually the MXTALCLK @19.2 MHz
+		 * divided by 8. This clock is used by the timers and
+		 * watchdog. See page 105 ff.
+		 */
+		timclk: timclk at 2.4M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <8>;
+			clock-mult = <1>;
+			clocks = <&mxtal>;
+		};
+
+		/* PLL1 is locked to MXTALI and variable from 20.4 to 334 MHz */
+		pll1: pll1 at 0 {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-pll-clock";
+			pll-id = <1>;
+			clocks = <&mxtal>;
+		};
+
+		/* HCLK divides the PLL1 with 1,2,3 or 4 */
+		hclk: hclk at 0 {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-hclk-clock";
+			clocks = <&pll1>;
+		};
+		/* The PCLK domain uses HCLK right off */
+		pclk: pclk at 0 {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <1>;
+			clock-mult = <1>;
+			clocks = <&hclk>;
+		};
+
+		/* PLL2 is usually 864 MHz and divided into a few fixed rates */
+		pll2: pll2 at 0 {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-pll-clock";
+			pll-id = <2>;
+			clocks = <&mxtal>;
+		};
+		clk216: clk216 at 216M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <4>;
+			clock-mult = <1>;
+			clocks = <&pll2>;
+		};
+		clk108: clk108 at 108M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <2>;
+			clock-mult = <1>;
+			clocks = <&clk216>;
+		};
+		clk72: clk72 at 72M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			/* The data sheet does not say how this is derived */
+			clock-div = <12>;
+			clock-mult = <1>;
+			clocks = <&pll2>;
+		};
+		clk48: clk48 at 48M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			/* The data sheet does not say how this is derived */
+			clock-div = <18>;
+			clock-mult = <1>;
+			clocks = <&pll2>;
+		};
+		clk27: clk27 at 27M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <4>;
+			clock-mult = <1>;
+			clocks = <&clk108>;
+		};
+
+		/* This apparently exists as well */
+		ulpiclk: ulpiclk at 60M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <60000000>;
+		};
+
+		/*
+		 * IP AMBA bus clocks, driving the bus side of the
+		 * peripheral clocking, clock gates.
+		 */
+
+		hclkdma0: hclkdma0 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <0>;
+			clocks = <&hclk>;
+		};
+		hclksmc: hclksmc at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <1>;
+			clocks = <&hclk>;
+		};
+		hclksdram: hclksdram at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <2>;
+			clocks = <&hclk>;
+		};
+		hclkdma1: hclkdma1 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <3>;
+			clocks = <&hclk>;
+		};
+		hclkclcd: hclkclcd at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <4>;
+			clocks = <&hclk>;
+		};
+		pclkirda: pclkirda at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <5>;
+			clocks = <&pclk>;
+		};
+		pclkssp: pclkssp at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <6>;
+			clocks = <&pclk>;
+		};
+		pclkuart0: pclkuart0 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <7>;
+			clocks = <&pclk>;
+		};
+		pclksdi: pclksdi at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <8>;
+			clocks = <&pclk>;
+		};
+		pclki2c0: pclki2c0 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <9>;
+			clocks = <&pclk>;
+		};
+		pclki2c1: pclki2c1 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <10>;
+			clocks = <&pclk>;
+		};
+		pclkuart1: pclkuart1 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <11>;
+			clocks = <&pclk>;
+		};
+		pclkmsp0: pclkmsp0 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <12>;
+			clocks = <&pclk>;
+		};
+		hclkusb: hclkusb at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <13>;
+			clocks = <&hclk>;
+		};
+		hclkdif: hclkdif at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <14>;
+			clocks = <&hclk>;
+		};
+		hclksaa: hclksaa at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <15>;
+			clocks = <&hclk>;
+		};
+		hclksva: hclksva at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <16>;
+			clocks = <&hclk>;
+		};
+		pclkhsi: pclkhsi at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <17>;
+			clocks = <&pclk>;
+		};
+		pclkxti: pclkxti at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <18>;
+			clocks = <&pclk>;
+		};
+		pclkuart2: pclkuart2 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <19>;
+			clocks = <&pclk>;
+		};
+		pclkmsp1: pclkmsp1 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <20>;
+			clocks = <&pclk>;
+		};
+		pclkmsp2: pclkmsp2 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <21>;
+			clocks = <&pclk>;
+		};
+		pclkowm: pclkowm at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <22>;
+			clocks = <&pclk>;
+		};
+		hclkhpi: hclkhpi at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <23>;
+			clocks = <&hclk>;
+		};
+		pclkske: pclkske at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <24>;
+			clocks = <&pclk>;
+		};
+		pclkhsem: pclkhsem at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <25>;
+			clocks = <&pclk>;
+		};
+		hclk3d: hclk3d at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <26>;
+			clocks = <&hclk>;
+		};
+		hclkhash: hclkhash at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <27>;
+			clocks = <&hclk>;
+		};
+		hclkcryp: hclkcryp at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <28>;
+			clocks = <&hclk>;
+		};
+		pclkmshc: pclkmshc at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <29>;
+			clocks = <&pclk>;
+		};
+		hclkusbm: hclkusbm at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <30>;
+			clocks = <&hclk>;
+		};
+		hclkrng: hclkrng at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <31>;
+			clocks = <&hclk>;
+		};
+
+		/* IP kernel clocks */
+		clcdclk: clcdclk at 0 {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <36>;
+			clocks = <&clk72 &clk48>;
+		};
+		irdaclk: irdaclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <37>;
+			clocks = <&clk48>;
+		};
+		sspiclk: sspiclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <38>;
+			clocks = <&clk48>;
+		};
+		uart0clk: uart0clk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <39>;
+			clocks = <&clk48>;
+		};
+		sdiclk: sdiclk at 48M {
+			/* Also called MCCLK in some documents */
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <40>;
+			clocks = <&clk48>;
+		};
+		i2c0clk: i2c0clk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <41>;
+			clocks = <&clk48>;
+		};
+		i2c1clk: i2c1clk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <42>;
+			clocks = <&clk48>;
+		};
+		uart1clk: uart1clk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <43>;
+			clocks = <&clk48>;
+		};
+		mspclk0: mspclk0 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <44>;
+			clocks = <&clk48>;
+		};
+		usbclk: usbclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <45>;
+			clocks = <&clk48>; /* 48 MHz not ULPI */
+		};
+		difclk: difclk at 72M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <46>;
+			clocks = <&clk72>;
+		};
+		ipi2cclk: ipi2cclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <47>;
+			clocks = <&clk48>; /* Guess */
+		};
+		ipbmcclk: ipbmcclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <48>;
+			clocks = <&clk48>; /* Guess */
+		};
+		hsiclkrx: hsiclkrx at 216M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <49>;
+			clocks = <&clk216>;
+		};
+		hsiclktx: hsiclktx at 108M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <50>;
+			clocks = <&clk108>;
+		};
+		uart2clk: uart2clk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <51>;
+			clocks = <&clk48>;
+		};
+		mspclk1: mspclk1 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <52>;
+			clocks = <&clk48>;
+		};
+		mspclk2: mspclk2 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <53>;
+			clocks = <&clk48>;
+		};
+		owmclk: owmclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <54>;
+			clocks = <&clk48>; /* Guess */
+		};
+		skeclk: skeclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <56>;
+			clocks = <&clk48>; /* Guess */
+		};
+		x3dclk: x3dclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <58>;
+			clocks = <&clk48>; /* Guess */
+		};
+		pclkmsp3: pclkmsp3 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <59>;
+			clocks = <&pclk>;
+		};
+		mspclk3: mspclk3 at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <60>;
+			clocks = <&clk48>;
+		};
+		mshcclk: mshcclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <61>;
+			clocks = <&clk48>; /* Guess */
+		};
+		usbmclk: usbmclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <62>;
+			/* Stated as "48 MHz not ULPI clock" */
+			clocks = <&clk48>;
+		};
+		rngcclk: rngcclk at 48M {
+			#clock-cells = <0>;
+			compatible = "st,nomadik-src-clock";
+			clock-id = <63>;
+			clocks = <&clk48>; /* Guess */
 		};
 	};
 
@@ -212,7 +639,7 @@
 			<0x41000000 0x2000>,	/* NAND Base ADDR */
 			<0x40800000 0x2000>;	/* NAND Base CMD */
 		reg-names = "fsmc_regs", "nand_data", "nand_addr", "nand_cmd";
-		clocks = <&pclk>;
+		clocks = <&hclksmc>;
 		status = "okay";
 
 		partition at 0 {
@@ -334,7 +761,7 @@
 			reg = <0x101fd000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <12>;
-			clocks = <&clk48>, <&pclk>;
+			clocks = <&uart0clk>, <&pclkuart0>;
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_default_mux>;
@@ -345,7 +772,7 @@
 			reg = <0x101fb000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <17>;
-			clocks = <&clk48>, <&pclk>;
+			clocks = <&uart1clk>, <&pclkuart1>;
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_default_mux>;
@@ -356,7 +783,7 @@
 			reg = <0x101f2000 0x1000>;
 			interrupt-parent = <&vica>;
 			interrupts = <28>;
-			clocks = <&clk48>, <&pclk>;
+			clocks = <&uart2clk>, <&pclkuart2>;
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
 		};
@@ -364,7 +791,7 @@
 		rng: rng at 101b0000 {
 			compatible = "arm,primecell";
 			reg = <0x101b0000 0x1000>;
-			clocks = <&clk48>, <&pclk>;
+			clocks = <&rngcclk>, <&hclkrng>;
 			clock-names = "rng", "apb_pclk";
 		};
 
@@ -380,7 +807,7 @@
 		mmcsd: sdi at 101f6000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x101f6000 0x1000>;
-			clocks = <&clk48>, <&pclk>;
+			clocks = <&sdiclk>, <&pclksdi>;
 			clock-names = "mclk", "apb_pclk";
 			interrupt-parent = <&vica>;
 			interrupts = <22>;
-- 
1.8.1.4
