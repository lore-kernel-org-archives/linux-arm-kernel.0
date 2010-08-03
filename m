From: gking@nvidia.com (Gary King)
Date: Mon,  2 Aug 2010 19:42:49 -0700
Subject: [PATCH 4/4] [ARM] dma-mapping: add support for inner-writeback pages
In-Reply-To: <1280803369-13362-1-git-send-email-gking@nvidia.com>
References: <1280803369-13362-1-git-send-email-gking@nvidia.com>
Message-ID: <1280803369-13362-5-git-send-email-gking@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add support for pages allocated with the inner-writeback
allocation attribute to the cache flush and DMA cache maintenance
code.

pages allocated from the attribute page allocator with the inner-
writeback attribute selected can bypass outer cache maintenance,
since outer cachelines will not be allocated for these pages.
this results in a significant reduction in the time spent performing
cache maintenance for these pages.

Signed-off-by: Gary King <gking@nvidia.com>
---
 arch/arm/mm/dma-mapping.c |   23 +++++++++++++++--------
 arch/arm/mm/flush.c       |    3 ++-
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index fa94be5..5de376a 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -488,16 +488,20 @@ void ___dma_page_cpu_to_dev(struct page *page, unsigned long off,
 	if (PageUncached(page) &&
 	    !(page_private(page) == L_PTE_MT_WRITEBACK ||
 	      page_private(page) == L_PTE_MT_WRITEALLOC ||
-	      page_private(page) == L_PTE_MT_DEV_CACHED))
+	      page_private(page) == L_PTE_MT_DEV_CACHED ||
+	      page_private(page) == L_PTE_MT_INNER_WB))
 		return;
 
 	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
 
 	paddr = page_to_phys(page) + off;
-	if (dir == DMA_FROM_DEVICE) {
-		outer_inv_range(paddr, paddr + size);
-	} else {
-		outer_clean_range(paddr, paddr + size);
+
+	if (!PageUncached(page) || (page_private(page) != L_PTE_MT_INNER_WB)) {
+		if (dir == DMA_FROM_DEVICE) {
+			outer_inv_range(paddr, paddr + size);
+		} else {
+			outer_clean_range(paddr, paddr + size);
+		}
 	}
 	/* FIXME: non-speculating: flush on bidirectional mappings? */
 }
@@ -511,15 +515,18 @@ void ___dma_page_dev_to_cpu(struct page *page, unsigned long off,
 	if (PageUncached(page) &&
 	    !(page_private(page) == L_PTE_MT_WRITEBACK ||
 	      page_private(page) == L_PTE_MT_WRITEALLOC ||
-	      page_private(page) == L_PTE_MT_DEV_CACHED))
+	      page_private(page) == L_PTE_MT_DEV_CACHED ||
+	      page_private(page) == L_PTE_MT_INNER_WB))
 		return;
 
 	paddr = page_to_phys(page) + off;
 
 	/* FIXME: non-speculating: not required */
 	/* don't bother invalidating if DMA to device */
-	if (dir != DMA_TO_DEVICE)
-		outer_inv_range(paddr, paddr + size);
+	if (!PageUncached(page) || (page_private(page) != L_PTE_MT_INNER_WB)) {
+		if (dir != DMA_TO_DEVICE)
+			outer_inv_range(paddr, paddr + size);
+	}
 
 	dma_cache_maint_page(page, off, size, dir, dmac_unmap_area);
 }
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 33e900a..4f6f115 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -160,7 +160,8 @@ void __flush_dcache_page(struct address_space *mapping, struct page *page)
 	if (PageUncached(page) &&
 	    !(page_private(page) == L_PTE_MT_WRITEBACK ||
 	      page_private(page) == L_PTE_MT_WRITEALLOC ||
-	      page_private(page) == L_PTE_MT_DEV_CACHED))
+	      page_private(page) == L_PTE_MT_DEV_CACHED ||
+	      page_private(page) == L_PTE_MT_INNER_WB))
 		return;
 	/*
 	 * Writeback any data associated with the kernel mapping of this
-- 
1.7.0.4
