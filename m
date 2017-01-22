From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 22 Jan 2017 13:22:19 +0100
Subject: [PATCH 11/22] ARM: dts: add top-level DT bindings for Cortina Gemini
Message-ID: <20170122122219.10611-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the top level SoC bindings for Cortina systems Gemini
platforms.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/arm/gemini.txt | 58 ++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/gemini.txt

diff --git a/Documentation/devicetree/bindings/arm/gemini.txt b/Documentation/devicetree/bindings/arm/gemini.txt
new file mode 100644
index 000000000000..28ce7db0cfd3
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/gemini.txt
@@ -0,0 +1,58 @@
+Cortina systems Gemini platforms
+
+The gemini SoC is an ARMv4 SoC from Cortina systems used for NAS
+and similar usecases.
+
+Required properties (in root node):
+	compatible = "cortina,gemini";
+
+Required nodes:
+
+- syscon: the root node must have a system controller node pointing to the
+  global control registers, with the compatible string
+  "cortina,gemini-syscon", "syscon";
+
+- timer: the root node must have a timer node pointing to the SoC timer
+  block, with the compatible string "cortina,gemini-timer"
+  See: clocksource/cortina,gemini-timer.txt
+
+- intcon: the root node must have an interrupt controller node pointing to
+  the SoC interrupt controller block, with the compatible string
+  "cortina,gemini-interrupt-controller"
+  See interrupt-controller/cortina,gemini-interrupt-controller.txt
+
+Example:
+
+/ {
+	interrupt-parent = <&intcon>;
+
+	syscon: syscon at 40000000 {
+		compatible = "cortina,gemini-syscon", "syscon";
+		reg = <0x40000000 0x1000>;
+	};
+
+	timer at 43000000 {
+		compatible = "cortina,gemini-timer";
+		reg = <0x43000000 0x1000>;
+		interrupt-parent = <&intcon>;
+		interrupts = <14 IRQ_TYPE_EDGE_RISING>, /* Timer 1 */
+			   <15 IRQ_TYPE_EDGE_RISING>, /* Timer 2 */
+			   <16 IRQ_TYPE_EDGE_RISING>; /* Timer 3 */
+		syscon = <&syscon>;
+	};
+
+	uart0: serial at 42000000 {
+		compatible = "ns16550a";
+		reg = <0x42000000 0x100>;
+		clock-frequency = <48000000>;
+		interrupts = <18 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+	};
+
+	intcon: interrupt-controller at 48000000 {
+		compatible = "cortina,gemini-interrupt-controller";
+		reg = <0x48000000 0x1000>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
-- 
2.9.3
