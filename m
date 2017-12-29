From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:53 +0100
Subject: [PATCH 49/67] swiotlb: refactor coherent buffer freeing
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-50-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Factor out a new swiotlb_free_buffer helper that checks if an address
is allocated from the swiotlb bounce buffer, and if yes frees it.

This allows to simplify the swiotlb_free implemenation that uses
dma_direct_free to free the non-bounce buffer allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index a14fff30ee9d..adb4dd0091fa 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -773,22 +773,31 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 }
 EXPORT_SYMBOL(swiotlb_alloc_coherent);
 
+static bool swiotlb_free_buffer(struct device *dev, size_t size,
+		dma_addr_t dma_addr)
+{
+	phys_addr_t phys_addr = dma_to_phys(dev, dma_addr);
+
+	WARN_ON_ONCE(irqs_disabled());
+
+	if (!is_swiotlb_buffer(phys_addr))
+		return false;
+
+	/*
+	 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
+	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
+	 */
+	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
+				 DMA_ATTR_SKIP_CPU_SYNC);
+	return true;
+}
+
 void
 swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 		      dma_addr_t dev_addr)
 {
-	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
-
-	WARN_ON(irqs_disabled());
-	if (!is_swiotlb_buffer(paddr))
+	if (!swiotlb_free_buffer(hwdev, size, dev_addr))
 		free_pages((unsigned long)vaddr, get_order(size));
-	else
-		/*
-		 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
-		 * DMA_ATTR_SKIP_CPU_SYNC is optional.
-		 */
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, DMA_TO_DEVICE,
-					 DMA_ATTR_SKIP_CPU_SYNC);
 }
 EXPORT_SYMBOL(swiotlb_free_coherent);
 
@@ -1103,9 +1112,7 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
-		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-	else
+	if (!swiotlb_free_buffer(dev, size, dma_addr))
 		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
 }
 
-- 
2.14.2
