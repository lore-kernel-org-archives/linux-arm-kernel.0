From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 31 Aug 2017 01:36:07 +0200
Subject: [PATCH 1/3] dmaengine: sun6i: Correct DMA support on H3
In-Reply-To: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
References: <20170830233609.13855-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170830233609.13855-2-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H3 (and A64/H5) have a sligthly different DMA controller compared with
older SoC generations:

- it supports a buswidth of 8 bytes
- it supports burst length of 4 and 16 transfers
- the register offset for the burst lengths are different, it uses bits
  [6:7]/[22:23] instead of [7:8]/[23:24] for the src/dest lengths.

Set the src_addr_widths/dest_addr_widths fields in struct dma_device
according to the supported widths and use these for verification of the
slave configuration.

As struct dma_device has no detailed information for supported burst
lengths (only maxburst), the information is added to the config.

Separating verification of the config and conversion to register values
allows to keep both independent of the used controller.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 128 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 40 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a2358780ab2c..5f4eee4513e5 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -48,6 +48,9 @@
 #define SUN8I_DMA_GATE		0x20
 #define SUN8I_DMA_GATE_ENABLE	0x4
 
+#define SUNXI_H3_SECURITE_REG		0x20
+#define SUNXI_H3_DMA_GATE		0x28
+#define SUNXI_H3_DMA_GATE_ENABLE	0x4
 /*
  * Channels specific registers
  */
@@ -65,13 +68,15 @@
 #define DMA_CHAN_CFG_SRC_DRQ(x)		((x) & 0x1f)
 #define DMA_CHAN_CFG_SRC_IO_MODE	BIT(5)
 #define DMA_CHAN_CFG_SRC_LINEAR_MODE	(0 << 5)
-#define DMA_CHAN_CFG_SRC_BURST(x)	(((x) & 0x3) << 7)
+#define DMA_CHAN_CFG_SRC_BURST_A31(x)	(((x) & 0x3) << 7)
+#define DMA_CHAN_CFG_SRC_BURST_H3(x)	(((x) & 0x3) << 6)
 #define DMA_CHAN_CFG_SRC_WIDTH(x)	(((x) & 0x3) << 9)
 
 #define DMA_CHAN_CFG_DST_DRQ(x)		(DMA_CHAN_CFG_SRC_DRQ(x) << 16)
 #define DMA_CHAN_CFG_DST_IO_MODE	(DMA_CHAN_CFG_SRC_IO_MODE << 16)
 #define DMA_CHAN_CFG_DST_LINEAR_MODE	(DMA_CHAN_CFG_SRC_LINEAR_MODE << 16)
-#define DMA_CHAN_CFG_DST_BURST(x)	(DMA_CHAN_CFG_SRC_BURST(x) << 16)
+#define DMA_CHAN_CFG_DST_BURST_A31(x)	(DMA_CHAN_CFG_SRC_BURST_A31(x) << 16)
+#define DMA_CHAN_CFG_DST_BURST_H3(x)	(DMA_CHAN_CFG_SRC_BURST_H3(x) << 16)
 #define DMA_CHAN_CFG_DST_WIDTH(x)	(DMA_CHAN_CFG_SRC_WIDTH(x) << 16)
 
 #define DMA_CHAN_CUR_SRC	0x10
@@ -90,6 +95,16 @@
 #define NORMAL_WAIT	8
 #define DRQ_SDRAM	1
 
+/* Between SoC generations, there are some significant differences:
+ * - A23 added a clock gate register
+ * - the H3 burst length field has a different offset
+ */
+enum dmac_variant {
+	DMAC_VARIANT_A31,
+	DMAC_VARIANT_A23,
+	DMAC_VARIANT_H3,
+};
+
 /*
  * Hardware channels / ports representation
  *
@@ -101,6 +116,7 @@ struct sun6i_dma_config {
 	u32 nr_max_channels;
 	u32 nr_max_requests;
 	u32 nr_max_vchans;
+	enum dmac_variant dmac_variant;
 };
 
 /*
@@ -240,8 +256,12 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
+	case 16:
+		return 3;
 	default:
 		return -EINVAL;
 	}
@@ -249,11 +269,7 @@ static inline s8 convert_burst(u32 maxburst)
 
 static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 {
-	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
-	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
-		return -EINVAL;
-
-	return addr_width >> 1;
+	return ilog2(addr_width);
 }
 
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
@@ -499,45 +515,58 @@ static int set_config(struct sun6i_dma_dev *sdev,
 			enum dma_transfer_direction direction,
 			u32 *p_cfg)
 {
+	enum dma_slave_buswidth src_addr_width, dst_addr_width;
+	u32 src_maxburst, dst_maxburst, supported_burst_length;
 	s8 src_width, dst_width, src_burst, dst_burst;
 
+	src_addr_width = sconfig->src_addr_width;
+	dst_addr_width = sconfig->dst_addr_width;
+	src_maxburst = sconfig->src_maxburst;
+	dst_maxburst = sconfig->dst_maxburst;
+
+	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3)
+		supported_burst_length = BIT(1) | BIT(4) | BIT(8) | BIT(16);
+	else
+		supported_burst_length = BIT(1) | BIT(8);
+
 	switch (direction) {
 	case DMA_MEM_TO_DEV:
-		src_burst = convert_burst(sconfig->src_maxburst ?
-					sconfig->src_maxburst : 8);
-		src_width = convert_buswidth(sconfig->src_addr_width !=
-						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
-				sconfig->src_addr_width :
-				DMA_SLAVE_BUSWIDTH_4_BYTES);
-		dst_burst = convert_burst(sconfig->dst_maxburst);
-		dst_width = convert_buswidth(sconfig->dst_addr_width);
+		if (src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+			src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		src_maxburst = src_maxburst ? src_maxburst : 8;
 		break;
 	case DMA_DEV_TO_MEM:
-		src_burst = convert_burst(sconfig->src_maxburst);
-		src_width = convert_buswidth(sconfig->src_addr_width);
-		dst_burst = convert_burst(sconfig->dst_maxburst ?
-					sconfig->dst_maxburst : 8);
-		dst_width = convert_buswidth(sconfig->dst_addr_width !=
-						DMA_SLAVE_BUSWIDTH_UNDEFINED ?
-				sconfig->dst_addr_width :
-				DMA_SLAVE_BUSWIDTH_4_BYTES);
+		if (dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+			dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		dst_maxburst = dst_maxburst ? dst_maxburst : 8;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (src_burst < 0)
-		return src_burst;
-	if (src_width < 0)
-		return src_width;
-	if (dst_burst < 0)
-		return dst_burst;
-	if (dst_width < 0)
-		return dst_width;
-
-	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
-		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
-		DMA_CHAN_CFG_DST_BURST(dst_burst) |
+	if (!(BIT(src_addr_width) & sdev->slave.src_addr_widths))
+		return -EINVAL;
+	if (!(BIT(dst_addr_width) & sdev->slave.dst_addr_widths))
+		return -EINVAL;
+	if (!(BIT(src_maxburst) & supported_burst_length))
+		return -EINVAL;
+	if (!(BIT(dst_maxburst) & supported_burst_length))
+		return -EINVAL;
+
+	src_width = convert_buswidth(src_addr_width);
+	dst_width = convert_buswidth(dst_addr_width);
+	dst_burst = convert_burst(dst_maxburst);
+	src_burst = convert_burst(src_maxburst);
+
+	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3) {
+		*p_cfg = DMA_CHAN_CFG_SRC_BURST_H3(src_burst) |
+			 DMA_CHAN_CFG_DST_BURST_H3(dst_burst);
+	} else {
+		*p_cfg = DMA_CHAN_CFG_SRC_BURST_A31(src_burst) |
+			 DMA_CHAN_CFG_DST_BURST_A31(dst_burst);
+	}
+
+	*p_cfg |= DMA_CHAN_CFG_SRC_WIDTH(src_width) |
 		DMA_CHAN_CFG_DST_WIDTH(dst_width);
 
 	return 0;
@@ -582,11 +611,17 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 		DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
 		DMA_CHAN_CFG_DST_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_LINEAR_MODE |
-		DMA_CHAN_CFG_SRC_BURST(burst) |
 		DMA_CHAN_CFG_SRC_WIDTH(width) |
-		DMA_CHAN_CFG_DST_BURST(burst) |
 		DMA_CHAN_CFG_DST_WIDTH(width);
 
+	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3) {
+		v_lli->cfg |= DMA_CHAN_CFG_SRC_BURST_H3(burst) |
+			      DMA_CHAN_CFG_DST_BURST_H3(burst);
+	} else {
+		v_lli->cfg |= DMA_CHAN_CFG_SRC_BURST_A31(burst) |
+			      DMA_CHAN_CFG_DST_BURST_A31(burst);
+	}
+
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
 
 	sun6i_dma_dump_lli(vchan, v_lli);
@@ -998,6 +1033,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_channels = 16,
 	.nr_max_requests = 30,
 	.nr_max_vchans   = 53,
+	.dmac_variant    = DMAC_VARIANT_A31,
 };
 
 /*
@@ -1009,23 +1045,29 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 24,
 	.nr_max_vchans   = 37,
+	.dmac_variant    = DMAC_VARIANT_A23,
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_channels = 8,
 	.nr_max_requests = 28,
 	.nr_max_vchans   = 39,
+	.dmac_variant    = DMAC_VARIANT_A23,
 };
 
 /*
  * The H3 has 12 physical channels, a maximum DRQ port id of 27,
  * and a total of 34 usable source and destination endpoints.
+ * It also supports additional burst lengths and bus widths,
+ * and the burst length fields have different offsets.
  */
 
 static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_channels = 12,
 	.nr_max_requests = 27,
 	.nr_max_vchans   = 34,
+	.dmac_variant    = DMAC_VARIANT_H3,
+};
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
@@ -1110,6 +1152,10 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.dst_addr_widths		= BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	if (sdc->cfg->dmac_variant == DMAC_VARIANT_H3) {
+		sdc->slave.src_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		sdc->slave.dst_addr_widths |= BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	}
 	sdc->slave.directions			= BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
@@ -1177,10 +1223,12 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	/*
 	 * sun8i variant requires us to toggle a dma gating register,
 	 * as seen in Allwinner's SDK. This register is not documented
-	 * in the A23 user manual.
+	 * in the A23 user manual, but appears in e.g. the H83T manual.
+	 * For the H3, H5 and A64, the register has a different location
 	 */
-	if (of_device_is_compatible(pdev->dev.of_node,
-				    "allwinner,sun8i-a23-dma"))
+	if (sdc->cfg->dmac_variant == DMAC_VARIANT_H3)
+		writel(SUNXI_H3_DMA_GATE_ENABLE, sdc->base + SUNXI_H3_DMA_GATE);
+	else if (sdc->cfg->dmac_variant == DMAC_VARIANT_A23)
 		writel(SUN8I_DMA_GATE_ENABLE, sdc->base + SUN8I_DMA_GATE);
 
 	return 0;
-- 
2.14.1
