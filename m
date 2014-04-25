From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 25 Apr 2014 22:00:22 +0200
Subject: [RFC 3/5] ARM: berlin/dt: add support for the clock group to BG2
In-Reply-To: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1398456024-27876-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly added marvell,berlin2-clkgrp driver, add real support for cfgclk
and add the cpu0 and perif clocks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2.dtsi | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 2604c8692b77..589a71472e2e 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -43,12 +43,6 @@
 		clock-frequency = <25000000>;
 	};
 
-	cfgclk: cfg-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
 	twdclk: twdclk {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
@@ -190,6 +184,30 @@
 			reg = <0xea003c 0x8>;
 		};
 
+		grpclk: grpclk at ea0154 {
+			compatible = "marvell,berlin2-clkgrp";
+			clocks = <&syspll>;
+			reg = <0xea00f8 0x4>, <0xea00ec 0xc>;
+
+			cpu0clk: cpu0clk {
+				#clock-cells = <0>;
+				marvell,clk-switch-offset = <6>;
+				marvell,clk-select-offset = <6>;
+			};
+
+			cfgclk: cfgclk {
+				#clock-cells = <0>;
+				marvell,clk-switch-offset = <15>;
+				marvell,clk-select-offset = <23>;
+			};
+
+			perifclk: perifclk {
+				#clock-cells = <0>;
+				marvell,clk-switch-offset = <24>;
+				marvell,clk-select-offset = <41>;
+			};
+		};
+
 		sdio0xinclk: sdio0xinclk at ea023c {
 			compatible = "marvell,berlin-clk";
 			clocks = <&syspll>;
-- 
1.9.1
