From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:22 +0900
Subject: [PATCH 25/32] ARM: shmobile: r8a7790: add CAN clocks
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <41650f406cdc4a420d5c08e1b407f6420323a04b.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The R-Car CAN controllers can derive the CAN bus clock not only from their
peripheral clock input (clkp1) but also from the other internal clock (clkp2)
and external clock fed on CAN_CLK pin.  Describe those clocks in the device
tree,  along with  the USB_EXTAL clock  from which clkp2 is derived.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 22 ++++++++++++++++++++--
 include/dt-bindings/clock/r8a7790-clock.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 24de994..e872854 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
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
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 9194027..ffa8c11 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -21,6 +21,7 @@
 #define R8A7790_CLK_SD0			7
 #define R8A7790_CLK_SD1			8
 #define R8A7790_CLK_Z			9
+#define R8A7790_CLK_RCAN		10
 
 /* MSTP0 */
 #define R8A7790_CLK_MSIOF0		0
-- 
2.1.4
