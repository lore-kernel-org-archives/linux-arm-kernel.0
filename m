From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 25 Jul 2011 19:57:52 +0530
Subject: [PATCH] dmaengine: add helper function for slave_single
Message-ID: <mailman.31.1311608273.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For clients which require a single slave transfer and dont want to be bothered
about the scatterlist api, this helper gives simple API for this transfer and
creates single scatterlist for DMA API

Idea from Russel King

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/linux/dmaengine.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index eee7add..97dafc6 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -517,6 +517,16 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 			(unsigned long)config);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
+	struct dma_chan *chan, void *buf, size_t len,
+	enum dma_data_direction dir, unsigned long flags)
+{
+	struct scatterlist sg;
+	sg_init_one(&sg, buf, len);
+
+	return chan->device->device_prep_slave_sg(chan, &sg, 1, dir, flags);
+}
+
 static inline int dmaengine_terminate_all(struct dma_chan *chan)
 {
 	return dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
-- 
1.7.0.4




-- 
~Vinod Koul
Intel Corp.
