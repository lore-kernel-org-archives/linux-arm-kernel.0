From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 18 Oct 2011 09:47:30 -0400
Subject: [RFC/PATCH v4 3/7] ARM: ARM11 MPCore: {clean,
	flush}_pmd_entry are not preempt safe
In-Reply-To: <1318945654-548-1-git-send-email-gdavis@mvista.com>
References: <1318004800-6525-1-git-send-email-gdavis@mvista.com>
	<1318945654-548-1-git-send-email-gdavis@mvista.com>
Message-ID: <1318945654-548-4-git-send-email-gdavis@mvista.com>
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
 4 files changed, 20 insertions(+), 0 deletions(-)

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
-- 
1.7.4.4
