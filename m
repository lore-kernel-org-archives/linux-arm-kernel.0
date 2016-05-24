From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 May 2016 08:28:09 +0200
Subject: [PATCH 3/4] arm64: dma-mapping: Constify attrs passed to internal
 functions
In-Reply-To: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
References: <1464071290-15948-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1464071290-15948-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the non-exported functions do not modify passed dma_attrs so the
pointer can point to const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm64/mm/dma-mapping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index c566ec83719f..0ef620a34c4e 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -29,7 +29,7 @@
 
 #include <asm/cacheflush.h>
 
-static pgprot_t __get_dma_pgprot(struct dma_attrs *attrs, pgprot_t prot,
+static pgprot_t __get_dma_pgprot(const struct dma_attrs *attrs, pgprot_t prot,
 				 bool coherent)
 {
 	if (!coherent || dma_get_attr(DMA_ATTR_WRITE_COMBINE, attrs))
@@ -88,7 +88,7 @@ static int __free_from_pool(void *start, size_t size)
 
 static void *__dma_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flags,
-				  struct dma_attrs *attrs)
+				  const struct dma_attrs *attrs)
 {
 	if (dev == NULL) {
 		WARN_ONCE(1, "Use an actual device structure for DMA allocation\n");
@@ -118,7 +118,7 @@ static void *__dma_alloc_coherent(struct device *dev, size_t size,
 
 static void __dma_free_coherent(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle,
-				struct dma_attrs *attrs)
+				const struct dma_attrs *attrs)
 {
 	bool freed;
 	phys_addr_t paddr = dma_to_phys(dev, dma_handle);
-- 
1.9.1
