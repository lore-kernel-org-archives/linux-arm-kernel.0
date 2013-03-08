From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 08 Mar 2013 16:59:17 +0100
Subject: [PATCH] ARM: DMA-mapping: add missing GFP_DMA flag for atomic buffer
 allocation
Message-ID: <1362758357-20872-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atomic pool should always be allocated from DMA zone if such zone is
available in the system to avoid issues caused by limited dma mask of
any of the devices used for making an atomic allocation.

Reported-by: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mm/dma-mapping.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index c7e3759..e9db6b4 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -342,6 +342,7 @@ static int __init atomic_pool_init(void)
 {
 	struct dma_pool *pool = &atomic_pool;
 	pgprot_t prot = pgprot_dmacoherent(pgprot_kernel);
+	gfp_t gfp = GFP_KERNEL | GFP_DMA;
 	unsigned long nr_pages = pool->size >> PAGE_SHIFT;
 	unsigned long *bitmap;
 	struct page *page;
@@ -361,8 +362,8 @@ static int __init atomic_pool_init(void)
 		ptr = __alloc_from_contiguous(NULL, pool->size, prot, &page,
 					      atomic_pool_init);
 	else
-		ptr = __alloc_remap_buffer(NULL, pool->size, GFP_KERNEL, prot,
-					   &page, atomic_pool_init);
+		ptr = __alloc_remap_buffer(NULL, pool->size, gfp, prot, &page,
+					   atomic_pool_init);
 	if (ptr) {
 		int i;
 
-- 
1.7.9.5
