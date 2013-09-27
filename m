From: liuj97@gmail.com (Jiang Liu)
Date: Fri, 27 Sep 2013 16:04:42 +0800
Subject: [RFT PATCH v1 2/7] arm64: restore FPSIMD to default state for kernel
 and signal contexts
In-Reply-To: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
References: <1380269087-8520-1-git-send-email-liuj97@gmail.com>
Message-ID: <1380269087-8520-3-git-send-email-liuj97@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@huawei.com>

Restore FPSIMD control and status registers to default values
when creating new FPSIMD contexts for kernel and signal handling,
otherwise the stale value in FPSIMD control and status registers
may affect the new kernal or signal handling contexts.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>
---
 arch/arm64/include/asm/fpsimd.h | 12 ++++++++++++
 arch/arm64/kernel/fpsimd.c      | 11 +++++++++--
 arch/arm64/kernel/signal.c      |  1 +
 arch/arm64/kernel/signal32.c    |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index c43b4ac..4c2bc80 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -50,8 +50,20 @@ struct fpsimd_state {
 #define VFP_STATE_SIZE		((32 * 8) + 4)
 #endif
 
+#define	AARCH64_FPCR_DEFAULT_VAL	0
+
 struct task_struct;
 
+/* Clear FP status register, so it doesn't affect new FP context */
+static inline void fpsimd_init_hw_state(void)
+{
+	int val = AARCH64_FPCR_DEFAULT_VAL;
+
+	asm ("msr fpcr, %x0\n"
+	     "msr fpsr, xzr\n"
+             : : "r"(val));
+}
+
 extern void fpsimd_save_state(struct fpsimd_state *state);
 extern void fpsimd_load_state(struct fpsimd_state *state);
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index bb785d2..12a25e5 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -80,9 +80,14 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 void fpsimd_flush_thread(void)
 {
+	struct fpsimd_state *state = &current->thread.fpsimd_state;
+
 	preempt_disable();
-	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
-	fpsimd_load_state(&current->thread.fpsimd_state);
+	memset(state, 0, sizeof(struct fpsimd_state));
+#if (AARCH64_FPCR_DEFAULT_VAL != 0)
+	state->fpcr = AARCH64_FPCR_DEFAULT_VAL;
+#endif
+	fpsimd_load_state(state);
 	preempt_enable();
 }
 
@@ -99,6 +104,8 @@ void kernel_neon_begin(void)
 
 	if (current->mm)
 		fpsimd_save_state(&current->thread.fpsimd_state);
+
+	fpsimd_init_hw_state();
 }
 EXPORT_SYMBOL(kernel_neon_begin);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 890a591..6d80612 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -52,6 +52,7 @@ static int preserve_fpsimd_context(struct fpsimd_context __user *ctx)
 
 	/* dump the hardware registers to the fpsimd_state structure */
 	fpsimd_save_state(fpsimd);
+	fpsimd_init_hw_state();
 
 	/* copy the FP and status/control registers */
 	err = __copy_to_user(ctx->vregs, fpsimd->vregs, sizeof(fpsimd->vregs));
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index e393174..cb2cb41 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -248,6 +248,7 @@ static int compat_preserve_vfp_context(struct compat_vfp_sigframe __user *frame)
 	 * in AArch32.
 	 */
 	fpsimd_save_state(fpsimd);
+	fpsimd_init_hw_state();
 
 	/* Place structure header on the stack */
 	__put_user_error(magic, &frame->magic, err);
-- 
1.8.1.2
