From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 13 Jun 2016 15:19:48 +0100
Subject: [PATCH v4 1/3] dt/bindings: display: Add DT bindings for Mali Display
 Processors.
In-Reply-To: <1465827590-17591-1-git-send-email-Liviu.Dudau@arm.com>
References: <1465827590-17591-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <1465827590-17591-2-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for the Mali Display Processor. The bindings
describe the Mali DP500, DP550 and DP650 processors from ARM Ltd.

Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>

Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/display/arm,malidp.txt     | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/arm,malidp.txt

diff --git a/Documentation/devicetree/bindings/display/arm,malidp.txt b/Documentation/devicetree/bindings/display/arm,malidp.txt
new file mode 100644
index 0000000..2f78709
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/arm,malidp.txt
@@ -0,0 +1,65 @@
+ARM Mali-DP
+
+The following bindings apply to a family of Display Processors sold as
+licensable IP by ARM Ltd. The bindings describe the Mali DP500, DP550 and
+DP650 processors that offer multiple composition layers, support for
+rotation and scaling output.
+
+Required properties:
+  - compatible: should be one of
+	"arm,mali-dp500"
+	"arm,mali-dp550"
+	"arm,mali-dp650"
+    depending on the particular implementation present in the hardware
+  - reg: Physical base address and size of the block of registers used by
+    the processor.
+  - interrupts: Interrupt list, as defined in ../interrupt-controller/interrupts.txt,
+    interrupt client nodes.
+  - interrupt-names: name of the engine inside the processor that will
+    use the corresponding interrupt. Should be one of "DE" or "SE".
+  - clocks: A list of phandle + clock-specifier pairs, one for each entry
+    in 'clock-names'
+  - clock-names: A list of clock names. It should contain:
+      - "pclk": for the APB interface clock
+      - "aclk": for the AXI interface clock
+      - "mclk": for the main processor clock
+      - "pxlclk": for the pixel clock feeding the output PLL of the processor.
+  - arm,malidp-output-port-lines: Array of u8 values describing the number
+    of output lines per channel (R, G and B).
+
+Required sub-nodes:
+  - port: The Mali DP connection to an encoder input port. The connection
+    is modelled using the OF graph bindings specified in
+    Documentation/devicetree/bindings/graph.txt
+
+Optional properties:
+  - memory-region: phandle to a node describing memory (see
+    Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt)
+    to be used for the framebuffer; if not present, the framebuffer may
+    be located anywhere in memory.
+
+
+Example:
+
+/ {
+	...
+
+	dp0: malidp at 6f200000 {
+		compatible = "arm,mali-dp650";
+		reg = <0 0x6f200000 0 0x20000>;
+		memory-region = <&display_reserved>;
+		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 168 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "DE", "SE";
+		clocks = <&oscclk2>, <&fpgaosc0>, <&fpgaosc1>, <&fpgaosc1>;
+		clock-names = "pxlclk", "mclk", "aclk", "pclk";
+		arm,malidp-output-port-lines = /bits/ 8 <8 8 8>;
+		port {
+			dp0_output: endpoint {
+				remote-endpoint = <&tda998x_2_input>;
+			};
+		};
+	};
+
+	...
+};
-- 
2.8.2
