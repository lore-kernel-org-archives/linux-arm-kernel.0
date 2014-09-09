From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue,  9 Sep 2014 12:14:20 +0200
Subject: [PATCH] ARM: at91/dt: declare sckc node on at91sam9g45
Message-ID: <1410257660-8590-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare the SCKC (Slow Clock Configuration) block and its clks.
Make use of the clk32k clk instead of slow_osc where appropriate.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 9d4d0a1..68a457b 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -159,7 +159,7 @@
 					compatible = "atmel,at91rm9200-clk-master";
 					#clock-cells = <0>;
 					interrupts-extended = <&pmc AT91_PMC_MCKRDY>;
-					clocks = <&slow_xtal>, <&main>, <&plladiv>, <&utmi>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>;
 					atmel,clk-output-range = <0 133333333>;
 					atmel,clk-divisors = <1 2 4 3>;
 				};
@@ -175,7 +175,7 @@
 					#address-cells = <1>;
 					#size-cells = <0>;
 					interrupt-parent = <&pmc>;
-					clocks = <&slow_xtal>, <&main>, <&plladiv>, <&utmi>, <&mck>;
+					clocks = <&clk32k>, <&main>, <&plladiv>, <&utmi>, <&mck>;
 
 					prog0: prog0 {
 						#clock-cells = <0>;
@@ -1160,6 +1160,32 @@
 				};
 			};
 
+			sckc at fffffd50 {
+				compatible = "atmel,at91sam9x5-sckc";
+				reg = <0xfffffd50 0x4>;
+
+				slow_osc: slow_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-osc";
+					#clock-cells = <0>;
+					atmel,startup-time-usec = <1200000>;
+					clocks = <&slow_xtal>;
+				};
+
+				slow_rc_osc: slow_rc_osc {
+					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
+					#clock-cells = <0>;
+					atmel,startup-time-usec = <75>;
+					clock-frequency = <32768>;
+					clock-accuracy = <50000000>;
+				};
+
+				clk32k: slck {
+					compatible = "atmel,at91sam9x5-clk-slow";
+					#clock-cells = <0>;
+					clocks = <&slow_rc_osc &slow_osc>;
+				};
+			};
+
 			rtc at fffffdb0 {
 				compatible = "atmel,at91rm9200-rtc";
 				reg = <0xfffffdb0 0x10>;
-- 
1.9.1
