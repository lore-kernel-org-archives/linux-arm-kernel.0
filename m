From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:29 +0900
Subject: [PATCH 03/29] ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <8994fff677610e2e0aacb25c39b49739444844b0.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Instantiate the two Audio DMA controllers in the r8a7791 device tree.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: corrected spelling of audmac1]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi            | 63 +++++++++++++++++++++++++++++--
 include/dt-bindings/clock/r8a7791-clock.h |  2 +
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a862243..b54af74 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -301,6 +301,62 @@
 		dma-channels = <15>;
 	};
 
+	audma0: dma-controller at ec700000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xec700000 0 0x10000>;
+		interrupts =	<0 346 IRQ_TYPE_LEVEL_HIGH
+				 0 320 IRQ_TYPE_LEVEL_HIGH
+				 0 321 IRQ_TYPE_LEVEL_HIGH
+				 0 322 IRQ_TYPE_LEVEL_HIGH
+				 0 323 IRQ_TYPE_LEVEL_HIGH
+				 0 324 IRQ_TYPE_LEVEL_HIGH
+				 0 325 IRQ_TYPE_LEVEL_HIGH
+				 0 326 IRQ_TYPE_LEVEL_HIGH
+				 0 327 IRQ_TYPE_LEVEL_HIGH
+				 0 328 IRQ_TYPE_LEVEL_HIGH
+				 0 329 IRQ_TYPE_LEVEL_HIGH
+				 0 330 IRQ_TYPE_LEVEL_HIGH
+				 0 331 IRQ_TYPE_LEVEL_HIGH
+				 0 332 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12";
+		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC0>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
+	audma1: dma-controller at ec720000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xec720000 0 0x10000>;
+		interrupts =	<0 347 IRQ_TYPE_LEVEL_HIGH
+				 0 333 IRQ_TYPE_LEVEL_HIGH
+				 0 334 IRQ_TYPE_LEVEL_HIGH
+				 0 335 IRQ_TYPE_LEVEL_HIGH
+				 0 336 IRQ_TYPE_LEVEL_HIGH
+				 0 337 IRQ_TYPE_LEVEL_HIGH
+				 0 338 IRQ_TYPE_LEVEL_HIGH
+				 0 339 IRQ_TYPE_LEVEL_HIGH
+				 0 340 IRQ_TYPE_LEVEL_HIGH
+				 0 341 IRQ_TYPE_LEVEL_HIGH
+				 0 342 IRQ_TYPE_LEVEL_HIGH
+				 0 343 IRQ_TYPE_LEVEL_HIGH
+				 0 344 IRQ_TYPE_LEVEL_HIGH
+				 0 345 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12";
+		clocks = <&mstp5_clks R8A7791_CLK_AUDIO_DMAC1>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <13>;
+	};
+
 	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
@@ -1053,10 +1109,11 @@
 		mstp5_clks: mstp5_clks at e6150144 {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7791_CLK_THERMAL R8A7791_CLK_PWM>;
-			clock-output-names = "thermal", "pwm";
+			renesas,clock-indices = <R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
+						 R8A7791_CLK_THERMAL R8A7791_CLK_PWM>;
+			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks at e615014c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index dcececd..3ea2bbc 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -69,6 +69,8 @@
 #define R8A7791_CLK_USBDMAC1		31
 
 /* MSTP5 */
+#define R8A7791_CLK_AUDIO_DMAC1		1
+#define R8A7791_CLK_AUDIO_DMAC0		2
 #define R8A7791_CLK_THERMAL		22
 #define R8A7791_CLK_PWM			23
 
-- 
2.1.1
