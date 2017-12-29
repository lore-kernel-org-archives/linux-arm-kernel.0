From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:25 +0100
Subject: [PATCH 21/67] dma-mapping: warn when there is no coherent_dma_mask
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-22-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These days all devices should have a DMA coherent mask, and most dma_ops
implementations rely on that fact.  But just to be sure add an assert to
ring the warning bell if that is not the case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e77e2dec4723..2779d544485c 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -520,6 +520,7 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 	void *cpu_addr;
 
 	BUG_ON(!ops);
+	WARN_ON_ONCE(!dev->coherent_dma_mask);
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
 		return cpu_addr;
-- 
2.14.2
