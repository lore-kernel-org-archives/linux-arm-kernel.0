From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 22 Apr 2014 15:12:34 +0200
Subject: [PATCH v3 05/11] ARM: at91/dt: move sama5d3 SoC to the new main/slow
 clk model
In-Reply-To: <1398172360-7837-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1398172360-7837-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1398172360-7837-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace the old main and clk definitions (fixed rate clk) by the new main and
slow clk subtree definition (ck = mux(rc_osc, osc)).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 61 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 55 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index eabcfdb..ceb274f 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -58,6 +58,18 @@
 		reg = <0x20000000 0x8000000>;
 	};
 
+	slow_xtal: slow_xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
+	main_xtal: main_xtal {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	clocks {
 		adc_op_clk: adc_op_clk{
 			compatible = "fixed-clock";
@@ -749,18 +761,29 @@
 				#size-cells = <0>;
 				#interrupt-cells = <1>;
 
-				clk32k: slck {
-					compatible = "fixed-clock";
+				main_rc_osc: main_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-main-rc-osc";
 					#clock-cells = <0>;
-					clock-frequency = <32768>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCRCS>;
+					clock-frequency = <12000000>;
+					clock-accuracy = <50000000>;
 				};
 
-				main: mainck {
-					compatible = "atmel,at91rm9200-clk-main";
+				main_osc: main_osc {
+					compatible = "atmel,at91rm9200-clk-main-osc";
 					#clock-cells = <0>;
 					interrupt-parent = <&pmc>;
 					interrupts = <AT91_PMC_MOSCS>;
-					clocks = <&clk32k>;
+					clocks = <&main_xtal>;
+				};
+
+				main: mainck {
+					compatible = "atmel,at91sam9x5-clk-main";
+					#clock-cells = <0>;
+					interrupt-parent = <&pmc>;
+					interrupts = <AT91_PMC_MOSCSELS>;
+					clocks = <&main_rc_osc &main_osc>;
 				};
 
 				plla: pllack {
@@ -1089,6 +1112,32 @@
 				status = "disabled";
 			};
 
+			sckc at fffffe50 {
+				compatible = "atmel,at91sam9x5-sckc";
+				reg = <0xfffffe50 0x4>;
+
+				slow_rc_osc: slow_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
+					#clock-cells = <0>;
+					clock-frequency = <32768>;
+					clock-accuracy = <50000000>;
+					atmel,startup-time-usec = <75>;
+				};
+
+				slow_osc: slow_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-osc";
+					#clock-cells = <0>;
+					clocks = <&slow_xtal>;
+					atmel,startup-time-usec = <1200000>;
+				};
+
+				clk32k: slowck {
+					compatible = "atmel,at91sam9x5-clk-slow";
+					#clock-cells = <0>;
+					clocks = <&slow_rc_osc &slow_osc>;
+				};
+			};
+
 			rtc at fffffeb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffeb0 0x30>;
-- 
1.8.3.2
