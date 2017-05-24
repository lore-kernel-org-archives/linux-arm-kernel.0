From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 May 2017 10:48:34 +0200
Subject: [PATCH 1/3 v4] dt-bindings: Augment Gemini for clocks, resets
Message-ID: <20170524084834.24876-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This augments the platform bindings for the Gemini SoC to include
the fact that the system controller also provides clock and reset
lines.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Spit off the header files into their own patches so they
  can be merged to respective subsystem.
ChangeLog v2->v3:
- Essentially a new patch from the two old patches adding
  bindings to the reset and clock controller separately.
  Instead add it all into the system controller and use one
  single compatible.
---
 Documentation/devicetree/bindings/arm/gemini.txt | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/gemini.txt b/Documentation/devicetree/bindings/arm/gemini.txt
index 0041eb031116..55bf7ce96c44 100644
--- a/Documentation/devicetree/bindings/arm/gemini.txt
+++ b/Documentation/devicetree/bindings/arm/gemini.txt
@@ -24,6 +24,19 @@ Required nodes:
   global control registers, with the compatible string
   "cortina,gemini-syscon", "syscon";
 
+  Required properties on the syscon:
+  - reg: syscon register location and size.
+  - #clock-cells: should be set to <1> - the system controller is also a
+                  clock provider.
+  - #reset-cells: should be set to <1> - the system controller is also a
+                  reset line provider.
+
+  The clock sources have shorthand defines in the include file:
+  <dt-bindings/clock/cortina,gemini-clock.h>
+
+  The reset lines have shorthand defines in the include file:
+  <dt-bindings/reset/cortina,gemini-reset.h>
+
 - timer: the soc bus node must have a timer node pointing to the SoC timer
   block, with the compatible string "cortina,gemini-timer"
   See: clocksource/cortina,gemini-timer.txt
@@ -56,12 +69,15 @@ Example:
 		syscon: syscon at 40000000 {
 			compatible = "cortina,gemini-syscon", "syscon";
 			reg = <0x40000000 0x1000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		uart0: serial at 42000000 {
 			compatible = "ns16550a";
 			reg = <0x42000000 0x100>;
-			clock-frequency = <48000000>;
+			resets = <&syscon GEMINI_RESET_UART>;
+			clocks = <&syscon GEMINI_CLK_UART>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 		};
@@ -73,12 +89,18 @@ Example:
 			interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
 				     <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
 				     <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+			resets = <&syscon GEMINI_RESET_TIMER>;
+			/* APB clock or RTC clock */
+			clocks = <&syscon GEMINI_CLK_APB>,
+				 <&syscon GEMINI_CLK_RTC>;
+			clock-names = "PCLK", "EXTCLK";
 			syscon = <&syscon>;
 		};
 
 		intcon: interrupt-controller at 48000000 {
 			compatible = "cortina,gemini-interrupt-controller";
 			reg = <0x48000000 0x1000>;
+			resets = <&syscon GEMINI_RESET_INTCON0>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
-- 
2.9.4
