From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Sun, 17 Sep 2017 05:19:49 +0200
Subject: [PATCH v2 03/10] dmaengine: sun6i: Restructure code to allow
 extension for new SoCs
In-Reply-To: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170917031956.28010-4-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code mixes three distinct operations when transforming
the slave config to register settings:

  1. special handling of DMA_SLAVE_BUSWIDTH_UNDEFINED, maxburst == 0
  2. range checking
  3. conversion of raw to register values

As the range checks depend on the specific SoC, move these out of the
conversion to distinct operations.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 66 ++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index a6fc066a0ac6..663f4b0b450e 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -118,6 +118,8 @@ struct sun6i_dma_config {
 	 */
 	void (*clock_autogate_enable)();
 	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
+	u32 src_burst_lengths;
+	u32 dst_burst_lengths;
 };
 
 /*
@@ -266,10 +268,6 @@ static inline s8 convert_burst(u32 maxburst)
 
 static inline s8 convert_buswidth(enum dma_slave_buswidth addr_width)
 {
-	if ((addr_width < DMA_SLAVE_BUSWIDTH_1_BYTE) ||
-	    (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES))
-		return -EINVAL;
-
 	return addr_width >> 1;
 }
 
@@ -542,41 +540,43 @@ static int set_config(struct sun6i_dma_dev *sdev,
 			enum dma_transfer_direction direction,
 			u32 *p_cfg)
 {
+	enum dma_slave_buswidth src_addr_width, dst_addr_width;
+	u32 src_maxburst, dst_maxburst;
 	s8 src_width, dst_width, src_burst, dst_burst;
 
+	src_addr_width = sconfig->src_addr_width;
+	dst_addr_width = sconfig->dst_addr_width;
+	src_maxburst = sconfig->src_maxburst;
+	dst_maxburst = sconfig->dst_maxburst;
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
+	if (!(BIT(src_addr_width) & sdev->slave.src_addr_widths))
+		return -EINVAL;
+	if (!(BIT(dst_addr_width) & sdev->slave.dst_addr_widths))
+		return -EINVAL;
+	if (!(BIT(src_maxburst) & sdev->cfg->src_burst_lengths))
+		return -EINVAL;
+	if (!(BIT(dst_maxburst) & sdev->cfg->dst_burst_lengths))
+		return -EINVAL;
+
+	src_width = convert_buswidth(src_addr_width);
+	dst_width = convert_buswidth(dst_addr_width);
+	dst_burst = convert_burst(dst_maxburst);
+	src_burst = convert_burst(src_maxburst);
 
 	*p_cfg = DMA_CHAN_CFG_SRC_WIDTH(src_width) |
 		DMA_CHAN_CFG_DST_WIDTH(dst_width);
@@ -1043,6 +1043,8 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_vchans   = 53,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_noop;
 	.set_burst_length = sun6i_set_burst_length_a31;
+	.src_burst_lengths = BIT(1) | BIT(8);
+	.dst_burst_lengths = BIT(1) | BIT(8);
 };
 
 /*
@@ -1056,6 +1058,8 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_vchans   = 37,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
 	.set_burst_length = sun6i_set_burst_length_a31;
+	.src_burst_lengths = BIT(1) | BIT(8);
+	.dst_burst_lengths = BIT(1) | BIT(8);
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
@@ -1064,6 +1068,8 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_vchans   = 39,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
 	.set_burst_length = sun6i_set_burst_length_a31;
+	.src_burst_lengths = BIT(1) | BIT(8);
+	.dst_burst_lengths = BIT(1) | BIT(8);
 };
 
 /*
@@ -1077,6 +1083,8 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_vchans   = 34,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3;
 	.set_burst_length = sun6i_set_burst_length_h3;
+	.src_burst_lengths = BIT(1) | BIT(8);
+	.dst_burst_lengths = BIT(1) | BIT(8);
 };
 
 /*
@@ -1090,6 +1098,8 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.nr_max_vchans   = 24,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23;
 	.set_burst_length = sun6i_set_burst_length_a31;
+	.src_burst_lengths = BIT(1) | BIT(8);
+	.dst_burst_lengths = BIT(1) | BIT(8);
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
-- 
2.14.1
