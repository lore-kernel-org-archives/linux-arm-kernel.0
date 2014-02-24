From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Feb 2014 15:26:28 +0100
Subject: [PATCH v3 2/4] arm64: defer reloading a task's FPSIMD state to
 userland resume
In-Reply-To: <1393251990-19614-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1393251990-19614-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1393251990-19614-3-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm64/include/asm/fpsimd.h      |   2 +
 arch/arm64/include/asm/thread_info.h |   4 +-
 arch/arm64/kernel/entry.S            |   2 +-
 arch/arm64/kernel/fpsimd.c           | 125 ++++++++++++++++++++++++++++++-----
 arch/arm64/kernel/signal.c           |   4 ++
 5 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 9f9b8e438546..7a900142dbc8 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -37,6 +37,8 @@ struct fpsimd_state {
 			u32 fpcr;
 		};
 	};
+	/* the id of the last cpu to have restored this state */
+	unsigned int cpu;
 };
 
 #if defined(__KERNEL__) && defined(CONFIG_COMPAT)
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
index 612328d91318..af93091b0366 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -35,6 +35,60 @@
 #define FPEXC_IDF	(1 << 7)
 
 /*
+ * In order to reduce the number of times the FPSIMD state is needlessly saved
+ * and restored, we need to keep track of two things:
+ * (a) for each task, we need to remember which CPU was the last one to have
+ *     the task's FPSIMD state loaded into its FPSIMD registers;
+ * (b) for each CPU, we need to remember which task's userland FPSIMD state has
+ *     been loaded into its FPSIMD registers most recently, or whether it has
+ *     been used to perform kernel mode NEON in the meantime.
+ *
+ * For (a), we add a 'cpu' field to struct fpsimd_state, which gets updated to
+ * the id of the current CPU everytime the state is loaded onto a CPU. For (b),
+ * we add the per-cpu variable 'fpsimd_last_state' (below), which contains the
+ * address of the userland FPSIMD state of the task that was loaded onto the CPU
+ * the most recently, or NULL if kernel mode NEON has been performed after that.
+ *
+ * With this in place, we no longer have to restore the next FPSIMD state right
+ * when switching between tasks. Instead, we can defer this check to userland
+ * resume,@which time we verify whether the CPU's fpsimd_last_state and the
+ * task's fpsimd_state.cpu are still mutually in sync. If this is the case, we
+ * can omit the FPSIMD restore.
+ *
+ * As an optimization, we use the thread_info flag TIF_FOREIGN_FPSTATE to
+ * indicate whether or not the userland FPSIMD state of the current task is
+ * present in the registers. The flag is set unless the FPSIMD registers of this
+ * CPU currently contain the most recent userland FPSIMD state of the current
+ * task.
+ *
+ * For a certain task, the sequence may look something like this:
+ * - the task gets scheduled in; if both the task's fpsimd_state.cpu field
+ *   contains the id of the current CPU, and the CPU's fpsimd_last_state per-cpu
+ *   variable points to the task's fpsimd_state, the TIF_FOREIGN_FPSTATE flag is
+ *   cleared, otherwise it is set;
+ *
+ * - the task returns to userland; if TIF_FOREIGN_FPSTATE is set, the task's
+ *   userland FPSIMD state is copied from memory to the registers, the task's
+ *   fpsimd_state.cpu field is set to the id of the current CPU, the current
+ *   CPU's fpsimd_last_state pointer is set to this task's fpsimd_state and the
+ *   TIF_FOREIGN_FPSTATE flag is cleared;
+ *
+ * - the task executes an ordinary syscall; upon return to userland, the
+ *   TIF_FOREIGN_FPSTATE flag will still be cleared, so no FPSIMD state is
+ *   restored;
+ *
+ * - the task executes a syscall which executes some NEON instructions; this is
+ *   preceded by a call to kernel_neon_begin(), which copies the task's FPSIMD
+ *   register contents to memory, clears the fpsimd_last_state per-cpu variable
+ *   and sets the TIF_FOREIGN_FPSTATE flag;
+ *
+ * - the task gets preempted after kernel_neon_end() is called; as we have not
+ *   returned from the 2nd syscall yet, TIF_FOREIGN_FPSTATE is still set so
+ *   whatever is in the FPSIMD registers is not saved to memory, but discarded.
+ */
+static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
+
+/*
  * Trapped FP/ASIMD access.
  */
 void do_fpsimd_acc(unsigned int esr, struct pt_regs *regs)
@@ -72,19 +126,38 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 
 void fpsimd_thread_switch(struct task_struct *next)
 {
-	/* check if not kernel threads */
-	if (current->mm)
+	/*
+	 * Save the current FPSIMD state to memory, but only if whatever is in
+	 * the registers is in fact the most recent userland FPSIMD state of
+	 * 'current'.
+	 */
+	if (current->mm && !test_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
-	if (next->mm)
-		fpsimd_load_state(&next->thread.fpsimd_state);
+
+	if (next->mm) {
+		/*
+		 * If we are switching to a task whose most recent userland
+		 * FPSIMD state is already in the registers of *this* cpu,
+		 * we can skip loading the state from memory. Otherwise, set
+		 * the TIF_FOREIGN_FPSTATE flag so the state will be loaded
+		 * upon the next return to userland.
+		 */
+		struct fpsimd_state *st = &next->thread.fpsimd_state;
+
+		if (__get_cpu_var(fpsimd_last_state) == st
+		    && st->cpu == smp_processor_id())
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
-	preempt_enable();
+	set_thread_flag(TIF_FOREIGN_FPSTATE);
 }
 
 /*
@@ -92,7 +165,10 @@ void fpsimd_flush_thread(void)
  */
 void fpsimd_preserve_current_state(void)
 {
-	fpsimd_save_state(&current->thread.fpsimd_state);
+	preempt_disable();
+	if (!test_thread_flag(TIF_FOREIGN_FPSTATE))
+		fpsimd_save_state(&current->thread.fpsimd_state);
+	preempt_enable();
 }
 
 /*
@@ -100,7 +176,15 @@ void fpsimd_preserve_current_state(void)
  */
 void fpsimd_restore_current_state(void)
 {
-	fpsimd_load_state(&current->thread.fpsimd_state);
+	preempt_disable();
+	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		struct fpsimd_state *st = &current->thread.fpsimd_state;
+
+		fpsimd_load_state(st);
+		__get_cpu_var(fpsimd_last_state) = st;
+		st->cpu = smp_processor_id();
+	}
+	preempt_enable();
 }
 
 /*
@@ -109,6 +193,12 @@ void fpsimd_restore_current_state(void)
 void fpsimd_update_current_state(struct fpsimd_state *state)
 {
 	fpsimd_load_state(state);
+	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
+		struct fpsimd_state *st = &current->thread.fpsimd_state;
+
+		__get_cpu_var(fpsimd_last_state) = st;
+		st->cpu = smp_processor_id();
+	}
 }
 
 /*
@@ -116,6 +206,7 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
  */
 void fpsimd_flush_task_state(struct task_struct *t)
 {
+	t->thread.fpsimd_state.cpu = NR_CPUS;
 }
 
 #ifdef CONFIG_KERNEL_MODE_NEON
@@ -129,16 +220,19 @@ void kernel_neon_begin(void)
 	BUG_ON(in_interrupt());
 	preempt_disable();
 
-	if (current->mm)
+	/*
+	 * Save the userland FPSIMD state if we have one and if we haven't done
+	 * so already. Clear fpsimd_last_state to indicate that there is no
+	 * longer userland FPSIMD state in the registers.
+	 */
+	if (current->mm && !test_and_set_thread_flag(TIF_FOREIGN_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
+	__get_cpu_var(fpsimd_last_state) = NULL;
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
@@ -151,12 +245,11 @@ static int fpsimd_cpu_pm_notifier(struct notifier_block *self,
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
index ee30afd846f0..3a6e08982d38 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -416,4 +416,8 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
 	}
+
+	if (thread_flags & _TIF_FOREIGN_FPSTATE)
+		fpsimd_restore_current_state();
+
 }
-- 
1.8.3.2
