From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Nov 2015 12:36:41 +0000
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <alpine.DEB.2.20.1511031724010.8178@east.gentwo.org>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
 <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
 <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
 <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511031724010.8178@east.gentwo.org>
Message-ID: <20151104123640.GK7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+ linux-mm)

On Tue, Nov 03, 2015 at 05:33:25PM -0600, Christoph Lameter wrote:
> On Tue, 3 Nov 2015, Catalin Marinas wrote:
> > (cc'ing Jonsoo and Christoph; summary: slab failure with L1_CACHE_BYTES
> > of 128 and sizeof(kmem_cache_node) of 152)
> 
> Hmmm... Yes that would mean use the 196 sized kmalloc array which is not a
> power of two slab. But the code looks fine to me.

I'm not entirely sure that gets used (or even created).
kmalloc_index(152) returns 8 (INDEX_NODE==8) since KMALLOC_MIN_SIZE==128
and the "kmalloc-node" cache size is 256.

> > If I revert commit 8fc9cf420b36 ("slab: make more slab management
> > structure off the slab") it works but I still need to figure out how
> > slab indices are calculated. The size_index[] array is overridden so
> > that 0..15 are 7 and 16..23 are 8. But the kmalloc_caches[7] has never
> > been populated, hence the BUG_ON. Another option may be to change
> > kmalloc_size and kmalloc_index to cope with KMALLOC_MIN_SIZE of 128.
> >
> > I'll do some more investigation tomorrow.
> 
> The commit allows off slab management for PAGE_SIZE >> 5 that is 128.

This means that the first kmalloc cache to be created, "kmalloc-128", is
off slab.

> After that commit kmem_cache_create would try to allocate an off slab
> management structure which is not available during early boot.
> But the slab_early_init is set which should prevent the use of an off slab
> management infrastructure in kmem_cache_create().
> 
> However, the failure in line 2283 shows that the OFF SLAB flag was
> mistakenly set anyways!!!! Something must havee cleared slab_early_init?

slab_early_init is cleared after "kmem_cache" and "kmalloc-node" caches
are successfully created. Following this, the minimum kmalloc allocation
goes off-slab when KMALLOC_MIN_SIZE == 128.

When trying to create "kmalloc-128" (via create_kmalloc_caches(),
slab_early_init is already 0), __kmem_cache_create() requires an
allocation of 32 bytes (freelist_size) which has index 7, hence exactly
the kmalloc_caches[7] we are trying to create.

The simplest option would be to make sure that off slab isn't allowed
for caches of KMALLOC_MIN_SIZE or smaller, with the drawback that not
only "kmalloc-128" but any other such caches will be on slab.

I think a better option would be to first check that there is a
kmalloc_caches[] entry for freelist_size before deciding to go off-slab.
See below:

-----8<------------------------------

>From ce27c5c6d156522ceaff20de8a7af281cf079b6f Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 4 Nov 2015 12:19:00 +0000
Subject: [PATCH] mm: slab: Avoid BUG when KMALLOC_MIN_SIZE == (PAGE_SIZE >> 5)

The slab allocator, following commit 8fc9cf420b36 ("slab: make more slab
management structure off the slab"), tries to place slab management
off-slab when the object size is PAGE_SIZE >> 5 or larger. On arm64 with
KMALLOC_MIN_SIZE = L1_CACHE_BYTES = 128, "kmalloc-128" is the smallest
cache to be created after slab_early_init = 0. The current
__kmem_cache_create() implementation aims to place the management
structure off-slab. However, the kmalloc_slab(freelist_size) has not
been populated yet, triggering a bug on !cachep->freelist_cache.

This patch addresses the problem by keeping the management structure
on-slab if the corresponding kmalloc_caches[] is not populated yet.

Fixes: 8fc9cf420b36 ("slab: make more slab management structure off the slab")
Cc: <stable@vger.kernel.org> # 3.15+
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/slab.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 4fcc5dd8d5a6..d4a21736eb5d 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2246,16 +2246,33 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 
 	if (flags & CFLGS_OFF_SLAB) {
 		/* really off slab. No need for manual alignment */
-		freelist_size = calculate_freelist_size(cachep->num, 0);
+		size_t off_freelist_size = calculate_freelist_size(cachep->num, 0);
+
+		cachep->freelist_cache = kmalloc_slab(off_freelist_size, 0u);
+		if (ZERO_OR_NULL_PTR(cachep->freelist_cache)) {
+			/*
+			 * We don't have kmalloc_caches[] populated for
+			 * off_freelist_size yet. This can happen during
+			 * create_kmalloc_caches() when KMALLOC_MIN_SIZE >=
+			 * (PAGE_SHIFT >> 5) and CFLGS_OFF_SLAB is set. Move
+			 * the cache on-slab.
+			 */
+			flags &= ~CFLGS_OFF_SLAB;
+			left_over = calculate_slab_order(cachep, size, cachep->align, flags);
+		} else {
+			freelist_size = off_freelist_size;
 
 #ifdef CONFIG_PAGE_POISONING
-		/* If we're going to use the generic kernel_map_pages()
-		 * poisoning, then it's going to smash the contents of
-		 * the redzone and userword anyhow, so switch them off.
-		 */
-		if (size % PAGE_SIZE == 0 && flags & SLAB_POISON)
-			flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
+			/*
+			 * If we're going to use the generic kernel_map_pages()
+			 * poisoning, then it's going to smash the contents of
+			 * the redzone and userword anyhow, so switch them off.
+			 */
+			if (size % PAGE_SIZE == 0 && flags & SLAB_POISON)
+				flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
 #endif
+		}
+
 	}
 
 	cachep->colour_off = cache_line_size();
@@ -2271,18 +2288,6 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 	cachep->size = size;
 	cachep->reciprocal_buffer_size = reciprocal_value(size);
 
-	if (flags & CFLGS_OFF_SLAB) {
-		cachep->freelist_cache = kmalloc_slab(freelist_size, 0u);
-		/*
-		 * This is a possibility for one of the kmalloc_{dma,}_caches.
-		 * But since we go off slab only for object size greater than
-		 * PAGE_SIZE/8, and kmalloc_{dma,}_caches get created
-		 * in ascending order,this should not happen at all.
-		 * But leave a BUG_ON for some lucky dude.
-		 */
-		BUG_ON(ZERO_OR_NULL_PTR(cachep->freelist_cache));
-	}
-
 	err = setup_cpu_cache(cachep, gfp);
 	if (err) {
 		__kmem_cache_shutdown(cachep);
