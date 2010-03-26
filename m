From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 17:36:19 +0000
Subject: [PATCH 1/5] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <1269614982.807.80.camel@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151939.6353.7646.stgit@e102109-lin.cambridge.arm.com>
	<20100323213345.GH19572@n2100.arm.linux.org.uk>
	<1269614982.807.80.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1269624979.807.135.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-26 at 14:49 +0000, Catalin Marinas wrote:
> On Tue, 2010-03-23 at 21:33 +0000, Russell King - ARM Linux wrote:
> > On Mon, Mar 22, 2010 at 03:19:39PM +0000, Catalin Marinas wrote:
> > > ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> > > operations in hardware. This patch allows the
> > > flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
> > > similar to the UP case.
> >
> > Didn't Ben point out that there's a race with the lazy dcache flushing
> > on SMP platforms?
> 
> BTW, even with the current code we still have a similar race with the
> I-cache. set_pte_at() creates the entry that another CPU may execute
> from before we invalidate the I-cache in update_mmu_cache().
> 
> A solution would be that set_pte_at() sets the NX bit which is cleared
> later in udpate_mmu_cache() after the I-cache invalidation. Some care
> needs to be taken with possible prefetch aborts in the small window when
> the page isn't executable.
> 
> Note that even if we flush the caches in set_pte_at(), we still have the
> I-cache race unless we write the pte twice, first with NX and then
> without. So I'm more in favour of the solution in the previous
> paragraph.

And that's an attempt at this (not fully tested and it could be
optimised for the UP case). I can add more comments later if you find
this the right approach.


ARM: Do not set the exec flag in set_pte_at()

From: Catalin Marinas <catalin.marinas@arm.com>

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable.h |    3 ++-
 arch/arm/mm/fault-armv.c       |   15 ++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 6fae619..d6d06e7 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -279,7 +279,8 @@ extern struct page *empty_zero_page;
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
 #define set_pte_at(mm,addr,ptep,pteval) do { \
-	set_pte_ext(ptep, pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
+	set_pte_ext(ptep, __pte(pte_val(pteval) & ~L_PTE_EXEC), \
+		    (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
  } while (0)
 
 /*
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index c5ef5a7..ced1c70 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -167,11 +167,16 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 	if (test_and_clear_bit(PG_dcache_dirty, &page->flags))
 		__flush_dcache_page(mapping, page);
 #endif
-	if (mapping) {
-		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, pfn);
-		else if (vma->vm_flags & VM_EXEC)
-			__flush_icache_all();
+	if (!mapping)
+		return;
+
+	if (cache_is_vivt())
+		make_coherent(mapping, vma, addr, pfn);
+	else if (vma->vm_flags & VM_EXEC) {
+		__flush_icache_all();
+		set_pte_ext(ptep, __pte(pte_val(*ptep) | L_PTE_EXEC),
+			    addr >= TASK_SIZE ? 0 : PTE_EXT_NG);
+		flush_tlb_page(vma, addr);
 	}
 }
 

-- 
Catalin
