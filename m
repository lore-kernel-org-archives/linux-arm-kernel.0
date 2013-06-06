From: will.deacon@arm.com (Will Deacon)
Date: Thu,  6 Jun 2013 11:54:46 +0100
Subject: [PATCH 2/2] arm64: mm: don't bother invalidating the icache in
 switch_mm
In-Reply-To: <1370516086-16653-1-git-send-email-will.deacon@arm.com>
References: <1370516086-16653-1-git-send-email-will.deacon@arm.com>
Message-ID: <1370516086-16653-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't support software broadcast of cache maintenance operations, so
this flush is not required (__sync_icache_dcache will always affect all
CPUs).

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/mmu_context.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index e2bc385..a9eee33 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -151,12 +151,6 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	unsigned int cpu = smp_processor_id();
 
-#ifdef CONFIG_SMP
-	/* check for possible thread migration */
-	if (!cpumask_empty(mm_cpumask(next)) &&
-	    !cpumask_test_cpu(cpu, mm_cpumask(next)))
-		__flush_icache_all();
-#endif
 	if (!cpumask_test_and_set_cpu(cpu, mm_cpumask(next)) || prev != next)
 		check_and_switch_context(next, tsk);
 }
-- 
1.8.2.2
