From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 17:44:03 +0200
Subject: [PATCH v3 49/59] dmaengine: rapidio: tsi721: Rename device_control
In-Reply-To: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413992653-21963-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413992653-21963-50-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the device_control callback of the TXX9 DMA driver to terminate_all
since it's all it's really doing. That will eventually be used to retrieve
slave capabilities.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/rapidio/devices/tsi721_dma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721_dma.c b/drivers/rapidio/devices/tsi721_dma.c
index f64c5decb747..47295940a868 100644
--- a/drivers/rapidio/devices/tsi721_dma.c
+++ b/drivers/rapidio/devices/tsi721_dma.c
@@ -815,8 +815,7 @@ struct dma_async_tx_descriptor *tsi721_prep_rio_sg(struct dma_chan *dchan,
 	return txd;
 }
 
-static int tsi721_device_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
-			     unsigned long arg)
+static int tsi721_terminate_all(struct dma_chan *dchan)
 {
 	struct tsi721_bdma_chan *bdma_chan = to_tsi721_chan(dchan);
 	struct tsi721_tx_desc *desc, *_d;
@@ -825,9 +824,6 @@ static int tsi721_device_control(struct dma_chan *dchan, enum dma_ctrl_cmd cmd,
 
 	dev_dbg(dchan->device->dev, "%s: Entry\n", __func__);
 
-	if (cmd != DMA_TERMINATE_ALL)
-		return -ENOSYS;
-
 	spin_lock_bh(&bdma_chan->lock);
 
 	bdma_chan->active = false;
@@ -901,7 +897,7 @@ int tsi721_register_dma(struct tsi721_device *priv)
 	mport->dma.device_tx_status = tsi721_tx_status;
 	mport->dma.device_issue_pending = tsi721_issue_pending;
 	mport->dma.device_prep_slave_sg = tsi721_prep_rio_sg;
-	mport->dma.device_control = tsi721_device_control;
+	mport->dma.device_terminate_all = tsi721_terminate_all;
 
 	err = dma_async_device_register(&mport->dma);
 	if (err)
-- 
2.1.1
