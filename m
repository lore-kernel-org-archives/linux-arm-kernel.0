From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 20 Aug 2017 12:05:54 +0200
Subject: [PATCH 1/4 v2] drm/tve200: Add DT bindings
Message-ID: <20170820100557.24991-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Faraday TVE200 IP block.
This IP block is present in the Gemini ARM SoC and also in some
Grain Media GMxxxx SoCs.

Cc: devicetree at vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix display port bindings: list required endpoint.
- Fix the example to include an endpoint.
---
 .../devicetree/bindings/display/faraday,tve200.txt | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt

diff --git a/Documentation/devicetree/bindings/display/faraday,tve200.txt b/Documentation/devicetree/bindings/display/faraday,tve200.txt
new file mode 100644
index 000000000000..82e3bc0b7485
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/faraday,tve200.txt
@@ -0,0 +1,54 @@
+* Faraday TV Encoder TVE200
+
+Required properties:
+
+- compatible: must be one of:
+	"faraday,tve200"
+	"cortina,gemini-tvc", "faraday,tve200"
+
+- reg: base address and size of the control registers block
+
+- interrupts: contains an interrupt specifier for the interrupt
+	line from the TVE200
+
+- clock-names: should contain "PCLK" for the clock line clocking the
+	silicon and "TVE" for the 27MHz clock to the video driver
+
+- clocks: contains phandle and clock specifier pairs for the entries
+	in the clock-names property. See
+	Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Optional properties:
+
+- resets: contains the reset line phandle for the block
+
+Required sub-nodes:
+
+- port: describes LCD panel signals, following the common binding
+	for video transmitter interfaces; see
+	Documentation/devicetree/bindings/media/video-interfaces.txt
+	This port should have the properties:
+	reg = <0>;
+	It should have one endpoint connected to a remote endpoint where
+	the display is connected.
+
+Example:
+
+display-controller at 6a000000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "faraday,tve200";
+	reg = <0x6a000000 0x1000>;
+	interrupts = <13 IRQ_TYPE_EDGE_RISING>;
+	resets = <&syscon GEMINI_RESET_TVC>;
+	clocks = <&syscon GEMINI_CLK_GATE_TVC>,
+		 <&syscon GEMINI_CLK_TVC>;
+	clock-names = "PCLK", "TVE";
+
+	port at 0 {
+		reg = <0>;
+		display_out: endpoint {
+			remote-endpoint = <&panel_in>;
+		};
+	};
+};
-- 
2.13.5
