From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:42:09 +0200
Subject: [PATCH v2 5/7] ARM: shmobile: r8a7791 dtsi: Add SYS-DMAC0 and
 SYS-DMAC1 nodes
In-Reply-To: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716531-29794-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the SYS-DMA controllers, SYS-DMAC0 and SYS-DMAC1. These
both share the same device sources, so are wrapped in the shdma-mux
node to allow both to be used.

Cfr. the r8a7790 version by Ben Dooks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes

 arch/arm/boot/dts/r8a7791.dtsi | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e5c35d784ec8..37685ef32ea0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -11,6 +11,7 @@
  */
 
 #include <dt-bindings/clock/r8a7791-clock.h>
+#include <dt-bindings/dma/r8a7791-dma.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
@@ -55,6 +56,74 @@
 		};
 	};
 
+	dma0: dma-mux at 0 {
+		compatible = "renesas,shdma-mux";
+		#dma-cells = <2>;
+		dma-channels = <30>;
+		dma-requests = <256>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		sysdma0: dma-controller at e6700020 {
+			compatible = "renesas,shdma-r8a7791";
+			reg = <0 0xe6700020 0 0xffc0>;
+			clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC0>;
+			dma-channels = <15>;
+			interrupts =	<0 197 IRQ_TYPE_LEVEL_HIGH>, /* error */
+					<0 200 IRQ_TYPE_LEVEL_HIGH>, /* ch0 */
+					<0 201 IRQ_TYPE_LEVEL_HIGH>,
+					<0 202 IRQ_TYPE_LEVEL_HIGH>,
+					<0 203 IRQ_TYPE_LEVEL_HIGH>,
+					<0 204 IRQ_TYPE_LEVEL_HIGH>,
+					<0 205 IRQ_TYPE_LEVEL_HIGH>,
+					<0 206 IRQ_TYPE_LEVEL_HIGH>,
+					<0 207 IRQ_TYPE_LEVEL_HIGH>,
+					<0 208 IRQ_TYPE_LEVEL_HIGH>,
+					<0 209 IRQ_TYPE_LEVEL_HIGH>,
+					<0 210 IRQ_TYPE_LEVEL_HIGH>,
+					<0 211 IRQ_TYPE_LEVEL_HIGH>,
+					<0 212 IRQ_TYPE_LEVEL_HIGH>,
+					<0 213 IRQ_TYPE_LEVEL_HIGH>,
+					<0 214 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14";
+			status = "disabled";
+		};
+
+		sysdma1: dma-controller at e6720020 {
+			compatible = "renesas,shdma-r8a7791";
+			reg = <0 0xe6720020 0 0xffc0>;
+			clocks = <&mstp2_clks R8A7791_CLK_SYS_DMAC1>;
+			dma-channels = <15>;
+			interrupts =  <0 220 IRQ_TYPE_LEVEL_HIGH>,
+					<0 216 IRQ_TYPE_LEVEL_HIGH>,
+					<0 217 IRQ_TYPE_LEVEL_HIGH>,
+					<0 218 IRQ_TYPE_LEVEL_HIGH>,
+					<0 219 IRQ_TYPE_LEVEL_HIGH>,
+					<0 308 IRQ_TYPE_LEVEL_HIGH>,
+					<0 309 IRQ_TYPE_LEVEL_HIGH>,
+					<0 310 IRQ_TYPE_LEVEL_HIGH>,
+					<0 311 IRQ_TYPE_LEVEL_HIGH>,
+					<0 312 IRQ_TYPE_LEVEL_HIGH>,
+					<0 313 IRQ_TYPE_LEVEL_HIGH>,
+					<0 314 IRQ_TYPE_LEVEL_HIGH>,
+					<0 315 IRQ_TYPE_LEVEL_HIGH>,
+					<0 316 IRQ_TYPE_LEVEL_HIGH>,
+					<0 317 IRQ_TYPE_LEVEL_HIGH>,
+					<0 318 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "error",
+					"ch0", "ch1", "ch2", "ch3",
+					"ch4", "ch5", "ch6", "ch7",
+					"ch8", "ch9", "ch10", "ch11",
+					"ch12", "ch13", "ch14";
+			status = "disabled";
+		};
+	};
+
 	gic: interrupt-controller at f1001000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.9.1
