From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  5 Feb 2014 18:13:35 +0100
Subject: [PATCH v2 1/4] arm64: add abstractions for FPSIMD state manipulation
In-Reply-To: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1391620418-3999-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1391620418-3999-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a preparatory patch that replaces code that saves or restores the
on-CPU or preserved FPSIMD state directly with wrapper functions, resulting
in all direct manipulation of the FPSIMD state to be concentrated in fpsimd.c

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/fpsimd.h |  9 ++++++---
 arch/arm64/kernel/fpsimd.c      | 31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/process.c     |  2 +-
 arch/arm64/kernel/ptrace.c      | 22 +++++++++++++---------
 arch/arm64/kernel/signal.c      |  6 +++---
 arch/arm64/kernel/signal32.c    |  6 +++---
 6 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index c43b4ac13008..7807974b49ee 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -52,12 +52,15 @@ struct fpsimd_state {
 
 struct task_struct;
 
-extern void fpsimd_save_state(struct fpsimd_state *state);
-extern void fpsimd_load_state(struct fpsimd_state *state);
-
 extern void fpsimd_thread_switch(struct task_struct *next);
 extern void fpsimd_flush_thread(void);
 
+struct fpsimd_state *fpsimd_get_task_state(void);
+void fpsimd_set_task_state(struct fpsimd_state *state);
+
+struct user_fpsimd_state *fpsimd_get_user_state(struct task_struct *t);
+void fpsimd_set_user_state(struct task_struct *t, struct user_fpsimd_state *st);
+
 #endif
 
 #endif
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4aef42a04bdc..eeb003f54ad0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -34,6 +34,10 @@
 #define FPEXC_IXF	(1 << 4)
 #define FPEXC_IDF	(1 << 7)
 
+/* defined in entry-fpsimd.S but only used in this unit */
+void fpsimd_save_state(struct fpsimd_state *state);
+void fpsimd_load_state(struct fpsimd_state *state);
+
 /*
  * Trapped FP/ASIMD access.
  */
@@ -87,6 +91,33 @@ void fpsimd_flush_thread(void)
 	preempt_enable();
 }
 
+/*
+ * Sync the saved FPSIMD context with the FPSIMD register file
+ */
+struct fpsimd_state *fpsimd_get_task_state(void)
+{
+	fpsimd_save_state(&current->thread.fpsimd_state);
+	return &current->thread.fpsimd_state;
+}
+
+/*
+ * Load a new FPSIMD state into the FPSIMD register file.
+ */
+void fpsimd_set_task_state(struct fpsimd_state *state)
+{
+	fpsimd_load_state(state);
+}
+
+struct user_fpsimd_state *fpsimd_get_user_state(struct task_struct *t)
+{
+	return &t->thread.fpsimd_state.user_fpsimd;
+}
+
+void fpsimd_set_user_state(struct task_struct *t, struct user_fpsimd_state *st)
+{
+	t->thread.fpsimd_state.user_fpsimd = *st;
+}
+
 #ifdef CONFIG_KERNEL_MODE_NEON
 
 /*
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1c0a9be2ffa8..bfa8214f92d1 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -199,7 +199,7 @@ void release_thread(struct task_struct *dead_task)
 
 int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 {
-	fpsimd_save_state(&current->thread.fpsimd_state);
+	fpsimd_get_task_state();
 	*dst = *src;
 	return 0;
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 6a8928bba03c..d0b35af14539 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -500,8 +500,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
-	struct user_fpsimd_state *uregs;
-	uregs = &target->thread.fpsimd_state.user_fpsimd;
+	struct user_fpsimd_state *uregs = fpsimd_get_user_state(target);
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
 }
 
@@ -516,7 +515,7 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	target->thread.fpsimd_state.user_fpsimd = newstate;
+	fpsimd_set_user_state(target, &newstate);
 	return ret;
 }
 
@@ -723,7 +722,7 @@ static int compat_vfp_get(struct task_struct *target,
 	compat_ulong_t fpscr;
 	int ret;
 
-	uregs = &target->thread.fpsimd_state.user_fpsimd;
+	uregs = fpsimd_get_user_state(target);
 
 	/*
 	 * The VFP registers are packed into the fpsimd_state, so they all sit
@@ -746,24 +745,29 @@ static int compat_vfp_set(struct task_struct *target,
 			  unsigned int pos, unsigned int count,
 			  const void *kbuf, const void __user *ubuf)
 {
-	struct user_fpsimd_state *uregs;
+	struct user_fpsimd_state newstate;
 	compat_ulong_t fpscr;
 	int ret;
 
 	if (pos + count > VFP_STATE_SIZE)
 		return -EIO;
 
-	uregs = &target->thread.fpsimd_state.user_fpsimd;
+	/*
+	 * We will not overwrite the entire FPSIMD state, so we need to
+	 * initialize 'newstate' with sane values.
+	 */
+	newstate = *fpsimd_get_user_state(target);
 
-	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, uregs, 0,
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &newstate, 0,
 				 VFP_STATE_SIZE - sizeof(compat_ulong_t));
 
 	if (count && !ret) {
 		ret = get_user(fpscr, (compat_ulong_t *)ubuf);
-		uregs->fpsr = fpscr & VFP_FPSCR_STAT_MASK;
-		uregs->fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
+		newstate.fpsr = fpscr & VFP_FPSCR_STAT_MASK;
+		newstate.fpcr = fpscr & VFP_FPSCR_CTRL_MASK;
 	}
 
+	fpsimd_set_user_state(target, &newstate);
 	return ret;
 }
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 890a591f75dd..54e1092c5b4c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -47,11 +47,11 @@ struct rt_sigframe {
 
 static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 {
-	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
+	struct fpsimd_state *fpsimd;
 	int err;
 
 	/* dump the hardware registers to the fpsimd_state structure */
-	fpsimd_save_state(fpsimd);
+	fpsimd = fpsimd_get_task_state();
 
 	/* copy the FP and status/control registers */
 	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
@@ -88,7 +88,7 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	/* load the hardware registers from the fpsimd_state structure */
 	if (!err) {
 		preempt_disable();
-		fpsimd_load_state(&fpsimd);
+		fpsimd_set_task_state(&fpsimd);
 		preempt_enable();
 	}
 
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index b3fc9f5ec6d3..88e4535c3a45 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -208,7 +208,7 @@ int copy_siginfo_from_user32(siginfo_t *to, compat_siginfo_t __user *from)
  */
 static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 {
-	struct fpsimd_state *fpsimd = &current->thread.fpsimd_state;
+	struct fpsimd_state *fpsimd;
 	compat_ulong_t magic = VFP_MAGIC;
 	compat_ulong_t size = VFP_STORAGE_SIZE;
 	compat_ulong_t fpscr, fpexc;
@@ -219,7 +219,7 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	 * Note that this also saves V16-31, which aren't visible
 	 * in AArch32.
 	 */
-	fpsimd_save_state(fpsimd);
+	fpsimd = fpsimd_get_task_state();
 
 	/* Place structure header on the stack */
 	__put_user_error(magic, &frame->magic, err);
@@ -284,7 +284,7 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	 */
 	if (!err) {
 		preempt_disable();
-		fpsimd_load_state(&fpsimd);
+		fpsimd_set_task_state(&fpsimd);
 		preempt_enable();
 	}
 
-- 
1.8.3.2
