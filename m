From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 May 2017 19:19:58 +0200
Subject: [PATCH 5/5 v3] ARM: dts: Add clocks to the Gemini SoC
Message-ID: <20170515171958.1179-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have a clock controller for the Gemini SoC, so make use of the
driver and add clocks to the peripherals. Remove the hard-coded
frequency from the UART and add switch the timer compatible to the
generic that uses the clock framework for clock speed look-up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No special compatible on the system controller to indicate
  that it is a clock controller.
ChangeLog v1->v2:
- Reference clocks directly from the syscon (subnode needed)
---
 arch/arm/boot/dts/gemini.dtsi | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 2be589fccb5c..4c09ec2cefbc 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -5,6 +5,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/cortina,gemini-clock.h>
 #include <dt-bindings/reset/cortina,gemini-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 
@@ -29,6 +30,7 @@
 			compatible = "cortina,gemini-syscon",
 				     "syscon", "simple-mfd";
 			reg = <0x40000000 0x1000>;
+			#clock-cells = <1>;
 			#reset-cells = <1>;
 
 			syscon-reboot {
@@ -46,25 +48,29 @@
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_WDOG>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 		};
 
 		uart0: serial at 42000000 {
 			compatible = "ns16550a";
 			reg = <0x42000000 0x100>;
 			resets = <&syscon GEMINI_RESET_UART>;
-			clock-frequency = <48000000>;
+			clocks = <&syscon GEMINI_CLK_UART>;
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
 			resets = <&syscon GEMINI_RESET_TIMER>;
+			/* APB clock or RTC clock */
+			clocks = <&syscon GEMINI_CLK_APB>, <&syscon GEMINI_CLK_RTC>;
+			clock-names = "PCLK", "EXTCLK";
 			syscon = <&syscon>;
 		};
 
@@ -73,6 +79,8 @@
 			reg = <0x45000000 0x100>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_RTC>;
+			clocks = <&syscon GEMINI_CLK_APB>, <&syscon GEMINI_CLK_RTC>;
+			clock-names = "PCLK", "EXTCLK";
 		};
 
 		intcon: interrupt-controller at 48000000 {
@@ -94,6 +102,7 @@
 			reg = <0x4d000000 0x100>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_GPIO0>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -105,6 +114,7 @@
 			reg = <0x4e000000 0x100>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_GPIO1>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -116,6 +126,7 @@
 			reg = <0x4f000000 0x100>;
 			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 			resets = <&syscon GEMINI_RESET_GPIO2>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -130,6 +141,8 @@
 			 */
 			reg = <0x50000000 0x100>;
 			resets = <&syscon GEMINI_RESET_PCI>;
+			clocks = <&syscon GEMINI_CLK_GATE_PCI>, <&syscon GEMINI_CLK_PCI>;
+			clock-names = "PCLK", "PCICLK";
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.9.3
