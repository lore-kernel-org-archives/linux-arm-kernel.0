From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu,  9 Aug 2018 21:21:00 +0200
Subject: [PATCH v5 08/18] khwasan: preassign tags to objects with ctors or
 SLAB_TYPESAFE_BY_RCU
In-Reply-To: <cover.1533842385.git.andreyknvl@google.com>
References: <cover.1533842385.git.andreyknvl@google.com>
Message-ID: <625d42d5cb7f20bb54ce7af2c4b87910b1474c74.1533842385.git.andreyknvl@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An object constructor can initialize pointers within this objects based on
the address of the object. Since the object address might be tagged, we
need to assign a tag before calling constructor.

The implemented approach is to assign tags to objects with constructors
when a slab is allocated and call constructors once as usual. The
downside is that such object would always have the same tag when it is
reallocated, so we won't catch use-after-frees on it.

Also pressign tags for objects from SLAB_TYPESAFE_BY_RCU caches, since
they can be validy accessed after having been freed.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab.c | 6 +++++-
 mm/slub.c | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/slab.c b/mm/slab.c
index 6fdca9ec2ea4..3b4227059f2e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -403,7 +403,11 @@ static inline struct kmem_cache *virt_to_cache(const void *obj)
 static inline void *index_to_obj(struct kmem_cache *cache, struct page *page,
 				 unsigned int idx)
 {
-	return page->s_mem + cache->size * idx;
+	void *obj;
+
+	obj = page->s_mem + cache->size * idx;
+	obj = khwasan_preset_slab_tag(cache, idx, obj);
+	return obj;
 }
 
 /*
diff --git a/mm/slub.c b/mm/slub.c
index 8fa21afcd3fb..a891bc49dc38 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1532,12 +1532,14 @@ static bool shuffle_freelist(struct kmem_cache *s, struct page *page)
 	/* First entry is used as the base of the freelist */
 	cur = next_freelist_entry(s, page, &pos, start, page_limit,
 				freelist_count);
+	cur = khwasan_preset_slub_tag(s, cur);
 	page->freelist = cur;
 
 	for (idx = 1; idx < page->objects; idx++) {
 		setup_object(s, page, cur);
 		next = next_freelist_entry(s, page, &pos, start, page_limit,
 			freelist_count);
+		next = khwasan_preset_slub_tag(s, next);
 		set_freepointer(s, cur, next);
 		cur = next;
 	}
@@ -1614,8 +1616,10 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	shuffle = shuffle_freelist(s, page);
 
 	if (!shuffle) {
+		start = khwasan_preset_slub_tag(s, start);
 		for_each_object_idx(p, idx, s, start, page->objects) {
 			setup_object(s, page, p);
+			p = khwasan_preset_slub_tag(s, p);
 			if (likely(idx < page->objects))
 				set_freepointer(s, p, p + s->size);
 			else
-- 
2.18.0.597.ga71716f1ad-goog
