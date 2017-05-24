From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 May 2017 10:49:02 +0200
Subject: [PATCH 3/3 v4] ARM: dts: Add clocks to the Gemini SoC
Message-ID: <20170524084902.24972-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a clock controller for the Gemini SoC, so make use of the
driver and add clocks to the peripherals. Remove the hard-coded
frequency from the UART and add switch the timer compatible to the
generic that uses the clock framework for clock speed look-up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Use numerical values rather than macros and plan for a patch
  post-rc1 to switch to the macro definitions.
ChangeLog v2->v3:
- No special compatible on the system controller to indicate
  that it is a clock controller.
ChangeLog v1->v2:
- Reference clocks directly from the syscon (subnode needed)
---
 arch/arm/boot/dts/gemini.dtsi | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index dadc8412243e..80abf84f8a80 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -28,6 +28,7 @@
 			compatible = "cortina,gemini-syscon",
 				     "syscon", "simple-mfd";
 			reg = <0x40000000 0x1000>;
+			#clock-cells = <1>;
 			#reset-cells = <1>;
 
 			syscon-reboot {
@@ -45,25 +46,29 @@
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon 23>;
+			clocks = <&syscon 2>;
 		};
 
 		uart0: serial at 42000000 {
 			compatible = "ns16550a";
 			reg = <0x42000000 0x100>;
 			resets = <&syscon 18>;
-			clock-frequency = <48000000>;
+			clocks = <&syscon 6>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 		};
 
 		timer at 43000000 {
-			compatible = "cortina,gemini-timer";
+			compatible = "faraday,fttmr010";
 			reg = <0x43000000 0x1000>;
 			interrupt-parent = <&intcon>;
 			interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
 				     <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
 				     <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
 			resets = <&syscon 17>;
+			/* APB clock or RTC clock */
+			clocks = <&syscon 2>, <&syscon 0>;
+			clock-names = "PCLK", "EXTCLK";
 			syscon = <&syscon>;
 		};
 
@@ -72,6 +77,8 @@
 			reg = <0x45000000 0x100>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon 16>;
+			clocks = <&syscon 2>, <&syscon 0>;
+			clock-names = "PCLK", "EXTCLK";
 		};
 
 		intcon: interrupt-controller at 48000000 {
@@ -93,6 +100,7 @@
 			reg = <0x4d000000 0x100>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon 20>;
+			clocks = <&syscon 2>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -104,6 +112,7 @@
 			reg = <0x4e000000 0x100>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon 21>;
+			clocks = <&syscon 2>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -115,6 +124,7 @@
 			reg = <0x4f000000 0x100>;
 			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon 22>;
+			clocks = <&syscon 2>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -129,6 +139,8 @@
 			 */
 			reg = <0x50000000 0x100>;
 			resets = <&syscon 7>;
+			clocks = <&syscon 15>, <&syscon 4>;
+			clock-names = "PCLK", "PCICLK";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.9.4
