From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:08 +0400
Subject: [RFC/PATCH RESEND -next 14/21] mm: slub: kasan: disable kasan when
 touching unaccessible memory
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-15-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some code in slub could validly touch memory marked by kasan as unaccessible.
Even though slub.c doesn't instrumented, functions called in it are instrumented,
so to avoid false positive reports such places are protected by
kasan_disable_local()/kasan_enable_local() calls.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 mm/slub.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6ddedf9..c8dbea7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -560,8 +560,10 @@ static void print_tracking(struct kmem_cache *s, void *object)
 	if (!(s->flags & SLAB_STORE_USER))
 		return;
 
+	kasan_disable_local();
 	print_track("Allocated", get_track(s, object, TRACK_ALLOC));
 	print_track("Freed", get_track(s, object, TRACK_FREE));
+	kasan_enable_local();
 }
 
 static void print_page_info(struct page *page)
@@ -604,6 +606,8 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 	unsigned int off;	/* Offset of last byte */
 	u8 *addr = page_address(page);
 
+	kasan_disable_local();
+
 	print_tracking(s, p);
 
 	print_page_info(page);
@@ -632,6 +636,8 @@ static void print_trailer(struct kmem_cache *s, struct page *page, u8 *p)
 		/* Beginning of the filler is the free pointer */
 		print_section("Padding ", p + off, s->size - off);
 
+	kasan_enable_local();
+
 	dump_stack();
 }
 
@@ -1012,6 +1018,8 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 					struct page *page,
 					void *object, unsigned long addr)
 {
+
+	kasan_disable_local();
 	if (!check_slab(s, page))
 		goto bad;
 
@@ -1028,6 +1036,7 @@ static noinline int alloc_debug_processing(struct kmem_cache *s,
 		set_track(s, object, TRACK_ALLOC, addr);
 	trace(s, page, object, 1);
 	init_object(s, object, SLUB_RED_ACTIVE);
+	kasan_enable_local();
 	return 1;
 
 bad:
@@ -1041,6 +1050,7 @@ bad:
 		page->inuse = page->objects;
 		page->freelist = NULL;
 	}
+	kasan_enable_local();
 	return 0;
 }
 
@@ -1052,6 +1062,7 @@ static noinline struct kmem_cache_node *free_debug_processing(
 
 	spin_lock_irqsave(&n->list_lock, *flags);
 	slab_lock(page);
+	kasan_disable_local();
 
 	if (!check_slab(s, page))
 		goto fail;
@@ -1088,6 +1099,7 @@ static noinline struct kmem_cache_node *free_debug_processing(
 	trace(s, page, object, 0);
 	init_object(s, object, SLUB_RED_INACTIVE);
 out:
+	kasan_enable_local();
 	slab_unlock(page);
 	/*
 	 * Keep node_lock to preserve integrity
@@ -1096,6 +1108,7 @@ out:
 	return n;
 
 fail:
+	kasan_enable_local();
 	slab_unlock(page);
 	spin_unlock_irqrestore(&n->list_lock, *flags);
 	slab_fix(s, "Object at 0x%p not freed", object);
@@ -1371,8 +1384,11 @@ static void setup_object(struct kmem_cache *s, struct page *page,
 				void *object)
 {
 	setup_object_debug(s, page, object);
-	if (unlikely(s->ctor))
+	if (unlikely(s->ctor)) {
+		kasan_disable_local();
 		s->ctor(object);
+		kasan_enable_local();
+	}
 }
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
@@ -1425,11 +1441,12 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
 
 	if (kmem_cache_debug(s)) {
 		void *p;
-
+		kasan_disable_local();
 		slab_pad_check(s, page);
 		for_each_object(p, s, page_address(page),
 						page->objects)
 			check_object(s, page, p, SLUB_RED_INACTIVE);
+		kasan_enable_local();
 	}
 
 	kmemcheck_free_shadow(page, compound_order(page));
-- 
1.8.5.5
