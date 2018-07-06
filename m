From: guodong.xu@linaro.org (Guodong Xu)
Date: Fri,  6 Jul 2018 11:55:19 +0800
Subject: [PATCH v2 2/4] k3dma: add support to reserved minimum channels
In-Reply-To: <20180706035521.13736-1-guodong.xu@linaro.org>
References: <20180706035521.13736-1-guodong.xu@linaro.org>
Message-ID: <20180706035521.13736-3-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Li Yu <liyu65@hisilicon.com>

On k3 series of SoC, DMA controller reserves some channels for
other on-chip coprocessors. By reading property "hisilicon,dma-min-chan"
from dts node, kernel will not use these reserved channels.

As an example, on Hi3660, channel 0 is reserved for lpm3.

Refer to Documentation/devicetree/bindings/dma/k3dma.txt for more
information.

Signed-off-by: Li Yu <liyu65@hisilicon.com>
Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
---
 drivers/dma/k3dma.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index fa31cccbe04f..33efb541acb2 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -113,6 +113,7 @@ struct k3_dma_dev {
 	struct dma_pool		*pool;
 	u32			dma_channels;
 	u32			dma_requests;
+	u32			dma_min_chan;
 	unsigned int		irq;
 };
 
@@ -309,7 +310,7 @@ static void k3_dma_tasklet(unsigned long arg)
 
 	/* check new channel request in d->chan_pending */
 	spin_lock_irq(&d->lock);
-	for (pch = 0; pch < d->dma_channels; pch++) {
+	for (pch = d->dma_min_chan; pch < d->dma_channels; pch++) {
 		p = &d->phy[pch];
 
 		if (p->vchan == NULL && !list_empty(&d->chan_pending)) {
@@ -326,7 +327,7 @@ static void k3_dma_tasklet(unsigned long arg)
 	}
 	spin_unlock_irq(&d->lock);
 
-	for (pch = 0; pch < d->dma_channels; pch++) {
+	for (pch = d->dma_min_chan; pch < d->dma_channels; pch++) {
 		if (pch_alloc & (1 << pch)) {
 			p = &d->phy[pch];
 			c = p->vchan;
@@ -825,6 +826,8 @@ static int k3_dma_probe(struct platform_device *op)
 				"dma-channels", &d->dma_channels);
 		of_property_read_u32((&op->dev)->of_node,
 				"dma-requests", &d->dma_requests);
+		of_property_read_u32((&op->dev)->of_node,
+				"hisilicon,dma-min-chan", &d->dma_min_chan);
 	}
 
 	d->clk = devm_clk_get(&op->dev, NULL);
@@ -848,12 +851,12 @@ static int k3_dma_probe(struct platform_device *op)
 		return -ENOMEM;
 
 	/* init phy channel */
-	d->phy = devm_kcalloc(&op->dev,
-		d->dma_channels, sizeof(struct k3_dma_phy), GFP_KERNEL);
+	d->phy = devm_kcalloc(&op->dev, (d->dma_channels - d->dma_min_chan),
+			sizeof(struct k3_dma_phy), GFP_KERNEL);
 	if (d->phy == NULL)
 		return -ENOMEM;
 
-	for (i = 0; i < d->dma_channels; i++) {
+	for (i = d->dma_min_chan; i < d->dma_channels; i++) {
 		struct k3_dma_phy *p = &d->phy[i];
 
 		p->idx = i;
-- 
2.17.1
