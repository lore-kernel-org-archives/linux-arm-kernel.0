From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Sep 2015 13:50:17 +0100
Subject: [PATCH 08/10] arm64: mm: kill mm_cpumask usage
In-Reply-To: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
References: <1442494219-6133-1-git-send-email-will.deacon@arm.com>
Message-ID: <1442494219-6133-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mm_cpumask isn't actually used for anything on arm64, so remove all the
code trying to keep it up-to-date.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/smp.c | 7 -------
 arch/arm64/mm/context.c | 2 --
 2 files changed, 9 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index fdd4d4dbd64f..03b0aa28ea61 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -142,7 +142,6 @@ asmlinkage void secondary_start_kernel(void)
 	 */
 	atomic_inc(&mm->mm_count);
 	current->active_mm = mm;
-	cpumask_set_cpu(cpu, mm_cpumask(mm));
 
 	set_my_cpu_offset(per_cpu_offset(smp_processor_id()));
 	printk("CPU%u: Booted secondary processor\n", cpu);
@@ -233,12 +232,6 @@ int __cpu_disable(void)
 	 * OK - migrate IRQs away from this CPU
 	 */
 	migrate_irqs();
-
-	/*
-	 * Remove this CPU from the vm mask set of all processes.
-	 */
-	clear_tasks_mm_cpumask(cpu);
-
 	return 0;
 }
 
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 4b9ec4484e3f..f636a2639f03 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -132,7 +132,6 @@ set_asid:
 
 bump_gen:
 	asid |= generation;
-	cpumask_clear(mm_cpumask(mm));
 	return asid;
 }
 
@@ -169,7 +168,6 @@ void check_and_switch_context(struct mm_struct *mm, unsigned int cpu)
 	raw_spin_unlock_irqrestore(&cpu_asid_lock, flags);
 
 switch_mm_fastpath:
-	cpumask_set_cpu(cpu, mm_cpumask(mm));
 	cpu_switch_mm(mm->pgd, mm);
 }
 
-- 
2.1.4
