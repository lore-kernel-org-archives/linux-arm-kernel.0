From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri,  1 Aug 2014 12:20:10 +0200
Subject: [PATCH] dmaengine: Remove the context argument to the prep_dma_cyclic
 operation
Message-ID: <1406888410-14504-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The argument is always set to NULL and never used. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/dma/amba-pl08x.c      | 2 +-
 drivers/dma/at_hdmac.c        | 3 +--
 drivers/dma/bcm2835-dma.c     | 2 +-
 drivers/dma/dma-jz4740.c      | 2 +-
 drivers/dma/edma.c            | 2 +-
 drivers/dma/ep93xx_dma.c      | 4 +---
 drivers/dma/fsl-edma.c        | 2 +-
 drivers/dma/imx-dma.c         | 2 +-
 drivers/dma/imx-sdma.c        | 2 +-
 drivers/dma/mmp_pdma.c        | 2 +-
 drivers/dma/mmp_tdma.c        | 2 +-
 drivers/dma/mxs-dma.c         | 2 +-
 drivers/dma/omap-dma.c        | 3 +--
 drivers/dma/pl330.c           | 2 +-
 drivers/dma/s3c24xx-dma.c     | 3 +--
 drivers/dma/sa11x0-dma.c      | 2 +-
 drivers/dma/sh/shdma-base.c   | 2 +-
 drivers/dma/sirf-dma.c        | 2 +-
 drivers/dma/ste_dma40.c       | 3 +--
 drivers/dma/tegra20-apb-dma.c | 2 +-
 include/linux/dmaengine.h     | 4 ++--
 21 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 8114731..48ec81f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1653,7 +1653,7 @@ static struct dma_async_tx_descriptor *pl08x_prep_slave_sg(
 static struct dma_async_tx_descriptor *pl08x_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct pl08x_dma_chan *plchan = to_pl08x_chan(chan);
 	struct pl08x_driver_data *pl08x = plchan->host;
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index c13a3bb..d20ab1b 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -893,12 +893,11 @@ atc_dma_cyclic_fill_desc(struct dma_chan *chan, struct at_desc *desc,
  * @period_len: number of bytes for each period
  * @direction: transfer direction, to or from device
  * @flags: tx descriptor status flags
- * @context: transfer context (ignored)
  */
 static struct dma_async_tx_descriptor *
 atc_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct at_dma_chan	*atchan = to_at_dma_chan(chan);
 	struct at_dma_slave	*atslave = chan->private;
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index a036021..6800797 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -335,7 +335,7 @@ static void bcm2835_dma_issue_pending(struct dma_chan *chan)
 static struct dma_async_tx_descriptor *bcm2835_dma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long flags, void *context)
+	unsigned long flags)
 {
 	struct bcm2835_chan *c = to_bcm2835_dma_chan(chan);
 	enum dma_slave_buswidth dev_width;
diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
index bfbce6b..6a9d89c 100644
--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -433,7 +433,7 @@ static struct dma_async_tx_descriptor *jz4740_dma_prep_slave_sg(
 static struct dma_async_tx_descriptor *jz4740_dma_prep_dma_cyclic(
 	struct dma_chan *c, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long flags, void *context)
+	unsigned long flags)
 {
 	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
 	struct jz4740_dma_desc *desc;
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 3754ffa..0bcfcd1 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -597,7 +597,7 @@ struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long tx_flags, void *context)
+	unsigned long tx_flags)
 {
 	struct edma_chan *echan = to_edma_chan(chan);
 	struct device *dev = chan->device->dev;
diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index cb4bf68..7650470 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1092,7 +1092,6 @@ fail:
  * @period_len: length of a single period
  * @dir: direction of the operation
  * @flags: tx descriptor status flags
- * @context: operation context (ignored)
  *
  * Prepares a descriptor for cyclic DMA operation. This means that once the
  * descriptor is submitted, we will be submitting in a @period_len sized
@@ -1105,8 +1104,7 @@ fail:
 static struct dma_async_tx_descriptor *
 ep93xx_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 			   size_t buf_len, size_t period_len,
-			   enum dma_transfer_direction dir, unsigned long flags,
-			   void *context)
+			   enum dma_transfer_direction dir, unsigned long flags)
 {
 	struct ep93xx_dma_chan *edmac = to_ep93xx_dma_chan(chan);
 	struct ep93xx_dma_desc *desc, *first;
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index 24ab3d3..3c5711d 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -517,7 +517,7 @@ err:
 static struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
 	struct fsl_edma_desc *fsl_desc;
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index 286660a..9d2c9e7 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -866,7 +866,7 @@ static struct dma_async_tx_descriptor *imxdma_prep_slave_sg(
 static struct dma_async_tx_descriptor *imxdma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct imxdma_channel *imxdmac = to_imxdma_chan(chan);
 	struct imxdma_engine *imxdma = imxdmac->imxdma;
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index de584e6..f7626e3 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1125,7 +1125,7 @@ err_out:
 static struct dma_async_tx_descriptor *sdma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
 	struct sdma_engine *sdma = sdmac->sdma;
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index a7b186d..a1a4db5 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -601,7 +601,7 @@ static struct dma_async_tx_descriptor *
 mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
 			 dma_addr_t buf_addr, size_t len, size_t period_len,
 			 enum dma_transfer_direction direction,
-			 unsigned long flags, void *context)
+			 unsigned long flags)
 {
 	struct mmp_pdma_chan *chan;
 	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 724f7f4..6ad30e2 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -389,7 +389,7 @@ struct mmp_tdma_desc *mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
 static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
 	struct mmp_tdma_desc *desc;
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index dc1dba7..5ea6120 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -589,7 +589,7 @@ err_out:
 static struct dma_async_tx_descriptor *mxs_dma_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(chan);
 	struct mxs_dma_engine *mxs_dma = mxs_chan->mxs_dma;
diff --git a/drivers/dma/omap-dma.c b/drivers/dma/omap-dma.c
index b19f04f..4cf7d9a 100644
--- a/drivers/dma/omap-dma.c
+++ b/drivers/dma/omap-dma.c
@@ -853,8 +853,7 @@ static struct dma_async_tx_descriptor *omap_dma_prep_slave_sg(
 
 static struct dma_async_tx_descriptor *omap_dma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
-	size_t period_len, enum dma_transfer_direction dir, unsigned long flags,
-	void *context)
+	size_t period_len, enum dma_transfer_direction dir, unsigned long flags)
 {
 	struct omap_dmadev *od = to_omap_dma_dev(chan->device);
 	struct omap_chan *c = to_omap_dma_chan(chan);
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index a55d754..d5149aa 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2362,7 +2362,7 @@ static inline int get_burst_len(struct dma_pl330_desc *desc, size_t len)
 static struct dma_async_tx_descriptor *pl330_prep_dma_cyclic(
 		struct dma_chan *chan, dma_addr_t dma_addr, size_t len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context)
+		unsigned long flags)
 {
 	struct dma_pl330_desc *desc = NULL, *first = NULL;
 	struct dma_pl330_chan *pch = to_pchan(chan);
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index 012520c..7416572 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -889,8 +889,7 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_memcpy(
 
 static struct dma_async_tx_descriptor *s3c24xx_dma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t addr, size_t size, size_t period,
-	enum dma_transfer_direction direction, unsigned long flags,
-	void *context)
+	enum dma_transfer_direction direction, unsigned long flags)
 {
 	struct s3c24xx_dma_chan *s3cchan = to_s3c24xx_dma_chan(chan);
 	struct s3c24xx_dma_engine *s3cdma = s3cchan->host;
diff --git a/drivers/dma/sa11x0-dma.c b/drivers/dma/sa11x0-dma.c
index 5ebdfbc..4b0ef04 100644
--- a/drivers/dma/sa11x0-dma.c
+++ b/drivers/dma/sa11x0-dma.c
@@ -612,7 +612,7 @@ static struct dma_async_tx_descriptor *sa11x0_dma_prep_slave_sg(
 
 static struct dma_async_tx_descriptor *sa11x0_dma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t addr, size_t size, size_t period,
-	enum dma_transfer_direction dir, unsigned long flags, void *context)
+	enum dma_transfer_direction dir, unsigned long flags)
 {
 	struct sa11x0_dma_chan *c = to_sa11x0_dma_chan(chan);
 	struct sa11x0_dma_desc *txd;
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index b35007e..6cb190c 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -662,7 +662,7 @@ static struct dma_async_tx_descriptor *shdma_prep_slave_sg(
 static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long flags, void *context)
+	unsigned long flags)
 {
 	struct shdma_chan *schan = to_shdma_chan(chan);
 	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 03f7820..aac03ab 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -580,7 +580,7 @@ err_dir:
 static struct dma_async_tx_descriptor *
 sirfsoc_dma_prep_cyclic(struct dma_chan *chan, dma_addr_t addr,
 	size_t buf_len, size_t period_len,
-	enum dma_transfer_direction direction, unsigned long flags, void *context)
+	enum dma_transfer_direction direction, unsigned long flags)
 {
 	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
 	struct sirfsoc_dma_desc *sdesc = NULL;
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index c798445..5fe5933 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2531,8 +2531,7 @@ d40_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 static struct dma_async_tx_descriptor *
 dma40_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr,
 		     size_t buf_len, size_t period_len,
-		     enum dma_transfer_direction direction, unsigned long flags,
-		     void *context)
+		     enum dma_transfer_direction direction, unsigned long flags)
 {
 	unsigned int periods = buf_len / period_len;
 	struct dma_async_tx_descriptor *txd;
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 03ad64e..16efa60 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -1055,7 +1055,7 @@ static struct dma_async_tx_descriptor *tegra_dma_prep_slave_sg(
 static struct dma_async_tx_descriptor *tegra_dma_prep_dma_cyclic(
 	struct dma_chan *dc, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
-	unsigned long flags, void *context)
+	unsigned long flags)
 {
 	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
 	struct tegra_dma_desc *dma_desc = NULL;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 4eb2f82..94ddccd 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -669,7 +669,7 @@ struct dma_device {
 	struct dma_async_tx_descriptor *(*device_prep_dma_cyclic)(
 		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 		size_t period_len, enum dma_transfer_direction direction,
-		unsigned long flags, void *context);
+		unsigned long flags);
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
 		unsigned long flags);
@@ -744,7 +744,7 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_cyclic(
 		unsigned long flags)
 {
 	return chan->device->device_prep_dma_cyclic(chan, buf_addr, buf_len,
-						period_len, dir, flags, NULL);
+						period_len, dir, flags);
 }
 
 static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
-- 
Regards,

Laurent Pinchart
