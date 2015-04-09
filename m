From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  9 Apr 2015 16:34:06 +0200
Subject: [PATCH 3/6] drm/cache: Implement drm_clflush_*() for 64-bit ARM
In-Reply-To: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
References: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1428590049-20357-3-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add implementations for drm_clflush_*() on 64-bit ARM. This shares a lot
of code with the 32-bit ARM implementation.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_cache.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 200d86c3d72d..0c3072b4cdc9 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -102,6 +102,17 @@ static void drm_clflush_page(struct page *page)
 }
 #endif
 
+#if defined(CONFIG_ARM64)
+static void drm_clflush_page(struct page *page)
+{
+	void *virt;
+
+	virt = kmap_atomic(page);
+	__dma_flush_range(virt, virt + PAGE_SIZE);
+	kunmap_atomic(virt);
+}
+#endif
+
 void
 drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 {
@@ -129,7 +140,7 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 				   (unsigned long)page_virtual + PAGE_SIZE);
 		kunmap_atomic(page_virtual);
 	}
-#elif defined(CONFIG_ARM)
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	unsigned long i;
 
 	for (i = 0; i < num_pages; i++)
@@ -158,7 +169,7 @@ drm_clflush_sg(struct sg_table *st)
 
 	if (wbinvd_on_all_cpus())
 		printk(KERN_ERR "Timed out waiting for cache flush.\n");
-#elif defined(CONFIG_ARM)
+#elif defined(CONFIG_ARM) || defined(CONFIG_ARM64)
 	struct sg_page_iter sg_iter;
 
 	for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
-- 
2.3.2
