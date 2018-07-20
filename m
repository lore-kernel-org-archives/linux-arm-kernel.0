From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 20 Jul 2018 16:56:04 +0200
Subject: [PATCH RESEND 1/7] dt-bindings: Add a dma-parent property
In-Reply-To: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
References: <cover.d2aafc48da035aed80793da89079e5da269b45b4.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <50441bfc16c0b78fed4f07c8e6b3b6d1c6b4dff6.1532098561.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current DT bindings assume that the DMA will be performed by the
devices through their parent DT node, and rely on that assumption for the
address translation using dma-ranges.

However, some SoCs have devices that will perform DMA through another bus,
with separate address translation rules. We therefore need to express that
relationship, through the dma-parent property.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 Documentation/devicetree/booting-without-of.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/booting-without-of.txt b/Documentation/devicetree/booting-without-of.txt
index e86bd2f64117..4a65c943c02d 100644
--- a/Documentation/devicetree/booting-without-of.txt
+++ b/Documentation/devicetree/booting-without-of.txt
@@ -1403,8 +1403,15 @@ In addition, each DMA master device on the DMA bus may or may not support
 coherent DMA operations. The "dma-coherent" property is intended to be used
 for identifying devices supported coherent DMA operations in DT.
 
+Some devices will also perform DMA through another bus than their parent
+control bus. In such a case, the "dma-parent" property is intended to express
+that relationship to another device in DT that will be the DMA parent bus.
+
 * DMA Bus master
 Optional property:
+- #dma-parent-cells: <integer>
+	The #dma-parent-cells property defines the width of the cells used to
+	represent the DMA parent.
 - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
 	(child-bus-address, parent-bus-address, length). Each triplet specified
 	describes a contiguous DMA address range.
@@ -1420,6 +1427,9 @@ Optional property:
 - dma-ranges: <empty> value. if present - It means that DMA addresses
 	translation has to be enabled for this device.
 - dma-coherent: Present if dma operations are coherent
+- dma-parent: List of phandles and their optional arguments according to the
+	#dma-parent-cells from the provider. Expresses the routing of DMA if it
+	doesn't go through the parent node, but some other node in the device tree.
 
 Example:
 soc {
-- 
git-series 0.9.1
