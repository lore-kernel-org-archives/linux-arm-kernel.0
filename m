From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  1 Jun 2016 19:54:27 +0200
Subject: [PATCH 1/4] dt-bindings: Add A10 I2S controller binding documentation
In-Reply-To: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
References: <20160601175430.11625-1-maxime.ripard@free-electrons.com>
Message-ID: <20160601175430.11625-2-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the device tree binding for the I2S controller found in the
Allwinner A10 and later SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 .../devicetree/bindings/sound/sun4i-i2s.txt        | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sun4i-i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
new file mode 100644
index 000000000000..365ca4eede5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
@@ -0,0 +1,33 @@
+* Allwinner A10 I2S controller
+
+The I2S bus (Inter-IC sound bus) is a serial link for digital
+audio data transfer between devices in the system.
+
+Required properties:
+
+- compatible: should be one of the followings
+   - "allwinner,sun4i-a10-i2s"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: should contain the I2S interrupt.
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: should include "tx" and "rx".
+- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
+- clock-names: should contain followings:
+   - "apb" : clock for the I2S bus interface
+   - "mod" : module clock for the I2S controller
+
+Example:
+
+i2s0: i2s at 01c22400 {
+	#sound-dai-cells = <0>;
+	compatible = "allwinner,sun4i-a10-i2s";
+	reg = <0x01c22400 0x400>;
+	interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&apb0_gates 3>, <&i2s0_clk>;
+	clock-names = "apb", "mod";
+	dmas = <&dma SUN4I_DMA_NORMAL 3>,
+	       <&dma SUN4I_DMA_NORMAL 3>;
+	dma-names = "rx", "tx";
+};
-- 
2.8.3
