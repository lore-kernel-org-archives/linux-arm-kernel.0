From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 25 Apr 2014 22:00:23 +0200
Subject: [RFC 4/5] ARM: berlin/dt: add support for the clock group to BG2D
In-Reply-To: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1398456024-27876-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly added marvell,berlin2-clkgrp driver, add real support for cfgclk
and add the cpu0, perif and nfcecc clocks.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index b05d32bf70e0..fe5a332908c9 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -36,12 +36,6 @@
 		clock-frequency = <25000000>;
 	};
 
-	cfgclk: cfg-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <75000000>;
-	};
-
 	twdclk: twdclk {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
@@ -183,6 +177,36 @@
 			reg = <0xea003c 0x8>;
 		};
 
+		grpclk: grpclk at ea0154 {
+			compatible = "marvell,berlin2-clkgrp";
+			clocks = <&syspll>;
+			reg = <0xea0164 0x8>, <0xea0154 0x8>;
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
+
+			nfceccclk: nfceccclk {
+				#clock-cells = <0>;
+				marvell,clk-switch-offset = <33>;
+				marvell,clk-select-offset = <61>;
+			};
+		};
+
 		sdio0xinclk: sdio0xinclk at ea023c {
 			compatible = "marvell,berlin-clk";
 			clocks = <&syspll>;
-- 
1.9.1
