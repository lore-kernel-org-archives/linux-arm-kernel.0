From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  9 Aug 2018 21:20:53 +0200
Subject: [PATCH v5 01/18] khwasan, mm: change kasan hooks signatures
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
Message-ID: <327ede8363658620073d173c615a26ba9faf38d0.1533842385.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KHWASAN will change the value of the top byte of pointers returned from the
kernel allocation functions (such as kmalloc). This patch updates KASAN
hooks signatures and their usage in SLAB and SLUB code to reflect that.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h | 34 +++++++++++++++++++++++-----------
 mm/kasan/kasan.c      | 24 ++++++++++++++----------
 mm/slab.c             | 12 ++++++------
 mm/slab.h             |  2 +-
 mm/slab_common.c      |  4 ++--
 mm/slub.c             | 15 +++++++--------
 6 files changed, 53 insertions(+), 38 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index de784fd11d12..cbdc54543803 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -53,14 +53,14 @@ void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
 void kasan_poison_object_data(struct kmem_cache *cache, void *object);
 void kasan_init_slab_obj(struct kmem_cache *cache, const void *object);
 
-void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
+void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags);
 void kasan_kfree_large(void *ptr, unsigned long ip);
 void kasan_poison_kfree(void *ptr, unsigned long ip);
-void kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
+void *kasan_kmalloc(struct kmem_cache *s, const void *object, size_t size,
 		  gfp_t flags);
-void kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
+void *kasan_krealloc(const void *object, size_t new_size, gfp_t flags);
 
-void kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
+void *kasan_slab_alloc(struct kmem_cache *s, void *object, gfp_t flags);
 bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
 
 struct kasan_cache {
@@ -105,16 +105,28 @@ static inline void kasan_poison_object_data(struct kmem_cache *cache,
 static inline void kasan_init_slab_obj(struct kmem_cache *cache,
 				const void *object) {}
 
-static inline void kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags) {}
+static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
+{
+	return ptr;
+}
 static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
 static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
-static inline void kasan_kmalloc(struct kmem_cache *s, const void *object,
-				size_t size, gfp_t flags) {}
-static inline void kasan_krealloc(const void *object, size_t new_size,
-				 gfp_t flags) {}
+static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
+				size_t size, gfp_t flags)
+{
+	return (void *)object;
+}
+static inline void *kasan_krealloc(const void *object, size_t new_size,
+				 gfp_t flags)
+{
+	return (void *)object;
+}
 
-static inline void kasan_slab_alloc(struct kmem_cache *s, void *object,
-				   gfp_t flags) {}
+static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
+				   gfp_t flags)
+{
+	return object;
+}
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
 				   unsigned long ip)
 {
diff --git a/mm/kasan/kasan.c b/mm/kasan/kasan.c
index c3bd5209da38..f696c7c143c2 100644
--- a/mm/kasan/kasan.c
+++ b/mm/kasan/kasan.c
@@ -485,9 +485,9 @@ void kasan_init_slab_obj(struct kmem_cache *cache, const void *object)
 	__memset(alloc_info, 0, sizeof(*alloc_info));
 }
 
-void kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
+void *kasan_slab_alloc(struct kmem_cache *cache, void *object, gfp_t flags)
 {
-	kasan_kmalloc(cache, object, cache->object_size, flags);
+	return kasan_kmalloc(cache, object, cache->object_size, flags);
 }
 
 static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
@@ -528,7 +528,7 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
 	return __kasan_slab_free(cache, object, ip, true);
 }
 
-void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
+void *kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 		   gfp_t flags)
 {
 	unsigned long redzone_start;
@@ -538,7 +538,7 @@ void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 		quarantine_reduce();
 
 	if (unlikely(object == NULL))
-		return;
+		return NULL;
 
 	redzone_start = round_up((unsigned long)(object + size),
 				KASAN_SHADOW_SCALE_SIZE);
@@ -551,10 +551,12 @@ void kasan_kmalloc(struct kmem_cache *cache, const void *object, size_t size,
 
 	if (cache->flags & SLAB_KASAN)
 		set_track(&get_alloc_info(cache, object)->alloc_track, flags);
+
+	return (void *)object;
 }
 EXPORT_SYMBOL(kasan_kmalloc);
 
-void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
+void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 {
 	struct page *page;
 	unsigned long redzone_start;
@@ -564,7 +566,7 @@ void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 		quarantine_reduce();
 
 	if (unlikely(ptr == NULL))
-		return;
+		return NULL;
 
 	page = virt_to_page(ptr);
 	redzone_start = round_up((unsigned long)(ptr + size),
@@ -574,21 +576,23 @@ void kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
 	kasan_unpoison_shadow(ptr, size);
 	kasan_poison_shadow((void *)redzone_start, redzone_end - redzone_start,
 		KASAN_PAGE_REDZONE);
+
+	return (void *)ptr;
 }
 
-void kasan_krealloc(const void *object, size_t size, gfp_t flags)
+void *kasan_krealloc(const void *object, size_t size, gfp_t flags)
 {
 	struct page *page;
 
 	if (unlikely(object == ZERO_SIZE_PTR))
-		return;
+		return ZERO_SIZE_PTR;
 
 	page = virt_to_head_page(object);
 
 	if (unlikely(!PageSlab(page)))
-		kasan_kmalloc_large(object, size, flags);
+		return kasan_kmalloc_large(object, size, flags);
 	else
-		kasan_kmalloc(page->slab_cache, object, size, flags);
+		return kasan_kmalloc(page->slab_cache, object, size, flags);
 }
 
 void kasan_poison_kfree(void *ptr, unsigned long ip)
diff --git a/mm/slab.c b/mm/slab.c
index aa76a70e087e..6fdca9ec2ea4 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3551,7 +3551,7 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
 {
 	void *ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	kasan_slab_alloc(cachep, ret, flags);
+	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc(_RET_IP_, ret,
 			       cachep->object_size, cachep->size, flags);
 
@@ -3617,7 +3617,7 @@ kmem_cache_alloc_trace(struct kmem_cache *cachep, gfp_t flags, size_t size)
 
 	ret = slab_alloc(cachep, flags, _RET_IP_);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(_RET_IP_, ret,
 		      size, cachep->size, flags);
 	return ret;
@@ -3641,7 +3641,7 @@ void *kmem_cache_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid)
 {
 	void *ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	kasan_slab_alloc(cachep, ret, flags);
+	ret = kasan_slab_alloc(cachep, ret, flags);
 	trace_kmem_cache_alloc_node(_RET_IP_, ret,
 				    cachep->object_size, cachep->size,
 				    flags, nodeid);
@@ -3660,7 +3660,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *cachep,
 
 	ret = slab_alloc_node(cachep, flags, nodeid, _RET_IP_);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, cachep->size,
 			   flags, nodeid);
@@ -3679,7 +3679,7 @@ __do_kmalloc_node(size_t size, gfp_t flags, int node, unsigned long caller)
 	if (unlikely(ZERO_OR_NULL_PTR(cachep)))
 		return cachep;
 	ret = kmem_cache_alloc_node_trace(cachep, flags, node, size);
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 
 	return ret;
 }
@@ -3715,7 +3715,7 @@ static __always_inline void *__do_kmalloc(size_t size, gfp_t flags,
 		return cachep;
 	ret = slab_alloc(cachep, flags, caller);
 
-	kasan_kmalloc(cachep, ret, size, flags);
+	ret = kasan_kmalloc(cachep, ret, size, flags);
 	trace_kmalloc(caller, ret,
 		      size, cachep->size, flags);
 
diff --git a/mm/slab.h b/mm/slab.h
index 68bdf498da3b..15ef6a0d9c16 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -441,7 +441,7 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
 
 		kmemleak_alloc_recursive(object, s->object_size, 1,
 					 s->flags, flags);
-		kasan_slab_alloc(s, object, flags);
+		p[i] = kasan_slab_alloc(s, object, flags);
 	}
 
 	if (memcg_kmem_enabled())
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 2296caf87bfb..a99a1feb52c4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1183,7 +1183,7 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
 	page = alloc_pages(flags, order);
 	ret = page ? page_address(page) : NULL;
 	kmemleak_alloc(ret, size, 1, flags);
-	kasan_kmalloc_large(ret, size, flags);
+	ret = kasan_kmalloc_large(ret, size, flags);
 	return ret;
 }
 EXPORT_SYMBOL(kmalloc_order);
@@ -1461,7 +1461,7 @@ static __always_inline void *__do_krealloc(const void *p, size_t new_size,
 		ks = ksize(p);
 
 	if (ks >= new_size) {
-		kasan_krealloc((void *)p, new_size, flags);
+		p = kasan_krealloc((void *)p, new_size, flags);
 		return (void *)p;
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index 51258eff4178..382bc0fea498 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1336,10 +1336,10 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
  * Hooks for other subsystems that check memory allocations. In a typical
  * production configuration these hooks all should produce no code at all.
  */
-static inline void kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
+static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
 {
 	kmemleak_alloc(ptr, size, 1, flags);
-	kasan_kmalloc_large(ptr, size, flags);
+	return kasan_kmalloc_large(ptr, size, flags);
 }
 
 static __always_inline void kfree_hook(void *x)
@@ -2732,7 +2732,7 @@ void *kmem_cache_alloc_trace(struct kmem_cache *s, gfp_t gfpflags, size_t size)
 {
 	void *ret = slab_alloc(s, gfpflags, _RET_IP_);
 	trace_kmalloc(_RET_IP_, ret, size, s->size, gfpflags);
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_trace);
@@ -2760,7 +2760,7 @@ void *kmem_cache_alloc_node_trace(struct kmem_cache *s,
 	trace_kmalloc_node(_RET_IP_, ret,
 			   size, s->size, gfpflags, node);
 
-	kasan_kmalloc(s, ret, size, gfpflags);
+	ret = kasan_kmalloc(s, ret, size, gfpflags);
 	return ret;
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_trace);
@@ -3750,7 +3750,7 @@ void *__kmalloc(size_t size, gfp_t flags)
 
 	trace_kmalloc(_RET_IP_, ret, size, s->size, flags);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
@@ -3767,8 +3767,7 @@ static void *kmalloc_large_node(size_t size, gfp_t flags, int node)
 	if (page)
 		ptr = page_address(page);
 
-	kmalloc_large_node_hook(ptr, size, flags);
-	return ptr;
+	return kmalloc_large_node_hook(ptr, size, flags);
 }
 
 void *__kmalloc_node(size_t size, gfp_t flags, int node)
@@ -3795,7 +3794,7 @@ void *__kmalloc_node(size_t size, gfp_t flags, int node)
 
 	trace_kmalloc_node(_RET_IP_, ret, size, s->size, flags, node);
 
-	kasan_kmalloc(s, ret, size, flags);
+	ret = kasan_kmalloc(s, ret, size, flags);
 
 	return ret;
 }
-- 
2.18.0.597.ga71716f1ad-goog
