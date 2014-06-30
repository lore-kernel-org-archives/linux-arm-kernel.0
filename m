From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Jun 2014 15:20:53 +0200
Subject: [PATCH v10 1/2] Documentation: dt: Add Allwinner A31 DMA controller
 bindings
In-Reply-To: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1404134454-25513-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1404134454-25513-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 DMA controller is rather simple to describe in the DT. Add
the bindings documentation.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/dma/sun6i-dma.txt          | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sun6i-dma.txt

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
new file mode 100644
index 000000000000..3e145c1675b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -0,0 +1,45 @@
+Allwinner A31 DMA Controller
+
+This driver follows the generic DMA bindings defined in dma.txt.
+
+Required properties:
+
+- compatible:	Must be "allwinner,sun6i-a31-dma"
+- reg:		Should contain the registers base address and length
+- interrupts:	Should contain a reference to the interrupt used by this device
+- clocks:	Should contain a reference to the parent AHB clock
+- resets:	Should contain a reference to the reset controller asserting
+		this device in reset
+- #dma-cells :	Should be 1, a single cell holding a line request number
+
+Example:
+	dma: dma-controller at 01c02000 {
+		compatible = "allwinner,sun6i-a31-dma";
+		reg = <0x01c02000 0x1000>;
+		interrupts = <0 50 4>;
+		clocks = <&ahb1_gates 6>;
+		resets = <&ahb1_rst 6>;
+		#dma-cells = <1>;
+	};
+
+Clients:
+
+DMA clients connected to the A31 DMA controller must use the format
+described in the dma.txt file, using a two-cell specifier for each
+channel: a phandle plus one integer cells.
+The two cells in order are:
+
+1. A phandle pointing to the DMA controller.
+2. The port ID as specified in the datasheet
+
+Example:
+spi2: spi at 01c6a000 {
+	compatible = "allwinner,sun6i-a31-spi";
+	reg = <0x01c6a000 0x1000>;
+	interrupts = <0 67 4>;
+	clocks = <&ahb1_gates 22>, <&spi2_clk>;
+	clock-names = "ahb", "mod";
+	dmas = <&dma 25>, <&dma 25>;
+	dma-names = "rx", "tx";
+	resets = <&ahb1_rst 22>;
+};
-- 
2.0.0
