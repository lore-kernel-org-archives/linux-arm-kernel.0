From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:05 +0200
Subject: [PATCH RESEND 2/7] dt-bindings: bus: Add binding for the Allwinner
 MBUS controller
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <0dc202cef44d5b63505e11c979148c4ab80cff81.1532098561.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MBUS controller drives the MBUS that other devices in the SoC will
use to perform DMA. It also has a register interface that allows to
monitor and control the bandwidth and priorities for masters on that
bus.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/bindings/sunxi-mbus.txt | 35 +++++++++++++++++-
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sunxi-mbus.txt

diff --git a/Documentation/devicetree/bindings/sunxi-mbus.txt b/Documentation/devicetree/bindings/sunxi-mbus.txt
new file mode 100644
index 000000000000..436df0cac9d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sunxi-mbus.txt
@@ -0,0 +1,35 @@
+Allwinner Memory Bus (MBUS) controller
+
+The MBUS controller drives the MBUS that other devices in the SoC will
+use to perform DMA. It also has a register interface that allows to
+monitor and control the bandwidth and priorities for masters on that
+bus.
+
+Required properties:
+ - compatible: Must be one of:
+	- allwinner,sun5i-a13-mbus
+ - reg: Offset and length of the register set for the controller
+ - clocks: phandle to the clock driving the controller
+ - dma-ranges: see booting-without-of.txt
+ - #dma-parent-cells: Must be one, with the argument being the MBUS port
+   ID
+
+Each device having to perform their DMA through the MBUS must have the
+dma-parent property set to the MBUS controller, as documented in
+booting-without-of.txt.
+
+Example:
+
+mbus: dram-controller at 1c01000 {
+	compatible = "allwinner,sun5i-a13-mbus";
+	reg = <0x01c01000 0x1000>;
+	clocks = <&ccu CLK_MBUS>;
+	dma-ranges = <0x00000000 0x40000000 0x20000000>;
+	#dma-parent-cells = <1>;
+};
+
+fe0: display-frontend at 1e00000 {
+	compatible = "allwinner,sun5i-a13-display-frontend";
+	...
+	dma-parent = <&mbus 19>;
+};
-- 
git-series 0.9.1
