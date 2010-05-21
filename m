From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 May 2010 10:52:21 +0100
Subject: [PATCH 0/4] Patches for -next
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5667016@dbde02.ent.ti.com>
Message-ID: <1274435541.11965.18.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Fri, 2010-05-21 at 06:59 +0100, Shilimkar, Santosh wrote:
> > Catalin Marinas (4):
> >       ARM: Remove the domain switching on ARMv6k/v7 CPUs
> >       ARM: Use lazy cache flushing on ARMv7 SMP systems
> >       ARM: Assume new page cache pages have dirty D-cache
> >       ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP
> >
> >
> I just gave quick try with these patches on OMAP4 yesterday.
> "ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP"
> patch is creating regression when loading the module.

Thanks for testing and reporting this. I missed the fact the modules
allocation uses set_pte_at(). Below is an updated patch which makes sure
that L_PTE_EXEC is set for addresses greater than TASK_SIZE. We
shouldn't have a race for modules as initialisation only happens on a
single CPU.

Could you please try the updated patch below?


ARM: Defer the L_PTE_EXEC flag setting to update_mmu_cache() on SMP

From: Catalin Marinas <catalin.marinas@arm.com>

On SMP systems, there is a small chance of a PTE becoming visible to a
different CPU before the cache maintenance operations in
update_mmu_cache(). This patch clears the L_PTE_EXEC bit in set_pte_at()
but sets it later in update_mmu_cache() if vm_flags & VM_EXEC.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable.h |   15 +++++++++++++++
 arch/arm/mm/fault-armv.c       |   17 ++++++++++++-----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 1139768..ee8cc13 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -278,9 +278,24 @@ extern struct page *empty_zero_page;
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
+#ifndef CONFIG_SMP
 #define set_pte_at(mm,addr,ptep,pteval) do { \
 	set_pte_ext(ptep, pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
  } while (0)
+#else
+/*
+ * The L_PTE_EXEC attribute is later set in update_mmu_cache() to avoid a
+ * race with SMP systems executing from the new mapping before the cache
+ * flushing took place.
+ */
+#define set_pte_at(mm,addr,ptep,pteval) do { \
+	if ((addr) >= TASK_SIZE) \
+		set_pte_ext(ptep, pteval, 0); \
+	else \
+		set_pte_ext(ptep, __pte(pte_val(pteval) & ~L_PTE_EXEC), \
+			    PTE_EXT_NG); \
+ } while (0)
+#endif
 
 /*
  * The following only work if pte_present() is true.
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index f9e9cbb..c01356d 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -172,11 +172,18 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 	mapping = page_mapping(page);
 	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
 		__flush_dcache_page(mapping, page);
-	if (mapping) {
-		if (cache_is_vivt())
-			make_coherent(mapping, vma, addr, ptep, pfn);
-		else if (vma->vm_flags & VM_EXEC)
-			__flush_icache_all();
+	if (!mapping)
+		return;
+
+	if (cache_is_vivt())
+		make_coherent(mapping, vma, addr, ptep, pfn);
+	else if (vma->vm_flags & VM_EXEC) {
+		__flush_icache_all();
+#ifdef CONFIG_SMP
+		set_pte_ext(ptep, __pte(pte_val(*ptep) | L_PTE_EXEC),
+			    addr >= TASK_SIZE ? 0 : PTE_EXT_NG);
+		flush_tlb_page(vma, addr);
+#endif
 	}
 }
 


-- 
Catalin
