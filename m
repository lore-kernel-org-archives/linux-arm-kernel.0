From: manabian@gmail.com (Joachim Eastwood)
Date: Thu,  2 Apr 2015 22:31:48 +0200
Subject: [PATCH 6/6] ARM: dts: lpc18xx: add clock nodes for cgu and ccu
In-Reply-To: <1428006708-13690-1-git-send-email-manabian@gmail.com>
References: <1428006708-13690-1-git-send-email-manabian@gmail.com>
Message-ID: <1428006708-13690-7-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/lpc18xx.dtsi | 96 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 161e98b442e0..8e9f51c88fad 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -13,6 +13,9 @@
 
 #include "armv7-m.dtsi"
 
+#include "dt-bindings/clock/lpc18xx-cgu.h"
+#include "dt-bindings/clock/lpc18xx-ccu.h"
+
 / {
 	aliases {
 		serial0 = &uart0;
@@ -29,6 +32,7 @@
 			compatible = "arm,cortex-m3";
 			device_type = "cpu";
 			reg = <0x0>;
+			clocks = <&ccu1 CLK_CPU_CORE>;
 		};
 	};
 
@@ -39,23 +43,84 @@
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
+		cgu: cgu at 40050000 {
+			compatible = "nxp,lpc1850-cgu";
+			reg = <0x40050000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&xtal>, <&xtal32>, <&enet_rx_clk>, <&enet_tx_clk>, <&gp_clkin>;
+			clock-indices =  <0>,  <1>,  <2>,  <3>,  <4>,  <5>,  <6>,  <7>,
+					 <8>,  <9>, <10>, <11>, <12>, <13>, <14>, <15>,
+					<16>, <17>, <18>, <19>, <20>, <25>, <26>, <27>;
+			clock-output-names = "base_safe_clk",    "base_usb0_clk",
+					     "base_periph_clk",  "base_usb1_clk",
+					     "base_cpu_clk",     "base_spifi_clk",
+					     "base_spi_clk",     "base_phy_rx_clk",
+					     "base_phy_tx_clk",  "base_apb1_clk",
+					     "base_apb3_clk",    "base_lcd_clk",
+					     "base_adchs_clk",   "base_sdio_clk",
+					     "base_ssp0_clk",    "base_ssp1_clk",
+					     "base_uart0_clk",   "base_uart1_clk",
+					     "base_uart2_clk",   "base_uart3_clk",
+					     "base_out_clk",     "base_audio_clk",
+					     "base_cgu_out0_clk","base_cgu_out1_clk";
+		};
+
+		ccu1: ccu at 40051000 {
+			compatible = "nxp,lpc1850-ccu";
+			reg = <0x40051000 0x1000>;
+			#clock-cells = <1>;
+			clocks = <&cgu BASE_APB3_CLK>,   <&cgu BASE_APB1_CLK>,
+				 <&cgu BASE_SPIFI_CLK>,  <&cgu BASE_CPU_CLK>,
+				 <&cgu BASE_PERIPH_CLK>, <&cgu BASE_USB0_CLK>,
+				 <&cgu BASE_USB1_CLK>,   <&cgu BASE_SPI_CLK>;
+		};
+
+		ccu2: ccu at 40052000 {
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
+			clock-names = "uart", "reg";
 			status = "disabled";
 		};
 
@@ -64,7 +129,8 @@
 			reg = <0x40082000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <25>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB0_UART1>, <&ccu1 CLK_CPU_UART1>;
+			clock-names = "uart", "reg";
 			status = "disabled";
 		};
 
@@ -72,14 +138,14 @@
 			compatible = "nxp,lpc3250-timer";
 			reg = <0x40084000 0x1000>;
 			interrupts = <12>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER0>;
 		};
 
 		timer1: timer at 40085000 {
 			compatible = "nxp,lpc3250-timer";
 			reg = <0x40085000 0x1000>;
 			interrupts = <13>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER1>;
 		};
 
 		uart2: serial at 400c1000 {
@@ -87,7 +153,8 @@
 			reg = <0x400c1000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <26>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB2_UART2>, <&ccu1 CLK_CPU_UART2>;
+			clock-names = "uart", "reg";
 			status = "disabled";
 		};
 
@@ -96,7 +163,8 @@
 			reg = <0x400c2000 0x1000>;
 			reg-shift = <2>;
 			interrupts = <27>;
-			clocks = <&pll1>;
+			clocks = <&ccu2 CLK_APB2_UART3>, <&ccu1 CLK_CPU_UART3>;
+			clock-names = "uart", "reg";
 			status = "disabled";
 		};
 
@@ -104,14 +172,14 @@
 			compatible = "nxp,lpc3250-timer";
 			reg = <0x400c3000 0x1000>;
 			interrupts = <14>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER2>;
 		};
 
 		timer3: timer at 400c4000 {
 			compatible = "nxp,lpc3250-timer";
 			reg = <0x400c4000 0x1000>;
 			interrupts = <15>;
-			clocks = <&pll1>;
+			clocks = <&ccu1 CLK_CPU_TIMER3>;
 		};
 	};
 };
-- 
1.8.0
