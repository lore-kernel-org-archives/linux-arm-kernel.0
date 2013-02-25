From: will.deacon@arm.com (Will Deacon)
Date: Mon, 25 Feb 2013 15:21:28 +0000
Subject: [PATCH 2/2] ARM: mm: perform explicit branch predictor maintenance
 when required
In-Reply-To: <1361805688-8886-1-git-send-email-will.deacon@arm.com>
References: <1361805688-8886-1-git-send-email-will.deacon@arm.com>
Message-ID: <1361805688-8886-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM ARM requires branch predictor maintenance if, for a given ASID,
the instructions at a specific virtual address appear to change.

>From the kernel's point of view, that means:

	- Changing the kernel's view of memory (e.g. switching to the
	  identity map)
	- ASID rollover (since ASIDs will be re-allocated to new tasks)

This patch adds explicit branch predictor maintenance when either of the
two conditions above are met.

Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/smp.c     | 1 +
 arch/arm/kernel/suspend.c | 1 +
 arch/arm/mm/context.c     | 4 +++-
 arch/arm/mm/idmap.c       | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 5f73f70..6f00f3c 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -285,6 +285,7 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	 * switch away from it before attempting any exclusive accesses.
 	 */
 	cpu_switch_mm(mm->pgd, mm);
+	local_flush_bp_all();
 	enter_lazy_tlb(mm, current);
 	local_flush_tlb_all();
 
diff --git a/arch/arm/kernel/suspend.c b/arch/arm/kernel/suspend.c
index 358bca3..c59c97e 100644
--- a/arch/arm/kernel/suspend.c
+++ b/arch/arm/kernel/suspend.c
@@ -68,6 +68,7 @@ int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 	ret = __cpu_suspend(arg, fn);
 	if (ret == 0) {
 		cpu_switch_mm(mm->pgd, mm);
+		local_flush_bp_all();
 		local_flush_tlb_all();
 	}
 
diff --git a/arch/arm/mm/context.c b/arch/arm/mm/context.c
index 44d4ee5..a5a4b2bc 100644
--- a/arch/arm/mm/context.c
+++ b/arch/arm/mm/context.c
@@ -212,8 +212,10 @@ void check_and_switch_context(struct mm_struct *mm, struct task_struct *tsk)
 		atomic64_set(&mm->context.id, asid);
 	}
 
-	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending))
+	if (cpumask_test_and_clear_cpu(cpu, &tlb_flush_pending)) {
+		local_flush_bp_all();
 		local_flush_tlb_all();
+	}
 
 	atomic64_set(&per_cpu(active_asids, cpu), asid);
 	cpumask_set_cpu(cpu, mm_cpumask(mm));
diff --git a/arch/arm/mm/idmap.c b/arch/arm/mm/idmap.c
index 2dffc01..5ee505c 100644
--- a/arch/arm/mm/idmap.c
+++ b/arch/arm/mm/idmap.c
@@ -141,6 +141,7 @@ void setup_mm_for_reboot(void)
 {
 	/* Switch to the identity mapping. */
 	cpu_switch_mm(idmap_pgd, &init_mm);
+	local_flush_bp_all();
 
 #ifdef CONFIG_CPU_HAS_ASID
 	/*
-- 
1.8.0
