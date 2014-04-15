From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 15 Apr 2014 17:13:32 +0200
Subject: [PATCH 1/6] dmaengine: Add fly-by transfer flag to slave
 configuration structure
In-Reply-To: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1397574817-15559-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1397574817-15559-2-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fly-by transfer mode cuts down the number of bus transactions by letting
the slave drive or latch the memory data bus during memory transactions
instead of performing a dedicated transaction to read data from or write
data to the slave.

Support for fly-by mode by adding a new flag field to struct
dma_slave_config.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 include/linux/dmaengine.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c5c92d5..ae99153 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -304,6 +304,17 @@ enum dma_slave_buswidth {
 };
 
 /**
+ * enum dma_slave_flags - DMA slave configuration flags
+ * @DMA_SLAVE_FLAG_FLY_BY - perform DMA transfers for the slave in fly-by mode.
+ *   Instead of performing a bus transaction to read (write) data from (to) the
+ *   slave, let the slave drive (latch) the memory bus data signals during the
+ *   memory write (read) transaction.
+ */
+enum dma_slave_flags {
+	DMA_SLAVE_FLAG_FLY_BY = (1 << 0),
+};
+
+/**
  * struct dma_slave_config - dma slave channel runtime config
  * @direction: whether the data shall go in or out on this slave
  * channel, right now. DMA_MEM_TO_DEV and DMA_DEV_TO_MEM are
@@ -333,6 +344,7 @@ enum dma_slave_buswidth {
  * @slave_id: Slave requester id. Only valid for slave channels. The dma
  * slave peripheral will have unique id as dma requester which need to be
  * pass as slave config.
+ * @flags: DMA slave flags, a combination of enum dma_slave_flags flags.
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport@runtime.
@@ -361,6 +373,7 @@ struct dma_slave_config {
 	u32 dst_maxburst;
 	bool device_fc;
 	unsigned int slave_id;
+	u32 flags;
 };
 
 /**
-- 
1.8.3.2
