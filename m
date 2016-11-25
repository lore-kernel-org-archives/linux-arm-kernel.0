From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:10 +0000
Subject: [RFC PATCH 22/29] arm64/sve: Implement FPSIMD-only context for tasks
 not using SVE
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-23-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To reduce unnecessary context switch overhead, we don't need to
switch the whole SVE state for tasks that are not using it.

This patch restores the FPSIMD-only behaviour for tasks that have
never used SVE.

Note that coredumps and ptrace may see FPSIMD/SVE out of sync at
present -- this will be fixed later.

SVE state is saved on signal delivery only for tasks that have
used SVE.  However, it should be possible to add SVE state on
return from a signal handler when the task didn't have any SVE
state previously.  The caller may need to add its own SVE record
to the signal frame in this case.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 34 +++++++++++++++++++++++-----------
 arch/arm64/kernel/signal.c |  5 ++++-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 40566a9..cad86e5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -100,6 +100,9 @@ void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_ARM64_SVE
+
+static void task_fpsimd_to_sve(struct task_struct *task);
+
 void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
 	unsigned long tmp;
@@ -107,11 +110,16 @@ void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 	if (test_and_set_thread_flag(TIF_SVE))
 		BUG();
 
+	BUG_ON(is_compat_task());
+
+	task_fpsimd_to_sve(current);
+
 	asm ("mrs %0, cpacr_el1" : "=r" (tmp));
 	asm volatile ("msr cpacr_el1, %0" :: "r" (tmp | (1 << 17)));
 	/* Serialised by exception return to user */
 }
-#endif
+
+#endif /* CONFIG_ARM64_SVE */
 
 /*
  * Raise a SIGFPE for the current process.
@@ -164,7 +172,8 @@ extern void *__task_pffr(struct task_struct *task);
 
 static void task_fpsimd_load(struct task_struct *task)
 {
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    test_tsk_thread_flag(task, TIF_SVE))
 		sve_load_state(__task_pffr(task),
 			       &task->thread.fpsimd_state.fpsr);
 	else
@@ -173,7 +182,8 @@ static void task_fpsimd_load(struct task_struct *task)
 
 static void task_fpsimd_save(struct task_struct *task)
 {
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE))
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    test_tsk_thread_flag(task, TIF_SVE))
 		sve_save_state(__task_pffr(task),
 			       &task->thread.fpsimd_state.fpsr);
 	else
@@ -202,11 +212,9 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 		if (__this_cpu_read(fpsimd_last_state) == st
 		    && st->cpu == smp_processor_id())
-			clear_ti_thread_flag(task_thread_info(next),
-					     TIF_FOREIGN_FPSTATE);
+			clear_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
 		else
-			set_ti_thread_flag(task_thread_info(next),
-					   TIF_FOREIGN_FPSTATE);
+			set_tsk_thread_flag(next, TIF_FOREIGN_FPSTATE);
 	}
 }
 
@@ -285,7 +293,8 @@ static void task_sve_to_fpsimd(struct task_struct *task __always_unused) { }
 void fpsimd_signal_preserve_current_state(void)
 {
 	fpsimd_preserve_current_state();
-	task_sve_to_fpsimd(current);
+	if (test_thread_flag(TIF_SVE))
+		task_sve_to_fpsimd(current);
 }
 
 /*
@@ -367,7 +376,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 {
 	preempt_disable();
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE)) {
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
 		current->thread.fpsimd_state = *state;
 		task_fpsimd_to_sve(current);
 	}
@@ -408,8 +417,8 @@ void kernel_neon_begin_partial(u32 num_regs)
 	 * interrupt context, so always save the userland SVE state
 	 * if there is any, even for interrupts.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE) &&
-	    current->mm &&
+	if (IS_ENABLED(CONFIG_ARM64_SVE) &&
+	    test_thread_flag(TIF_SVE) && current->mm &&
 	    !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		fpsimd_save_state(&current->thread.fpsimd_state);
 		this_cpu_write(fpsimd_last_state, NULL);
@@ -532,6 +541,9 @@ static int __init fpsimd_init(void)
 	if (!(elf_hwcap & HWCAP_ASIMD))
 		pr_notice("Advanced SIMD is not implemented\n");
 
+	if (!(elf_hwcap & HWCAP_SVE))
+		pr_info("Scalable Vector Extension available\n");
+
 	return 0;
 }
 late_initcall(fpsimd_init);
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 129b016..2528ec1 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -259,6 +259,7 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 	preempt_disable();
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
+	set_thread_flag(TIF_SVE);
 
 	BUG_ON(SVE_SIG_REGS_SIZE(vq) > sizeof(*task_sve_regs));
 	BUG_ON(round_up(SVE_SIG_REGS_SIZE(vq), 16) < sizeof(*task_sve_regs));
@@ -543,9 +544,11 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user)
 			return err;
 	}
 
-	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
+	if (IS_ENABLED(CONFIG_ARM64_SVE) && test_thread_flag(TIF_SVE)) {
 		unsigned int vq = sve_vq_from_vl(sve_get_vl());
 
+		BUG_ON(!(elf_hwcap & HWCAP_SVE));
+
 		err = sigframe_alloc(user, &user->sve_offset,
 				     SVE_SIG_CONTEXT_SIZE(vq));
 		if (err)
-- 
2.1.4
