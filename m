From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Oct 2014 12:17:12 +0200
Subject: [PATCH v2 13/53] dmaengine: jz4740: Split device_control
In-Reply-To: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413454672-27400-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1413454672-27400-14-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Split the device_control callback of the JZ4740 DMA driver to make use of the
newly introduced callbacks, that will eventually be used to retrieve slave
capabilities.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/dma/dma-jz4740.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
index 6a9d89c93b1f..2ee3f8f8693f 100644
--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -210,7 +210,7 @@ static enum jz4740_dma_transfer_size jz4740_dma_maxburst(u32 maxburst)
 }
 
 static int jz4740_dma_slave_config(struct dma_chan *c,
-	const struct dma_slave_config *config)
+				   struct dma_slave_config *config)
 {
 	struct jz4740_dmaengine_chan *chan = to_jz4740_dma_chan(c);
 	struct jz4740_dma_dev *dmadev = jz4740_dma_chan_get_dev(chan);
@@ -290,21 +290,6 @@ static int jz4740_dma_terminate_all(struct dma_chan *c)
 	return 0;
 }
 
-static int jz4740_dma_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
-	unsigned long arg)
-{
-	struct dma_slave_config *config = (struct dma_slave_config *)arg;
-
-	switch (cmd) {
-	case DMA_SLAVE_CONFIG:
-		return jz4740_dma_slave_config(chan, config);
-	case DMA_TERMINATE_ALL:
-		return jz4740_dma_terminate_all(chan);
-	default:
-		return -ENOSYS;
-	}
-}
-
 static int jz4740_dma_start_transfer(struct jz4740_dmaengine_chan *chan)
 {
 	struct jz4740_dma_dev *dmadev = jz4740_dma_chan_get_dev(chan);
@@ -560,7 +545,8 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 	dd->device_issue_pending = jz4740_dma_issue_pending;
 	dd->device_prep_slave_sg = jz4740_dma_prep_slave_sg;
 	dd->device_prep_dma_cyclic = jz4740_dma_prep_dma_cyclic;
-	dd->device_control = jz4740_dma_control;
+	dd->device_config = jz4740_dma_slave_config;
+	dd->device_terminate_all = jz4740_dma_terminate_all;
 	dd->dev = &pdev->dev;
 	dd->chancnt = JZ_DMA_NR_CHANS;
 	INIT_LIST_HEAD(&dd->channels);
-- 
2.1.1
