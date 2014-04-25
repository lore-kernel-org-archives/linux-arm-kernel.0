From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 25 Apr 2014 22:00:24 +0200
Subject: [RFC 5/5] ARM: berlin/dt: add support for the clock group to BG2Q
In-Reply-To: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1398456024-27876-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1398456024-27876-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the newly added marvell,berlin2-clkgrp driver, add real support for cfgclk
and add the nfcecc clock.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/berlin2q.dtsi | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index 559819b89ea1..169c783ef262 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -53,12 +53,6 @@
 		clock-frequency = <25000000>;
 	};
 
-	cfgclk: config-clock {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <100000000>;
-	};
-
 	twdclk: twdclk {
 		compatible = "fixed-factor-clock";
 		#clock-cells = <0>;
@@ -191,6 +185,24 @@
 			reg = <0xea0030 0x8>;
 		};
 
+		grpclk: grpclk at ea00ec {
+			compatible = "marvell,berlin2-clkgrp";
+			clocks = <&syspll>;
+			reg = <0xea00f8 0x4>, <0xea00ec 0xc>;
+
+			cfgclk: cfgclk {
+				#clock-cells = <0>;
+				marvell,clk-switch-offset = <9>;
+				marvell,clk-select-offset = <12>;
+			};
+
+			nfceccclk: nfceccclk {
+				#clock-cells = <0>;
+				marvell,clk-switch-offset = <27>;
+				marvell,clk-select-offset = <50>;
+			};
+		};
+
 		sdio0xinclk: sdio0xinclk at ea0158 {
 			compatible = "marvell,berlin-clk";
 			clocks = <&syspll>;
-- 
1.9.1
