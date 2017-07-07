From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat,  8 Jul 2017 00:32:27 +0200
Subject: [PATCH] ARM: dts: gemini: Switch to using macros
Message-ID: <20170707223227.20477-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macros for reset and clock lines were merged during the merge
window, this switches the Gemini to use these macros rather than
numerical defines.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: The required header files are now upstream. Please
apply and merge this at -rc1 or whenever fits you best (it can be
applied to Torvald's tree right now.)
---
 arch/arm/boot/dts/gemini.dtsi | 56 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 141d8d3a1d07..49cce9e9d51f 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -5,6 +5,8 @@
 /include/ "skeleton.dtsi"
 
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/cortina,gemini-clock.h>
+#include <dt-bindings/reset/cortina,gemini-reset.h>
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -45,15 +47,15 @@
 			compatible = "cortina,gemini-watchdog";
 			reg = <0x41000000 0x1000>;
 			interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&syscon 23>;
-			clocks = <&syscon 2>;
+			resets = <&syscon GEMINI_RESET_WDOG>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 		};
 
 		uart0: serial at 42000000 {
 			compatible = "ns16550a";
 			reg = <0x42000000 0x100>;
-			resets = <&syscon 18>;
-			clocks = <&syscon 6>;
+			resets = <&syscon GEMINI_RESET_UART>;
+			clocks = <&syscon GEMINI_CLK_UART>;
 			interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 		};
@@ -65,9 +67,9 @@
 			interrupts = <14 IRQ_TYPE_EDGE_FALLING>, /* Timer 1 */
 				     <15 IRQ_TYPE_EDGE_FALLING>, /* Timer 2 */
 				     <16 IRQ_TYPE_EDGE_FALLING>; /* Timer 3 */
-			resets = <&syscon 17>;
+			resets = <&syscon GEMINI_RESET_TIMER>;
 			/* APB clock or RTC clock */
-			clocks = <&syscon 2>, <&syscon 0>;
+			clocks = <&syscon GEMINI_CLK_APB>, <&syscon GEMINI_CLK_RTC>;
 			clock-names = "PCLK", "EXTCLK";
 			syscon = <&syscon>;
 		};
@@ -76,19 +78,19 @@
 			compatible = "cortina,gemini-rtc";
 			reg = <0x45000000 0x100>;
 			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&syscon 16>;
-			clocks = <&syscon 2>, <&syscon 0>;
+			resets = <&syscon GEMINI_RESET_RTC>;
+			clocks = <&syscon GEMINI_CLK_APB>, <&syscon GEMINI_CLK_RTC>;
 			clock-names = "PCLK", "EXTCLK";
 		};
 
 		sata: sata at 46000000 {
 			compatible = "cortina,gemini-sata-bridge";
 			reg = <0x46000000 0x100>;
-			resets = <&syscon 26>,
-				 <&syscon 27>;
+			resets = <&syscon GEMINI_RESET_SATA0>,
+				 <&syscon GEMINI_RESET_SATA1>;
 			reset-names = "sata0", "sata1";
-			clocks = <&syscon 10>,
-				 <&syscon 11>;
+			clocks = <&syscon GEMINI_CLK_GATE_SATA0>,
+				 <&syscon GEMINI_CLK_GATE_SATA1>;
 			clock-names = "SATA0_PCLK", "SATA1_PCLK";
 			syscon = <&syscon>;
 			status = "disabled";
@@ -97,7 +99,7 @@
 		intcon: interrupt-controller at 48000000 {
 			compatible = "faraday,ftintc010";
 			reg = <0x48000000 0x1000>;
-			resets = <&syscon 14>;
+			resets = <&syscon GEMINI_RESET_INTCON0>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
@@ -112,8 +114,8 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4d000000 0x100>;
 			interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&syscon 20>;
-			clocks = <&syscon 2>;
+			resets = <&syscon GEMINI_RESET_GPIO0>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -124,8 +126,8 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4e000000 0x100>;
 			interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&syscon 21>;
-			clocks = <&syscon 2>;
+			resets = <&syscon GEMINI_RESET_GPIO1>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -136,8 +138,8 @@
 			compatible = "cortina,gemini-gpio", "faraday,ftgpio010";
 			reg = <0x4f000000 0x100>;
 			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
-			resets = <&syscon 22>;
-			clocks = <&syscon 2>;
+			resets = <&syscon GEMINI_RESET_GPIO2>;
+			clocks = <&syscon GEMINI_CLK_APB>;
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
@@ -151,8 +153,8 @@
 			 * to configure the host bridge.
 			 */
 			reg = <0x50000000 0x100>;
-			resets = <&syscon 7>;
-			clocks = <&syscon 15>, <&syscon 4>;
+			resets = <&syscon GEMINI_RESET_PCI>;
+			clocks = <&syscon GEMINI_CLK_GATE_PCI>, <&syscon GEMINI_CLK_PCI>;
 			clock-names = "PCLK", "PCICLK";
 			#address-cells = <3>;
 			#size-cells = <2>;
@@ -193,8 +195,8 @@
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63000000 0x1000>;
 			interrupts = <4 IRQ_TYPE_EDGE_RISING>;
-			resets = <&syscon 2>;
-			clocks = <&syscon 14>;
+			resets = <&syscon GEMINI_RESET_IDE>;
+			clocks = <&syscon GEMINI_CLK_GATE_IDE>;
 			clock-names = "PCLK";
 			sata = <&sata>;
 			status = "disabled";
@@ -204,8 +206,8 @@
 			compatible = "cortina,gemini-pata", "faraday,ftide010";
 			reg = <0x63400000 0x1000>;
 			interrupts = <5 IRQ_TYPE_EDGE_RISING>;
-			resets = <&syscon 2>;
-			clocks = <&syscon 14>;
+			resets = <&syscon GEMINI_RESET_IDE>;
+			clocks = <&syscon GEMINI_CLK_GATE_IDE>;
 			clock-names = "PCLK";
 			sata = <&sata>;
 			status = "disabled";
@@ -217,8 +219,8 @@
 			arm,primecell-periphid = <0x0003b080>;
 			reg = <0x67000000 0x1000>;
 			interrupts = <9 IRQ_TYPE_EDGE_RISING>;
-			resets = <&syscon 10>;
-			clocks = <&syscon 1>;
+			resets = <&syscon GEMINI_RESET_DMAC>;
+			clocks = <&syscon GEMINI_CLK_AHB>;
 			clock-names = "apb_pclk";
 			/* Bus interface AHB1 (AHB0) is totally tilted */
 			lli-bus-interface-ahb2;
-- 
2.9.4
