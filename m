From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 31 Jul 2015 11:39:48 +0200
Subject: [PATCH 12/23] ARM: at91/dt: at91sam9x5: use slow clock where necessary
In-Reply-To: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438335599-3301-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438335599-3301-13-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog, the reset controller, the RTC, the shutdown controller, the
timer counters and the LCD PWM need the slow clock, add it where necessary,
The LCD PWM will be handled later.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index b6c8df8d380e..1709a071c5ae 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -376,11 +376,13 @@
 			rstc at fffffe00 {
 				compatible = "atmel,at91sam9g45-rstc";
 				reg = <0xfffffe00 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			shdwc at fffffe10 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfffffe10 0x10>;
+				clocks = <&clk32k>;
 			};
 
 			pit: timer at fffffe30 {
@@ -418,16 +420,16 @@
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf8008000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb0_clk>, <&clk32k>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			tcb1: timer at f800c000 {
 				compatible = "atmel,at91sam9x5-tcb";
 				reg = <0xf800c000 0x100>;
 				interrupts = <17 IRQ_TYPE_LEVEL_HIGH 0>;
-				clocks = <&tcb0_clk>;
-				clock-names = "t0_clk";
+				clocks = <&tcb0_clk>, <clk32k>;
+				clock-names = "t0_clk", "slow_clk";
 			};
 
 			dma0: dma-controller at ffffec00 {
@@ -1173,6 +1175,7 @@
 				compatible = "atmel,at91sam9260-wdt";
 				reg = <0xfffffe40 0x10>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				atmel,watchdog-type = "hardware";
 				atmel,reset-type = "all";
 				atmel,dbg-halt;
@@ -1183,6 +1186,7 @@
 				compatible = "atmel,at91sam9x5-rtc";
 				reg = <0xfffffeb0 0x40>;
 				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&clk32k>;
 				status = "disabled";
 			};
 
-- 
2.1.4
