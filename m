From: ritesh.harjani@gmail.com (Ritesh Harjani)
Date: Thu, 6 Feb 2014 17:21:51 +0530
Subject: [PATCH] arm64: Change misleading function names in dma-mapping
Message-ID: <CAD15agYoPm8krMTAFRRRPRWu2Z7SQaUJUkO9mm_QGR=zeFvO5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

arm64_swiotlb_alloc/free_coherent name can be misleading
somtimes with CMA support being enabled after this
patch (c2104debc235b745265b64d610237a6833fd53)

Change this name to be more generic:
__dma_alloc/free_coherent

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 arch/arm64/mm/dma-mapping.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 45b5ab5..aee7521 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -30,7 +30,7 @@
 struct dma_map_ops *dma_ops;
 EXPORT_SYMBOL(dma_ops);

-static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
+static void *__dma_alloc_coherent(struct device *dev, size_t size,
                                          dma_addr_t *dma_handle, gfp_t flags,
                                          struct dma_attrs *attrs)
 {
@@ -57,7 +57,7 @@ static void *arm64_swiotlb_alloc_coherent(struct
device *dev, size_t size,
        }
 }

-static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
+static void __dma_free_coherent(struct device *dev, size_t size,
                                        void *vaddr, dma_addr_t dma_handle,
                                        struct dma_attrs *attrs)
 {
@@ -78,8 +78,8 @@ static void arm64_swiotlb_free_coherent(struct
device *dev, size_t size,
 }

 static struct dma_map_ops arm64_swiotlb_dma_ops = {
-       .alloc = arm64_swiotlb_alloc_coherent,
-       .free = arm64_swiotlb_free_coherent,
+       .alloc = __dma_alloc_coherent,
+       .free = __dma_free_coherent,
        .map_page = swiotlb_map_page,
        .unmap_page = swiotlb_unmap_page,
        .map_sg = swiotlb_map_sg_attrs,
--
1.8.1.3
