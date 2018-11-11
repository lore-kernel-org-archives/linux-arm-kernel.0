From: drinkcat@chromium.org (Nicolas Boichat)
Date: Sun, 11 Nov 2018 17:03:39 +0800
Subject: [PATCH v2 1/3] mm: slab/slub: Add check_slab_flags function to check
 for valid flags
In-Reply-To: <20181111090341.120786-1-drinkcat@chromium.org>
References: <20181111090341.120786-1-drinkcat@chromium.org>
Message-ID: <20181111090341.120786-2-drinkcat@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicated code between slab and slub, and will make it
easier to make the test more complicated in the next commits.

Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
 mm/internal.h | 17 +++++++++++++++--
 mm/slab.c     |  8 +-------
 mm/slub.c     |  8 +-------
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3b1ec1412fd2cd..7a500b232e4a43 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -33,8 +33,22 @@
 /* Control allocation cpuset and node placement constraints */
 #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
 
-/* Do not use these with a slab allocator */
-#define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
+/* Check for flags that must not be used with a slab allocator */
+static inline gfp_t check_slab_flags(gfp_t flags)
+{
+	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
+
+	if (unlikely(flags & bug_mask)) {
+		gfp_t invalid_mask = flags & bug_mask;
+
+		flags &= ~bug_mask;
+		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
+				invalid_mask, &invalid_mask, flags, &flags);
+		dump_stack();
+	}
+
+	return flags;
+}
 
 void page_writeback_init(void);
 
diff --git a/mm/slab.c b/mm/slab.c
index 2a5654bb3b3ff3..251e09a5a3ef5c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2656,13 +2656,7 @@ static struct page *cache_grow_begin(struct kmem_cache *cachep,
 	 * Be lazy and only check for valid flags here,  keeping it out of the
 	 * critical path in kmem_cache_alloc().
 	 */
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = check_slab_flags(flags);
 	WARN_ON_ONCE(cachep->ctor && (flags & __GFP_ZERO));
 	local_flags = flags & (GFP_CONSTRAINT_MASK|GFP_RECLAIM_MASK);
 
diff --git a/mm/slub.c b/mm/slub.c
index e3629cd7aff164..1cca562bebdc8d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1681,13 +1681,7 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
-	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
-		gfp_t invalid_mask = flags & GFP_SLAB_BUG_MASK;
-		flags &= ~GFP_SLAB_BUG_MASK;
-		pr_warn("Unexpected gfp: %#x (%pGg). Fixing up to gfp: %#x (%pGg). Fix your code!\n",
-				invalid_mask, &invalid_mask, flags, &flags);
-		dump_stack();
-	}
+	flags = check_slab_flags(flags);
 
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-- 
2.19.1.930.g4563a0d9d0-goog
