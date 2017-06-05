From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon,  5 Jun 2017 20:33:48 +0800
Subject: [PATCH 2/2] dmaengine: sun6i: support V3s SoC variant
In-Reply-To: <20170605123348.26137-1-icenowy@aosc.io>
References: <20170605123348.26137-1-icenowy@aosc.io>
Message-ID: <20170605123348.26137-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Allwinner V3s has a DMA engine similar to the ones from A31, but with
fewer channels and DRQs.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since the original codec patchset v3:
- Added Rob's ACK.

 Documentation/devicetree/bindings/dma/sun6i-dma.txt |  1 +
 drivers/dma/sun6i-dma.c                             | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/sun6i-dma.txt b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
index 6b267045f522..98fbe1a5c6dd 100644
--- a/Documentation/devicetree/bindings/dma/sun6i-dma.txt
+++ b/Documentation/devicetree/bindings/dma/sun6i-dma.txt
@@ -9,6 +9,7 @@ Required properties:
 		  "allwinner,sun8i-a23-dma"
 		  "allwinner,sun8i-a83t-dma"
 		  "allwinner,sun8i-h3-dma"
+		  "allwinner,sun8i-v3s-dma"
 - reg:		Should contain the registers base address and length
 - interrupts:	Should contain a reference to the interrupt used by this device
 - clocks:	Should contain a reference to the parent AHB clock
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 252b59c1d1d5..bcd496edc70f 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1040,11 +1040,24 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 };
 
+/*
+ * The V3s have only 8 physical channels, a maximum DRQ port id of 23,
+ * and a total of 24 usable source and destination endpoints.
+ */
+
+static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
+	.nr_max_channels = 8,
+	.nr_max_requests = 23,
+	.nr_max_vchans   = 24,
+	.gate_needed	 = true,
+};
+
 static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
+	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
-- 
2.12.2
