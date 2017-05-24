From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 24 May 2017 10:48:52 +0200
Subject: [PATCH 2/3 v4] ARM: dts: Add the Gemini reset controller
Message-ID: <20170524084852.24925-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the Gemini reset controller to the Gemini SoC
DTSI file and also adds the reset references to all existing
blocks already in the device tree.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Use numerical values for the reset lines again. Adopt merge
  strategy to replace this with macros after rc1 with a separate patch.
ChangeLog v2->v3:
- No special compatible on the syscon to indicate that it is
  a reset controller.
ChangeLog v1->v2:
- Cut the reset controller child node and reference resets
  directly from the syscon.
- Use <dt-bindings/reset/cortina,gemini-reset.h> defines.
---
 arch/arm/boot/dts/gemini.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index b8d011bdcc76..dadc8412243e 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -25,8 +25,10 @@
 		};
 
 		syscon: syscon at 40000000 {
-			compatible = "cortina,gemini-syscon", "syscon", "simple-mfd";
+			compatible = "cortina,gemini-syscon",
+				     "syscon", "simple-mfd";
 			reg = <0x40000000 0x1000>;
+			#reset-cells = <1>;
 
 			syscon-reboot {
 				compatible = "syscon-reboot";
@@ -42,11 +44,13 @@
 			compatible = "cortina,gemini-watchdog";
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon 23>;
 		};
 
 		uart0: serial at 42000000 {
 			compatible = "ns16550a";
 			reg = <0x42000000 0x100>;
+			resets = <&syscon 18>;
 			clock-frequency = <48000000>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
@@ -59,6 +63,7 @@
 			interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
 				     <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
 				     <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
+			resets = <&syscon 17>;
 			syscon = <&syscon>;
 		};
 
@@ -66,11 +71,13 @@
 			compatible = "cortina,gemini-rtc";
 			reg = <0x45000000 0x100>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon 16>;
 		};
 
 		intcon: interrupt-controller at 48000000 {
 			compatible = "faraday,ftintc010";
 			reg = <0x48000000 0x1000>;
+			resets = <&syscon 14>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
@@ -85,6 +92,7 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4d000000 0x100>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon 20>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -95,6 +103,7 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4e000000 0x100>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon 21>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -105,6 +114,7 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4f000000 0x100>;
 			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&syscon 22>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -118,6 +128,7 @@
 			 * to configure the host bridge.
 			 */
 			reg = <0x50000000 0x100>;
+			resets = <&syscon 7>;
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.9.4
