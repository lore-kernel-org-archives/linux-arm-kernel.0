From: pawelo@king.net.pl (Paul Osmialowski)
Date: Tue, 30 Jun 2015 14:27:30 +0200
Subject: [PATCH v2 9/9] arm: twr-k70f120m: use Freescale lpuart driver with
 Kinetis SoC
In-Reply-To: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
Message-ID: <1435667250-28299-10-git-send-email-pawelo@king.net.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that enabling tx DMA resulted in messy output, so I didn't configure
it in the .dts file - however nothing in the code prevents one from doing
so. Also note that original reference UART driver from Emcraft did not
implement tx DMA at all.

Signed-off-by: Paul Osmialowski <pawelo@king.net.pl>
---
 arch/arm/boot/dts/kinetis-twr-k70f120m.dts | 23 +++++++++
 arch/arm/boot/dts/kinetis.dtsi             | 78 ++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
index a6efc29..5d8470a 100644
--- a/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
+++ b/arch/arm/boot/dts/kinetis-twr-k70f120m.dts
@@ -10,11 +10,34 @@
 	model = "Freescale TWR-K70F120M Development Kit";
 	compatible = "fsl,kinetis-twr-k70f120m";
 
+	chosen {
+		bootargs = "console=ttyLP2,115200";
+	};
+
 	memory {
 		reg = <0x8000000 0x8000000>;
 	};
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "ok";
+};
+
+&portE {
+	status = "ok";
+
+	uart2 {
+		uart2_pins: pinmux_uart2_pins {
+			fsl,pins = <
+				16	0x300 /* E.16 = UART2_TX */
+				17	0x300 /* E.17 = UART2_RX */
+			>;
+		};
+	};
+};
+
 &pit0 {
 	status = "ok";
 };
diff --git a/arch/arm/boot/dts/kinetis.dtsi b/arch/arm/boot/dts/kinetis.dtsi
index c2861f5..fedafe3 100644
--- a/arch/arm/boot/dts/kinetis.dtsi
+++ b/arch/arm/boot/dts/kinetis.dtsi
@@ -16,9 +16,87 @@
 		pmx3 = &portD;
 		pmx4 = &portE;
 		pmx5 = &portF;
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
+		serial5 = &uart5;
 	};
 
 	soc {
+		uart0: serial at 4006a000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006a000 0x1000>;
+			interrupts = <45>, <46>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_cclk_gate 3 10>;
+			clock-names = "ipg";
+			dmas = <&edma 0 2>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart1: serial at 4006b000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006b000 0x1000>;
+			interrupts = <47>, <48>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_cclk_gate 3 11>;
+			clock-names = "ipg";
+			dmas = <&edma 0 4>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart2: serial at 4006c000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006c000 0x1000>;
+			interrupts = <49>, <50>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 3 12>;
+			clock-names = "ipg";
+			dmas = <&edma 0 6>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart3: serial at 4006d000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x4006d000 0x1000>;
+			interrupts = <51>, <52>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 3 13>;
+			clock-names = "ipg";
+			dmas = <&edma 0 8>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart4: serial at 400ea000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x400ea000 0x1000>;
+			interrupts = <53>, <54>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 0 10>;
+			clock-names = "ipg";
+			dmas = <&edma 0 10>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
+		uart5: serial at 400eb000 {
+			compatible = "fsl,kinetis-lpuart";
+			reg = <0x400eb000 0x1000>;
+			interrupts = <55>, <56>;
+			interrupt-names = "uart-stat", "uart-err";
+			clocks = <&mcg_pclk_gate 0 11>;
+			clock-names = "ipg";
+			dmas = <&edma 0 12>;
+			dma-names = "rx";
+			status = "disabled";
+		};
+
 		edma: dma-controller at 40008000 {
 			compatible = "fsl,kinetis-edma";
 			reg = <0x40008000 0x2000>, /* DMAC */
-- 
2.3.6
