From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:04 +0400
Subject: [RFC/PATCH RESEND -next 10/21] mm: slab: share virt_to_cache() between
 slab and slub
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-11-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch shares virt_to_cache() between slab and slub and
it used in cache_from_obj() now.
Later virt_to_cache() will be kernel address sanitizer also.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 mm/slab.c |  6 ------
 mm/slab.h | 10 +++++++---
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index e7763db..fa4f840 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -433,12 +433,6 @@ static inline void set_obj_status(struct page *page, int idx, int val) {}
 static int slab_max_order = SLAB_MAX_ORDER_LO;
 static bool slab_max_order_set __initdata;
 
-static inline struct kmem_cache *virt_to_cache(const void *obj)
-{
-	struct page *page = virt_to_head_page(obj);
-	return page->slab_cache;
-}
-
 static inline void *index_to_obj(struct kmem_cache *cache, struct page *page,
 				 unsigned int idx)
 {
diff --git a/mm/slab.h b/mm/slab.h
index 84c160a..1257ade 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -260,10 +260,15 @@ static inline void memcg_uncharge_slab(struct kmem_cache *s, int order)
 }
 #endif
 
+static inline struct kmem_cache *virt_to_cache(const void *obj)
+{
+	struct page *page = virt_to_head_page(obj);
+	return page->slab_cache;
+}
+
 static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 {
 	struct kmem_cache *cachep;
-	struct page *page;
 
 	/*
 	 * When kmemcg is not being used, both assignments should return the
@@ -275,8 +280,7 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
 	if (!memcg_kmem_enabled() && !unlikely(s->flags & SLAB_DEBUG_FREE))
 		return s;
 
-	page = virt_to_head_page(x);
-	cachep = page->slab_cache;
+	cachep = virt_to_cache(x);
 	if (slab_equal_or_root(cachep, s))
 		return cachep;
 
-- 
1.8.5.5
