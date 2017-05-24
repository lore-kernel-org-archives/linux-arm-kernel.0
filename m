From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 May 2017 11:07:48 +0200
Subject: [PATCH] ARM: dts: augment Moxa and Aspeed DTS for FTTMR010
Message-ID: <20170524090748.27345-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This augments the Moxa Art and Aspeed device trees to:

- Explicitly name the clock "PCLK" as the Faraday FTTMR010
  names it.
- List the Moxa timer as compatible with the Faradat FTTMR010
  vanilla version.
- Add a comment that the Aspeed driver is a Faraday
  FTTMR010 derivative.
- Pass all IRQs to the timer from Aspeed: they are all there
  so they should be in the device tree, we only use the
  first one anyways.

Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC maintainers: this is the DTS changes needt to generalize
the Faraday timer. Please merge this into some suitable ARM SoC
DTS branch.
Clocksource maintainers: I will ask the ARM SoC people to merge
this patch orthogonally, it is only included in this series
for reference and for testing.
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++----
 arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++----
 arch/arm/boot/dts/moxart.dtsi    | 3 ++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 8c6bc29eb7f6..8a04c7e2d818 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -886,13 +886,12 @@
 			};
 
 			timer: timer at 1e782000 {
+				/* This timer is a Faraday FTTMR010 derivative */
 				compatible = "aspeed,ast2400-timer";
 				reg = <0x1e782000 0x90>;
-				// The moxart_timer driver registers only one
-				// interrupt and assumes it's for timer 1
-				//interrupts = <16 17 18 35 36 37 38 39>;
-				interrupts = <16>;
+				interrupts = <16 17 18 35 36 37 38 39>;
 				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 			};
 
 			wdt1: wdt at 1e785000 {
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index a0bea4a6ec77..9cffe347b828 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -993,13 +993,12 @@
 			};
 
 			timer: timer at 1e782000 {
+				/* This timer is a Faraday FTTMR010 derivative */
 				compatible = "aspeed,ast2400-timer";
 				reg = <0x1e782000 0x90>;
-				// The moxart_timer driver registers only one
-				// interrupt and assumes it's for timer 1
-				//interrupts = <16 17 18 35 36 37 38 39>;
-				interrupts = <16>;
+				interrupts = <16 17 18 35 36 37 38 39>;
 				clocks = <&clk_apb>;
+				clock-names = "PCLK";
 			};
 
 
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index e86f8c905ac5..1f4c795d3f72 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -58,10 +58,11 @@
 		};
 
 		timer: timer at 98400000 {
-			compatible = "moxa,moxart-timer";
+			compatible = "moxa,moxart-timer", "faraday,fttmr010";
 			reg = <0x98400000 0x42>;
 			interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
 			clocks = <&clk_apb>;
+			clock-names = "PCLK";
 		};
 
 		gpio: gpio at 98700000 {
-- 
2.9.4
