From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 15 May 2017 19:18:39 +0200
Subject: [PATCH 1/5 v3] dt-bindings: Augment Gemini for clocks, resets
Message-ID: <20170515171839.953-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This augments the platform bindings for the Gemini SoC to include
the fact that the system controller also provides clock and reset
lindes, and adds all the required include files.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Essentially a new patch from the two old patches adding
  bindings to the reset and clock controller separately.
  Instead add it all into the system controller and use one
  single compatible.

Rob: I need to merge this together in front of the device tree
changes that sprinkle references to the headers all over the
Gemini device trees, so if this sits good with you please ACK
it.
---
 Documentation/devicetree/bindings/arm/gemini.txt | 24 +++++++++++++++-
 include/dt-bindings/clock/cortina,gemini-clock.h | 29 +++++++++++++++++++
 include/dt-bindings/reset/cortina,gemini-reset.h | 36 ++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/clock/cortina,gemini-clock.h
 create mode 100644 include/dt-bindings/reset/cortina,gemini-reset.h

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
diff --git a/include/dt-bindings/clock/cortina,gemini-clock.h b/include/dt-bindings/clock/cortina,gemini-clock.h
new file mode 100644
index 000000000000..acf5cd550b0c
--- /dev/null
+++ b/include/dt-bindings/clock/cortina,gemini-clock.h
@@ -0,0 +1,29 @@
+#ifndef DT_BINDINGS_CORTINA_GEMINI_CLOCK_H
+#define DT_BINDINGS_CORTINA_GEMINI_CLOCK_H
+
+/* RTC, AHB, APB, CPU, PCI, TVC, UART clocks and 13 gates */
+#define GEMINI_NUM_CLKS 20
+
+#define GEMINI_CLK_RTC 0
+#define GEMINI_CLK_AHB 1
+#define GEMINI_CLK_APB 2
+#define GEMINI_CLK_CPU 3
+#define GEMINI_CLK_PCI 4
+#define GEMINI_CLK_TVC 5
+#define GEMINI_CLK_UART 6
+#define GEMINI_CLK_GATES 7
+#define GEMINI_CLK_GATE_SECURITY 7
+#define GEMINI_CLK_GATE_GMAC0 8
+#define GEMINI_CLK_GATE_GMAC1 9
+#define GEMINI_CLK_GATE_SATA0 10
+#define GEMINI_CLK_GATE_SATA1 11
+#define GEMINI_CLK_GATE_USB0 12
+#define GEMINI_CLK_GATE_USB1 13
+#define GEMINI_CLK_GATE_IDE 14
+#define GEMINI_CLK_GATE_PCI 15
+#define GEMINI_CLK_GATE_DDR 16
+#define GEMINI_CLK_GATE_FLASH 17
+#define GEMINI_CLK_GATE_TVC 18
+#define GEMINI_CLK_GATE_BOOT 19
+
+#endif /* DT_BINDINGS_CORTINA_GEMINI_CLOCK_H */
diff --git a/include/dt-bindings/reset/cortina,gemini-reset.h b/include/dt-bindings/reset/cortina,gemini-reset.h
new file mode 100644
index 000000000000..aebecae43721
--- /dev/null
+++ b/include/dt-bindings/reset/cortina,gemini-reset.h
@@ -0,0 +1,36 @@
+#ifndef _DT_BINDINGS_RESET_CORTINA_GEMINI_H
+#define _DT_BINDINGS_RESET_CORTINA_GEMINI_H
+
+#define GEMINI_RESET_DRAM	0
+#define GEMINI_RESET_FLASH	1
+#define GEMINI_RESET_IDE	2
+#define GEMINI_RESET_RAID	3
+#define GEMINI_RESET_SECURITY	4
+#define GEMINI_RESET_GMAC0	5
+#define GEMINI_RESET_GMAC1	6
+#define GEMINI_RESET_PCI	7
+#define GEMINI_RESET_USB0	8
+#define GEMINI_RESET_USB1	9
+#define GEMINI_RESET_DMAC	10
+#define GEMINI_RESET_APB	11
+#define GEMINI_RESET_LPC	12
+#define GEMINI_RESET_LCD	13
+#define GEMINI_RESET_INTCON0	14
+#define GEMINI_RESET_INTCON1	15
+#define GEMINI_RESET_RTC	16
+#define GEMINI_RESET_TIMER	17
+#define GEMINI_RESET_UART	18
+#define GEMINI_RESET_SSP	19
+#define GEMINI_RESET_GPIO0	20
+#define GEMINI_RESET_GPIO1	21
+#define GEMINI_RESET_GPIO2	22
+#define GEMINI_RESET_WDOG	23
+#define GEMINI_RESET_EXTERN	24
+#define GEMINI_RESET_CIR	25
+#define GEMINI_RESET_SATA0	26
+#define GEMINI_RESET_SATA1	27
+#define GEMINI_RESET_TVE	28
+#define GEMINI_RESET_CPU1	30
+#define GEMINI_RESET_GLOBAL	31
+
+#endif
-- 
2.9.3
