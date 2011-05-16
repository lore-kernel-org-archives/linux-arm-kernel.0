From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 May 2011 12:58:50 +0100
Subject: [PATCH 1/2] ARM: remove unneeded check of the
	cache_is_vipt_nonaliasing()
In-Reply-To: <BANLkTi=cf47Axm1rXEa-gX7oK0h2aGq0nA@mail.gmail.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
	<BANLkTim=dmHg_vyfYN6m73z6SQXiVzM7vg@mail.gmail.com>
	<BANLkTikUphZ4azqK50YBZa4uTyU4EystLA@mail.gmail.com>
	<BANLkTikWJzdYOrk4=gte8zOHDVioGAOhhg@mail.gmail.com>
	<BANLkTimFst-+LEuN9cDpAtRiF4aDOipAKA@mail.gmail.com>
	<BANLkTi=cf47Axm1rXEa-gX7oK0h2aGq0nA@mail.gmail.com>
Message-ID: <1305547130.19230.42.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-05-16 at 11:00 +0100, saeed bishara wrote:
> BTW, there is something concerns me about ARM11MP core, this system
> doesn't support cache maintenance broadcasting, but when looking at
> do_cache_op(), it doesn't seem to flush the cache of other cpus, so if
> we have a multithreaded applications like java that uses self
> modifying code, how can you make sure that all cpus will have their I
> cache flushed when one cpu requests to do do_cache_op?

We don't :). If you are unlucky enough, your thread may migrate to
another CPU between the moment it wrote the data and the do_cache_op()
call so you'll miss the D-cache flushing.

I had a simple fix for a while, see below (I posted it in the past in a
slightly different form, maybe I should post it again).


ARM: Allow lazy cache flushing on ARM11MPCore

From: Catalin Marinas <catalin.marinas@arm.com>

The ARM11MPCore doesn't broadcast the cache maintenance operations in
hardware, therefore the flush_dcache_page() currently performs the cache
flushing non-lazily. But since not all drivers call this function after
writing to a page cache page, the kernel needs a different approach like
using read-for-ownership on the CPU flushing the cache to force the
dirty cache lines migration from other CPUs. This way the cache flushing
operation can be done lazily via __sync_icache_dcache().

Since we cannot force read-for-ownership on the I-cache, the patch
invalidates the whole I-cache when a thread migrates to another CPU.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/mmu_context.h |    3 ++-
 arch/arm/mm/cache-v6.S             |    4 ++++
 arch/arm/mm/flush.c                |    3 +--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index 71605d9..d116a23 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -114,7 +114,8 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #ifdef CONFIG_SMP
 	/* check for possible thread migration */
 	if (!cpumask_empty(mm_cpumask(next)) &&
-	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
+	    (cache_ops_need_broadcast() ||
+	     !cpumask_test_cpu(cpu, mm_cpumask(next))))
 		__flush_icache_all();
 #endif
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index c96fa1b..59bd8b94 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -177,6 +177,10 @@ ENDPROC(v6_coherent_kern_range)
 ENTRY(v6_flush_kern_dcache_area)
 	add	r1, r0, r1
 1:
+#ifdef CONFIG_SMP
+	/* no cache maintenance broadcasting on ARM11MPCore */
+	ldr	r2, [r0]			@ read for ownership
+#endif
 #ifdef HARVARD_CACHE
 	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
 #else
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 2b269c9..7c98287 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -290,8 +290,7 @@ void flush_dcache_page(struct page *page)
 
 	mapping = page_mapping(page);
 
-	if (!cache_ops_need_broadcast() &&
-	    mapping && !mapping_mapped(mapping))
+	if (mapping && !mapping_mapped(mapping))
 		clear_bit(PG_dcache_clean, &page->flags);
 	else {
 		__flush_dcache_page(mapping, page);


-- 
Catalin
