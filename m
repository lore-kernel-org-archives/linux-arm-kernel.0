From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 06 Jan 2015 00:33:25 +0300
Subject: [PATCH v2 1/2] ARM: shmobile: r8a7790: add CAN clocks
In-Reply-To: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
References: <28994794.h3WeokSSG3@wasted.cogentembedded.com>
Message-ID: <1948350.BT8VM0CPFC@wasted.cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car CAN controllers can derive the CAN bus clock not only from their
peripheral clock input (clkp1) but also from the other internal clock (clkp2)
and external clock fed on CAN_CLK pin.  Describe those clocks in the device
tree,  along with  the USB_EXTAL clock  from which clkp2 is derived.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
Changes in version 2:
- fixed spelling in the comment to the CAN_CLK node;
- added Geert's ACK.

 arch/arm/boot/dts/r8a7790.dtsi            |   22 ++++++++++++++++++++--
 include/dt-bindings/clock/r8a7790-clock.h |    1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

Index: renesas/arch/arm/boot/dts/r8a7790.dtsi
===================================================================
--- renesas.orig/arch/arm/boot/dts/r8a7790.dtsi
+++ renesas/arch/arm/boot/dts/r8a7790.dtsi
@@ -838,16 +838,34 @@
 			clock-output-names = "audio_clk_c";
 		};
 
+		/* External USB clock - can be overridden by the board */
+		usb_extal_clk: usb_extal_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <48000000>;
+			clock-output-names = "usb_extal";
+		};
+
+		/* External CAN clock */
+		can_clk: can_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			/* This value must be overridden by the board. */
+			clock-frequency = <0>;
+			clock-output-names = "can_clk";
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks at e6150000 {
 			compatible = "renesas,r8a7790-cpg-clocks",
 				     "renesas,rcar-gen2-cpg-clocks";
 			reg = <0 0xe6150000 0 0x1000>;
-			clocks = <&extal_clk>;
+			clocks = <&extal_clk &usb_extal_clk>;
 			#clock-cells = <1>;
 			clock-output-names = "main", "pll0", "pll1", "pll3",
 					     "lb", "qspi", "sdh", "sd0", "sd1",
-					     "z";
+					     "z", "rcan";
 		};
 
 		/* Variable factor clocks */
Index: renesas/include/dt-bindings/clock/r8a7790-clock.h
===================================================================
--- renesas.orig/include/dt-bindings/clock/r8a7790-clock.h
+++ renesas/include/dt-bindings/clock/r8a7790-clock.h
@@ -21,6 +21,7 @@
 #define R8A7790_CLK_SD0			7
 #define R8A7790_CLK_SD1			8
 #define R8A7790_CLK_Z			9
+#define R8A7790_CLK_RCAN		10
 
 /* MSTP0 */
 #define R8A7790_CLK_MSIOF0		0
