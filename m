From: yong.deng@magewell.com (Yong Deng)
Date: Tue, 27 Jun 2017 19:07:34 +0800
Subject: [PATCH RFC 2/2] dt-bindings: add binding documentation for Allwinner
 CSI
In-Reply-To: <1498561654-14658-1-git-send-email-yong.deng@magewell.com>
References: <1498561654-14658-1-git-send-email-yong.deng@magewell.com>
Message-ID: <1498561654-14658-3-git-send-email-yong.deng@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for Allwinner CSI.

Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 .../devicetree/bindings/media/sunxi-csi.txt        | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/sunxi-csi.txt

diff --git a/Documentation/devicetree/bindings/media/sunxi-csi.txt b/Documentation/devicetree/bindings/media/sunxi-csi.txt
new file mode 100644
index 0000000..770be0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/sunxi-csi.txt
@@ -0,0 +1,51 @@
+Allwinner V3s Camera Sensor Interface
+------------------------------
+
+Required properties:
+  - compatible: value must be "allwinner,sun8i-v3s-csi"
+  - reg: base address and size of the memory-mapped region.
+  - interrupts: interrupt associated to this IP
+  - clocks: phandles to the clocks feeding the CSI
+    * ahb: the CSI interface clock
+    * mod: the CSI module clock
+    * ram: the CSI DRAM clock
+  - clock-names: the clock names mentioned above
+  - resets: phandles to the reset line driving the CSI
+
+- ports: A ports node with endpoint definitions as defined in
+  Documentation/devicetree/bindings/media/video-interfaces.txt. The
+  first port should be the input endpoints, the second one the outputs
+
+Example:
+
+	csi1: csi at 01cb4000 {
+		compatible = "allwinner,sun8i-v3s-csi";
+		reg = <0x01cb4000 0x1000>;
+		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&ccu CLK_BUS_CSI>,
+			 <&ccu CLK_CSI1_SCLK>,
+			 <&ccu CLK_DRAM_CSI>;
+		clock-names = "ahb", "mod", "ram";
+		resets = <&ccu RST_BUS_CSI>;
+
+		port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/* Parallel bus endpoint */
+			csi1_0: endpoint at 0 {
+				reg = <0>;
+				remote = <&adv7611_1>;
+				bus-width = <16>;
+				data-shift = <0>;
+
+				/* If hsync-active/vsync-active are missing,
+				   embedded BT.656 sync is used */
+				hsync-active = <0>; /* Active low */
+				vsync-active = <0>; /* Active low */
+				data-active = <1>;  /* Active high */
+				pclk-sample = <1>;  /* Rising */
+			};
+		};
+	};
+
-- 
1.8.3.1
