From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 19 May 2015 00:35:59 +0200
Subject: [PATCH v3 6/6] ARM: dts: lpc18xx: add clock nodes for cgu and ccu
In-Reply-To: <1431988559-23338-1-git-send-email-manabian@gmail.com>
References: <1431988559-23338-1-git-send-email-manabian@gmail.com>
Message-ID: <1431988559-23338-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi           | 77 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/lpc4350-hitex-eval.dts |  4 --
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 204da5b52ef9..5664654e0ba9 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -13,6 +13,9 @@
 
 #include "armv7-m.dtsi"
 
+#include "dt-bindings/clock/lpc18xx-cgu.h"
+#include "dt-bindings/clock/lpc18xx-ccu.h"
+
 / {
 	cpus {
 		#address-cells = <1>;
@@ -22,6 +25,7 @@
 			compatible = "arm,cortex-m3";
 			device_type = "cpu";
 			reg = <0x0>;
+			clocks = <&ccu1 CLK_CPU_CORE>;
 		};
 	};
 
@@ -32,23 +36,68 @@
 			clock-frequency = <12000000>;
 		};
 
-		/* Temporary hardcode PLL1 until clk drivers are merged */
-		pll1: pll1 {
-			compatible = "fixed-factor-clock";
-			clocks = <&xtal>;
+		xtal32: xtal32 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32768>;
+		};
+
+		enet_rx_clk: enet_rx_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "enet_rx_clk";
+		};
+
+		enet_tx_clk: enet_tx_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+			clock-output-names = "enet_tx_clk";
+		};
+
+		gp_clkin: gp_clkin {
+			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <12>;
+			clock-frequency = <0>;
+			clock-output-names = "gp_clkin";
 		};
 	};
 
 	soc {
+		cgu: clock-controller at 40050000 {
+			compatible = "nxp,lpc1850-cgu";
+			reg = <0x40050000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&xtal>, <&xtal32>, <&enet_rx_clk>, <&enet_tx_clk>, <&gp_clkin>;
+		};
+
+		ccu1: clock-controller at 40051000 {
+			compatible = "nxp,lpc1850-ccu";
+			reg = <0x40051000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&cgu BASE_APB3_CLK>,   <&cgu BASE_APB1_CLK>,
+				 <&cgu BASE_SPIFI_CLK>,  <&cgu BASE_CPU_CLK>,
+				 <&cgu BASE_PERIPH_CLK>, <&cgu BASE_USB0_CLK>,
+				 <&cgu BASE_USB1_CLK>,   <&cgu BASE_SPI_CLK>;
+		};
+
+		ccu2: clock-controller at 40052000 {
+			compatible = "nxp,lpc1850-ccu";
+			reg = <0x40052000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&cgu BASE_AUDIO_CLK>, <&cgu BASE_UART3_CLK>,
+				 <&cgu BASE_UART2_CLK>, <&cgu BASE_UART1_CLK>,
+				 <&cgu BASE_UART0_CLK>, <&cgu BASE_SSP1_CLK>,
+				 <&cgu BASE_SSP0_CLK>,  <&cgu BASE_SDIO_CLK>;
+		};
+
 		uart0: serial at 40081000 {
 			compatible = "ns16550a";
 			reg = <0x40081000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <24>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB0_UART0>, <&ccu1 CLK_CPU_UART0>;
 			status = "disabled";
 		};
 
@@ -57,7 +106,7 @@
 			reg = <0x40082000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <25>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
 			status = "disabled";
 		};
 
@@ -65,7 +114,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x40084000 0x1000>;
 			interrupts = <12>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER0>;
 			clock-names = "timerclk";
 		};
 
@@ -73,7 +122,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x40085000 0x1000>;
 			interrupts = <13>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER1>;
 			clock-names = "timerclk";
 		};
 
@@ -82,7 +131,7 @@
 			reg = <0x400c1000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <26>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB2_UART2>, <&ccu1 CLK_CPU_UART2>;
 			status = "disabled";
 		};
 
@@ -91,7 +140,7 @@
 			reg = <0x400c2000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <27>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB2_UART3>, <&ccu1 CLK_CPU_UART3>;
 			status = "disabled";
 		};
 
@@ -99,7 +148,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x400c3000 0x1000>;
 			interrupts = <14>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER2>;
 			clock-names = "timerclk";
 		};
 
@@ -107,7 +156,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x400c4000 0x1000>;
 			interrupts = <15>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER3>;
 			clock-names = "timerclk";
 		};
 	};
diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index d04072f40817..4ebdb54cc9ce 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -36,10 +36,6 @@
 	};
 };
 
-&pll1 {
-	clock-mult = <15>;
-};
-
 &uart0 {
 	status = "okay";
 };
-- 
1.8.0
