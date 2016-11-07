From: hao5781286@gmail.com (Hao Zhang)
Date: Tue, 8 Nov 2016 02:28:40 +0800
Subject: [PATCH v3 3/3] ARM: dmaengine: sun6i: share the dma driver with sun50i
Message-ID: <20161107182840.GA3711@arx12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the datasheet, the dma of A64 support 8/16/32/64 bits
so, we can add the condition of device compatible in convert_buswidth
function and other place to determine the device whether is for A64,
and then accept the 8 bytes bus width to it.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/dma/sun6i-dma.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 8346199..8a95a1a 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -247,13 +247,17 @@ static inline s8 convert_burst(u32 maxburst)
 	}
 }
 
-static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
+static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width,
+				  struct sun6i_dma_dev *sdev)
 {
-	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
-	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
+	if (((addr_width >= DMA_SLAVE_BUSWIDTH_1_BYTE) &&
+	     (addr_width <= DMA_SLAVE_BUSWIDTH_4_BYTES)) ||
+	    ((addr_width == DMA_SLAVE_BUSWIDTH_8_BYTES) &&
+	     (of_device_is_compatible(sdev->slave.dev->of_node,
+				      "allwinner,sun50i-a64-dma"))))
+		return addr_width >> 1;
+	else
 		return -EINVAL;
-
-	return addr_width >> 1;
 }
 
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
@@ -508,19 +512,19 @@ static int set_config(struct sun6i_dma_dev *sdev,
 		src_width = convert_buswidth(sconfig->src_addr_width !=
 						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
 				sconfig->src_addr_width :
-				DMA_SLAVE_BUSWIDTH_4_BYTES);
+				DMA_SLAVE_BUSWIDTH_4_BYTES, sdev);
 		dst_burst = convert_burst(sconfig->dst_maxburst);
-		dst_width = convert_buswidth(sconfig->dst_addr_width);
+		dst_width = convert_buswidth(sconfig->dst_addr_width, sdev);
 		break;
 	case DMA_DEV_TO_MEM:
 		src_burst = convert_burst(sconfig->src_maxburst);
-		src_width = convert_buswidth(sconfig->src_addr_width);
+		src_width = convert_buswidth(sconfig->src_addr_width, sdev);
 		dst_burst = convert_burst(sconfig->dst_maxburst ?
 					sconfig->dst_maxburst : 8);
 		dst_width = convert_buswidth(sconfig->dst_addr_width !=
 						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
 				sconfig->dst_addr_width :
-				DMA_SLAVE_BUSWIDTH_4_BYTES);
+				DMA_SLAVE_BUSWIDTH_4_BYTES, sdev);
 		break;
 	default:
 		return -EINVAL;
@@ -577,7 +581,7 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 	v_lli->para = NORMAL_WAIT;
 
 	burst = convert_burst(8);
-	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	width = convert_buswidth(DMA_SLAVE_BUSWIDTH_4_BYTES, sdev);
 	v_lli->cfg |= DMA_CHAN_CFG_SRC_DRQ(DRQ_SDRAM) |
 		DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
 		DMA_CHAN_CFG_DST_LINEAR_MODE |
@@ -1028,11 +1032,23 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
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
@@ -1112,6 +1128,13 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
+
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun50i-a64-dma")) {
+		sdc->slave.src_addr_widths	|= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		sdc->slave.dst_addr_widths	|= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	}
+
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
 	sdc->slave.dev = &pdev->dev;
 
-- 
2.7.4
