From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Jun 2014 20:18:25 +0200
Subject: [RFC PATCH 2/3] dts: add devicetree bindings for pxa27x clocks
In-Reply-To: <1402165106-16534-1-git-send-email-robert.jarzmik@free.fr>
References: <1402165106-16534-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1402165106-16534-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the clock tree description for the PXA27x based boards.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 .../devicetree/bindings/clock/pxa-clock.txt        | 23 ++++++++++++++++++++++
 arch/arm/boot/dts/pxa27x.dtsi                      |  4 ++++
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/pxa-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/pxa-clock.txt b/Documentation/devicetree/bindings/clock/pxa-clock.txt
new file mode 100644
index 0000000..54ab59c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/pxa-clock.txt
@@ -0,0 +1,23 @@
+* Clock bindings for Marvell PXA chips
+
+Required properties:
+- compatible: Should be "mrvl,pxa-clocks"
+- reg: Address and length of the CKEN register
+- #clock-cells: Should be <1>
+- clocks: the parent fixed rate clocks
+- clock-indices: the bit index in the CKEN register gating the clock
+- clock-outpout-names: the names of the clocks
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell.
+
+Examples:
+
+pxa2xx_clks: pxa2xx_clks at 41300004 {
+	compatible = "mrvl,pxa-clocks";
+	clocks = <&clk_14_857mhz>, <&clk_14_857mhz>
+	#clock-cells = <1>;
+	clock-output-names =
+	         "pxa27x-ffuart", "pxa27x-btuart";
+	clock-indices = <CKEN_FFUART CKEN_BTUART>
+};	
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 7b151c0..488a9e6 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -42,6 +42,9 @@
 		* The muxing of external clocks/internal dividers for osc* clock
 		* sources has been hidden under the carpet by now.
 		*/
+		#address-cells = <1>;
+		#size-cells = <1>;
+
 		osc13mhz:osc13mhz {
 			compatible = "fixed-clock";
 			 #clock-cells = <0>;
@@ -111,6 +114,7 @@
 
 		pxa2xx_clks: pxa2xx_clks at 41300004 {
 			compatible = "mrvl,pxa2xx-clocks";
+			reg = <0x41300004 0x4>;
 			clocks = <&clk_14_857mhz>, <&clk_14_857mhz>, <&clk_14_857mhz>,
 			       <&clk_14_682mhz>, <&clk_32_842mhz>, <&clk_48mhz>,
 			       <&clk_19_5mhz>, <&clk_48mhz>, <&clk_48mhz>,
-- 
2.0.0.rc2
