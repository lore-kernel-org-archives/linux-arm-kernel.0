From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 4 Sep 2017 00:40:53 +0200
Subject: [PATCH 02/10] dmaengine: sun6i: Correct burst length field offsets
 for H3
In-Reply-To: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170903224100.17893-3-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the H3, the burst lengths field offsets in the channel configuration
register differs from earlier SoC generations.

Using the A31 register macros actually configured the H3 controller
do to bursts of length 1 always, which although working leads to higher
bus utilisation.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 1d9b3be30d22..f1a139f0102f 100644
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
@@ -554,11 +556,17 @@ static int set_config(struct sun6i_dma_dev *sdev,
 	if (dst_width < 0)
 		return dst_width;
 
-	*p_cfg = DMA_CHAN_CFG_SRC_BURST(src_burst) |
-		DMA_CHAN_CFG_SRC_WIDTH(src_width) |
-		DMA_CHAN_CFG_DST_BURST(dst_burst) |
+	*p_cfg = DMA_CHAN_CFG_SRC_WIDTH(src_width) |
 		DMA_CHAN_CFG_DST_WIDTH(dst_width);
 
+	if (sdev->cfg->dmac_variant == DMAC_VARIANT_H3) {
+		*p_cfg |= DMA_CHAN_CFG_SRC_BURST_H3(src_burst) |
+			  DMA_CHAN_CFG_DST_BURST_H3(dst_burst);
+	} else {
+		*p_cfg |= DMA_CHAN_CFG_SRC_BURST_A31(src_burst) |
+			  DMA_CHAN_CFG_DST_BURST_A31(dst_burst);
+	}
+
 	return 0;
 }
 
@@ -601,11 +609,17 @@ static struct dma_async_tx_descriptor *sun6i_dma_prep_dma_memcpy(
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
-- 
2.14.1
