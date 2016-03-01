From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  1 Mar 2016 18:17:38 +0000
Subject: [PATCH] iommu/io-pgtable-armv7s: Fix kmem_cache_alloc() flags
Message-ID: <cbd13a3db3924a67f8aa8a352f04c883c47d8815.1456856051.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whilst the default SLUB allocator happily just merges the original
allocation flags from kmem_cache_create() with those passed through
kmem_cache_alloc(), there is a code path in the SLAB allocator which
will aggressively BUG_ON() if the cache was created with SLAB_CACHE_DMA
but GFP_DMA is not specified for an allocation.

Keep the peace by adding GFP_DMA when allocating a table.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/io-pgtable-arm-v7s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 9fcceb1..9488e3c 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -192,7 +192,7 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
 	if (lvl == 1)
 		table = (void *)__get_dma_pages(__GFP_ZERO, get_order(size));
 	else if (lvl == 2)
-		table = kmem_cache_zalloc(data->l2_tables, gfp);
+		table = kmem_cache_zalloc(data->l2_tables, gfp | GFP_DMA);
 	if (table && !selftest_running) {
 		dma = dma_map_single(dev, table, size, DMA_TO_DEVICE);
 		if (dma_mapping_error(dev, dma))
-- 
2.7.2.333.g70bd996.dirty
