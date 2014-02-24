From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Feb 2014 15:26:27 +0100
Subject: [PATCH v3 1/4] arm64: add abstractions for FPSIMD state manipulation
In-Reply-To: <1393251990-19614-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1393251990-19614-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1393251990-19614-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two tacit assumptions in the FPSIMD handling code that will no longer
hold after the next patch that optimizes away some FPSIMD state restores:
. the FPSIMD registers of this CPU contain the userland FPSIMD state of
  task 'current';
. when switching to a task, its FPSIMD state will always be restored from
  memory.

This patch adds the following functions to abstract away from straight FPSIMD
register file saves and restores:
- fpsimd_preserve_current_state -> ensure current's FPSIMD state is saved
- fpsimd_restore_current_state -> ensure current's FPSIMD state is loaded
- fpsimd_update_current_state -> replace current's FPSIMD state
- fpsimd_flush_task_state -> invalidate live copies of a task's FPSIMD state

Where necessary, the ptrace, signal handling and fork code are updated to use
the above wrappers instead of poking into the FPSIMD registers directly.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/fpsimd.h |  6 ++++++
 arch/arm64/kernel/fpsimd.c      | 31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c     |  2 +-
 arch/arm64/kernel/ptrace.c      |  2 ++
 arch/arm64/kernel/signal.c      |  4 ++--
 arch/arm64/kernel/signal32.c    |  4 ++--
 6 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index c43b4ac13008..9f9b8e438546 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -58,6 +58,12 @@ extern void fpsimd_load_state(struct fpsimd_state *state);
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
+extern void fpsimd_preserve_current_state(void);
+extern void fpsimd_restore_current_state(void);
+extern void fpsimd_update_current_state(struct fpsimd_state *state);
+
+extern void fpsimd_flush_task_state(struct task_struct *target);
+
 #endif
 
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4aef42a04bdc..612328d91318 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -87,6 +87,37 @@ void fpsimd_flush_thread(void)
 	preempt_enable();
 }
 
+/*
+ * Save the userland FPSIMD state of 'current' to memory
+ */
+void fpsimd_preserve_current_state(void)
+{
+	fpsimd_save_state(&current->thread.fpsimd_state);
+}
+
+/*
+ * Load the userland FPSIMD state of 'current' from memory
+ */
+void fpsimd_restore_current_state(void)
+{
+	fpsimd_load_state(&current->thread.fpsimd_state);
+}
+
+/*
+ * Load an updated userland FPSIMD state for 'current' from memory
+ */
+void fpsimd_update_current_state(struct fpsimd_state *state)
+{
+	fpsimd_load_state(state);
+}
+
+/*
+ * Invalidate live CPU copies of task t's FPSIMD state
+ */
+void fpsimd_flush_task_state(struct task_struct *t)
+{
+}
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1c0a9be2ffa8..6074e0a4418d 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -199,7 +199,7 @@ void release_thread(struct task_struct *dead_task)
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	fpsimd_save_state(&current->thread.fpsimd_state);
+	fpsimd_preserve_current_state();
 	*dst = *src;
 	return 0;
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6a8928bba03c..f8700eca24e7 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -517,6 +517,7 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 		return ret;
 
 	target->thread.fpsimd_state.user_fpsimd = newstate;
+	fpsimd_flush_task_state(target);
 	return ret;
 }
 
@@ -764,6 +765,7 @@ static int compat_vfp_set(struct task_struct *target,
 		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
 	}
 
+	fpsimd_flush_task_state(target);
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 890a591f75dd..ee30afd846f0 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -51,7 +51,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	int err;
 
 	/* dump the hardware registers to the fpsimd_state structure */
-	fpsimd_save_state(fpsimd);
+	fpsimd_preserve_current_state();
 
 	/* copy the FP and status/control registers */
 	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
@@ -88,7 +88,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	/* load the hardware registers from the fpsimd_state structure */
 	if (!err) {
 		preempt_disable();
-		fpsimd_load_state(&fpsimd);
+		fpsimd_update_current_state(&fpsimd);
 		preempt_enable();
 	}
 
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b3fc9f5ec6d3..78e169c8214c 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -219,7 +219,7 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	 * Note that this also saves V16-31, which aren't visible
 	 * in AArch32.
 	 */
-	fpsimd_save_state(fpsimd);
+	fpsimd_preserve_current_state();
 
 	/* Place structure header on the stack */
 	__put_user_error(magic, &frame->magic, err);
@@ -284,7 +284,7 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	 */
 	if (!err) {
 		preempt_disable();
-		fpsimd_load_state(&fpsimd);
+		fpsimd_update_current_state(&fpsimd);
 		preempt_enable();
 	}
 
-- 
1.8.3.2
