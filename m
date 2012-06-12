From: gdavis@mvista.com (gdavis at mvista.com)
Date: Tue, 12 Jun 2012 16:40:14 -0400
Subject: [RFC/PATCH v5 3/7] ARM: ARM11 MPCore: Make {clean,
 flush}_pmd_entry preempt safe
In-Reply-To: <1339533618-15969-1-git-send-email-gdavis@mvista.com>
References: <1318945654-548-1-git-send-email-gdavis@mvista.com>
 <1339533618-15969-1-git-send-email-gdavis@mvista.com>
Message-ID: <1339533618-15969-4-git-send-email-gdavis@mvista.com>
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
 arch/arm/include/asm/pgalloc.h        |    4 ++++
 arch/arm/include/asm/pgtable-2level.h |    8 ++++++++
 arch/arm/include/asm/pgtable.h        |    1 +
 arch/arm/include/asm/smp_plat.h       |    2 ++
 arch/arm/mm/idmap.c                   |    4 ++++
 5 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index c290b42..0dc9a81 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -144,11 +144,15 @@ static inline void __pmd_populate(pmd_t *pmdp, phys_addr_t pte,
 				  pmdval_t prot)
 {
 	pmdval_t pmdval = (pte + PTE_HWTABLE_OFF) | prot;
+	if (cache_ops_need_broadcast())
+		preempt_disable();
 	pmdp[0] = __pmd(pmdval);
 #ifndef CONFIG_ARM_LPAE
 	pmdp[1] = __pmd(pmdval + 256 * sizeof(pte_t));
 #endif
 	flush_pmd_entry(pmdp);
+	if (cache_ops_need_broadcast())
+		preempt_enable();
 }
 
 /*
diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 2317a71..93ad948 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -162,16 +162,24 @@ static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 
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
 
 /* we don't need complex calculations here as the pmd is folded into the pgd */
diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index f66626d..b511fcf 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -12,6 +12,7 @@
 
 #include <linux/const.h>
 #include <asm/proc-fns.h>
+#include <asm/smp_plat.h>
 
 #ifndef CONFIG_MMU
 
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index 558d6c8..bd419d5 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -5,6 +5,7 @@
 #ifndef __ASMARM_SMP_PLAT_H
 #define __ASMARM_SMP_PLAT_H
 
+#ifndef	__ASSEMBLY__
 #include <asm/cputype.h>
 
 /*
@@ -50,3 +51,4 @@ extern int __cpu_logical_map[];
 #define cpu_logical_map(cpu)	__cpu_logical_map[cpu]
 
 #endif
+#endif
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index ab88ed4..2846ce7 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -39,11 +39,15 @@ static void idmap_add_pmd(pud_t *pud, unsigned long addr, unsigned long end,
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
 #endif	/* CONFIG_ARM_LPAE */
 
-- 
1.7.4.4
