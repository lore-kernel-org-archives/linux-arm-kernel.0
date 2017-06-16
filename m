From: olivier.moysan@st.com (olivier moysan)
Date: Fri, 16 Jun 2017 15:57:31 +0200
Subject: [PATCH 1/2] dt-bindings: Document the STM32 SPDIFRX interface
In-Reply-To: <1497621452-615-1-git-send-email-olivier.moysan@st.com>
References: <1497621452-615-1-git-send-email-olivier.moysan@st.com>
Message-ID: <1497621452-615-2-git-send-email-olivier.moysan@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation of device tree bindings for the
STM32 SPDIFRX interface.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 .../devicetree/bindings/sound/st,stm32-spdifrx.txt | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
new file mode 100644
index 0000000..33826f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/st,stm32-spdifrx.txt
@@ -0,0 +1,56 @@
+STMicroelectronics STM32 S/PDIF receiver (SPDIFRX).
+
+The SPDIFRX peripheral, is designed to receive an S/PDIF flow compliant with
+IEC-60958 and IEC-61937.
+
+Required properties:
+  - compatible: should be "st,stm32h7-spdifrx"
+  - reg: cpu DAI IP base address and size
+  - clocks: must contain an entry for kclk (used as S/PDIF signal reference)
+  - clock-names: must contain "kclk"
+  - interrupts: cpu DAI interrupt line
+  - dmas: DMA specifiers for audio data DMA and iec control flow DMA
+    See STM32 DMA bindings, Documentation/devicetree/bindings/dma/stm32-dma.txt
+  - dma-names: two dmas have to be defined, "rx" and "rx-ctrl"
+
+Optional properties:
+  - resets: Reference to a reset controller asserting the SPDIFRX
+
+The device node should contain one 'port' child node with one child 'endpoint'
+node, according to the bindings defined in Documentation/devicetree/bindings/
+graph.txt.
+
+Example:
+spdifrx: spdifrx at 40004000 {
+	compatible = "st,stm32h7-spdifrx";
+	reg = <0x40004000 0x400>;
+	clocks = <&rcc SPDIFRX_CK>;
+	clock-names = "kclk";
+	interrupts = <97>;
+	dmas = <&dmamux1 2 93 0x400 0x0>,
+	       <&dmamux1 3 94 0x400 0x0>;
+	dma-names = "rx", "rx-ctrl";
+	pinctrl-0 = <&spdifrx_pins>;
+	pinctrl-names = "default";
+
+	spdifrx_port: port {
+		cpu_endpoint: endpoint {
+			remote-endpoint = <&codec_endpoint>;
+		};
+	};
+};
+
+spdif_in: spdif-in {
+	compatible = "linux,spdif-dir";
+
+	codec_port: port {
+		codec_endpoint: endpoint {
+			remote-endpoint = <&cpu_endpoint>;
+		};
+	};
+};
+
+soundcard {
+	compatible = "audio-graph-card";
+	dais = <&spdifrx_port>;
+};
-- 
1.9.1
