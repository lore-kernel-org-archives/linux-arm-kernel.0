From: stefan.bruens@rwth-aachen.de (=?UTF-8?q?Stefan=20Br=C3=BCns?=)
Date: Thu, 28 Sep 2017 03:49:22 +0200
Subject: [PATCH v4 05/11] dmaengine: sun6i: Move number of
 pchans/vchans/request to device struct
In-Reply-To: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
References: <20170928014928.2272-1-stefan.bruens@rwth-aachen.de>
Message-ID: <86c0dfa0-9284-4501-b845-a67a766b51cc@rwthex-w2-a.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Preparatory patch: If the same compatible is used for different SoCs which
have a common register layout, but different number of channels, the
channel count can no longer be stored in the config. Store it in the
device structure instead.

Signed-off-by: Stefan Br?ns <stefan.bruens@rwth-aachen.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 drivers/dma/sun6i-dma.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index eb45ab39eddd..7fce976a13d8 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -188,6 +188,9 @@ struct sun6i_dma_dev {
 	struct sun6i_pchan	*pchans;
 	struct sun6i_vchan	*vchans;
 	const struct sun6i_dma_config *cfg;
+	u32			num_pchans;
+	u32			num_vchans;
+	u32			max_request;
 };
 
 static struct device *chan2dev(struct dma_chan *chan)
@@ -434,7 +437,6 @@ static int sun6i_dma_start_desc(struct sun6i_vchan *vchan)
 static void sun6i_dma_tasklet(unsigned long data)
 {
 	struct sun6i_dma_dev *sdev = (struct sun6i_dma_dev *)data;
-	const struct sun6i_dma_config *cfg = sdev->cfg;
 	struct sun6i_vchan *vchan;
 	struct sun6i_pchan *pchan;
 	unsigned int pchan_alloc = 0;
@@ -462,7 +464,7 @@ static void sun6i_dma_tasklet(unsigned long data)
 	}
 
 	spin_lock_irq(&sdev->lock);
-	for (pchan_idx = 0; pchan_idx < cfg->nr_max_channels; pchan_idx++) {
+	for (pchan_idx = 0; pchan_idx < sdev->num_pchans; pchan_idx++) {
 		pchan = &sdev->pchans[pchan_idx];
 
 		if (pchan->vchan || list_empty(&sdev->pending))
@@ -483,7 +485,7 @@ static void sun6i_dma_tasklet(unsigned long data)
 	}
 	spin_unlock_irq(&sdev->lock);
 
-	for (pchan_idx = 0; pchan_idx < cfg->nr_max_channels; pchan_idx++) {
+	for (pchan_idx = 0; pchan_idx < sdev->num_pchans; pchan_idx++) {
 		if (!(pchan_alloc & BIT(pchan_idx)))
 			continue;
 
@@ -505,7 +507,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
 	int i, j, ret = IRQ_NONE;
 	u32 status;
 
-	for (i = 0; i < sdev->cfg->nr_max_channels / DMA_IRQ_CHAN_NR; i++) {
+	for (i = 0; i < sdev->num_pchans / DMA_IRQ_CHAN_NR; i++) {
 		status = readl(sdev->base + DMA_IRQ_STAT(i));
 		if (!status)
 			continue;
@@ -985,7 +987,7 @@ static struct dma_chan *sun6i_dma_of_xlate(struct of_phandle_args *dma_spec,
 	struct dma_chan *chan;
 	u8 port = dma_spec->args[0];
 
-	if (port > sdev->cfg->nr_max_requests)
+	if (port > sdev->max_request)
 		return NULL;
 
 	chan = dma_get_any_slave_channel(&sdev->slave);
@@ -1018,7 +1020,7 @@ static inline void sun6i_dma_free(struct sun6i_dma_dev *sdev)
 {
 	int i;
 
-	for (i = 0; i < sdev->cfg->nr_max_vchans; i++) {
+	for (i = 0; i < sdev->num_vchans; i++) {
 		struct sun6i_vchan *vchan = &sdev->vchans[i];
 
 		list_del(&vchan->vc.chan.device_node);
@@ -1224,26 +1226,30 @@ static int sun6i_dma_probe(struct platform_device *pdev)
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
