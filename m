From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:14:59 +0200
Subject: [RFC v3 PATCH 3/7] ARM64: defer reloading a task's FPSIMD state to
 userland resume
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-4-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify kernel_neon_begin() and kernel_neon_end() so subsequent calls
don't need to preserve/restore the userland FPSIMD state if the task
has not entered userland in the mean time.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/thread_info.h | 4 +++-
 arch/arm64/kernel/entry.S            | 2 +-
 arch/arm64/kernel/fpsimd.c           | 7 ++-----
 arch/arm64/kernel/signal.c           | 2 ++
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 23a3c47..3bdeab6 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -106,6 +106,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SIGPENDING		0
 #define TIF_NEED_RESCHED	1
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
+#define TIF_RELOAD_FPSTATE	3	/* user FPSIMD context saved to mem */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_POLLING_NRFLAG	16
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -118,10 +119,11 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
+#define _TIF_RELOAD_FPSTATE	(1 << TIF_RELOAD_FPSTATE)
 #define _TIF_32BIT		(1 << TIF_32BIT)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME)
+				 _TIF_NOTIFY_RESUME | _TIF_RELOAD_FPSTATE)
 
 #endif /* __KERNEL__ */
 #endif /* __ASM_THREAD_INFO_H */
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 3881fd1..2c6c7fb 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -589,7 +589,7 @@ fast_work_pending:
 	str	x0, [sp, #S_X0]			// returned x0
 work_pending:
 	tbnz	x1, #TIF_NEED_RESCHED, work_resched
-	/* TIF_SIGPENDING or TIF_NOTIFY_RESUME case */
+	/* TIF_SIGPENDING/TIF_NOTIFY_RESUME/TIF_RELOAD_FPSTATE case */
 	ldr	x2, [sp, #S_PSTATE]
 	mov	x0, sp				// 'regs'
 	tst	x2, #PSR_MODE_MASK		// user mode regs?
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 1f2e4d5..a52affd 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -72,7 +72,7 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 void fpsimd_thread_switch(struct task_struct *next)
 {
 	/* check if not kernel threads */
-	if (current->mm)
+	if (current->mm && !test_and_clear_thread_flag(TIF_RELOAD_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
 	if (next->mm)
 		fpsimd_load_state(&next->thread.fpsimd_state);
@@ -95,16 +95,13 @@ void kernel_neon_begin(void)
 	BUG_ON(in_interrupt());
 	preempt_disable();
 
-	if (current->mm)
+	if (current->mm && !test_and_set_thread_flag(TIF_RELOAD_FPSTATE))
 		fpsimd_save_state(&current->thread.fpsimd_state);
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
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 890a591..da3a433 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -416,4 +416,6 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		clear_thread_flag(TIF_NOTIFY_RESUME);
 		tracehook_notify_resume(regs);
 	}
+	if (test_and_clear_thread_flag(TIF_RELOAD_FPSTATE))
+		fpsimd_load_state(&current->thread.fpsimd_state);
 }
-- 
1.8.1.2
