From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  9 Apr 2015 16:34:05 +0200
Subject: [PATCH 2/6] drm/cache: Implement drm_clflush_*() for ARM
In-Reply-To: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1428590049-20357-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add implementations for drm_clflush_*() on ARM by borrowing code from
the DMA mapping API implementation. Unfortunately ARM doesn't export an
API to flush caches on a page by page basis, so this replicates most of
the code.

Reviewed-by: Rob Clark <robdclark@gmail.com>
Tested-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_cache.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 9a62d7a53553..200d86c3d72d 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -67,6 +67,41 @@ static void drm_cache_flush_clflush(struct page *pages[],
 }
 #endif
 
+#if defined(CONFIG_ARM)
+
+#include <asm/cacheflush.h>
+#include <asm/cachetype.h>
+#include <asm/highmem.h>
+#include <asm/outercache.h>
+
+static void drm_clflush_page(struct page *page)
+{
+	enum dma_data_direction dir = DMA_TO_DEVICE;
+	phys_addr_t phys = page_to_phys(page);
+	size_t size = PAGE_SIZE;
+	void *virt;
+
+	if (PageHighMem(page)) {
+		if (cache_is_vipt_nonaliasing()) {
+			virt = kmap_atomic(page);
+			dmac_map_area(virt, size, dir);
+			kunmap_atomic(virt);
+		} else {
+			virt = kmap_high_get(page);
+			if (virt) {
+				dmac_map_area(virt, size, dir);
+				kunmap_high(page);
+			}
+		}
+	} else {
+		virt = page_address(page);
+		dmac_map_area(virt, size, dir);
+	}
+
+	outer_flush_range(phys, phys + PAGE_SIZE);
+}
+#endif
+
 void
 drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 {
@@ -94,6 +129,11 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 				   (unsigned long)page_virtual + PAGE_SIZE);
 		kunmap_atomic(page_virtual);
 	}
+#elif defined(CONFIG_ARM)
+	unsigned long i;
+
+	for (i = 0; i < num_pages; i++)
+		drm_clflush_page(pages[i]);
 #else
 	printk(KERN_ERR "Architecture has no drm_cache.c support\n");
 	WARN_ON_ONCE(1);
@@ -118,6 +158,11 @@ drm_clflush_sg(struct sg_table *st)
 
 	if (wbinvd_on_all_cpus())
 		printk(KERN_ERR "Timed out waiting for cache flush.\n");
+#elif defined(CONFIG_ARM)
+	struct sg_page_iter sg_iter;
+
+	for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
+		drm_clflush_page(sg_page_iter_page(&sg_iter));
 #else
 	printk(KERN_ERR "Architecture has no drm_cache.c support\n");
 	WARN_ON_ONCE(1);
-- 
2.3.2
