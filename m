From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 14 May 2014 22:15:21 +0200
Subject: [PATCH v2 10/10] ARM: dts: berlin: convert BG2Q to DT clock nodes
In-Reply-To: <1400098522-14770-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1400098522-14770-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1400098522-14770-11-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

This converts Berlin BG2Q SoC dtsi to make use of the new DT clock
nodes for Berlin SoCs.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Changelog:
v1->v2:
- initial version

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
 arch/arm/boot/dts/berlin2q.dtsi | 80 ++++++++++++++++++++++++++++-------------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 52c7d644e492..8128c2b5ac07 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -6,6 +6,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <dt-bindings/clock/berlin2q.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #include "skeleton.dtsi"
@@ -47,28 +48,16 @@
 		};
 	};
 
-	smclk: sysmgr-clock {
+	refclk: oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <25000000>;
 	};
 
-	cfgclk: config-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
-	cpuclk: cpu-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <1200000000>;
-	};
-
 	twdclk: twdclk {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
-		clocks = <&cpuclk>;
+		clocks = <&cpupll>;
 		clock-mult = <1>;
 		clock-div = <3>;
 	};
@@ -106,6 +95,13 @@
 			#interrupt-cells = <3>;
 		};
 
+		cpupll: cpupll at dd0170 {
+			compatible = "marvell,berlin2q-pll";
+			clocks = <&refclk>;
+			#clock-cells = <0>;
+			reg = <0xdd0170 0x8>;
+		};
+
 		apb at e80000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -189,7 +185,7 @@
 			timer0: timer at 2c00 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c00 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				interrupts = <8>;
 			};
@@ -197,7 +193,7 @@
 			timer1: timer at 2c14 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c14 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -205,7 +201,7 @@
 			timer2: timer at 2c28 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c28 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -213,7 +209,7 @@
 			timer3: timer at 2c3c {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c3c 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -221,7 +217,7 @@
 			timer4: timer at 2c50 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c50 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -229,7 +225,7 @@
 			timer5: timer at 2c64 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c64 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -237,7 +233,7 @@
 			timer6: timer at 2c78 {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c78 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -245,7 +241,7 @@
 			timer7: timer at 2c8c {
 				compatible = "snps,dw-apb-timer";
 				reg = <0x2c8c 0x14>;
-				clocks = <&cfgclk>;
+				clocks = <&coreclk CLKID_CFG>;
 				clock-names = "timer";
 				status = "disabled";
 			};
@@ -290,11 +286,47 @@
 			};
 		};
 
+		syspll: syspll at ea0030 {
+			compatible = "marvell,berlin2q-pll";
+			clocks = <&refclk>;
+			#clock-cells = <0>;
+			reg = <0xea0030 0x8>;
+		};
+
+		coreclk: core-clock at ea00e8 {
+			compatible = "marvell,berlin2q-core-clocks";
+			#clock-cells = <1>;
+			reg = <0xea00e8 0x18>;
+			clocks = <&refclk>, <&syspll>;
+			clock-names = "refclk", "syspll";
+			clock-output-names = "sys", "drmfigo", "cfg",
+				"gfx2d", "zsp", "perif", "pcube", "vscope",
+				"nfc_ecc", "vpp", "app", "gfx2daxi", "geth0",
+				"ahbapb", "usb0", "usb1", "usb2", "usb3",
+				"pbridge", "sdio", "nfc", "smemc", "pcie";
+		};
+
 		generic-regs at ea0110 {
 			compatible = "marvell,berlin-generic-regs", "syscon";
 			reg = <0xea0110 0x10>;
 		};
 
+		sdio0xin_clk: sdio0xinclk at ea0158 {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea0158 0x4>;
+			clocks = <&syspll>;
+			clock-names = "mux_bypass";
+		};
+
+		sdio1xin_clk: sdio1xinclk at ea015c {
+			compatible = "marvell,berlin2-clk-div";
+			#clock-cells = <0>;
+			reg = <0xea015c 0x4>;
+			clocks = <&syspll>;
+			clock-names = "mux_bypass";
+		};
+
 		apb at fc0000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -308,7 +340,7 @@
 				reg = <0x9000 0x100>;
 				interrupt-parent = <&sic>;
 				interrupts = <8>;
-				clocks = <&smclk>;
+				clocks = <&refclk>;
 				reg-shift = <2>;
 				status = "disabled";
 			};
@@ -318,7 +350,7 @@
 				reg = <0xa000 0x100>;
 				interrupt-parent = <&sic>;
 				interrupts = <9>;
-				clocks = <&smclk>;
+				clocks = <&refclk>;
 				reg-shift = <2>;
 				status = "disabled";
 			};
-- 
1.9.1
