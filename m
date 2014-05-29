From: robherring2@gmail.com (Rob Herring)
Date: Thu, 29 May 2014 17:40:20 -0500
Subject: [PATCH v2 10/11] dts: versatile: add clock tree
In-Reply-To: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
Message-ID: <1401403221-27523-11-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

The versatile dts is missing any clock data. Add the clocks.

It is not clear from the documentation where pclk comes from, so for
now it is a dummy clock which is sufficient for things to work.

Signed-off-by: Rob Herring <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
- Move and Rename crystal node.
- Define pclk as 24MHz based on Linus W's input
- fix timer to be 3 clocks and fix names
- Fix sspclk clock name

 arch/arm/boot/dts/versatile-ab.dts | 75 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/versatile-pb.dts | 10 +++++
 2 files changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 85c7b2b..36c771a 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -19,6 +19,41 @@
 		reg = <0x0 0x08000000>;
 	};
 
+	xtal24mhz: xtal24mhz at 24M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+	};
+
+	core-module at 10000000 {
+		compatible = "arm,core-module-versatile", "syscon";
+		reg = <0x10000000 0x200>;
+
+		/* OSC1 on AB, OSC4 on PB */
+		osc1: cm_aux_osc at 24M {
+			#clock-cells = <0>;
+			compatible = "arm,versatile-cm-auxosc";
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
+
+		pclk: pclk at 24M {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <1>;
+			clock-mult = <1>;
+			clocks = <&xtal24mhz>;
+		};
+	};
+
 	flash at 34000000 {
 		compatible = "arm,versatile-flash";
 		reg = <0x34000000 0x4000000>;
@@ -78,63 +113,85 @@
 			compatible = "arm,pl081", "arm,primecell";
 			reg = <0x10130000 0x1000>;
 			interrupts = <17>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		uart0: uart at 101f1000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f1000 0x1000>;
 			interrupts = <12>;
+			clocks = <&xtal24mhz>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		uart1: uart at 101f2000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f2000 0x1000>;
 			interrupts = <13>;
+			clocks = <&xtal24mhz>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		uart2: uart at 101f3000 {
 			compatible = "arm,pl011", "arm,primecell";
 			reg = <0x101f3000 0x1000>;
 			interrupts = <14>;
+			clocks = <&xtal24mhz>, <&pclk>;
+			clock-names = "uartclk", "apb_pclk";
 		};
 
 		smc at 10100000 {
 			compatible = "arm,primecell";
 			reg = <0x10100000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		mpmc at 10110000 {
 			compatible = "arm,primecell";
 			reg = <0x10110000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		display at 10120000 {
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0x10120000 0x1000>;
 			interrupts = <16>;
+			clocks = <&osc1>, <&pclk>;
+			clock-names = "clcd", "apb_pclk";
 		};
 
 		sctl at 101e0000 {
 			compatible = "arm,primecell";
 			reg = <0x101e0000 0x1000>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		watchdog at 101e1000 {
 			compatible = "arm,primecell";
 			reg = <0x101e1000 0x1000>;
 			interrupts = <0>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		timer at 101e2000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x101e2000 0x1000>;
 			interrupts = <4>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer0", "timer1", "apb_pclk";
 		};
 
 		timer at 101e3000 {
 			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x101e3000 0x1000>;
 			interrupts = <5>;
+			clocks = <&timclk>, <&timclk>, <&pclk>;
+			clock-names = "timer0", "timer1", "apb_pclk";
 		};
 
 		gpio0: gpio at 101e4000 {
@@ -145,6 +202,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		gpio1: gpio at 101e5000 {
@@ -155,24 +214,32 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		rtc at 101e8000 {
 			compatible = "arm,pl030", "arm,primecell";
 			reg = <0x101e8000 0x1000>;
 			interrupts = <10>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		sci at 101f0000 {
 			compatible = "arm,primecell";
 			reg = <0x101f0000 0x1000>;
 			interrupts = <15>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		ssp at 101f4000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x101f4000 0x1000>;
 			interrupts = <11>;
+			clocks = <&xtal24mhz>, <&pclk>;
+			clock-names = "SSPCLK", "apb_pclk";
 		};
 
 		fpga {
@@ -185,23 +252,31 @@
 				compatible = "arm,primecell";
 				reg = <0x4000 0x1000>;
 				interrupts = <24>;
+				clocks = <&pclk>;
+				clock-names = "apb_pclk";
 			};
 			mmc at 5000 {
 				compatible = "arm,pl180", "arm,primecell";
 				reg = < 0x5000 0x1000>;
 				interrupts-extended = <&vic 22 &sic 2>;
+				clocks = <&xtal24mhz>, <&pclk>;
+				clock-names = "mclk", "apb_pclk";
 			};
 			kmi at 6000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x6000 0x1000>;
 				interrupt-parent = <&sic>;
 				interrupts = <3>;
+				clocks = <&xtal24mhz>, <&pclk>;
+				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 			kmi at 7000 {
 				compatible = "arm,pl050", "arm,primecell";
 				reg = <0x7000 0x1000>;
 				interrupt-parent = <&sic>;
 				interrupts = <4>;
+				clocks = <&xtal24mhz>, <&pclk>;
+				clock-names = "KMIREFCLK", "apb_pclk";
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/versatile-pb.dts b/arch/arm/boot/dts/versatile-pb.dts
index a428541..d025048 100644
--- a/arch/arm/boot/dts/versatile-pb.dts
+++ b/arch/arm/boot/dts/versatile-pb.dts
@@ -13,6 +13,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		gpio3: gpio at 101e7000 {
@@ -23,6 +25,8 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+			clocks = <&pclk>;
+			clock-names = "apb_pclk";
 		};
 
 		fpga {
@@ -31,17 +35,23 @@
 				reg = <0x9000 0x1000>;
 				interrupt-parent = <&sic>;
 				interrupts = <6>;
+				clocks = <&xtal24mhz>, <&pclk>;
+				clock-names = "uartclk", "apb_pclk";
 			};
 			sci at a000 {
 				compatible = "arm,primecell";
 				reg = <0xa000 0x1000>;
 				interrupt-parent = <&sic>;
 				interrupts = <5>;
+				clocks = <&xtal24mhz>;
+				clock-names = "apb_pclk";
 			};
 			mmc at b000 {
 				compatible = "arm,pl180", "arm,primecell";
 				reg = <0xb000 0x1000>;
 				interrupts-extended = <&vic 23 &sic 2>;
+				clocks = <&xtal24mhz>, <&pclk>;
+				clock-names = "mclk", "apb_pclk";
 			};
 		};
 	};
-- 
1.9.1
