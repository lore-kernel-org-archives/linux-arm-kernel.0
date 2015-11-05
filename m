From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Nov 2015 16:08:40 +0000
Subject: [PATCH] mm: slab: Only move management objects off-slab for
 sizes larger than KMALLOC_MIN_SIZE
In-Reply-To: <20151105053139.e38214a9.akpm@linux-foundation.org>
References: <20151105043155.GA20374@js1304-P5Q-DELUXE>
 <1446724235-31400-1-git-send-email-catalin.marinas@arm.com>
 <20151105053139.e38214a9.akpm@linux-foundation.org>
Message-ID: <20151105160839.GR7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 05, 2015 at 05:31:39AM -0800, Andrew Morton wrote:
> On Thu,  5 Nov 2015 11:50:35 +0000 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
> > Commit 8fc9cf420b36 ("slab: make more slab management structure off the
> > slab") enables off-slab management objects for sizes starting with
> > PAGE_SIZE >> 5. This means 128 bytes for a 4KB page configuration.
> > However, on systems with a KMALLOC_MIN_SIZE of 128 (arm64 in 4.4), such
> > optimisation does not make sense since the slab management allocation
> > would take 128 bytes anyway (even though freelist_size is 32) with the
> > additional overhead of another allocation.
> > 
> > This patch introduces an OFF_SLAB_MIN_SIZE macro which takes
> > KMALLOC_MIN_SIZE into account. It also solves a slab bug on arm64 where
> > the first kmalloc_cache to be initialised after slab_early_init = 0,
> > "kmalloc-128", fails to allocate off-slab management objects from the
> > same "kmalloc-128" cache.
> 
> That all seems to be quite minor stuff.

Apart from "it also solves a bug on arm64...". But I agree, the initial
commit log doesn't give any justification for cc stable.

> > Fixes: 8fc9cf420b36 ("slab: make more slab management structure off the slab")
> > Cc: <stable@vger.kernel.org> # 3.15+
> 
> Yet you believe the fix should be backported.
> 
> So, the usual refrain: when fixing a bug, please describe the end-user
> visible effects of that bug.

What about (unless you prefer this slightly more intrusive fix:
http://article.gmane.org/gmane.linux.ports.sh.devel/50303):

------------------8<--------------------------

>From fda8f306b6941f4ddbefcbcfaa59fedef4a679a3 Mon Sep 17 00:00:00 2001
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Thu, 5 Nov 2015 11:14:48 +0000
Subject: [PATCH] mm: slab: Only move management objects off-slab for sizes
 larger than KMALLOC_MIN_SIZE

On systems with a KMALLOC_MIN_SIZE of 128 (arm64, some mips and powerpc
configurations defining ARCH_DMA_MINALIGN to 128), the first
kmalloc_caches[] entry to be initialised after slab_early_init = 0 is
"kmalloc-128" with index 7. Depending on the debug kernel configuration,
sizeof(struct kmem_cache) can be larger than 128 resulting in an
INDEX_NODE of 8.

Commit 8fc9cf420b36 ("slab: make more slab management structure off the
slab") enables off-slab management objects for sizes starting with
PAGE_SIZE >> 5 (128 bytes for a 4KB page configuration) and the creation
of the "kmalloc-128" cache would try to place the management objects
off-slab. However, since KMALLOC_MIN_SIZE is already 128 and
freelist_size == 32 in __kmem_cache_create(),
kmalloc_slab(freelist_size) returns NULL (kmalloc_caches[7] not
populated yet). This triggers the following bug on arm64:

[    0.000000] kernel BUG at /work/Linux/linux-2.6-aarch64/mm/slab.c:2283!
[    0.000000] Internal error: Oops - BUG: 0 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.3.0-rc4+ #540
[    0.000000] Hardware name: Juno (DT)
[    0.000000] task: ffffffc0006962b0 ti: ffffffc00068c000 task.ti: ffffffc00068c000
[    0.000000] PC is at __kmem_cache_create+0x21c/0x280
[    0.000000] LR is at __kmem_cache_create+0x210/0x280
[...]
[    0.000000] Call trace:
[    0.000000] [<ffffffc000154948>] __kmem_cache_create+0x21c/0x280
[    0.000000] [<ffffffc000652da4>] create_boot_cache+0x48/0x80
[    0.000000] [<ffffffc000652e2c>] create_kmalloc_cache+0x50/0x88
[    0.000000] [<ffffffc000652f14>] create_kmalloc_caches+0x4c/0xf4
[    0.000000] [<ffffffc000654a9c>] kmem_cache_init+0x100/0x118
[    0.000000] [<ffffffc0006447d4>] start_kernel+0x214/0x33c

This patch introduces an OFF_SLAB_MIN_SIZE definition to avoid off-slab
management objects for sizes equal to or smaller than KMALLOC_MIN_SIZE.

Fixes: 8fc9cf420b36 ("slab: make more slab management structure off the slab")
Cc: <stable@vger.kernel.org> # 3.15+
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 mm/slab.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 4fcc5dd8d5a6..419b649b395e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -282,6 +282,7 @@ static void kmem_cache_node_init(struct kmem_cache_node *parent)
 
 #define CFLGS_OFF_SLAB		(0x80000000UL)
 #define	OFF_SLAB(x)	((x)->flags & CFLGS_OFF_SLAB)
+#define OFF_SLAB_MIN_SIZE	(max_t(size_t, PAGE_SIZE >> 5, KMALLOC_MIN_SIZE + 1))
 
 #define BATCHREFILL_LIMIT	16
 /*
@@ -2212,7 +2213,7 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 	 * it too early on. Always use on-slab management when
 	 * SLAB_NOLEAKTRACE to avoid recursive calls into kmemleak)
 	 */
-	if ((size >= (PAGE_SIZE >> 5)) && !slab_early_init &&
+	if (size >= OFF_SLAB_MIN_SIZE && !slab_early_init &&
 	    !(flags & SLAB_NOLEAKTRACE))
 		/*
 		 * Size is large, assume best to place the slab management obj
@@ -2276,7 +2277,7 @@ __kmem_cache_create (struct kmem_cache *cachep, unsigned long flags)
 		/*
 		 * This is a possibility for one of the kmalloc_{dma,}_caches.
 		 * But since we go off slab only for object size greater than
-		 * PAGE_SIZE/8, and kmalloc_{dma,}_caches get created
+		 * OFF_SLAB_MIN_SIZE, and kmalloc_{dma,}_caches get created
 		 * in ascending order,this should not happen at all.
 		 * But leave a BUG_ON for some lucky dude.
 		 */
