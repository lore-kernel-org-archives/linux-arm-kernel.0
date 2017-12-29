From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Dec 2017 09:18:36 +0100
Subject: [PATCH 32/67] dma-direct: add support for allocation from ZONE_DMA
 and ZONE_DMA32
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
Message-ID: <20171229081911.2802-33-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/dma-direct.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/lib/dma-direct.c b/lib/dma-direct.c
index 7e913728e099..2e9b9494610c 100644
--- a/lib/dma-direct.c
+++ b/lib/dma-direct.c
@@ -12,6 +12,14 @@
 
 #define DIRECT_MAPPING_ERROR		0
 
+/*
+ * Most architectures use ZONE_DMA for the first 16 Megabytes, but
+ * some use it for entirely different regions:
+ */
+#ifndef ARCH_ZONE_DMA_BITS
+#define ARCH_ZONE_DMA_BITS 24
+#endif
+
 static bool
 check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 		const char *caller)
@@ -40,6 +48,12 @@ void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	int page_order = get_order(size);
 	struct page *page = NULL;
 
+	/* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
+	if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
+		gfp |= GFP_DMA32;
+	else if (dev->coherent_dma_mask < DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
+		gfp |= GFP_DMA;
+
 again:
 	/* CMA can be used only in the context which permits sleeping */
 	if (gfpflags_allow_blocking(gfp)) {
-- 
2.14.2
