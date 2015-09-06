From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Sun,  6 Sep 2015 09:12:44 +0800
Subject: [PATCH v4 06/10] dmaengine: add API for getting dma controller's quirk
In-Reply-To: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1441501964-13952-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dmaengine_get_quirks API for peripheral devices to query
quirks if they need it to make special workaround due to broken
dma controller design.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 include/linux/dmaengine.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e2f5eb4..5174ca4 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -704,6 +704,7 @@ struct dma_device {
 
 	int (*device_config)(struct dma_chan *chan,
 			     struct dma_slave_config *config);
+	int (*device_get_quirks)(struct dma_chan *chan);
 	int (*device_pause)(struct dma_chan *chan);
 	int (*device_resume)(struct dma_chan *chan);
 	int (*device_terminate_all)(struct dma_chan *chan);
@@ -723,6 +724,14 @@ static inline int dmaengine_slave_config(struct dma_chan *chan,
 	return -ENOSYS;
 }
 
+static inline int dmaengine_get_quirks(struct dma_chan *chan)
+{
+	if (chan->device->device_get_quirks)
+		return chan->device->device_get_quirks(chan);
+
+	return -ENOSYS;
+}
+
 static inline bool is_slave_direction(enum dma_transfer_direction direction)
 {
 	return (direction == DMA_MEM_TO_DEV) || (direction == DMA_DEV_TO_MEM);
-- 
2.3.7
