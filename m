From: gdavis@mvista.com (gdavis at mvista.com)
Date: Fri,  7 Oct 2011 12:26:36 -0400
Subject: [RFC/PATCH v3 3/7] ARM: ARM11 MPCore: {clean,
	flush}_pmd_entry are not preempt safe
In-Reply-To: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
References: <1317955121-28047-1-git-send-email-gdavis@mvista.com>
	<1318004800-6525-1-git-send-email-gdavis@mvista.com>
Message-ID: <1318004800-6525-4-git-send-email-gdavis@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: George G. Davis <gdavis@mvista.com>

If preemption and subsequent task migration occurs during calls to
{clean,flush}_pmd_entry on ARM11 MPCore machines, global memory state
can become inconsistent.  To prevent inconsistent memory state on
these machines, disable preemption in callers of these functions around
PMD modifications and subsequent {clean,flush}_pmd_entry calls.

Signed-off-by: George G. Davis <gdavis@mvista.com>
---
 arch/arm/include/asm/pgalloc.h  |    4 ++++
 arch/arm/include/asm/pgtable.h  |    9 +++++++++
 arch/arm/include/asm/smp_plat.h |    2 ++
 arch/arm/mm/idmap.c             |    5 +++++
 arch/arm/mm/ioremap.c           |    9 +++++++++
 arch/arm/mm/mmu.c               |   12 ++++++++++++
 6 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 92d3f27..ba8cf6a 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -122,9 +122,13 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
 	unsigned long prot)
 {
 	unsigned long pmdval = (pte + PTE_HWTABLE_OFF) | prot;
+	if (cache_ops_need_broadcast())
+		preempt_disable();
 	pmdp[0] = __pmd(pmdval);
 	pmdp[1] = __pmd(pmdval + 256 * sizeof(pte_t));
 	flush_pmd_entry(pmdp);
+	if (cache_ops_need_broadcast())
+		preempt_enable();
 }
 
 /*
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 5750704..00068dc 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -13,6 +13,7 @@
 #include <linux/const.h>
 #include <asm-generic/4level-fixup.h>
 #include <asm/proc-fns.h>
+#include <asm/smp_plat.h>
 
 #ifndef CONFIG_MMU
 
@@ -313,16 +314,24 @@ extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 
 #define copy_pmd(pmdpd,pmdps)		\
 	do {				\
+		if (cache_ops_need_broadcast())	\
+			preempt_disable();	\
 		pmdpd[0] = pmdps[0];	\
 		pmdpd[1] = pmdps[1];	\
 		flush_pmd_entry(pmdpd);	\
+		if (cache_ops_need_broadcast())	\
+			preempt_enable();	\
 	} while (0)
 
 #define pmd_clear(pmdp)			\
 	do {				\
+		if (cache_ops_need_broadcast())	\
+			preempt_disable();	\
 		pmdp[0] = __pmd(0);	\
 		pmdp[1] = __pmd(0);	\
 		clean_pmd_entry(pmdp);	\
+		if (cache_ops_need_broadcast())	\
+			preempt_enable();	\
 	} while (0)
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index f24c1b9..5a8d3df 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -5,6 +5,7 @@
 #ifndef __ASMARM_SMP_PLAT_H
 #define __ASMARM_SMP_PLAT_H
 
+#ifndef	__ASSEMBLY__
 #include <asm/cputype.h>
 
 /*
@@ -42,5 +43,6 @@ static inline int cache_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 #endif
+#endif
 
 #endif
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2be9139..c04face 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -3,17 +3,22 @@
 #include <asm/cputype.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
+#include <asm/smp_plat.h>
 
 static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
 	unsigned long prot)
 {
 	pmd_t *pmd = pmd_offset(pud, addr);
 
+	if (cache_ops_need_broadcast())
+		preempt_disable();
 	addr = (addr & PMD_MASK) | prot;
 	pmd[0] = __pmd(addr);
 	addr += SECTION_SIZE;
 	pmd[1] = __pmd(addr);
 	flush_pmd_entry(pmd);
+	if (cache_ops_need_broadcast())
+		preempt_enable();
 }
 
 static void idmap_add_pud(pgd_t *pgd, unsigned long addr, unsigned long end,
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index ab50627..b56d78a 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -32,6 +32,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/sizes.h>
+#include <asm/smp_plat.h>
 
 #include <asm/mach/map.h>
 #include "mm.h"
@@ -135,11 +136,15 @@ remap_area_sections(unsigned long virt, unsigned long pfn,
 	do {
 		pmd_t *pmd = pmd_offset(pgd, addr);
 
+		if (cache_ops_need_broadcast())
+			preempt_disable();
 		pmd[0] = __pmd(__pfn_to_phys(pfn) | type->prot_sect);
 		pfn += SZ_1M >> PAGE_SHIFT;
 		pmd[1] = __pmd(__pfn_to_phys(pfn) | type->prot_sect);
 		pfn += SZ_1M >> PAGE_SHIFT;
 		flush_pmd_entry(pmd);
+		if (cache_ops_need_broadcast())
+			preempt_enable();
 
 		addr += PGDIR_SIZE;
 		pgd++;
@@ -172,9 +177,13 @@ remap_area_supersections(unsigned long virt, unsigned long pfn,
 		for (i = 0; i < 8; i++) {
 			pmd_t *pmd = pmd_offset(pgd, addr);
 
+			if (cache_ops_need_broadcast())
+				preempt_disable();
 			pmd[0] = __pmd(super_pmd_val);
 			pmd[1] = __pmd(super_pmd_val);
 			flush_pmd_entry(pmd);
+			if (cache_ops_need_broadcast())
+				preempt_enable();
 
 			addr += PGDIR_SIZE;
 			pgd++;
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 594d677..3c8253f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -567,12 +567,24 @@ static void __init alloc_init_section(pud_t *pud, unsigned long addr,
 		if (addr & SECTION_SIZE)
 			pmd++;
 
+		if (cache_ops_need_broadcast())
+			preempt_disable();
 		do {
 			*pmd = __pmd(phys | type->prot_sect);
 			phys += SECTION_SIZE;
 		} while (pmd++, addr += SECTION_SIZE, addr != end);
 
+		/* FIXME: Multiple PMD entries may be written above
+		 * but only one cache line, up to 8 PMDs depending
+		 * on the alignment of this mapping, is flushed below.
+		 * IFF this mapping spans >8MiB, then only the first
+		 * 8MiB worth of entries will be flushed.  Entries
+		 * above the 8MiB limit will not be flushed if I
+		 * read this correctly.
+		 */
 		flush_pmd_entry(p);
+		if (cache_ops_need_broadcast())
+			preempt_enable();
 	} else {
 		/*
 		 * No need to loop; pte's aren't interested in the
-- 
1.7.4.4
