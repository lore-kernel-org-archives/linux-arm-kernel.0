From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 28 Sep 2017 03:49:19 +0200
Subject: [PATCH v4 02/11] dmaengine: sun6i: Correct burst length field offsets
 for H3
In-Reply-To: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
Message-ID: <8bff4e60-f464-4b96-874b-f8a610b5a2ef@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the H3, the burst lengths field offsets in the channel configuration
register differs from earlier SoC generations.

Using the A31 register macros actually configured the H3 controller
do to bursts of length 1 always, which although working leads to higher
bus utilisation.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

---

Changes in v4:
- Pass reference to config instead of config itself
- Fix config initialization

Changes in v3: None
Changes in v2:
- Use controller specific callback for burst length setting

 drivers/dma/sun6i-dma.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 6f9d7c4ac7c0..48b3701c9aa1 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -68,13 +68,15 @@
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
@@ -118,6 +120,7 @@ struct sun6i_dma_config {
 	 * BSP kernel source code.
 	 */
 	void (*clock_autogate_enable)(struct sun6i_dma_dev *);
+	void (*set_burst_length)(u32 *p_cfg, s8 src_burst, s8 dst_burst);
 };
 
 /*
@@ -283,6 +286,18 @@ static void sun6i_enable_clock_autogate_h3(struct sun6i_dma_dev *sdev)
 	writel(SUNXI_H3_DMA_GATE_ENABLE, sdev->base + SUNXI_H3_DMA_GATE);
 }
 
+static void sun6i_set_burst_length_a31(u32 *p_cfg, s8 src_burst, s8 dst_burst)
+{
+	*p_cfg |= DMA_CHAN_CFG_SRC_BURST_A31(src_burst) |
+		  DMA_CHAN_CFG_DST_BURST_A31(dst_burst);
+}
+
+static void sun6i_set_burst_length_h3(u32 *p_cfg, s8 src_burst, s8 dst_burst)
+{
+	*p_cfg |= DMA_CHAN_CFG_SRC_BURST_H3(src_burst) |
+		  DMA_CHAN_CFG_DST_BURST_H3(dst_burst);
+}
+
 static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 {
 	struct sun6i_desc *txd = pchan->desc;
@@ -562,11 +577,11 @@ static int set_config(struct sun6i_dma_dev *sdev,
 	if (dst_width < 0)
 		return dst_width;
 
-	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
-		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
-		DMA_CHAN_CFG_DST_BURST(dst_burst) |
+	*p_cfg = DMA_CHAN_CFG_SRC_WIDTH(src_width) |
 		DMA_CHAN_CFG_DST_WIDTH(dst_width);
 
+	sdev->cfg->set_burst_length(p_cfg, src_burst, dst_burst);
+
 	return 0;
 }
 
@@ -609,11 +624,11 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
 		DMA_CHAN_CFG_DST_DRQ(DRQ_SDRAM) |
 		DMA_CHAN_CFG_DST_LINEAR_MODE |
 		DMA_CHAN_CFG_SRC_LINEAR_MODE |
-		DMA_CHAN_CFG_SRC_BURST(burst) |
 		DMA_CHAN_CFG_SRC_WIDTH(width) |
-		DMA_CHAN_CFG_DST_BURST(burst) |
 		DMA_CHAN_CFG_DST_WIDTH(width);
 
+	sdev->cfg->set_burst_length(&v_lli->cfg, burst, burst);
+
 	sun6i_dma_lli_add(NULL, v_lli, p_lli, txd);
 
 	sun6i_dma_dump_lli(vchan, v_lli);
@@ -1025,6 +1040,7 @@ static struct sun6i_dma_config sun6i_a31_dma_cfg = {
 	.nr_max_channels = 16,
 	.nr_max_requests = 30,
 	.nr_max_vchans   = 53,
+	.set_burst_length = sun6i_set_burst_length_a31,
 };
 
 /*
@@ -1037,6 +1053,7 @@ static struct sun6i_dma_config sun8i_a23_dma_cfg = {
 	.nr_max_requests = 24,
 	.nr_max_vchans   = 37,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
+	.set_burst_length = sun6i_set_burst_length_a31,
 };
 
 static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
@@ -1044,6 +1061,7 @@ static struct sun6i_dma_config sun8i_a83t_dma_cfg = {
 	.nr_max_requests = 28,
 	.nr_max_vchans   = 39,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
+	.set_burst_length = sun6i_set_burst_length_a31,
 };
 
 /*
@@ -1056,6 +1074,7 @@ static struct sun6i_dma_config sun8i_h3_dma_cfg = {
 	.nr_max_requests = 27,
 	.nr_max_vchans   = 34,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
+	.set_burst_length = sun6i_set_burst_length_h3,
 };
 
 /*
@@ -1068,6 +1087,7 @@ static struct sun6i_dma_config sun8i_v3s_dma_cfg = {
 	.nr_max_requests = 23,
 	.nr_max_vchans   = 24,
 	.clock_autogate_enable = sun6i_enable_clock_autogate_a23,
+	.set_burst_length = sun6i_set_burst_length_a31,
 };
 
 static const struct of_device_id sun6i_dma_match[] = {
-- 
2.14.1
