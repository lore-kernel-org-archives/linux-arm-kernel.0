From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  5 Feb 2014 18:13:36 +0100
Subject: [PATCH v2 2/4] arm64: defer reloading a task's FPSIMD state to
 userland resume
In-Reply-To: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1391620418-3999-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a task gets scheduled out and back in again and nothing has touched
its FPSIMD state in the mean time, there is really no reason to reload
it from memory. Similarly, repeated calls to kernel_neon_begin() and
kernel_neon_end() will preserve and restore the FPSIMD state every time.

This patch defers the FPSIMD state restore to the last possible moment,
i.e., right before the task re-enters userland. If a task does not enter
userland at all (for any reason), the existing FPSIMD state is preserved
and may be reused by the owning task if it gets scheduled in again on the
same CPU.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/fpsimd.h      |   4 ++
 arch/arm64/include/asm/thread_info.h |   4 +-
 arch/arm64/kernel/entry.S            |   2 +-
 arch/arm64/kernel/fpsimd.c           | 102 +++++++++++++++++++++++++++++------
 arch/arm64/kernel/signal.c           |   4 ++
 5 files changed, 98 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 7807974b49ee..f7e70f3f1eb7 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -37,6 +37,8 @@ struct fpsimd_state {
 			u32 fpcr;
 		};
 	};
+	/* the id of the last cpu to have restored this state */
+	unsigned int last_cpu;
 };
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
@@ -61,6 +63,8 @@ void fpsimd_set_task_state(struct fpsimd_state *state);
 struct user_fpsimd_state *fpsimd_get_user_state(struct task_struct *t);
 void fpsimd_set_user_state(struct task_struct *t, struct user_fpsimd_state *st);
 
+void fpsimd_reload_fpstate(void);
+
 #endif
 
 #endif
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 720e70b66ffd..4a1ca1cfb2f8 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -100,6 +100,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SIGPENDING		0
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
+#define TIF_FOREIGN_FPSTATE	3	/* CPU's FP state is not current's */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_POLLING_NRFLAG	16
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -112,10 +113,11 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME)
+				 _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE)
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 39ac630d83de..80464e2fb1a5 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -576,7 +576,7 @@ fast_work_pending:
 	str	x0, [sp, #S_X0]			// returned x0
 work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
-	/* TIF_SIGPENDING or TIF_NOTIFY_RESUME case */
+	/* TIF_SIGPENDING, TIF_NOTIFY_RESUME or TIF_FOREIGN_FPSTATE case */
 	ldr	x2, [sp, #S_PSTATE]
 	mov	x0, sp				// 'regs'
 	tst	x2, #PSR_MODE_MASK		// user mode regs?
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index eeb003f54ad0..239c8162473f 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -39,6 +39,23 @@ void fpsimd_save_state(struct fpsimd_state *state);
 void fpsimd_load_state(struct fpsimd_state *state);
 
 /*
+ * In order to reduce the number of times the fpsimd state is needlessly saved
+ * and restored, keep track here of which task's userland owns the current state
+ * of the FPSIMD register file.
+ *
+ * This percpu variable points to the fpsimd_state.last_cpu field of the task
+ * whose FPSIMD state was most recently loaded onto this cpu. The last_cpu field
+ * itself contains the id of the cpu onto which the task's FPSIMD state was
+ * loaded most recently. So, to decide whether we can skip reloading the FPSIMD
+ * state, we need to check
+ * (a) whether this task was the last one to have its FPSIMD state loaded onto
+ *     this cpu
+ * (b) whether this task may have manipulated its FPSIMD state on another cpu in
+ *     the meantime
+ */
+static DEFINE_PER_CPU(unsigned int *, fpsimd_last_task);
+
+/*
  * Trapped FP/ASIMD access.
  */
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
@@ -76,36 +93,84 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 
 void fpsimd_thread_switch(struct task_struct *next)
 {
-	/* check if not kernel threads */
-	if (current->mm)
+	/*
+	 * The thread flag TIF_FOREIGN_FPSTATE conveys that the userland FPSIMD
+	 * state belonging to the current task is not present in the registers
+	 * but has (already) been saved to memory in order for the kernel to be
+	 * able to go off and use the registers for something else. Therefore,
+	 * we must not (re)save the register contents if this flag is set.
+	 */
+	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
-	if (next->mm)
-		fpsimd_load_state(&next->thread.fpsimd_state);
+
+	if (next->mm) {
+		/*
+		 * If we are switching to a task whose most recent userland
+		 * FPSIMD contents are already in the registers of *this* cpu,
+		 * we can skip loading the state from memory. Otherwise, set
+		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
+		 * upon the next entry of userland.
+		 */
+		struct fpsimd_state *st = &next->thread.fpsimd_state;
+
+		if (__get_cpu_var(fpsimd_last_task) == &st->last_cpu
+		    && st->last_cpu == smp_processor_id())
+			clear_ti_thread_flag(task_thread_info(next),
+					     TIF_FOREIGN_FPSTATE);
+		else
+			set_ti_thread_flag(task_thread_info(next),
+					   TIF_FOREIGN_FPSTATE);
+	}
 }
 
 void fpsimd_flush_thread(void)
 {
-	preempt_disable();
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
-	fpsimd_load_state(&current->thread.fpsimd_state);
+	set_thread_flag(TIF_FOREIGN_FPSTATE);
+}
+
+/*
+ * Sync the FPSIMD register file with the saved FPSIMD context (if necessary)
+ */
+void fpsimd_reload_fpstate(void)
+{
+	preempt_disable();
+	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		struct fpsimd_state *st = &current->thread.fpsimd_state;
+
+		fpsimd_load_state(st);
+		__get_cpu_var(fpsimd_last_task) = &st->last_cpu;
+		st->last_cpu = smp_processor_id();
+	}
 	preempt_enable();
 }
 
 /*
- * Sync the saved FPSIMD context with the FPSIMD register file
+ * Sync the saved FPSIMD context with the FPSIMD register file (if necessary)
  */
 struct fpsimd_state *fpsimd_get_task_state(void)
 {
-	fpsimd_save_state(&current->thread.fpsimd_state);
+	preempt_disable();
+	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
+		fpsimd_save_state(&current->thread.fpsimd_state);
+	preempt_enable();
 	return &current->thread.fpsimd_state;
 }
 
 /*
- * Load a new FPSIMD state into the FPSIMD register file.
+ * Load a new FPSIMD state into the FPSIMD register file, and clear the
+ * TIF_FOREIGN_FPSTATE flag to convey that the register content is now
+ * owned by 'current'. To be called with preemption disabled.
  */
 void fpsimd_set_task_state(struct fpsimd_state *state)
 {
 	fpsimd_load_state(state);
+	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		struct fpsimd_state *st = &current->thread.fpsimd_state;
+
+		__get_cpu_var(fpsimd_last_task) = &st->last_cpu;
+		st->last_cpu = smp_processor_id();
+	}
 }
 
 struct user_fpsimd_state *fpsimd_get_user_state(struct task_struct *t)
@@ -116,6 +181,9 @@ struct user_fpsimd_state *fpsimd_get_user_state(struct task_struct *t)
 void fpsimd_set_user_state(struct task_struct *t, struct user_fpsimd_state *st)
 {
 	t->thread.fpsimd_state.user_fpsimd = *st;
+
+	/* invalidate potential live copies of this FPSIMD state */
+	t->thread.fpsimd_state.last_cpu = NR_CPUS;
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
@@ -129,16 +197,19 @@ void kernel_neon_begin(void)
 	BUG_ON(in_interrupt());
 	preempt_disable();
 
-	if (current->mm)
+	/*
+	 * Save the userland FPSIMD state if we have one and if we haven't done
+	 * so already. Clear fpsimd_last_task to indicate that there is no
+	 * longer userland context in the registers.
+	 */
+	if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
+	__get_cpu_var(fpsimd_last_task) = NULL;
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
 void kernel_neon_end(void)
 {
-	if (current->mm)
-		fpsimd_load_state(&current->thread.fpsimd_state);
-
 	preempt_enable();
 }
 EXPORT_SYMBOL(kernel_neon_end);
@@ -151,12 +222,11 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
 {
 	switch (cmd) {
 	case CPU_PM_ENTER:
-		if (current->mm)
+		if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
 			fpsimd_save_state(&current->thread.fpsimd_state);
 		break;
 	case CPU_PM_EXIT:
-		if (current->mm)
-			fpsimd_load_state(&current->thread.fpsimd_state);
+		set_thread_flag(TIF_FOREIGN_FPSTATE);
 		break;
 	case CPU_PM_ENTER_FAILED:
 	default:
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 54e1092c5b4c..68d2957e5ebe 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -416,4 +416,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
 	}
+
+	if (thread_flags & _TIF_FOREIGN_FPSTATE)
+		fpsimd_reload_fpstate();
+
 }
-- 
1.8.3.2
