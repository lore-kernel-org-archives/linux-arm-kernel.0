From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 25 Sep 2017 02:02:40 +0200
Subject: [PATCH v3 06/10] arm64: allwinner: a64: Add devicetree binding for
 DMA controller
In-Reply-To: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
References: <20170925000244.11679-1-stefan.bruens@rwth-aachen.de>
Message-ID: <a8bc9cc4-ad2a-4206-9f50-f5918601adbe@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A64 is register compatible with the H3, but has a different number
of dma channels and request ports.

Attach additional properties to the node to allow future reuse of the
compatible for controllers with different number of channels/requests.

If dma-requests is not specified, the register layout defined maximum
of 32 is used.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
Acked-by: Rob Herring <robh@kernel.org>

---

Changes in v3:
- Drop leading 0 from unit name in DT example

Changes in v2: None

 .../devicetree/bindings/dma/sun6i-dma.txt          | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 98fbe1a5c6dd..b2df4f0f1488 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -18,7 +18,7 @@ Required properties:
 - #dma-cells :	Should be 1, a single cell holding a line request number
 
 Example:
-	dma: dma-controller at 01c02000 {
+	dma: dma-controller at 1c02000 {
 		compatible = "allwinner,sun6i-a31-dma";
 		reg = <0x01c02000 0x1000>;
 		interrupts = <0 50 4>;
@@ -27,6 +27,32 @@ Example:
 		#dma-cells = <1>;
 	};
 
+------------------------------------------------------------------------------
+For A64 DMA controller:
+
+Required properties:
+- compatible:	"allwinner,sun50i-a64-dma"
+- dma-channels: Number of DMA channels supported by the controller.
+		Refer to Documentation/devicetree/bindings/dma/dma.txt
+- all properties above, i.e. reg, interrupts, clocks, resets and #dma-cells
+
+Optional properties:
+- dma-requests: Number of DMA request signals supported by the controller.
+		Refer to Documentation/devicetree/bindings/dma/dma.txt
+
+Example:
+	dma: dma-controller at 1c02000 {
+		compatible = "allwinner,sun50i-a64-dma";
+		reg = <0x01c02000 0x1000>;
+		interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&ccu CLK_BUS_DMA>;
+		dma-channels = <8>;
+		dma-requests = <27>;
+		resets = <&ccu RST_BUS_DMA>;
+		#dma-cells = <1>;
+	};
+------------------------------------------------------------------------------
+
 Clients:
 
 DMA clients connected to the A31 DMA controller must use the format
-- 
2.14.1
