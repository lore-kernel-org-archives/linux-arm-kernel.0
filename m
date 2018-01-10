From: hch@lst.de (Christoph Hellwig)
Date: Wed, 10 Jan 2018 09:00:23 +0100
Subject: [PATCH 29/33] dma-direct: retry allocations using GFP_DMA for small
 masks
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
Message-ID: <20180110080027.13879-30-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an attempt to allocate memory succeeded, but isn't inside the
supported DMA mask, retry the allocation with GFP_DMA set as a
last resort.

Based on the x86 code, but an off by one error in what is now
dma_coherent_ok has been fixed vs the x86 code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 8f76032ebc3c..4e43c2bb7f5f 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -35,6 +35,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 	return true;
 }
 
+static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
+{
+	return phys_to_dma(dev, phys) + size - 1 <= dev->coherent_dma_mask;
+}
+
 static void *dma_direct_alloc(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
@@ -48,11 +53,29 @@ static void *dma_direct_alloc(struct device *dev, size_t size,
 	if (dev->coherent_dma_mask <= DMA_BIT_MASK(32) && !(gfp & GFP_DMA))
 		gfp |= GFP_DMA32;
 
+again:
 	/* CMA can be used only in the context which permits sleeping */
-	if (gfpflags_allow_blocking(gfp))
+	if (gfpflags_allow_blocking(gfp)) {
 		page = dma_alloc_from_contiguous(dev, count, page_order, gfp);
+		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+			dma_release_from_contiguous(dev, page, count);
+			page = NULL;
+		}
+	}
 	if (!page)
 		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
+
+	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
+		__free_pages(page, page_order);
+		page = NULL;
+
+		if (dev->coherent_dma_mask < DMA_BIT_MASK(32) &&
+		    !(gfp & GFP_DMA)) {
+			gfp = (gfp & ~GFP_DMA32) | GFP_DMA;
+			goto again;
+		}
+	}
+
 	if (!page)
 		return NULL;
 
-- 
2.14.2
