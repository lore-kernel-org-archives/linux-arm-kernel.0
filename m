From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 16 Jun 2015 14:50:39 +0100
Subject: [PATCH 1/2] arm64: kernel: rename __cpu_suspend to keep it aligned
 with arm
In-Reply-To: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1434462640-19613-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames __cpu_suspend to cpu_suspend so that it's aligned
with ARM32. It also removes the redundant wrapper created.

This is preparation to implement generic PSCI system suspend using the
cpu_{suspend,resume} which now has the same interface on both ARM and
ARM64.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/include/asm/cpuidle.h | 8 ++------
 arch/arm64/include/asm/suspend.h | 2 +-
 arch/arm64/kernel/cpuidle.c      | 4 ++--
 arch/arm64/kernel/psci.c         | 2 +-
 arch/arm64/kernel/suspend.c      | 6 +++---
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpuidle.h
index 141b2fcabaa6..0f74f05d662a 100644
--- a/arch/arm64/include/asm/cpuidle.h
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -5,20 +5,16 @@
 
 #ifdef CONFIG_CPU_IDLE
 extern int arm_cpuidle_init(unsigned int cpu);
-extern int cpu_suspend(unsigned long arg);
+extern int arm_cpuidle_suspend(int index);
 #else
 static inline int arm_cpuidle_init(unsigned int cpu)
 {
 	return -EOPNOTSUPP;
 }
 
-static inline int cpu_suspend(unsigned long arg)
+static inline int arm_cpuidle_suspend(int index)
 {
 	return -EOPNOTSUPP;
 }
 #endif
-static inline int arm_cpuidle_suspend(int index)
-{
-	return cpu_suspend(index);
-}
 #endif
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 003802f58963..59a5b0f1e81c 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -21,6 +21,6 @@ struct sleep_save_sp {
 	phys_addr_t save_ptr_stash_phys;
 };
 
-extern int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
+extern int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));
 extern void cpu_resume(void);
 #endif
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index f8aa16973318..7ce589ca54a4 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -32,7 +32,7 @@ int arm_cpuidle_init(unsigned int cpu)
  * Return: 0 on success, -EOPNOTSUPP if CPU suspend hook not initialized, CPU
  * operations back-end error code otherwise.
  */
-int cpu_suspend(unsigned long arg)
+int arm_cpuidle_suspend(int index)
 {
 	int cpu = smp_processor_id();
 
@@ -42,5 +42,5 @@ int cpu_suspend(unsigned long arg)
 	 */
 	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
 		return -EOPNOTSUPP;
-	return cpu_ops[cpu]->cpu_suspend(arg);
+	return cpu_ops[cpu]->cpu_suspend(index);
 }
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index a0fc99a518b8..4be597228b14 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -203,7 +203,7 @@ static int __maybe_unused cpu_psci_cpu_suspend(unsigned long index)
 	if (!psci_power_state_loses_context(state[index - 1]))
 		ret = psci_ops.cpu_suspend(state[index - 1], 0);
 	else
-		ret = __cpu_suspend(index, psci_suspend_finisher);
+		ret = cpu_suspend(index, psci_suspend_finisher);
 
 	return ret;
 }
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
index d7daf45ae7a2..400e1265e205 100644
--- a/arch/arm64/kernel/suspend.c
+++ b/arch/arm64/kernel/suspend.c
@@ -51,13 +51,13 @@ void __init cpu_suspend_set_dbg_restorer(void (*hw_bp_restore)(void *))
 }
 
 /*
- * __cpu_suspend
+ * cpu_suspend
  *
  * arg: argument to pass to the finisher function
  * fn: finisher function pointer
  *
  */
-int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
+int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 {
 	struct mm_struct *mm = current->active_mm;
 	int ret;
@@ -82,7 +82,7 @@ int __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
 		 * We are resuming from reset with TTBR0_EL1 set to the
 		 * idmap to enable the MMU; restore the active_mm mappings in
 		 * TTBR0_EL1 unless the active_mm == &init_mm, in which case
-		 * the thread entered __cpu_suspend with TTBR0_EL1 set to
+		 * the thread entered cpu_suspend with TTBR0_EL1 set to
 		 * reserved TTBR0 page tables and should be restored as such.
 		 */
 		if (mm == &init_mm)
-- 
1.9.1
