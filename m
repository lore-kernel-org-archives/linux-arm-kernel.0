From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:36 +0200
Subject: [PATCH 01/17] ARM: dts: lpc18xx: add cgu and ccu clock-controller
 nodes
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CGU and CCU clock-controller nodes for lpc18xx together with
the fixed input clocks. Also remove the temporary fixed-factor
pll1 clock from both lpc18xx and lpc4350-hitex-eval DTS now that
proper clock drivers are inplace.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
Acked-by: Michael Turquette <mturquette@baylibre.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi           | 85 ++++++++++++++++++++++++++------
 arch/arm/boot/dts/lpc4350-hitex-eval.dts |  4 --
 2 files changed, 71 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 204da5b52ef9..78292d0cb263 100644
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
 
@@ -32,23 +36,76 @@
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
+			clock-names = "base_apb3_clk",   "base_apb1_clk",
+				      "base_spifi_clk",  "base_cpu_clk",
+				      "base_periph_clk", "base_usb0_clk",
+				      "base_usb1_clk",   "base_spi_clk";
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
+			clock-names = "base_audio_clk", "base_uart3_clk",
+				      "base_uart2_clk", "base_uart1_clk",
+				      "base_uart0_clk", "base_ssp1_clk",
+				      "base_ssp0_clk",  "base_sdio_clk";
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
 
@@ -57,7 +114,7 @@
 			reg = <0x40082000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <25>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
 			status = "disabled";
 		};
 
@@ -65,7 +122,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x40084000 0x1000>;
 			interrupts = <12>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER0>;
 			clock-names = "timerclk";
 		};
 
@@ -73,7 +130,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x40085000 0x1000>;
 			interrupts = <13>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER1>;
 			clock-names = "timerclk";
 		};
 
@@ -82,7 +139,7 @@
 			reg = <0x400c1000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <26>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB2_UART2>, <&ccu1 CLK_CPU_UART2>;
 			status = "disabled";
 		};
 
@@ -91,7 +148,7 @@
 			reg = <0x400c2000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <27>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB2_UART3>, <&ccu1 CLK_CPU_UART3>;
 			status = "disabled";
 		};
 
@@ -99,7 +156,7 @@
 			compatible = "nxp,lpc3220-timer";
 			reg = <0x400c3000 0x1000>;
 			interrupts = <14>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER2>;
 			clock-names = "timerclk";
 		};
 
@@ -107,7 +164,7 @@
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
