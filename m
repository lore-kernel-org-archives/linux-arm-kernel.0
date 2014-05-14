From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 14 May 2014 22:15:20 +0200
Subject: [PATCH v2 09/10] ARM: dts: berlin: convert BG2 to DT clock nodes
In-Reply-To: <1400098522-14770-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400098522-14770-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1400098522-14770-10-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This converts Berlin BG2 SoC dtsi to make use of the new DT clock
nodes for Berlin SoCs. While at it, also fix up twdclk which is
running at cpuclk/3 instead of sysclk.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- dropped of_clk_create_name() usage required unique node names for
  clocks and plls 
- added clock-output-names to allow fixed-factor-clock to find its 
  parent name 

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Jisheng Zhang <jszhang@marvell.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/berlin2.dtsi | 207 +++++++++++++++++++++++++++++++++++------
 1 file changed, 178 insertions(+), 29 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 57cadd31f4e1..edeecb711e97 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -12,6 +12,7 @@
  */
 
 #include "skeleton.dtsi"
+#include <dt-bindings/clock/berlin2.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -37,24 +38,18 @@
 		};
 	};
 
-	clocks {
-		smclk: sysmgr-clock {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <25000000>;
-		};
-
-		cfgclk: cfg-clock {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <100000000>;
-		};
+	refclk: oscillator {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+	};
 
-		sysclk: system-clock {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <400000000>;
-		};
+	twdclk: twdclk {
+		compatible = "fixed-factor-clock";
+		#clock-cells = <0>;
+		clocks = <&coreclk CLKID_CPU>;
+		clock-mult = <1>;
+		clock-div = <3>;
 	};
 
 	soc {
@@ -88,7 +83,7 @@
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0xad0600 0x20>;
 			interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>;
+			clocks = <&twdclk>;
 		};
 
 		apb at e80000 {
@@ -175,7 +170,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
 				interrupts = <8>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "okay";
 			};
@@ -184,7 +179,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c14 0x14>;
 				interrupts = <9>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "okay";
 			};
@@ -193,7 +188,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c28 0x14>;
 				interrupts = <10>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -202,7 +197,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c3c 0x14>;
 				interrupts = <11>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -211,7 +206,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c50 0x14>;
 				interrupts = <12>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -220,7 +215,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c64 0x14>;
 				interrupts = <13>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -229,7 +224,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c78 0x14>;
 				interrupts = <14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -238,7 +233,7 @@
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c8c 0x14>;
 				interrupts = <15>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -253,11 +248,165 @@
 			};
 		};
 
+		syspll: syspll at ea0014 {
+			compatible = "marvell,berlin2-pll";
+			#clock-cells = <0>;
+			reg = <0xea0014 0x14>;
+			clocks = <&refclk>;
+		};
+
+		mempll: mempll at ea0028 {
+			compatible = "marvell,berlin2-pll";
+			#clock-cells = <0>;
+			reg = <0xea0028 0x14>;
+			clocks = <&refclk>;
+		};
+
+		cpupll: cpupll at ea003c {
+			compatible = "marvell,berlin2-pll";
+			#clock-cells = <0>;
+			reg = <0xea003c 0x14>;
+			clocks = <&refclk>;
+		};
+
+		avpll: avpll at ea0040 {
+			compatible = "marvell,berlin2-avpll";
+			#clock-cells = <2>;
+			reg = <0xea0050 0x100>;
+			clocks = <&refclk>;
+		};
+
+		coreclk: core-clock at ea0150 {
+			compatible = "marvell,berlin2-core-clocks";
+			#clock-cells = <1>;
+			reg = <0xea0150 0x1c>;
+			clocks = <&refclk>, <&syspll>, <&mempll>, <&cpupll>,
+				<&avpll 0 1>, <&avpll 0 2>,
+				<&avpll 0 3>, <&avpll 0 4>,
+				<&avpll 0 5>, <&avpll 0 6>,
+				<&avpll 0 7>, <&avpll 0 8>,
+				<&avpll 1 1>, <&avpll 1 2>,
+				<&avpll 1 3>, <&avpll 1 4>,
+				<&avpll 1 5>, <&avpll 1 6>,
+				<&avpll 1 7>, <&avpll 1 8>;
+			clock-names = "refclk", "syspll", "mempll", "cpupll",
+				"avpll_a1", "avpll_a2", "avpll_a3", "avpll_a4",
+				"avpll_a5", "avpll_a6", "avpll_a7", "avpll_a8",
+				"avpll_b1", "avpll_b2", "avpll_b3", "avpll_b4",
+				"avpll_b5", "avpll_b6", "avpll_b7", "avpll_b8";
+			clock-output-names = "sys", "cpu", "drmfigo", "cfg",
+				"gfx", "zsp", "perif", "pcube", "vscope",
+				"nfc_ecc", "vpp", "app", "audio0", "audio2",
+				"audio3", "audio1", "geth0", "geth1", "sata",
+				"ahbapb", "usb0", "usb1", "pbridge", "sdio0",
+				"sdio1", "nfc", "smemc", "audiohd", "video0",
+				"video1", "video2";
+		};
+
 		generic-regs at ea0184 {
 			compatible = "marvell,berlin-generic-regs", "syscon";
 			reg = <0xea0184 0x10>;
 		};
 
+		gfx3dcore_clk: gfx3dcore at ea022c {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea022c 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		gfx3dsys_clk: gfx3dsys at ea0230 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0230 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		arc_clk: arc at ea0234 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0234 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		vip_clk: vip at ea0238 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0238 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		sdio0xin_clk: sdio0xin at ea023c {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea023c 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		sdio1xin_clk: sdio1xin at ea0240 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0240 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		gfx3dextra_clk: gfx3dextra at ea0244 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0244 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		gc360_clk: gc360 at ea024c {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea024c 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
+		sdio_dllmst_clk: sdio_dllmst at ea0250 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0250 0x4>;
+			clocks = <&syspll>,
+				<&avpll 1 4>, <&avpll 1 5>,
+				<&avpll 1 6>, <&avpll 1 7>;
+			clock-names = "mux_bypass",
+				"mux0", "mux1", "mux2", "mux3";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -305,7 +454,7 @@
 				reg-shift = <2>;
 				reg-io-width = <1>;
 				interrupts = <8>;
-				clocks = <&smclk>;
+				clocks = <&refclk>;
 				status = "disabled";
 			};
 
@@ -315,7 +464,7 @@
 				reg-shift = <2>;
 				reg-io-width = <1>;
 				interrupts = <9>;
-				clocks = <&smclk>;
+				clocks = <&refclk>;
 				status = "disabled";
 			};
 
@@ -325,7 +474,7 @@
 				reg-shift = <2>;
 				reg-io-width = <1>;
 				interrupts = <10>;
-				clocks = <&smclk>;
+				clocks = <&refclk>;
 				status = "disabled";
 			};
 
-- 
1.9.1
