From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 11 Jul 2015 14:12:05 +0200
Subject: [PATCH 2/4] doc: dt: dma: add binding doc for pl08x
In-Reply-To: <1436616727-4847-1-git-send-email-manabian@gmail.com>
References: <1436616727-4847-1-git-send-email-manabian@gmail.com>
Message-ID: <1436616727-4847-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This introduces device tree bindings for the PL08x DMA controllers
when used with fixed signal assignment per channel, i.e. if each
channel on the PL08x is assigned precisely one burst/single signal
set.

[je: remove channel sub-node parsing, use cell value to assign AHB]

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/dma/arm-pl08x.txt          | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt

diff --git a/Documentation/devicetree/bindings/dma/arm-pl08x.txt b/Documentation/devicetree/bindings/dma/arm-pl08x.txt
new file mode 100644
index 000000000000..8a0097a029d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/arm-pl08x.txt
@@ -0,0 +1,54 @@
+* ARM PrimeCells PL080 and PL081 and derivatives DMA controller
+
+Required properties:
+- compatible: "arm,pl080", "arm,primecell";
+	      "arm,pl081", "arm,primecell";
+- reg: Address range of the PL08x registers
+- interrupt: The PL08x interrupt number
+- clocks: The clock running the IP core clock
+- clock-names: Must contain "apb_pclk"
+- lli-bus-interface-ahb1: if AHB master 1 is eligible for fetching LLIs
+- lli-bus-interface-ahb2: if AHB master 2 is eligible for fetching LLIs
+- mem-bus-interface-ahb1: if AHB master 1 is eligible for fetching memory contents
+- mem-bus-interface-ahb2: if AHB master 2 is eligible for fetching memory contents
+- #dma-cells: must be <2>. First cell should contain the DMA request,
+              second cell should contain either 1 or 2 depending on
+              which AHB master that is used.
+
+Optional properties:
+- dma-channels: contains the total number of DMA channels supported by the DMAC
+- dma-requests: contains the total number of DMA requests supported by the DMAC
+- memcpy-burst-size: the size of the bursts for memcpy: 1, 4, 8, 16, 32
+  64, 128 or 256 bytes are legal values
+- memcpy-bus-width: the bus width used for memcpy: 8, 16 or 32 are legal
+  values
+
+Clients
+Required properties:
+- dmas: List of DMA controller phandle, request channel and AHB master id
+- dma-names: Names of the aforementioned requested channels
+
+Example:
+
+dmac0: dma-controller at 10130000 {
+	compatible = "arm,pl080", "arm,primecell";
+	reg = <0x10130000 0x1000>;
+	interrupt-parent = <&vica>;
+	interrupts = <15>;
+	clocks = <&hclkdma0>;
+	clock-names = "apb_pclk";
+	lli-bus-interface-ahb1;
+	lli-bus-interface-ahb2;
+	mem-bus-interface-ahb2;
+	memcpy-burst-size = <256>;
+	memcpy-bus-width = <32>;
+	#dma-cells = <2>;
+};
+
+device at 40008000 {
+	...
+	dmas = <&dmac0 0 2
+		&dmac0 1 2>;
+	dma-names = "tx", "rx";
+	...
+};
-- 
1.8.0
