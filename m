From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sat, 24 Mar 2012 14:28:31 +0400
Subject: [PATCH 03/10] powerpc: Use clear_tasks_mm_cpumask()
In-Reply-To: <20120324102609.GA28356@lizard>
References: <20120324102609.GA28356@lizard>
Message-ID: <20120324102831.GC29067@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current CPU hotplug code has some task->mm handling issues:

1. Working with task->mm w/o getting mm or grabing the task lock is
   dangerous as ->mm might disappear (exit_mm() assigns NULL under
   task_lock(), so tasklist lock is not enough).

   We can't use get_task_mm()/mmput() pair as mmput() might sleep,
   so we must take the task lock while handle its mm.

2. Checking for process->mm is not enough because process' main
   thread may exit or detach its mm via use_mm(), but other threads
   may still have a valid mm.

   To fix this we would need to use find_lock_task_mm(), which would
   walk up all threads and returns an appropriate task (with task
   lock held).

clear_tasks_mm_cpumask() has all the issues fixed, so let's use it.

Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/powerpc/mm/mmu_context_nohash.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index 5b63bd3..e779642 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -333,9 +333,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 					    unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned int)(long)hcpu;
-#ifdef CONFIG_HOTPLUG_CPU
-	struct task_struct *p;
-#endif
+
 	/* We don't touch CPU 0 map, it's allocated at aboot and kept
 	 * around forever
 	 */
@@ -358,12 +356,7 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 		stale_map[cpu] = NULL;
 
 		/* We also clear the cpu_vm_mask bits of CPUs going away */
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			if (p->mm)
-				cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
-		}
-		read_unlock(&tasklist_lock);
+		clear_tasks_mm_cpumask(cpu);
 	break;
 #endif /* CONFIG_HOTPLUG_CPU */
 	}
-- 
1.7.9.2
