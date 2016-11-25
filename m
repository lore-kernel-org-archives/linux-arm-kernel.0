From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:05 +0000
Subject: [RFC PATCH 17/29] arm64/sve: signal: Dump Scalable Vector Extension
 registers to user stack
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-18-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch populates the sve_regs() area reserved on the user stack
with the actual register context.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 1 +
 arch/arm64/kernel/fpsimd.c      | 5 ++---
 arch/arm64/kernel/signal.c      | 8 ++++++++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index aa82b38..e39066a 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -93,6 +93,7 @@ extern void fpsimd_load_partial_state(struct fpsimd_partial_state *state);
 
 extern void __init fpsimd_init_task_struct_size(void);
 
+extern void *__task_sve_state(struct task_struct *task);
 extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr);
 extern unsigned int sve_get_vl(void);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 9a90921..4ef2e37 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -128,7 +128,7 @@ void do_fpsimd_exc(unsigned int esr, struct pt_regs *regs)
 
 #ifdef CONFIG_ARM64_SVE
 
-static void *__task_sve_state(struct task_struct *task)
+void *__task_sve_state(struct task_struct *task)
 {
 	return (char *)task + ALIGN(sizeof(*task), 16);
 }
@@ -143,8 +143,7 @@ static void *__task_pffr(struct task_struct *task)
 
 #else /* !CONFIG_ARM64_SVE */
 
-/* Turn any non-optimised out attempts to use these into a link error: */
-extern void *__task_sve_state(struct task_struct *task);
+/* Turn any non-optimised out attempts to use this into a link error: */
 extern void *__task_pffr(struct task_struct *task);
 
 #endif /* !CONFIG_ARM64_SVE */
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 7418237..038e7338 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -229,6 +229,14 @@ static int preserve_sve_context(struct sve_context __user *ctx)
 	BUILD_BUG_ON(sizeof(ctx->__reserved) != sizeof(reserved));
 	err |= copy_to_user(&ctx->__reserved, reserved, sizeof(reserved));
 
+	/*
+	 * This assumes that the SVE state has already been saved to
+	 * the task struct by calling preserve_fpsimd_context().
+	 */
+	err |= copy_to_user((char __user *)ctx + SVE_SIG_REGS_OFFSET,
+			    __task_sve_state(current),
+			    SVE_SIG_REGS_SIZE(vq));
+
 	return err ? -EFAULT : 0;
 }
 
-- 
2.1.4
