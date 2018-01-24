From: gurchetansingh@chromium.org (Gurchetan Singh)
Date: Tue, 23 Jan 2018 18:55:30 -0800
Subject: [PATCH 1/5] drm: rename {drm_clflush_sg, drm_clflush_pages}
Message-ID: <20180124025534.2964-1-gurchetansingh@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since clfush is an x86-only instruction, these function names won't
make much sense if we start adding cases for other architectures.

Signed-off-by: Gurchetan Singh <gurchetansingh@chromium.org>
---
 drivers/gpu/drm/drm_cache.c                 | 12 ++++++------
 drivers/gpu/drm/i915/i915_gem.c             |  2 +-
 drivers/gpu/drm/i915/i915_gem_clflush.c     |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c |  2 +-
 drivers/gpu/drm/ttm/ttm_tt.c                |  2 +-
 drivers/gpu/drm/vgem/vgem_drv.c             |  2 +-
 include/drm/drm_cache.h                     |  4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
index 3bd76e918b5d..89cdd32fe1f3 100644
--- a/drivers/gpu/drm/drm_cache.c
+++ b/drivers/gpu/drm/drm_cache.c
@@ -70,7 +70,7 @@ static void drm_cache_flush_clflush(struct page *pages[],
 #endif
 
 /**
- * drm_clflush_pages - Flush dcache lines of a set of pages.
+ * drm_flush_pages - Flush dcache lines of a set of pages.
  * @pages: List of pages to be flushed.
  * @num_pages: Number of pages in the array.
  *
@@ -78,7 +78,7 @@ static void drm_cache_flush_clflush(struct page *pages[],
  * to a page in the array.
  */
 void
-drm_clflush_pages(struct page *pages[], unsigned long num_pages)
+drm_flush_pages(struct page *pages[], unsigned long num_pages)
 {
 
 #if defined(CONFIG_X86)
@@ -109,17 +109,17 @@ drm_clflush_pages(struct page *pages[], unsigned long num_pages)
 	WARN_ON_ONCE(1);
 #endif
 }
-EXPORT_SYMBOL(drm_clflush_pages);
+EXPORT_SYMBOL(drm_flush_pages);
 
 /**
- * drm_clflush_sg - Flush dcache lines pointing to a scather-gather.
+ * drm_flush_sg - Flush dcache lines pointing to a scather-gather.
  * @st: struct sg_table.
  *
  * Flush every data cache line entry that points to an address in the
  * sg.
  */
 void
-drm_clflush_sg(struct sg_table *st)
+drm_flush_sg(struct sg_table *st)
 {
 #if defined(CONFIG_X86)
 	if (static_cpu_has(X86_FEATURE_CLFLUSH)) {
@@ -140,7 +140,7 @@ drm_clflush_sg(struct sg_table *st)
 	WARN_ON_ONCE(1);
 #endif
 }
-EXPORT_SYMBOL(drm_clflush_sg);
+EXPORT_SYMBOL(drm_flush_sg);
 
 /**
  * drm_clflush_virt_range - Flush dcache lines of a region
diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 8bc3283484be..a8c0703a096d 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -259,7 +259,7 @@ __i915_gem_object_release_shmem(struct drm_i915_gem_object *obj,
 	if (needs_clflush &&
 	    (obj->base.read_domains & I915_GEM_DOMAIN_CPU) == 0 &&
 	    !(obj->cache_coherent & I915_BO_CACHE_COHERENT_FOR_READ))
-		drm_clflush_sg(pages);
+		drm_flush_sg(pages);
 
 	__start_cpu_write(obj);
 }
diff --git a/drivers/gpu/drm/i915/i915_gem_clflush.c b/drivers/gpu/drm/i915/i915_gem_clflush.c
index b9b53ac14176..f6cff6e5c520 100644
--- a/drivers/gpu/drm/i915/i915_gem_clflush.c
+++ b/drivers/gpu/drm/i915/i915_gem_clflush.c
@@ -71,7 +71,7 @@ static const struct dma_fence_ops i915_clflush_ops = {
 static void __i915_do_clflush(struct drm_i915_gem_object *obj)
 {
 	GEM_BUG_ON(!i915_gem_object_has_pages(obj));
-	drm_clflush_sg(obj->mm.pages);
+	drm_flush_sg(obj->mm.pages);
 	intel_fb_obj_flush(obj, ORIGIN_CPU);
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 1d9655576b6e..8ac7eb25e46d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -100,7 +100,7 @@ static int rockchip_gem_get_pages(struct rockchip_gem_object *rk_obj)
 	 * Fake up the SG table so that dma_sync_sg_for_device() can be used
 	 * to flush the pages associated with it.
 	 *
-	 * TODO: Replace this by drm_clflush_sg() once it can be implemented
+	 * TODO: Replace this by drm_flush_sg() once it can be implemented
 	 * without relying on symbols that are not exported.
 	 */
 	for_each_sg(rk_obj->sgt->sgl, s, rk_obj->sgt->nents, i)
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 5a046a3c543a..54b1971cd817 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -122,7 +122,7 @@ static int ttm_tt_set_caching(struct ttm_tt *ttm,
 	}
 
 	if (ttm->caching_state == tt_cached)
-		drm_clflush_pages(ttm->pages, ttm->num_pages);
+		drm_flush_pages(ttm->pages, ttm->num_pages);
 
 	for (i = 0; i < ttm->num_pages; ++i) {
 		cur_page = ttm->pages[i];
diff --git a/drivers/gpu/drm/vgem/vgem_drv.c b/drivers/gpu/drm/vgem/vgem_drv.c
index 2524ff116f00..802a97e1a4bf 100644
--- a/drivers/gpu/drm/vgem/vgem_drv.c
+++ b/drivers/gpu/drm/vgem/vgem_drv.c
@@ -325,7 +325,7 @@ static int vgem_prime_pin(struct drm_gem_object *obj)
 	/* Flush the object from the CPU cache so that importers can rely
 	 * on coherent indirect access via the exported dma-address.
 	 */
-	drm_clflush_pages(pages, n_pages);
+	drm_flush_pages(pages, n_pages);
 
 	return 0;
 }
diff --git a/include/drm/drm_cache.h b/include/drm/drm_cache.h
index beab0f0d0cfb..25c029470315 100644
--- a/include/drm/drm_cache.h
+++ b/include/drm/drm_cache.h
@@ -35,8 +35,8 @@
 
 #include <linux/scatterlist.h>
 
-void drm_clflush_pages(struct page *pages[], unsigned long num_pages);
-void drm_clflush_sg(struct sg_table *st);
+void drm_flush_pages(struct page *pages[], unsigned long num_pages);
+void drm_flush_sg(struct sg_table *st);
 void drm_clflush_virt_range(void *addr, unsigned long length);
 
 static inline bool drm_arch_can_wc_memory(void)
-- 
2.13.5
