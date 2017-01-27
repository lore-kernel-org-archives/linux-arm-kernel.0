From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 27 Jan 2017 17:34:03 +0100
Subject: [PATCH 2/5] dmaengine: Provide a wrapper for memcpy operations
In-Reply-To: <1485534846-28111-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1485534846-28111-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1485534846-28111-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Almost all ->device_prep_dma_xx() methods have a wrapper defined in
dmaengine.h. Add one for  ->device_prep_dma_memcpy().

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 include/linux/dmaengine.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index feee6ec6a13b..533680860865 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -894,6 +894,17 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memset(
 						    len, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_memcpy(
+		struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
+		size_t len, unsigned long flags)
+{
+	if (!chan || !chan->device || !chan->device->device_prep_dma_memcpy)
+		return NULL;
+
+	return chan->device->device_prep_dma_memcpy(chan, dest, src,
+						    len, flags);
+}
+
 static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
 		struct dma_chan *chan,
 		struct scatterlist *dst_sg, unsigned int dst_nents,
-- 
2.7.4
