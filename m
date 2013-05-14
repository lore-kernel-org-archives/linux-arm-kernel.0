From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:48:52 +0100
Subject: [PATCH 2/7] ARM: nommu: define dummy TLB operations for nommu
 configurations
In-Reply-To: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
References: <1368532137-8871-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368532137-8871-3-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

nommu platforms do not perform address translation and therefore clearly
don't have TLBs. However, some SMP code assumes the presence of the TLB
flushing routines and will therefore fail to compile for a nommu system.

This patch defines dummy local_* TLB operations and #defines
tlb_ops_need_broadcast() as 0, therefore causing the usual ARM SMP TLB
operations to call the local variants instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/include/asm/smp_plat.h |    4 ++++
 arch/arm/include/asm/tlbflush.h |   23 ++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index aaa61b6..1c7b6f8 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -26,6 +26,9 @@ static inline bool is_smp(void)
 }
 
 /* all SMP configurations have the extended CPUID registers */
+#ifndef CONFIG_MMU
+#define tlb_ops_need_broadcast()	0
+#else
 static inline int tlb_ops_need_broadcast(void)
 {
 	if (!is_smp())
@@ -33,6 +36,7 @@ static inline int tlb_ops_need_broadcast(void)
 
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
 }
+#endif
 
 #if !defined(CONFIG_SMP) || __LINUX_ARM_ARCH__ >= 7
 #define cache_ops_need_broadcast()	0
diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index a3625d1..cc8517e 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -537,6 +537,27 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
 
 #endif
 
-#endif /* CONFIG_MMU */
+#elif defined(CONFIG_SMP)	/* !CONFIG_MMU */
+
+#ifndef __ASSEMBLY__
+
+#include <linux/mm_types.h>
+
+static inline void local_flush_tlb_all(void)									{ }
+static inline void local_flush_tlb_mm(struct mm_struct *mm)							{ }
+static inline void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr)			{ }
+static inline void local_flush_tlb_kernel_page(unsigned long kaddr)						{ }
+static inline void local_flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)	{ }
+static inline void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)				{ }
+
+extern void flush_tlb_all(void);
+extern void flush_tlb_mm(struct mm_struct *mm);
+extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long uaddr);
+extern void flush_tlb_kernel_page(unsigned long kaddr);
+extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end);
+extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+#endif	/* __ASSEMBLY__ */
+
+#endif
 
 #endif
-- 
1.7.9.5
