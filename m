From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:03 +0000
Subject: [RFC PATCH 15/29] arm64/sve: Restore working FPSIMD save/restore
 around signals
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-16-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because fpsimd_state and the SVE state are not magically
synchronised in the task_struct, stale FPSIMD data may be saved on
signal handler entry, and restored data my be lost on sigreturn.

This patch converts between SVE and FPSIMD views around the signal,
restoring working FPSIMD save/restore.

This will not save/restore the SVE state properly, but it should
restore a working FPSIMD ABI.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h |  1 +
 arch/arm64/kernel/fpsimd.c      | 92 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/signal.c      |  2 +-
 arch/arm64/kernel/signal32.c    |  2 +-
 4 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 1c41259..aa82b38 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -80,6 +80,7 @@ extern void fpsimd_load_state(struct fpsimd_state *state);
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
+extern void fpsimd_signal_preserve_current_state(void);
 extern void fpsimd_preserve_current_state(void);
 extern void fpsimd_restore_current_state(void);
 extern void fpsimd_update_current_state(struct fpsimd_state *state);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index cb947dd..9a90921 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -228,6 +228,52 @@ void fpsimd_preserve_current_state(void)
 	preempt_enable();
 }
 
+#ifdef CONFIG_ARM64_SVE
+
+/* Helpers to sync task FPSIMD and SVE register views */
+
+static void __task_sve_to_fpsimd(struct task_struct *task, unsigned int vq)
+{
+	struct sve_struct fpsimd_sve_state(vq) *sst =
+		__task_sve_state(task);
+	struct fpsimd_state *fst = &task->thread.fpsimd_state;
+	unsigned int i;
+
+	for (i = 0; i < 32; ++i)
+		fst->vregs[i] = sst->zregs[i][0];
+}
+
+static void task_sve_to_fpsimd(struct task_struct *task)
+{
+	unsigned int vl = sve_get_vl();
+	unsigned int vq;
+
+	if (!(elf_hwcap & HWCAP_SVE))
+		return;
+
+	BUG_ON(vl % 16);
+	vq = vl / 16;
+	BUG_ON(vq < 1 || vq > 16);
+
+	__task_sve_to_fpsimd(task, vq);
+}
+
+#else /* ! CONFIG_ARM64_SVE */
+
+static void task_sve_to_fpsimd(struct task_struct *task __always_unused) { }
+
+#endif /* ! CONFIG_ARM64_SVE */
+
+
+void fpsimd_signal_preserve_current_state(void)
+{
+	WARN_ONCE(elf_hwcap & HWCAP_SVE,
+		  "SVE state save/restore around signals doesn't work properly, expect userspace corruption!\n");
+
+	fpsimd_preserve_current_state();
+	task_sve_to_fpsimd(current);
+}
+
 /*
  * Load the userland FPSIMD state of 'current' from memory, but only if the
  * FPSIMD state already held in the registers is /not/ the most recent FPSIMD
@@ -246,6 +292,43 @@ void fpsimd_restore_current_state(void)
 	preempt_enable();
 }
 
+
+#ifdef CONFIG_ARM64_SVE
+
+static void __task_fpsimd_to_sve(struct task_struct *task, unsigned int vq)
+{
+	struct sve_struct fpsimd_sve_state(vq) *sst =
+		__task_sve_state(task);
+	struct fpsimd_state *fst = &task->thread.fpsimd_state;
+	unsigned int i;
+
+	memset(sst, 0, sizeof(*sst));
+	for (i = 0; i < 32; ++i)
+		sst->zregs[i][0] = fst->vregs[i];
+}
+
+static void task_fpsimd_to_sve(struct task_struct *task)
+{
+	unsigned int vl = sve_get_vl();
+	unsigned int vq;
+
+	if (!(elf_hwcap & HWCAP_SVE))
+		return;
+
+	BUG_ON(vl % 16);
+	vq = vl / 16;
+	BUG_ON(vq < 1 || vq > 16);
+
+	__task_fpsimd_to_sve(task, vq);
+}
+
+#else /* ! CONFIG_ARM64_SVE */
+
+/* Turn any non-optimised out attempts to use this into a link error: */
+extern void task_fpsimd_to_sve(struct task_struct *task);
+
+#endif /* ! CONFIG_ARM64_SVE */
+
 /*
  * Load an updated userland FPSIMD state for 'current' from memory and set the
  * flag that indicates that the FPSIMD register contents are the most recent
@@ -254,13 +337,20 @@ void fpsimd_restore_current_state(void)
 void fpsimd_update_current_state(struct fpsimd_state *state)
 {
 	preempt_disable();
-	fpsimd_load_state(state);
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE)) {
+		current->thread.fpsimd_state = *state;
+		task_fpsimd_to_sve(current);
+	}
+	task_fpsimd_load(current);
+
 	if (test_and_clear_thread_flag(TIF_FOREIGN_FPSTATE)) {
 		struct fpsimd_state *st = &current->thread.fpsimd_state;
 
 		this_cpu_write(fpsimd_last_state, st);
 		st->cpu = smp_processor_id();
 	}
+
 	preempt_enable();
 }
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index c7175a3..1e430b4 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -168,7 +168,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 	int err;
 
 	/* dump the hardware registers to the fpsimd_state structure */
-	fpsimd_preserve_current_state();
+	fpsimd_signal_preserve_current_state();
 
 	/* copy the FP and status/control registers */
 	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b7063de..08ca0dd 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -244,7 +244,7 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	 * Note that this also saves V16-31, which aren't visible
 	 * in AArch32.
 	 */
-	fpsimd_preserve_current_state();
+	fpsimd_signal_preserve_current_state();
 
 	/* Place structure header on the stack */
 	__put_user_error(magic, &frame->magic, err);
-- 
2.1.4
