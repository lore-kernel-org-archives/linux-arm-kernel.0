From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:45 +0000
Subject: [RFC PATCH v2 15/41] arm64/sve: Restore working FPSIMD save/restore
 around signals
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-16-git-send-email-Dave.Martin@arm.com>
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
 arch/arm64/kernel/fpsimd.c      | 73 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/signal.c      |  2 +-
 arch/arm64/kernel/signal32.c    |  2 +-
 4 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 757d304..93ae8a7 100644
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
index 7c6417a..0024931 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -105,11 +105,66 @@ static void *sve_pffr(struct task_struct *task)
 	return (char *)__sve_state(task) + 34 * vl;
 }
 
+static void __fpsimd_to_sve(struct task_struct *task, unsigned int vq)
+{
+	struct sve_struct fpsimd_sve_state(vq) *sst = __sve_state(task);
+	struct fpsimd_state *fst = &task->thread.fpsimd_state;
+	unsigned int i;
+
+	memset(sst, 0, sizeof(*sst));
+	for (i = 0; i < 32; ++i)
+		sst->zregs[i][0] = fst->vregs[i];
+}
+
+static void fpsimd_to_sve(struct task_struct *task)
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
+	__fpsimd_to_sve(task, vq);
+}
+
+static void __sve_to_fpsimd(struct task_struct *task, unsigned int vq)
+{
+	struct sve_struct fpsimd_sve_state(vq) *sst = __sve_state(task);
+	struct fpsimd_state *fst = &task->thread.fpsimd_state;
+	unsigned int i;
+
+	for (i = 0; i < 32; ++i)
+		fst->vregs[i] = sst->zregs[i][0];
+}
+
+static void sve_to_fpsimd(struct task_struct *task)
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
+	__sve_to_fpsimd(task, vq);
+}
+
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
 extern void *__sve_state(struct task_struct *task);
 extern void *sve_pffr(struct task_struct *task);
+extern void fpsimd_to_sve(struct task_struct *task);
+
+/* Functions that map to no-ops without SVE: */
+static void sve_to_fpsimd(struct task_struct *task __always_unused) { }
 
 #endif /* ! CONFIG_ARM64_SVE */
 
@@ -238,6 +293,15 @@ void fpsimd_preserve_current_state(void)
 	preempt_enable();
 }
 
+void fpsimd_signal_preserve_current_state(void)
+{
+	WARN_ONCE(elf_hwcap & HWCAP_SVE,
+		  "SVE state save/restore around signals doesn't work properly, expect userspace corruption!\n");
+
+	fpsimd_preserve_current_state();
+	sve_to_fpsimd(current);
+}
+
 /*
  * Load the userland FPSIMD state of 'current' from memory, but only if the
  * FPSIMD state already held in the registers is /not/ the most recent FPSIMD
@@ -268,13 +332,20 @@ void fpsimd_update_current_state(struct fpsimd_state *state)
 	if (!system_supports_fpsimd())
 		return;
 	preempt_disable();
-	fpsimd_load_state(state);
+
+	if (IS_ENABLED(CONFIG_ARM64_SVE)) {
+		current->thread.fpsimd_state = *state;
+		fpsimd_to_sve(current);
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
index 49c30df..15c7edf 100644
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
index c747a0f..2df31a38 100644
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
