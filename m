From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:47 +0000
Subject: [RFC PATCH v2 17/41] arm64/sve: signal: Dump Scalable Vector
 Extension registers to user stack
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-18-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch populates the sve_regs() area reserved on the user stack
with the actual register context.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/fpsimd.h | 1 +
 arch/arm64/kernel/fpsimd.c      | 3 +--
 arch/arm64/kernel/signal.c      | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 93ae8a7..be292c5 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -95,6 +95,7 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr);
 extern unsigned int sve_get_vl(void);
 extern void __init fpsimd_init_task_struct_size(void);
+extern void *__sve_state(struct task_struct *task);
 
 #endif
 
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 801f4d3..1bdf7f2 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -93,7 +93,7 @@ static DEFINE_PER_CPU(struct fpsimd_state *, fpsimd_last_state);
 
 #ifdef CONFIG_ARM64_SVE
 
-static void *__sve_state(struct task_struct *task)
+void *__sve_state(struct task_struct *task)
 {
 	return (char *)task + ALIGN(sizeof(*task), 16);
 }
@@ -153,7 +153,6 @@ static void sve_to_fpsimd(struct task_struct *task)
 #else /* ! CONFIG_ARM64_SVE */
 
 /* Dummy declarations for usage protected with IS_ENABLED(CONFIG_ARM64_SVE): */
-extern void *__sve_state(struct task_struct *task);
 extern void *sve_pffr(struct task_struct *task);
 extern void fpsimd_to_sve(struct task_struct *task);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 113502e..6b83917 100644
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
+			    __sve_state(current),
+			    SVE_SIG_REGS_SIZE(vq));
+
 	return err ? -EFAULT : 0;
 }
 
-- 
2.1.4
