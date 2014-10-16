From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:41 +0200
Subject: [PATCH v2 42/53] dmaengine: pch-dma: Rename device_control
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-43-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the device_control callback of the Intel PCH DMA driver to terminate_all
since it's all it's really doing. That will eventually be used to retrieve
slave capabilities.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/pch_dma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/pch_dma.c b/drivers/dma/pch_dma.c
index 9f9ca9fe5ce6..d03b9c93ccab 100644
--- a/drivers/dma/pch_dma.c
+++ b/drivers/dma/pch_dma.c
@@ -665,16 +665,12 @@ err_desc_get:
 	return NULL;
 }
 
-static int pd_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-			     unsigned long arg)
+static int pd_device_terminate_all(struct dma_chan *chan)
 {
 	struct pch_dma_chan *pd_chan = to_pd_chan(chan);
 	struct pch_dma_desc *desc, *_d;
 	LIST_HEAD(list);
 
-	if (cmd != DMA_TERMINATE_ALL)
-		return -ENXIO;
-
 	spin_lock_irq(&pd_chan->lock);
 
 	pdc_set_mode(&pd_chan->chan, DMA_CTL0_DISABLE);
@@ -932,7 +928,7 @@ static int pch_dma_probe(struct pci_dev *pdev,
 	pd->dma.device_tx_status = pd_tx_status;
 	pd->dma.device_issue_pending = pd_issue_pending;
 	pd->dma.device_prep_slave_sg = pd_prep_slave_sg;
-	pd->dma.device_control = pd_device_control;
+	pd->dma.device_terminate_all = pd_device_terminate_all;
 
 	err = dma_async_device_register(&pd->dma);
 	if (err) {
-- 
2.1.1
