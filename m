From: hao5781286@gmail.com (Hao Zhang)
Date: Sat, 5 Nov 2016 16:05:48 +0800
Subject: [PATCH v2 1/1] ARM: dmaengine: sun6i: share the dma driver with sun50i
Message-ID: <20161105080548.GA32546@arx12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add soc a64 dma support.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/dma/sun6i-dma.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 8346199..00fcfc7 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1028,11 +1028,23 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 };
 
+/*
+ * The A64 has 8 physical channels, a maximum DRQ port id of 27,
+ * and a total of 38 usable source and destination endpoints.
+ */
+
+static struct sun6i_dma_config sun50i_a64_dma_cfg = {
+	.nr_max_channels = 8,
+	.nr_max_requests = 27,
+	.nr_max_vchans   = 38,
+};
+
 static const struct of_device_id sun6i_dma_match[] = {
 	{ .compatible = "allwinner,sun6i-a31-dma", .data = &sun6i_a31_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a23-dma", .data = &sun8i_a23_dma_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-dma", .data = &sun8i_a83t_dma_cfg },
 	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
+	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun6i_dma_match);
@@ -1110,6 +1122,13 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun50i-a64-dma")) {
+		sdc->slave.src_addr_widths	|= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		sdc->slave.dst_addr_widths	|= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	}
+
 	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
-- 
2.7.4
