From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 02 Jun 2010 17:48:58 +0100
Subject: [PATCH v2 4/4] ARM: Synchronise the I and D caches via set_pte_at()
	on SMP systems
In-Reply-To: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
References: <20100602164459.17783.9741.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100602164858.17783.30961.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On SMP systems, there is a small chance of a PTE becoming visible to a
different CPU before the cache maintenance operations in
update_mmu_cache(). This patch follows the IA-64 and PowerPC approach of
synchronising the I and D caches via the set_pte_at() function. In this
case, there is no need for update_mmu_cache() to be implemented since
lazy cache flushing is already handled by the time this function is
called.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/pgtable.h  |   25 ++++++++++++++++++++++---
 arch/arm/include/asm/tlbflush.h |   10 +++++++++-
 arch/arm/mm/fault-armv.c        |    2 ++
 arch/arm/mm/flush.c             |   15 +++++++++++++++
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index ab68cf1..a3752f5 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -278,9 +278,24 @@ extern struct page *empty_zero_page;
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
-#define set_pte_at(mm,addr,ptep,pteval) do { \
-	set_pte_ext(ptep, pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
- } while (0)
+#ifndef CONFIG_SMP
+static inline void __sync_icache_dcache(pte_t pteval)
+{
+}
+#else
+extern void __sync_icache_dcache(pte_t pteval);
+#endif
+
+static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval)
+{
+	if (addr >= TASK_SIZE)
+		set_pte_ext(ptep, pteval, 0);
+	else {
+		__sync_icache_dcache(pteval);
+		set_pte_ext(ptep, pteval, PTE_EXT_NG);
+	}
+}
 
 /*
  * The following only work if pte_present() is true.
@@ -292,6 +307,10 @@ extern struct page *empty_zero_page;
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_special(pte)	(0)
 
+#define pte_present_exec_user(pte) \
+	((pte_val(pte) & (L_PTE_PRESENT | L_PTE_EXEC | L_PTE_USER)) == \
+	 (L_PTE_PRESENT | L_PTE_EXEC | L_PTE_USER))
+
 #define PTE_BIT_FUNC(fn,op) \
 static inline pte_t pte_##fn(pte_t pte) { pte_val(pte) op; return pte; }
 
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 40a7092..6aabedd 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -554,10 +554,18 @@ extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 /*
  * If PG_dcache_clean is not set for the page, we need to ensure that any
  * cache entries for the kernels virtual memory range are written
- * back to the page.
+ * back to the page. On SMP systems, the cache coherency is handled in the
+ * set_pte_at() function.
  */
+#ifndef CONFIG_SMP
 extern void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 	pte_t *ptep);
+#else
+static inline void update_mmu_cache(struct vm_area_struct *vma,
+				    unsigned long addr, pte_t *ptep)
+{
+}
+#endif
 
 #endif
 
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 91a691f..030f1da 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -28,6 +28,7 @@
 
 static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
+#ifndef CONFIG_SMP
 /*
  * We take the easy way out of this problem - we make the
  * PTE uncacheable.  However, we leave the write buffer on.
@@ -177,6 +178,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
 			__flush_icache_all();
 	}
 }
+#endif	/* !CONFIG_SMP */
 
 /*
  * Check whether the write buffer has physical address aliasing
diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 6f55e36..2d08a5e 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -212,6 +212,21 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 	flush_dcache_mmap_unlock(mapping);
 }
 
+#ifdef CONFIG_SMP
+void __sync_icache_dcache(pte_t pteval)
+{
+	unsigned long pfn = pte_pfn(pteval);
+
+	if (pfn_valid(pfn) && pte_present_exec_user(pteval)) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+			__flush_dcache_page(NULL, page);
+		__flush_icache_all();
+	}
+}
+#endif
+
 /*
  * Ensure cache coherency between kernel mapping and userspace mapping
  * of this page.
