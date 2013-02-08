From: steve.capper@arm.com (Steve Capper)
Date: Fri,  8 Feb 2013 15:01:21 +0000
Subject: [PATCH 4/6] ARM: mm: HugeTLB support for non-LPAE systems.
In-Reply-To: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
References: <1360335683-7755-1-git-send-email-steve.capper@arm.com>
Message-ID: <1360335683-7755-5-git-send-email-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on Bill Carson's HugeTLB patch, with the big difference being
in the way PTEs are passed back to the memory manager. Rather than
store a "Linux Huge PTE" separately; we make one up on the fly in
huge_ptep_get. Also rather than consider 16M supersections, we focus
solely on 2x1M sections.

To construct a huge PTE on the fly we need additional information
(such as the accessed flag and dirty bit) which we choose to store
in the domain bits of the short section descriptor. In order to use
these domain bits for storage, we need to make ourselves a client
for all 16 domains and this is done in head.S.

Storing extra information in the domain bits also makes it a lot
easier to implement Transparent Huge Pages, and some of the code in
pgtable-2level.h is arranged to facilitate THP support in a later
patch.

Non-LPAE HugeTLB pages are incompatible with the huge page migration
code (enabled when CONFIG_MEMORY_FAILURE is selected) as that code
dereferences PTEs directly, rather than calling huge_ptep_get and
set_huge_pte_at.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm/Kconfig                      |    2 +-
 arch/arm/include/asm/hugetlb-2level.h |  121 +++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hugetlb.h        |    4 ++
 arch/arm/include/asm/pgtable-2level.h |  102 +++++++++++++++++++++++++++
 arch/arm/include/asm/pgtable.h        |    2 +
 arch/arm/include/asm/tlb.h            |   10 ++-
 arch/arm/kernel/head.S                |   10 ++-
 arch/arm/mm/fault.c                   |   11 ---
 arch/arm/mm/fsr-2level.c              |    4 +-
 arch/arm/mm/mmu.c                     |   27 ++++++++
 10 files changed, 276 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm/include/asm/hugetlb-2level.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9a80544..077f5b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1780,7 +1780,7 @@ config HW_PERF_EVENTS
 
 config SYS_SUPPORTS_HUGETLBFS
        def_bool y
-       depends on ARM_LPAE
+       depends on ARM_LPAE || (!CPU_USE_DOMAINS && !MEMORY_FAILURE)
 
 source "mm/Kconfig"
 
diff --git a/arch/arm/include/asm/hugetlb-2level.h b/arch/arm/include/asm/hugetlb-2level.h
new file mode 100644
index 0000000..eb0e8b6
--- /dev/null
+++ b/arch/arm/include/asm/hugetlb-2level.h
@@ -0,0 +1,121 @@
+/*
+ * arch/arm/include/asm/hugetlb-2level.h
+ *
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * Based on arch/x86/include/asm/hugetlb.h and Bill Carson's patches
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_ARM_HUGETLB_2LEVEL_H
+#define _ASM_ARM_HUGETLB_2LEVEL_H
+
+
+static inline pte_t huge_ptep_get(pte_t *ptep)
+{
+	pmd_t pmd =  *((pmd_t *)ptep);
+	pte_t retval;
+
+	if (!pmd_val(pmd))
+		return __pte(0);
+
+	retval = __pte((pteval_t) (pmd_val(pmd) & HPAGE_MASK)
+			| arm_hugepteprotval);
+
+	if (pmd_exec(pmd))
+		retval = pte_mkexec(retval);
+	else
+		retval = pte_mknexec(retval);
+
+	if (pmd_young(pmd))
+		retval = pte_mkyoung(retval);
+	else
+		retval = pte_mkold(retval);
+
+	if (pmd_dirty(pmd))
+		retval = pte_mkdirty(retval);
+	else
+		retval = pte_mkclean(retval);
+
+	if (pmd_write(pmd))
+		retval = pte_mkwrite(retval);
+	else
+		retval = pte_wrprotect(retval);
+
+	return retval;
+}
+
+static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+				   pte_t *ptep, pte_t pte)
+{
+	pmdval_t pmdval = (pmdval_t) pte_val(pte);
+	pmd_t *pmdp = (pmd_t *) ptep;
+
+	/* take the target address bits from the pte only */
+	pmdval &= HPAGE_MASK;
+
+	/*
+	 * now use pmd_modify to translate the permission bits from the pte
+	 * and set the memory type information.
+	 */
+	pmdval = pmd_val(pmd_modify(__pmd(pmdval), __pgprot(pte_val(pte))));
+
+	__sync_icache_dcache(pte);
+
+	set_pmd_at(mm, addr, pmdp, __pmd(pmdval));
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
+#endif /* _ASM_ARM_HUGETLB_2LEVEL_H */
diff --git a/arch/arm/include/asm/hugetlb.h b/arch/arm/include/asm/hugetlb.h
index 7af9cf6..1e92975 100644
--- a/arch/arm/include/asm/hugetlb.h
+++ b/arch/arm/include/asm/hugetlb.h
@@ -24,7 +24,11 @@
 
 #include <asm/page.h>
 
+#ifdef CONFIG_ARM_LPAE
 #include <asm/hugetlb-3level.h>
+#else
+#include <asm/hugetlb-2level.h>
+#endif
 
 static inline void hugetlb_free_pgd_range(struct mmu_gather *tlb,
 					  unsigned long addr, unsigned long end,
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index f97ee02..d859613 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -181,6 +181,108 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
 #define set_pte_ext(ptep,pte,ext) cpu_set_pte_ext(ptep,pte,ext)
 
+
+#ifdef CONFIG_SYS_SUPPORTS_HUGETLBFS
+
+/*
+ * now follows some of the definitions to allow huge page support, we can't put
+ * these in the hugetlb source files as they are also required for transparent
+ * hugepage support.
+ */
+
+#define HPAGE_SHIFT             PMD_SHIFT
+#define HPAGE_SIZE              (_AC(1, UL) << HPAGE_SHIFT)
+#define HPAGE_MASK              (~(HPAGE_SIZE - 1))
+#define HUGETLB_PAGE_ORDER      (HPAGE_SHIFT - PAGE_SHIFT)
+
+#define HUGE_LINUX_PTE_COUNT       (PAGE_OFFSET >> HPAGE_SHIFT)
+#define HUGE_LINUX_PTE_SIZE        (HUGE_LINUX_PTE_COUNT * sizeof(pte_t *))
+#define HUGE_LINUX_PTE_INDEX(addr) (addr >> HPAGE_SHIFT)
+
+/*
+ *  We re-purpose the following domain bits in the section descriptor
+ */
+#define PMD_DOMAIN_MASK		(_AT(pmdval_t, 0xF) << 5)
+#define PMD_DSECT_DIRTY		(_AT(pmdval_t, 1) << 5)
+#define PMD_DSECT_AF		(_AT(pmdval_t, 1) << 6)
+
+#define PMD_BIT_FUNC(fn,op) \
+static inline pmd_t pmd_##fn(pmd_t pmd) { pmd_val(pmd) op; return pmd; }
+
+static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
+				pmd_t *pmdp, pmd_t pmd)
+{
+	/*
+	 * we can sometimes be passed a pmd pointing to a level 2 descriptor
+	 * from collapse_huge_page.
+	 */
+	if ((pmd_val(pmd) & PMD_TYPE_MASK) == PMD_TYPE_TABLE) {
+		pmdp[0] = __pmd(pmd_val(pmd));
+		pmdp[1] = __pmd(pmd_val(pmd) + 256 * sizeof(pte_t));
+	} else {
+		pmdp[0] = __pmd(pmd_val(pmd));			/* first 1M section  */
+		pmdp[1] = __pmd(pmd_val(pmd) + SECTION_SIZE);	/* second 1M section */
+	}
+
+	flush_pmd_entry(pmdp);
+}
+
+extern pmdval_t arm_hugepmdprotval;
+extern pteval_t arm_hugepteprotval;
+
+#define pmd_mkhuge(pmd)		(__pmd((pmd_val(pmd) & ~PMD_TYPE_MASK) | PMD_TYPE_SECT))
+
+PMD_BIT_FUNC(mkold, &= ~PMD_DSECT_AF);
+PMD_BIT_FUNC(mkdirty, |= PMD_DSECT_DIRTY);
+PMD_BIT_FUNC(mkclean, &= ~PMD_DSECT_DIRTY);
+PMD_BIT_FUNC(mkyoung, |= PMD_DSECT_AF);
+PMD_BIT_FUNC(mkwrite, |= PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(wrprotect,	&= ~PMD_SECT_AP_WRITE);
+PMD_BIT_FUNC(mknotpresent, &= ~PMD_TYPE_MASK);
+PMD_BIT_FUNC(mkexec,	&= ~PMD_SECT_XN);
+PMD_BIT_FUNC(mknexec,	|= PMD_SECT_XN);
+
+#define pmd_young(pmd)			(pmd_val(pmd) & PMD_DSECT_AF)
+#define pmd_write(pmd)			(pmd_val(pmd) & PMD_SECT_AP_WRITE)
+#define pmd_exec(pmd)			(!(pmd_val(pmd) & PMD_SECT_XN))
+#define pmd_dirty(pmd)			(pmd_val(pmd) & PMD_DSECT_DIRTY)
+
+#define __HAVE_ARCH_PMD_WRITE
+
+#define pmd_modify(pmd, prot)							\
+({										\
+	pmd_t pmdret = __pmd((pmd_val(pmd) & (PMD_MASK | PMD_DOMAIN_MASK)) 	\
+		| arm_hugepmdprotval);						\
+	pgprot_t inprot = prot;							\
+	pte_t newprot = __pte(pgprot_val(inprot));				\
+										\
+	if (pte_dirty(newprot))							\
+		pmdret = pmd_mkdirty(pmdret);					\
+	else									\
+		pmdret = pmd_mkclean(pmdret);					\
+										\
+	if (pte_exec(newprot))							\
+		pmdret = pmd_mkexec(pmdret);					\
+	else									\
+		pmdret = pmd_mknexec(pmdret);					\
+										\
+	if (pte_write(newprot))							\
+		pmdret = pmd_mkwrite(pmdret);					\
+	else									\
+		pmdret = pmd_wrprotect(pmdret);					\
+										\
+	if (pte_young(newprot))							\
+		pmdret = pmd_mkyoung(pmdret);					\
+	else									\
+		pmdret = pmd_mkold(pmdret);					\
+										\
+	pmdret;									\
+})
+
+#else
+#define HPAGE_SIZE 0
+#endif /* CONFIG_SYS_SUPPORTS_HUGETLBFS */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_PGTABLE_2LEVEL_H */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 9c82f98..4e7efc6 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -235,6 +235,8 @@ PTE_BIT_FUNC(mkclean,   &= ~L_PTE_DIRTY);
 PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
 PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
 PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
+PTE_BIT_FUNC(mkexec,	&= ~L_PTE_XN);
+PTE_BIT_FUNC(mknexec,	|= L_PTE_XN);
 
 static inline pte_t pte_mkspecial(pte_t pte) { return pte; }
 
diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index 99a1951..685e9e87 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -92,10 +92,16 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void tlb_add_flush(struct mmu_gather *tlb, unsigned long addr)
 {
 	if (!tlb->fullmm) {
+		unsigned long size = PAGE_SIZE;
+
 		if (addr < tlb->range_start)
 			tlb->range_start = addr;
-		if (addr + PAGE_SIZE > tlb->range_end)
-			tlb->range_end = addr + PAGE_SIZE;
+
+		if (tlb->vma && is_vm_hugetlb_page(tlb->vma))
+			size = HPAGE_SIZE;
+
+		if (addr + size > tlb->range_end)
+			tlb->range_end = addr + size;
 	}
 }
 
diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 486a15a..1378221 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -413,13 +413,21 @@ __enable_mmu:
 	mov	r5, #0
 	mcrr	p15, 0, r4, r5, c2		@ load TTBR0
 #else
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
index 5dbf13f..95d53f9 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -488,17 +488,6 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 #endif					/* CONFIG_MMU */
 
 /*
- * Some section permission faults need to be handled gracefully.
- * They can happen due to a __{get,put}_user during an oops.
- */
-static int
-do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
-{
-	do_bad_area(addr, fsr, regs);
-	return 0;
-}
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
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index ce328c7..74f1917 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -303,6 +303,21 @@ const struct mem_type *get_mem_type(unsigned int type)
 EXPORT_SYMBOL(get_mem_type);
 
 /*
+ * If the system supports huge pages and we are running with short descriptors,
+ * then compute the pmd and linux pte prot values for a huge page.
+ *
+ * These values are used by both the HugeTLB and THP code.
+ */
+#if defined(CONFIG_SYS_SUPPORTS_HUGETLBFS) && !defined(CONFIG_ARM_LPAE)
+pmdval_t arm_hugepmdprotval;
+EXPORT_SYMBOL(arm_hugepmdprotval);
+
+pteval_t arm_hugepteprotval;
+EXPORT_SYMBOL(arm_hugepteprotval);
+#endif
+
+
+/*
  * Adjust the PMD section entries according to the CPU in use.
  */
 static void __init build_mem_type_table(void)
@@ -526,6 +541,18 @@ static void __init build_mem_type_table(void)
 		if (t->prot_sect)
 			t->prot_sect |= PMD_DOMAIN(t->domain);
 	}
+
+#if defined(CONFIG_SYS_SUPPORTS_HUGETLBFS) && !defined(CONFIG_ARM_LPAE)
+	/*
+	 * we assume all huge pages are user pages and that hardware access
+	 * flag updates are disabled (i.e. SCTLR.AFE == 0b).
+	 */
+	arm_hugepteprotval = mem_types[MT_MEMORY].prot_pte | L_PTE_USER | L_PTE_VALID;
+
+	arm_hugepmdprotval = mem_types[MT_MEMORY].prot_sect | PMD_SECT_AP_READ
+				| PMD_SECT_nG;
+#endif
+
 }
 
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
-- 
1.7.9.5
