From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Jun 2013 11:54:45 +0100
Subject: [PATCH 1/2] ARM: mm: don't flush icache in switch_mm with hardware
 broadcasting
Message-ID: <1370516086-16653-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When scheduling an mm on a CPU where it hasn't previously been used, we
flush the icache on that CPU so that any code loaded previously on
a different core can be safely executed.

For cores with hardware broadcasting of cache maintenance operations,
this is clearly unnecessary, since the inner-shareable invalidation in
__sync_icache_dcache will affect all CPUs.

This patch conditionalises the icache flush in switch_mm based on
cache_ops_need_broadcast().

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Albin Tonnerre <albin.tonnerre@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/mmu_context.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index a7b85e0..2a45c33 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -18,6 +18,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cachetype.h>
 #include <asm/proc-fns.h>
+#include <asm/smp_plat.h>
 #include <asm-generic/mm_hooks.h>
 
 void __check_vmalloc_seq(struct mm_struct *mm);
@@ -98,12 +99,16 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #ifdef CONFIG_MMU
 	unsigned int cpu = smp_processor_id();
 
-#ifdef CONFIG_SMP
-	/* check for possible thread migration */
-	if (!cpumask_empty(mm_cpumask(next)) &&
+	/*
+	 * __sync_icache_dcache doesn't broadcast the I-cache invalidation,
+	 * so check for possible thread migration and invalidate the I-cache
+	 * if we're new to this CPU.
+	 */
+	if (cache_ops_need_broadcast() &&
+	    !cpumask_empty(mm_cpumask(next)) &&
 	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
 		__flush_icache_all();
-#endif
+
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next) {
 		check_and_switch_context(next, tsk);
 		if (cache_is_vivt())
-- 
1.8.2.2
