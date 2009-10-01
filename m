From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Thu,  1 Oct 2009 23:34:18 +0200
Subject: [PATCH] "Best-effort" FCSE: Handle shared mappings.
In-Reply-To: <1254432860-11511-8-git-send-email-gilles.chanteperdrix@xenomai.org>
References: <1254432860-11511-1-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-2-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-3-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-4-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-5-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-6-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-7-git-send-email-gilles.chanteperdrix@xenomai.org>
	<1254432860-11511-8-git-send-email-gilles.chanteperdrix@xenomai.org>
Message-ID: <1254432860-11511-9-git-send-email-gilles.chanteperdrix@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Account for writable shared mappings, so as to be able to flush cache
when switching out a process with such a mapping.

This accounting is done by adding the L_PTE_SHARED flag to page
belonging to such mappings in make_coherent(), then, set_pte_at() is
intercepted to account for both addition and removal of pages with
this flag set.

Note that using the L_PTE_SHARED flag makes the FCSE patch
incompatible with ARMv6+ and Xscale3, but the FCSE feature is
deprecated in ARMv6 anyway.

Signed-off-by: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
---
 arch/arm/include/asm/mmu.h         |    3 ++
 arch/arm/include/asm/mmu_context.h |    6 ++++
 arch/arm/include/asm/pgtable.h     |   42 ++++++++++++++++++++++++--
 arch/arm/kernel/fcse.c             |    3 +-
 arch/arm/mm/fault-armv.c           |   55 +++++++++++++++++++++++++++++++++++-
 5 files changed, 103 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 7472598..9a2fb51 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -10,6 +10,9 @@ typedef struct {
 #ifdef CONFIG_ARM_FCSE
 	unsigned long pid;
 	cpumask_t cpu_tlb_mask;
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	unsigned shared_dirty_pages;
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 #endif /* CONFIG_ARM_FCSE */
 	unsigned int kvm_seq;
 } mm_context_t;
diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index ad1bbb4..035a9f2 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -76,6 +76,9 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 	int pid;
 
 	cpus_clear(mm->context.cpu_tlb_mask);
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	mm->context.shared_dirty_pages = 0;
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 
 	pid = fcse_pid_alloc();
 	if (pid < 0)
@@ -91,6 +94,9 @@ init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 static inline void destroy_context(struct mm_struct *mm)
 {
 #ifdef CONFIG_ARM_FCSE
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+	BUG_ON(mm->context.shared_dirty_pages);
+#endif /* CONFIG_ARM_FCSE_BEST_EFFORT */
 	fcse_pid_free(mm->context.pid >> FCSE_PID_SHIFT);
 #endif /* CONFIG_ARM_FCSE */
 }
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 197c596..7775c1b 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -250,6 +250,33 @@ extern pgprot_t		pgprot_kernel;
 #define __S111  __PAGE_SHARED_EXEC
 
 #ifndef __ASSEMBLY__
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+#define fcse_account_page_removal(mm, addr, val) do {		\
+	struct mm_struct *_mm = (mm);				\
+	unsigned long _addr = (addr);				\
+	unsigned long _val = (val);				\
+	if (pte_present(_val) && ((_val) & L_PTE_SHARED))	\
+		--_mm->context.shared_dirty_pages;		\
+} while (0)
+
+#define fcse_account_page_addition(mm, addr, val) ({			\
+	struct mm_struct *_mm = (mm);					\
+	unsigned long _addr = (addr);					\
+	unsigned long _val = (val);					\
+	if (pte_present(_val) && (_val & L_PTE_SHARED)) {		\
+		if ((_val & (PTE_CACHEABLE | L_PTE_WRITE | L_PTE_DIRTY)) \
+		    != (PTE_CACHEABLE | L_PTE_WRITE | L_PTE_DIRTY))	\
+			_val &= ~L_PTE_SHARED;				\
+		else							\
+			++_mm->context.shared_dirty_pages;		\
+	}								\
+	_val;								\
+})
+#else /* CONFIG_ARM_FCSE_GUARANTEED || !CONFIG_ARM_FCSE */
+#define fcse_account_page_removal(mm, addr, val) do { } while (0)
+#define fcse_account_page_addition(mm, addr, val) (val)
+#endif /* CONFIG_ARM_FCSE_GUARANTEED || !CONFIG_ARM_FCSE */
+
 /*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
@@ -261,7 +288,10 @@ extern struct page *empty_zero_page;
 #define pfn_pte(pfn,prot)	(__pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot)))
 
 #define pte_none(pte)		(!pte_val(pte))
-#define pte_clear(mm,addr,ptep)	set_pte_ext(ptep, __pte(0), 0)
+#define pte_clear(mm,addr,ptep)	do {				\
+	fcse_account_page_removal(mm, addr, pte_val(*ptep));	\
+	set_pte_ext(ptep, __pte(0), 0);				\
+} while (0)
 #define pte_page(pte)		(pfn_to_page(pte_pfn(pte)))
 #define pte_offset_kernel(dir,addr)	(pmd_page_vaddr(*(dir)) + __pte_index(addr))
 
@@ -280,9 +310,13 @@ extern struct page *empty_zero_page;
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
-#define set_pte_at(mm,addr,ptep,pteval) do { \
-	set_pte_ext(ptep, pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
- } while (0)
+#define set_pte_at(mm,addr,ptep,pteval) do {				\
+	unsigned long _pteval = (pteval);				\
+	fcse_account_page_removal(mm, addr, pte_val(*ptep));		\
+	pte_val(_pteval) =						\
+		fcse_account_page_addition(mm, addr, pte_val(_pteval)); \
+	set_pte_ext(ptep, _pteval, (addr) >= TASK_SIZE ? 0 : PTE_EXT_NG); \
+} while (0)
 
 /*
  * The following only work if pte_present() is true.
diff --git a/arch/arm/kernel/fcse.c b/arch/arm/kernel/fcse.c
index 774717c..5b257c9 100644
--- a/arch/arm/kernel/fcse.c
+++ b/arch/arm/kernel/fcse.c
@@ -118,7 +118,8 @@ int fcse_needs_flush(struct mm_struct *prev, struct mm_struct *next)
 	__set_bit(pid, fcse_pids_cache_dirty);
 	spin_unlock_irqrestore(&fcse_lock, flags);
 
-	res = reused_pid;
+	res = reused_pid
+		|| prev->context.shared_dirty_pages;
 
 	if (res) {
 		cpu_clear(smp_processor_id(), prev->cpu_vm_mask);
diff --git a/arch/arm/mm/fault-armv.c b/arch/arm/mm/fault-armv.c
index 40bccb9..3135a6b 100644
--- a/arch/arm/mm/fault-armv.c
+++ b/arch/arm/mm/fault-armv.c
@@ -25,6 +25,57 @@
 
 static unsigned long shared_pte_mask = L_PTE_MT_BUFFERABLE;
 
+#ifdef CONFIG_ARM_FCSE_BEST_EFFORT
+static void fcse_set_pte_shared(struct vm_area_struct *vma,
+				unsigned long address)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte, entry;
+
+	if (!(vma->vm_flags & VM_MAYSHARE) || address >= TASK_SIZE)
+		return;
+
+	pgd = pgd_offset(vma->vm_mm, address);
+	if (pgd_none(*pgd))
+		goto no_pgd;
+	if (pgd_bad(*pgd))
+		goto bad_pgd;
+
+	pmd = pmd_offset(pgd, address);
+	if (pmd_none(*pmd))
+		goto no_pmd;
+	if (pmd_bad(*pmd))
+		goto bad_pmd;
+
+	pte = pte_offset_map(pmd, address);
+	entry = *pte;
+
+	if ((pte_val(entry)
+	     & (L_PTE_PRESENT | PTE_CACHEABLE | L_PTE_WRITE | L_PTE_DIRTY))
+	    == (L_PTE_PRESENT | PTE_CACHEABLE | L_PTE_WRITE | L_PTE_DIRTY)) {
+		pte_val(entry) |= L_PTE_SHARED;
+		set_pte_at(vma->vm_mm, address, pte, entry);
+	}
+	pte_unmap(pte);
+	return;
+
+bad_pgd:
+	pgd_ERROR(*pgd);
+	pgd_clear(pgd);
+no_pgd:
+	return;
+
+bad_pmd:
+	pmd_ERROR(*pmd);
+	pmd_clear(pmd);
+no_pmd:
+	return;
+}
+#else /* !CONFIG_ARM_FCSE_BEST_EFFORT */
+#define fcse_set_pte_shared(vma, addr) do { } while (0)
+#endif /* !CONFIG_ARM_FCSE_BEST_EFFORT */
+
 /*
  * We take the easy way out of this problem - we make the
  * PTE uncacheable.  However, we leave the write buffer on.
@@ -126,8 +177,10 @@ make_coherent(struct address_space *mapping, struct vm_area_struct *vma, unsigne
 	flush_dcache_mmap_unlock(mapping);
 	if (aliases)
 		adjust_pte(vma, addr);
-	else
+	else {
+		fcse_set_pte_shared(vma, addr);
 		flush_cache_page(vma, addr, pfn);
+	}
 #else /* CONFIG_ARM_FCSE_GUARANTEED */
 	if (vma->vm_flags & VM_MAYSHARE)
 		adjust_pte(vma, addr);
-- 
1.5.6.5
