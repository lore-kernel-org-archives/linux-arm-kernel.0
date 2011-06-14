From: pullip.cho@samsung.com (pullip.cho at samsung.com)
Date: Tue, 14 Jun 2011 13:33:09 +0900
Subject: [PATCH] dma-mapping: Undefine dma_map_single(),
	etc if CONFIG_HAVE_DMA_ATTRS is defined
Message-ID: <1308025989-877-1-git-send-email-pullip.cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: KyongHo Cho <pullip.cho@samsung.com>

If <asm/dma-mapping.h> includes <asm-generic/dma-mapping-common.h>,
dma_map_single() become defined recursively when CONFIG_HAVE_DMA_ATTRS
is not defined.
Since dma_map_*_attrs() are defined in <linux/dma-mapping.h>, those
in <asm-generic/dma-mapping-common.h> must be not defined
if CONFIG_HAVE_DMA_ATTRS is not defined.

Signed-off-by: KyongHo Cho <pullip.cho@samsung.com>
CC: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
CC: Joerg Roedel <joerg.roedel@amd.com>
CC Arnd Bergmann <arnd@arndb.de>

Change-Id: Ib99ee2b355dbe679263ce2e4e27d6219148c8338
---
 include/asm-generic/dma-mapping-common.h |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/dma-mapping-common.h b/include/asm-generic/dma-mapping-common.h
index 0c80bb3..b9a2040 100644
--- a/include/asm-generic/dma-mapping-common.h
+++ b/include/asm-generic/dma-mapping-common.h
@@ -6,6 +6,7 @@
 #include <linux/dma-debug.h>
 #include <linux/dma-attrs.h>
 
+#ifdef CONFIG_HAVE_DMA_ATTRS
 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
 					      size_t size,
 					      enum dma_data_direction dir,
@@ -67,6 +68,13 @@ static inline void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg
 		ops->unmap_sg(dev, sg, nents, dir, attrs);
 }
 
+#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
+#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
+#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
+#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
+
+#endif /* CONFIG_HAVE_DMA_ATTRS */
+
 static inline dma_addr_t dma_map_page(struct device *dev, struct page *page,
 				      size_t offset, size_t size,
 				      enum dma_data_direction dir)
@@ -160,9 +168,4 @@ dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
 
 }
 
-#define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, NULL)
-#define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, NULL)
-#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, NULL)
-#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, NULL)
-
 #endif
-- 
1.7.1
