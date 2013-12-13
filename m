From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 19:05:45 +0000
Subject: [RFC PATCH 5/6] arm: mm: HugeTLB support for non-LPAE systems
In-Reply-To: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
References: <1386961546-10061-1-git-send-email-steve.capper@linaro.org>
Message-ID: <1386961546-10061-6-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Bill Carson's HugeTLB patch, with the big difference being
in the way PTEs are stored. Rather than store a "Linux Huge PTE"
separately; we operate directly on the huge pte (which is actually
a pmd), by providing analogue huge pte manipulation functions.
Also rather than consider 16M supersections, we focus solely on
2x1M sections.

As we work directly with the pmd and need to store information that
doesn't directly correspond to hardware bits (such as the accessed
flag and dirty bit); we re-purporse the domain bits of the short
section descriptor. In order to use these domain bits for storage,
we need to make ourselves a client for all 16 domains and this is
done in head.S.

Storing extra information in the domain bits also makes it a lot
easier to implement Transparent Huge Pages, and some of the code in
pgtable-2level.h is arranged to facilitate THP support in a later
patch.

Non-LPAE HugeTLB pages are incompatible with the huge page migration
code (enabled when CONFIG_MEMORY_FAILURE is selected) as that code
dereferences PTEs directly, rather than calling huge_ptep_get and
set_huge_pte_at.

Signed-off-by: Steve Capper <steve.capper@linaro.org>
---
 arch/arm/Kconfig                      |   2 +-
 arch/arm/include/asm/hugetlb-2level.h | 121 ++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hugetlb-3level.h |   6 ++
 arch/arm/include/asm/hugetlb.h        |  10 ++-
 arch/arm/include/asm/pgtable-2level.h | 103 +++++++++++++++++++++++++++--
 arch/arm/include/asm/pgtable-3level.h |   5 ++
 arch/arm/include/asm/pgtable.h        |   1 +
 arch/arm/kernel/head.S                |  10 ++-
 arch/arm/mm/fault.c                   |  13 ----
 arch/arm/mm/fsr-2level.c              |   4 +-
 arch/arm/mm/hugetlbpage.c             |   2 +-
 11 files changed, 248 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7e..2eeee73 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1784,7 +1784,7 @@ config HW_PERF_EVENTS
 
 config SYS_SUPPORTS_HUGETLBFS
        def_bool y
-       depends on ARM_LPAE
+       depends on ARM_LPAE || (!CPU_USE_DOMAINS && !MEMORY_FAILURE)
 
 config HAVE_ARCH_TRANSPARENT_HUGEPAGE
        def_bool y
diff --git a/arch/arm/include/asm/hugetlb-2level.h b/arch/arm/include/asm/hugetlb-2level.h
new file mode 100644
index 0000000..38f89bd
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb-2level.h
@@ -0,0 +1,121 @@
+/*
+ * arch/arm/include/asm/hugetlb-2level.h
+ *
+ * Copyright (C) 2013 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _ASM_ARM_HUGETLB_2LEVEL_H
+#define _ASM_ARM_HUGETLB_2LEVEL_H
+
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	return *ptep;
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	set_pmd_at(mm, addr, (pmd_t *) ptep, __pmd(pte_val(pte)));
+}
+
+static inline pte_t pte_mkhuge(pte_t pte) { return pte; }
+
+static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
+					 unsigned long addr, pte_t *ptep)
+{
+	pmd_t *pmdp = (pmd_t *)ptep;
+	pmd_clear(pmdp);
+	flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	pmd_t *pmdp = (pmd_t *) ptep;
+	set_pmd_at(mm, addr, pmdp, pmd_wrprotect(*pmdp));
+}
+
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	pmd_t *pmdp = (pmd_t *)ptep;
+	pte_t pte = huge_ptep_get(ptep);
+	pmd_clear(pmdp);
+
+	return pte;
+}
+
+static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+					     unsigned long addr, pte_t *ptep,
+					     pte_t pte, int dirty)
+{
+	int changed = !pte_same(huge_ptep_get(ptep), pte);
+	if (changed) {
+		set_huge_pte_at(vma->vm_mm, addr, ptep, pte);
+		flush_tlb_range(vma, addr, addr + HPAGE_SIZE);
+	}
+
+	return changed;
+}
+
+static inline pte_t huge_pte_mkwrite(pte_t pte)
+{
+	pmd_t pmd = __pmd(pte_val(pte));
+	pmd = pmd_mkwrite(pmd);
+	return __pte(pmd_val(pmd));
+}
+
+static inline pte_t huge_pte_mkdirty(pte_t pte)
+{
+	pmd_t pmd = __pmd(pte_val(pte));
+	pmd = pmd_mkdirty(pmd);
+	return __pte(pmd_val(pmd));
+}
+
+static inline unsigned long huge_pte_dirty(pte_t pte)
+{
+	return pmd_dirty(__pmd(pte_val(pte)));
+}
+
+static inline unsigned long huge_pte_write(pte_t pte)
+{
+	return pmd_write(__pmd(pte_val(pte)));
+}
+
+static inline void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+				  pte_t *ptep)
+{
+	pmd_t *pmdp = (pmd_t *)ptep;
+	pmd_clear(pmdp);
+}
+
+static inline pte_t mk_huge_pte(struct page *page, pgprot_t pgprot)
+{
+	pmd_t pmd = mk_pmd(page,pgprot);
+	return __pte(pmd_val(pmd));
+}
+
+static inline pte_t huge_pte_modify(pte_t pte, pgprot_t newprot)
+{
+	pmd_t pmd = pmd_modify(__pmd(pte_val(pte)), newprot);
+	return __pte(pmd_val(pmd));
+}
+
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	pmd_t pmd = pmd_wrprotect(__pmd(pte_val(pte)));
+	return __pte(pmd_val(pmd));
+}
+
+#endif /* _ASM_ARM_HUGETLB_2LEVEL_H */
diff --git a/arch/arm/include/asm/hugetlb-3level.h b/arch/arm/include/asm/hugetlb-3level.h
index d4014fb..c633119 100644
--- a/arch/arm/include/asm/hugetlb-3level.h
+++ b/arch/arm/include/asm/hugetlb-3level.h
@@ -22,6 +22,7 @@
 #ifndef _ASM_ARM_HUGETLB_3LEVEL_H
 #define _ASM_ARM_HUGETLB_3LEVEL_H
 
+#include <asm-generic/hugetlb.h>
 
 /*
  * If our huge pte is non-zero then mark the valid bit.
@@ -68,4 +69,9 @@ static inline int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 }
 
+static inline pte_t huge_pte_wrprotect(pte_t pte)
+{
+	return pte_wrprotect(pte);
+}
+
 #endif /* _ASM_ARM_HUGETLB_3LEVEL_H */
diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 1f1b1cd..1d7f7b7 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -23,9 +23,12 @@
 #define _ASM_ARM_HUGETLB_H
 
 #include <asm/page.h>
-#include <asm-generic/hugetlb.h>
 
+#ifdef CONFIG_ARM_LPAE
 #include <asm/hugetlb-3level.h>
+#else
+#include <asm/hugetlb-2level.h>
+#endif
 
 static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 					  unsigned long addr, unsigned long end,
@@ -62,11 +65,6 @@ static inline int huge_pte_none(pte_t pte)
 	return pte_none(pte);
 }
 
-static inline pte_t huge_pte_wrprotect(pte_t pte)
-{
-	return pte_wrprotect(pte);
-}
-
 static inline int arch_prepare_hugepage(struct page *page)
 {
 	return 0;
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 86a659a..95ed36e 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -155,12 +155,26 @@
 #define pud_clear(pudp)		do { } while (0)
 #define set_pud(pud,pudp)	do { } while (0)
 
+static inline int pmd_large(pmd_t pmd)
+{
+	if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_FAULT)
+		return pmd_val(pmd);
+
+	return ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_SECT);
+}
+
+static inline int pte_huge(pte_t pte)
+{
+	pmd_t pmd = __pmd(pte_val(pte));
+	return pmd_large(pmd);
+}
+
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 {
 	return (pmd_t *)pud;
 }
 
-#define pmd_bad(pmd)		(pmd_val(pmd) & 2)
+#define pmd_bad(pmd) ((pmd_val(pmd) & PMD_TYPE_MASK) != PMD_TYPE_TABLE)
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
@@ -182,11 +196,90 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
 /*
- * We don't have huge page support for short descriptors, for the moment
- * define empty stubs for use by pin_page_for_write.
+ * now follows some of the definitions to allow huge page support, we can't put
+ * these in the hugetlb source files as they are also required for transparent
+ * hugepage support.
  */
-#define pmd_hugewillfault(pmd)	(0)
-#define pmd_thp_or_huge(pmd)	(0)
+
+#define HPAGE_SHIFT             PMD_SHIFT
+#define HPAGE_SIZE              (_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
+
+/*
+ *  We re-purpose the following domain bits in the section descriptor
+ */
+#define PMD_DSECT_DIRTY		(_AT(pmdval_t, 1) << 5)
+#define PMD_DSECT_AF		(_AT(pmdval_t, 1) << 6)
+
+#define PMD_BIT_FUNC(fn,op) \
+static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
+
+static inline unsigned long pmd_pfn(pmd_t pmd)
+{
+	/*
+	 * for a section, we need to mask off more of the pmd
+	 * before looking up the pfn.
+	 */
+	if (pmd_large(pmd))
+		return __phys_to_pfn(pmd_val(pmd) & HPAGE_MASK);
+	else
+		return __phys_to_pfn(pmd_val(pmd) & PHYS_MASK);
+}
+
+#define huge_pte_page(pte)	(pfn_to_page((pte_val(pte) & HPAGE_MASK) >> PAGE_SHIFT))
+#define huge_pte_present(pte)	(1)
+
+extern pgprot_t get_huge_pgprot(pgprot_t newprot);
+
+#define pfn_pmd(pfn,prot) __pmd(__pfn_to_phys(pfn) | pgprot_val(prot));
+#define mk_pmd(page,prot) pfn_pmd(page_to_pfn(page),get_huge_pgprot(prot));
+
+PMD_BIT_FUNC(mkdirty, |= PMD_DSECT_DIRTY);
+PMD_BIT_FUNC(mkwrite, |= PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(wrprotect,	&= ~PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(mknexec,	|= PMD_SECT_XN);
+PMD_BIT_FUNC(rmprotnone, |= PMD_TYPE_SECT);
+
+#define pmd_young(pmd)			(pmd_val(pmd) & PMD_DSECT_AF)
+#define pmd_write(pmd)			(pmd_val(pmd) & PMD_SECT_AP_WRITE)
+#define pmd_exec(pmd)			(!(pmd_val(pmd) & PMD_SECT_XN))
+#define pmd_dirty(pmd)			(pmd_val(pmd) & PMD_DSECT_DIRTY)
+
+#define pmd_hugewillfault(pmd)		(!pmd_young(pmd) || !pmd_write(pmd))
+#define pmd_thp_or_huge(pmd)		(pmd_large(pmd))
+
+#define __HAVE_ARCH_PMD_WRITE
+
+extern void __sync_icache_dcache(unsigned long pfn, int exec);
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd)
+{
+	VM_BUG_ON((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE);
+
+	if (!pmd_val(pmd)) {
+		pmdp[0] = pmdp[1] = __pmd(pmd);
+	} else {
+		pmdp[0] = __pmd(pmd_val(pmd));
+		pmdp[1] = __pmd(pmd_val(pmd) + SECTION_SIZE);
+
+		__sync_icache_dcache(pmd_pfn(pmd), pmd_exec(pmd));
+	}
+
+	flush_pmd_entry(pmdp);
+}
+
+static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
+{
+	pgprot_t hugeprot = get_huge_pgprot(newprot);
+	const pmdval_t mask = PMD_SECT_XN | PMD_SECT_AP_WRITE |
+				PMD_TYPE_SECT;
+
+	pmd_val(pmd) = (pmd_val(pmd) & ~mask) | (pgprot_val(hugeprot) & mask);
+
+	return pmd;
+}
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm/include/asm/pgtable-3level.h b/arch/arm/include/asm/pgtable-3level.h
index 4f95039..520a875 100644
--- a/arch/arm/include/asm/pgtable-3level.h
+++ b/arch/arm/include/asm/pgtable-3level.h
@@ -155,6 +155,11 @@
 		flush_pmd_entry(pudp);	\
 	} while (0)
 
+static inline int pmd_large(pmd_t pmd)
+{
+	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+}
+
 static inline pmd_t *pud_page_vaddr(pud_t pud)
 {
 	return __va(pud_val(pud) & PHYS_MASK & (s32)PAGE_MASK);
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 1ffe488..9bd4046 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -220,6 +220,7 @@ static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 #define pte_dirty(pte)		(pte_val(pte) & L_PTE_DIRTY)
 #define pte_young(pte)		(pte_val(pte) & L_PTE_YOUNG)
 #define pte_exec(pte)		(!(pte_val(pte) & L_PTE_XN))
+#define pte_protnone(pte)	(pte_val(pte) & L_PTE_NONE)
 #define pte_special(pte)	(0)
 
 #define pte_present_user(pte)  (pte_present(pte) && (pte_val(pte) & L_PTE_USER))
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 11d59b3..d625624 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -433,13 +433,21 @@ __enable_mmu:
 	bic	r0, r0, #CR_I
 #endif
 #ifndef CONFIG_ARM_LPAE
+#ifndef	CONFIG_SYS_SUPPORTS_HUGETLBFS
 	mov	r5, #(domain_val(DOMAIN_USER, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_KERNEL, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_TABLE, DOMAIN_MANAGER) | \
 		      domain_val(DOMAIN_IO, DOMAIN_CLIENT))
+#else
+	@ set ourselves as the client in all domains
+	@ this allows us to then use the 4 domain bits in the
+	@ section descriptors in our transparent huge pages
+	ldr	r5, =0x55555555
+#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
+
 	mcr	p15, 0, r5, c3, c0, 0		@ load domain access register
 	mcr	p15, 0, r4, c2, c0, 0		@ load page table pointer
-#endif
+#endif /* CONFIG_ARM_LPAE */
 	b	__turn_mmu_on
 ENDPROC(__enable_mmu)
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index eb8830a..faae9bd 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -491,19 +491,6 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 #endif					/* CONFIG_MMU */
 
 /*
- * Some section permission faults need to be handled gracefully.
- * They can happen due to a __{get,put}_user during an oops.
- */
-#ifndef CONFIG_ARM_LPAE
-static int
-do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-{
-	do_bad_area(addr, fsr, regs);
-	return 0;
-}
-#endif /* CONFIG_ARM_LPAE */
-
-/*
  * This abort handler always returns "fault".
  */
 static int
diff --git a/arch/arm/mm/fsr-2level.c b/arch/arm/mm/fsr-2level.c
index 18ca74c..c1a2afc 100644
--- a/arch/arm/mm/fsr-2level.c
+++ b/arch/arm/mm/fsr-2level.c
@@ -16,7 +16,7 @@ static struct fsr_info fsr_info[] = {
 	{ do_bad,		SIGBUS,	 0,		"external abort on non-linefetch"  },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"page domain fault"		   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
-	{ do_sect_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
+	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"page permission fault"		   },
 	/*
@@ -56,7 +56,7 @@ static struct fsr_info ifsr_info[] = {
 	{ do_bad,		SIGBUS,  0,		"unknown 10"			   },
 	{ do_bad,		SIGSEGV, SEGV_ACCERR,	"page domain fault"		   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
-	{ do_sect_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
+	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"section permission fault"	   },
 	{ do_bad,		SIGBUS,	 0,		"external abort on translation"	   },
 	{ do_page_fault,	SIGSEGV, SEGV_ACCERR,	"page permission fault"		   },
 	{ do_bad,		SIGBUS,  0,		"unknown 16"			   },
diff --git a/arch/arm/mm/hugetlbpage.c b/arch/arm/mm/hugetlbpage.c
index 54ee616..ca898c6 100644
--- a/arch/arm/mm/hugetlbpage.c
+++ b/arch/arm/mm/hugetlbpage.c
@@ -54,7 +54,7 @@ int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr, pte_t *ptep)
 
 int pmd_huge(pmd_t pmd)
 {
-	return pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT);
+	return pmd_large(pmd);
 }
 
 int pmd_huge_support(void)
-- 
1.8.1.4
