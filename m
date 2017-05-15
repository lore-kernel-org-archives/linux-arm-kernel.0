From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 May 2017 19:19:38 +0200
Subject: [PATCH 4/5 v3] ARM: dts: Add the Gemini reset controller
Message-ID: <20170515171938.1126-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Gemini reset controller to the Gemini SoC
DTSI file and also adds the reset references to all existing
blocks already in the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- No special compatible on the syscon to indicate that it is
  a reset controller.
ChangeLog v1->v2:
- Cut the reset controller child node and reference resets
  directly from the syscon.
- Use <dt-bindings/reset/cortina,gemini-reset.h> defines.
---
 arch/arm/boot/dts/gemini.dtsi | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index b8d011bdcc76..2be589fccb5c 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -5,6 +5,7 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/reset/cortina,gemini-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -25,8 +26,10 @@
 		};
 
 		syscon: syscon at 40000000 {
-			compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
+			compatible = "cortina,gemini-syscon",
+				     "syscon", "simple-mfd";
 			reg = <0x40000000 0x1000>;
+			#reset-cells = <1>;
 
 			syscon-reboot {
 				compatible = "syscon-reboot";
@@ -42,11 +45,13 @@
 			compatible = "cortina,gemini-watchdog";
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_WDOG>;
 		};
 
 		uart0: serial at 42000000 {
 			compatible = "ns16550a";
 			reg = <0x42000000 0x100>;
+			resets = <&syscon GEMINI_RESET_UART>;
 			clock-frequency = <48000000>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -59,6 +64,7 @@
 			interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
 				     <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
 				     <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+			resets = <&syscon GEMINI_RESET_TIMER>;
 			syscon = <&syscon>;
 		};
 
@@ -66,11 +72,13 @@
 			compatible = "cortina,gemini-rtc";
 			reg = <0x45000000 0x100>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_RTC>;
 		};
 
 		intcon: interrupt-controller at 48000000 {
 			compatible = "faraday,ftintc010";
 			reg = <0x48000000 0x1000>;
+			resets = <&syscon GEMINI_RESET_INTCON0>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
@@ -85,6 +93,7 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4d000000 0x100>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_GPIO0>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -95,6 +104,7 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4e000000 0x100>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_GPIO1>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -105,6 +115,7 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4f000000 0x100>;
 			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon GEMINI_RESET_GPIO2>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -118,6 +129,7 @@
 			 * to configure the host bridge.
 			 */
 			reg = <0x50000000 0x100>;
+			resets = <&syscon GEMINI_RESET_PCI>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.9.3
