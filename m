From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 May 2010 15:30:21 +0100
Subject: [PATCH 4/4] ARM: Defer the L_PTE_EXEC flag setting to
	update_mmu_cache() on SMP
In-Reply-To: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
References: <20100520142715.22202.33516.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100520143021.22202.52811.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SMP systems, there is a small chance of a PTE becoming visible to a
different CPU before the cache maintenance operations in
update_mmu_cache(). This patch clears the L_PTE_EXEC bit in set_pte_at()
but sets it later in update_mmu_cache() if vm_flags & VM_EXEC.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable.h |   12 ++++++++++++
 arch/arm/mm/fault-armv.c       |   17 ++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ab68cf1..c50691f 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -278,9 +278,21 @@ extern struct page *empty_zero_page;
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
+#ifndef CONFIG_SMP
 #define set_pte_at(mm,addr,ptep,pteval) do { \
 	set_pte_ext(ptep, pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
  } while (0)
+#else
+/*
+ * The L_PTE_EXEC attribute is later be set in update_mmu_cache() to avoid a
+ * race with SMP systems executing from the new mapping before the cache
+ * flushing took place.
+ */
+#define set_pte_at(mm,addr,ptep,pteval) do { \
+	set_pte_ext(ptep, __pte(pte_val(pteval) & ~L_PTE_EXEC), \
+		    (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
+ } while (0)
+#endif
 
 /*
  * The following only work if pte_present() is true.
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 91a691f..f2b2fa4 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -170,11 +170,18 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
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
 
