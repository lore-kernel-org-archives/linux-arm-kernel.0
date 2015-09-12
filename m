From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 12 Sep 2015 15:26:23 +0200
Subject: [PATCH 1/2] Documentation: bindings: Add the Allwinner A10 codec
 bindings
In-Reply-To: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1442064384-23379-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner SoCs have an in-SoC audio controller taking the role of a DAI
and a codec.

Add the binding documentation for that controller on the A10.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/sound/sun4i-codec.txt      | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-codec.txt

diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
new file mode 100644
index 000000000000..680144b74ae9
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
@@ -0,0 +1,33 @@
+* Allwinner A10 Codec
+
+Required properties:
+- compatible: must be either "allwinner,sun4i-a10-codec" or
+  "allwinner,sun7i-a20-codec"
+- reg: must contain the registers location and length
+- interrupts: must contain the codec interrupt
+- dmas: DMA channels for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry
+  in clock-names.
+- clock-names: should contain followings:
+   - "apb": the parent APB clock for this controller
+   - "codec": the parent module clock
+- routing : A list of the connections between audio components.  Each
+  entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source.
+
+
+Example:
+codec: codec at 01c22c00 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun7i-a20-codec";
+	reg = <0x01c22c00 0x40>;
+	interrupts = <0 30 4>;
+	clocks = <&apb0_gates 0>, <&codec_clk>;
+	clock-names = "apb", "codec";
+	dmas = <&dma 0 19>, <&dma 0 19>;
+	dma-names = "rx", "tx";
+	routing = "Headphone Jack", "HP Right",
+		  "Headphone Jack", "HP Left";
+};
-- 
2.5.1
