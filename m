From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Apr 2016 21:46:33 +0200
Subject: [PATCH] ARM: nomadik: add DMA engine and some channels
Message-ID: <1460663193-15483-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DMA engine to the Nomadik and assigns the UART
DMA channels. Both slave DMA for UARTs and the memcpy engine
works fine, tested on the Nomadik NHK15.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index e2be53343064..d2d532a9d783 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -748,6 +748,9 @@
 			clocks = <&uart0clk>, <&pclkuart0>;
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
+			dmas = <&dmac0 14 1>,
+			       <&dmac0 15 1>;
+			dma-names = "rx", "tx";
 		};
 
 		uart1: uart at 101fb000 {
@@ -759,6 +762,9 @@
 			clock-names = "uartclk", "apb_pclk";
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart1_default_mux>;
+			dmas = <&dmac1 22 1>,
+			       <&dmac1 23 1>;
+			dma-names = "rx", "tx";
 		};
 
 		uart2: uart at 101f2000 {
@@ -769,6 +775,9 @@
 			clocks = <&uart2clk>, <&pclkuart2>;
 			clock-names = "uartclk", "apb_pclk";
 			status = "disabled";
+			dmas = <&dmac1 30 1>,
+			       <&dmac1 31 1>;
+			dma-names = "rx", "tx";
 		};
 
 		rng: rng at 101b0000 {
@@ -813,5 +822,34 @@
 			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
 			vmmc-supply = <&vmmc_regulator>;
 		};
+
+		dmac0: dma-controller at 10130000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0x10130000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <15>;
+			clocks = <&hclkdma0>;
+			clock-names = "apb_pclk";
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+		};
+		dmac1: dma-controller at 10150000 {
+			compatible = "arm,pl080", "arm,primecell";
+			reg = <0x10150000 0x1000>;
+			interrupt-parent = <&vica>;
+			interrupts = <13>;
+			clocks = <&hclkdma1>;
+			clock-names = "apb_pclk";
+			lli-bus-interface-ahb1;
+			lli-bus-interface-ahb2;
+			mem-bus-interface-ahb2;
+			memcpy-burst-size = <256>;
+			memcpy-bus-width = <32>;
+			#dma-cells = <2>;
+		};
 	};
 };
-- 
2.4.11
