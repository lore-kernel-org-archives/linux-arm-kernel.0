From: cyril@ti.com (Cyril Chemparathy)
Date: Thu, 31 Jan 2013 16:58:25 -0500
Subject: [PATCH v4 06/13] ARM: LPAE: use 64-bit accessors for TTBR registers
In-Reply-To: <1359669512-31276-1-git-send-email-cyril@ti.com>
References: <1359669512-31276-1-git-send-email-cyril@ti.com>
Message-ID: <1359669512-31276-7-git-send-email-cyril@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds TTBR accessor macros, and modifies cpu_get_pgd() and
the LPAE version of cpu_set_reserved_ttbr0() to use these instead.

In the process, we also fix these functions to correctly handle cases
where the physical address lies beyond the 4G limit of 32-bit addressing.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/proc-fns.h |   22 +++++++++++++++++-----
 arch/arm/mm/context.c           |    9 ++-------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/proc-fns.h b/arch/arm/include/asm/proc-fns.h
index 75b5f14..1c3cf94 100644
--- a/arch/arm/include/asm/proc-fns.h
+++ b/arch/arm/include/asm/proc-fns.h
@@ -116,13 +116,25 @@ extern void cpu_resume(void);
 #define cpu_switch_mm(pgd,mm) cpu_do_switch_mm(virt_to_phys(pgd),mm)
 
 #ifdef CONFIG_ARM_LPAE
+
+#define cpu_get_ttbr(nr)					\
+	({							\
+		u64 ttbr;					\
+		__asm__("mrrc	p15, " #nr ", %Q0, %R0, c2"	\
+			: "=r" (ttbr));				\
+		ttbr;						\
+	})
+
+#define cpu_set_ttbr(nr, val)					\
+	do {							\
+		u64 ttbr = val;					\
+		__asm__("mcrr	p15, " #nr ", %Q0, %R0, c2"	\
+			: : "r" (ttbr));			\
+	} while (0)
+
 #define cpu_get_pgd()	\
 	({						\
-		unsigned long pg, pg2;			\
-		__asm__("mrrc	p15, 0, %0, %1, c2"	\
-			: "=r" (pg), "=r" (pg2)		\
-			:				\
-			: "cc");			\
+		u64 pg = cpu_get_ttbr(0);		\
 		pg &= ~(PTRS_PER_PGD*sizeof(pgd_t)-1);	\
 		(pgd_t *)phys_to_virt(pg);		\
 	})
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index bc4a5e9..7c17ff8 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -20,6 +20,7 @@
 #include <asm/smp_plat.h>
 #include <asm/thread_notify.h>
 #include <asm/tlbflush.h>
+#include <asm/proc-fns.h>
 
 /*
  * On ARMv6, we have the following structure in the Context ID:
@@ -52,17 +53,11 @@ static cpumask_t tlb_flush_pending;
 #ifdef CONFIG_ARM_LPAE
 static void cpu_set_reserved_ttbr0(void)
 {
-	unsigned long ttbl = __pa(swapper_pg_dir);
-	unsigned long ttbh = 0;
-
 	/*
 	 * Set TTBR0 to swapper_pg_dir which contains only global entries. The
 	 * ASID is set to 0.
 	 */
-	asm volatile(
-	"	mcrr	p15, 0, %0, %1, c2		@ set TTBR0\n"
-	:
-	: "r" (ttbl), "r" (ttbh));
+	cpu_set_ttbr(0, __pa(swapper_pg_dir));
 	isb();
 }
 #else
-- 
1.7.9.5
