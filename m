From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Mon, 4 Sep 2017 00:40:56 +0200
Subject: [PATCH 05/10] dmaengine: sun6i: Move number of pchans/vchans/request
 to device struct
In-Reply-To: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
References: <20170903224100.17893-1-stefan.bruens@rwth-aachen.de>
Message-ID: <20170903224100.17893-6-stefan.bruens@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Preparatory patch: If the same compatible is used for different SoCs which
have a common register layout, but different number of channels, the
channel count can no longer be stored in the config. Store it in the
device structure instead.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
---
 drivers/dma/sun6i-dma.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 335a8ec88b0b..c69dadb853d2 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -187,6 +187,9 @@ struct sun6i_dma_dev {
 	const struct sun6i_dma_config *cfg;
 	u32			src_burst_lengths;
 	u32			dst_burst_lengths;
+	u32			num_pchans;
+	u32			num_vchans;
+	u32			max_request;
 };
 
 static struct device *chan2dev(struct dma_chan *chan)
@@ -411,7 +414,6 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 static void sun6i_dma_tasklet(unsigned long data)
 {
 	struct sun6i_dma_dev *sdev = (struct sun6i_dma_dev *)data;
-	const struct sun6i_dma_config *cfg = sdev->cfg;
 	struct sun6i_vchan *vchan;
 	struct sun6i_pchan *pchan;
 	unsigned int pchan_alloc = 0;
@@ -439,7 +441,7 @@ static void sun6i_dma_tasklet(unsigned long data)
 	}
 
 	spin_lock_irq(&sdev->lock);
-	for (pchan_idx = 0; pchan_idx < cfg->nr_max_channels; pchan_idx++) {
+	for (pchan_idx = 0; pchan_idx < sdev->num_pchans; pchan_idx++) {
 		pchan = &sdev->pchans[pchan_idx];
 
 		if (pchan->vchan || list_empty(&sdev->pending))
@@ -460,7 +462,7 @@ static void sun6i_dma_tasklet(unsigned long data)
 	}
 	spin_unlock_irq(&sdev->lock);
 
-	for (pchan_idx = 0; pchan_idx < cfg->nr_max_channels; pchan_idx++) {
+	for (pchan_idx = 0; pchan_idx < sdev->num_pchans; pchan_idx++) {
 		if (!(pchan_alloc & BIT(pchan_idx)))
 			continue;
 
@@ -482,7 +484,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	int i, j, ret = IRQ_NONE;
 	u32 status;
 
-	for (i = 0; i < sdev->cfg->nr_max_channels / DMA_IRQ_CHAN_NR; i++) {
+	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
 		status = readl(sdev->base + DMA_IRQ_STAT(i));
 		if (!status)
 			continue;
@@ -974,7 +976,7 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
 	struct dma_chan *chan;
 	u8 port = dma_spec->args[0];
 
-	if (port > sdev->cfg->nr_max_requests)
+	if (port > sdev->max_request)
 		return NULL;
 
 	chan = dma_get_any_slave_channel(&sdev->slave);
@@ -1007,7 +1009,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 {
 	int i;
 
-	for (i = 0; i < sdev->cfg->nr_max_vchans; i++) {
+	for (i = 0; i < sdev->num_vchans; i++) {
 		struct sun6i_vchan *vchan = &sdev->vchans[i];
 
 		list_del(&vchan->vc.chan.device_node);
@@ -1167,26 +1169,30 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 	sdc->slave.residue_granularity		= DMA_RESIDUE_GRANULARITY_BURST;
 	sdc->slave.dev = &pdev->dev;
 
-	sdc->pchans = devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels,
+	sdc->num_pchans = sdc->cfg->nr_max_channels;
+	sdc->num_vchans = sdc->cfg->nr_max_vchans;
+	sdc->max_request = sdc->cfg->nr_max_requests;
+
+	sdc->pchans = devm_kcalloc(&pdev->dev, sdc->num_pchans,
 				   sizeof(struct sun6i_pchan), GFP_KERNEL);
 	if (!sdc->pchans)
 		return -ENOMEM;
 
-	sdc->vchans = devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_vchans,
+	sdc->vchans = devm_kcalloc(&pdev->dev, sdc->num_vchans,
 				   sizeof(struct sun6i_vchan), GFP_KERNEL);
 	if (!sdc->vchans)
 		return -ENOMEM;
 
 	tasklet_init(&sdc->task, sun6i_dma_tasklet, (unsigned long)sdc);
 
-	for (i = 0; i < sdc->cfg->nr_max_channels; i++) {
+	for (i = 0; i < sdc->num_pchans; i++) {
 		struct sun6i_pchan *pchan = &sdc->pchans[i];
 
 		pchan->idx = i;
 		pchan->base = sdc->base + 0x100 + i * 0x40;
 	}
 
-	for (i = 0; i < sdc->cfg->nr_max_vchans; i++) {
+	for (i = 0; i < sdc->num_vchans; i++) {
 		struct sun6i_vchan *vchan = &sdc->vchans[i];
 
 		INIT_LIST_HEAD(&vchan->node);
-- 
2.14.1
