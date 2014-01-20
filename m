From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Jan 2014 21:54:49 +0100
Subject: [PATCH 1/5] ARM: integrator: define clocks in the device trees
Message-ID: <1390251289-6240-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the clock definitions to the Integrator/CP
and Integrator/AP device trees.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/integratorap.dts |  35 +++++++++++++
 arch/arm/boot/dts/integratorcp.dts | 102 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/integratorap.dts b/arch/arm/boot/dts/integratorap.dts
index e6be9315ff0a..b10e6351da53 100644
--- a/arch/arm/boot/dts/integratorap.dts
+++ b/arch/arm/boot/dts/integratorap.dts
@@ -18,6 +18,28 @@
 		bootargs = "root=/dev/ram0 console=ttyAM0,38400n8 earlyprintk";
 	};
 
+	/* 24 MHz chrystal on the core module */
+	xtal24mhz: xtal24mhz at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	pclk: pclk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <1>;
+		clock-mult = <1>;
+		clocks = <&xtal24mhz>;
+	};
+
+	/* The UART clock is 14.74 MHz divided by an ICS525 */
+	uartclk: uartclk at 14.74M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <14745600>;
+	};
+
 	syscon {
 		compatible = "arm,integrator-ap-syscon";
 		reg = <0x11000000 0x100>;
@@ -28,14 +50,17 @@
 
 	timer0: timer at 13000000 {
 		compatible = "arm,integrator-timer";
+		clocks = <&xtal24mhz>;
 	};
 
 	timer1: timer at 13000100 {
 		compatible = "arm,integrator-timer";
+		clocks = <&xtal24mhz>;
 	};
 
 	timer2: timer at 13000200 {
 		compatible = "arm,integrator-timer";
+		clocks = <&xtal24mhz>;
 	};
 
 	pic: pic at 14000000 {
@@ -92,26 +117,36 @@
 		rtc: rtc at 15000000 {
 			compatible = "arm,pl030", "arm,primecell";
 			arm,primecell-periphid = <0x00041030>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		uart0: uart at 16000000 {
 			compatible = "arm,pl010", "arm,primecell";
 			arm,primecell-periphid = <0x00041010>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		uart1: uart at 17000000 {
 			compatible = "arm,pl010", "arm,primecell";
 			arm,primecell-periphid = <0x00041010>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		kmi0: kmi at 18000000 {
 			compatible = "arm,pl050", "arm,primecell";
 			arm,primecell-periphid = <0x00041050>;
+			clocks = <&xtal24mhz>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
 		};
 
 		kmi1: kmi at 19000000 {
 			compatible = "arm,pl050", "arm,primecell";
 			arm,primecell-periphid = <0x00041050>;
+			clocks = <&xtal24mhz>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/integratorcp.dts b/arch/arm/boot/dts/integratorcp.dts
index a21c17de9a5e..d43f15b4f79a 100644
--- a/arch/arm/boot/dts/integratorcp.dts
+++ b/arch/arm/boot/dts/integratorcp.dts
@@ -13,25 +13,107 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA0,38400n8 earlyprintk";
 	};
 
+	/*
+	 * The Integrator/CP overall clocking architecture can be found in
+	 * ARM DUI 0184B page 7-28 "Integrator/CP922T system clocks" which
+	 * appear to illustrate the layout used in most configurations.
+	 */
+
+	/* The codec chrystal operates at 24.576 MHz */
+	xtal_codec: xtal24.576 at 24.576M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24576000>;
+	};
+
+	/* The chrystal is divided by 2 by the codec for the AACI bit clock */
+	aaci_bitclk: aaci_bitclk at 12.288M {
+		#clock-cells = <0>;
+		compatible = "fixed-factor-clock";
+		clock-div = <2>;
+		clock-mult = <1>;
+		clocks = <&xtal_codec>;
+	};
+
+	/* This is a 25MHz chrystal on the base board */
+	xtal25mhz: xtal25mhz at 25M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <25000000>;
+	};
+
+	/* The UART clock is 14.74 MHz divided from 25MHz by an ICS525 */
+	uartclk: uartclk at 14.74M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <14745600>;
+	};
+
+	/* Actually sysclk I think */
+	pclk: pclk at 0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+	};
+
+	core-module at 10000000 {
+		/* 24 MHz chrystal on the core module */
+		xtal24mhz: xtal24mhz at 24M {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		/*
+		 * External oscillator on the core module, usually used
+		 * to drive video circuitry. Driven from the 24MHz clock.
+		 */
+		auxosc: cm_aux_osc at 25M {
+			#clock-cells = <0>;
+			compatible = "arm,integrator-cm-auxosc";
+			clocks = <&xtal24mhz>;
+		};
+
+		/* The KMI clock is the 24 MHz oscillator divided to 8MHz */
+		kmiclk: kmiclk at 1M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <3>;
+			clock-mult = <1>;
+			clocks = <&xtal24mhz>;
+		};
+
+		/* The timer clock is the 24 MHz oscillator divided to 1MHz */
+		timclk: timclk at 1M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <24>;
+			clock-mult = <1>;
+			clocks = <&xtal24mhz>;
+		};
+	};
+
 	syscon {
 		compatible = "arm,integrator-cp-syscon";
 		reg = <0xcb000000 0x100>;
 	};
 
 	timer0: timer at 13000000 {
-		/* TIMER0 runs @ 25MHz */
+		/* TIMER0 runs directly on the 25MHz chrystal */
 		compatible = "arm,integrator-cp-timer";
-		status = "disabled";
+		clocks = <&xtal25mhz>;
 	};
 
 	timer1: timer at 13000100 {
 		/* TIMER1 runs @ 1MHz */
 		compatible = "arm,integrator-cp-timer";
+		clocks = <&timclk>;
 	};
 
 	timer2: timer at 13000200 {
 		/* TIMER2 runs @ 1MHz */
 		compatible = "arm,integrator-cp-timer";
+		clocks = <&timclk>;
 	};
 
 	pic: pic at 14000000 {
@@ -74,22 +156,32 @@
 		 */
 		rtc at 15000000 {
 			compatible = "arm,pl031", "arm,primecell";
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		uart at 16000000 {
 			compatible = "arm,pl011", "arm,primecell";
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		uart at 17000000 {
 			compatible = "arm,pl011", "arm,primecell";
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		kmi at 18000000 {
 			compatible = "arm,pl050", "arm,primecell";
+			clocks = <&kmiclk>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
 		};
 
 		kmi at 19000000 {
 			compatible = "arm,pl050", "arm,primecell";
+			clocks = <&kmiclk>, <&pclk>;
+			clock-names = "KMIREFCLK", "apb_pclk";
 		};
 
 		/*
@@ -100,18 +192,24 @@
 			reg = <0x1c000000 0x1000>;
 			interrupts = <23 24>;
 			max-frequency = <515633>;
+			clocks = <&uartclk>, <&pclk>;
+			clock-names = "mclk", "apb_pclk";
 		};
 
 		aaci at 1d000000 {
 			compatible = "arm,pl041", "arm,primecell";
 			reg = <0x1d000000 0x1000>;
 			interrupts = <25>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		clcd at c0000000 {
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0xC0000000 0x1000>;
 			interrupts = <22>;
+			clocks = <&auxosc>, <&pclk>;
+			clock-names = "clcd", "apb_pclk";
 		};
 	};
 };
-- 
1.8.4.2
