From: gurchetansingh@chromium.org (Gurchetan Singh)
Date: Tue, 23 Jan 2018 18:56:04 -0800
Subject: [PATCH 3/5] drm: add ARM64 flush implementations
In-Reply-To: <20180124025606.3020-2-gurchetansingh@chromium.org>
References: <20180124025606.3020-2-gurchetansingh@chromium.org>
Message-ID: <20180124025606.3020-3-gurchetansingh@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses the __dma_map_area function to flush the cache
on ARM64.

v2: Don't use DMA API, call functions directly (Daniel)

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/drm_cache.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 5124582451c6..250cdfbb711f 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -159,6 +159,12 @@ drm_flush_pages(struct page *pages[], unsigned long num_pages)
 	for (i = 0; i < num_pages; i++)
 		drm_cache_maint_page(pages[i], 0, PAGE_SIZE, DMA_TO_DEVICE,
 				     dmac_map_area);
+#elif defined(CONFIG_ARM64)
+	unsigned long i;
+
+	for (i = 0; i < num_pages; i++)
+		__dma_map_area(phys_to_virt(page_to_phys(pages[i])), PAGE_SIZE,
+			       DMA_TO_DEVICE);
 #else
 	pr_err("Architecture has no drm_cache.c support\n");
 	WARN_ON_ONCE(1);
@@ -196,6 +202,13 @@ drm_flush_sg(struct sg_table *st)
 	for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
 		drm_cache_maint_page(sg_page_iter_page(&sg_iter), 0, PAGE_SIZE,
 				     DMA_TO_DEVICE, dmac_map_area);
+#elif defined(CONFIG_ARM64)
+	int i;
+	struct scatterlist *sg;
+
+	for_each_sg(st->sgl, sg, st->nents, i)
+		__dma_map_area(phys_to_virt(sg_phys(sg)), sg->length,
+			       DMA_TO_DEVICE);
 #else
 	pr_err("Architecture has no drm_cache.c support\n");
 	WARN_ON_ONCE(1);
-- 
2.13.5
