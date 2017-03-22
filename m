From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:55 +0000
Subject: [RFC PATCH v2 25/41] arm64/sve: Avoid preempt_disable() during
 sigreturn
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-26-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the sigreturn implementation for SVE relies on
preempt_disable() to avoid an intervening context switch from
corrupting the SVE state in the task_struct.

Unforunately, __get_user() and friends are not safe under
preempt_disable().

As an alternative, this patch removes preempt_disable() and sets
TIF_FOREIGN_FPSTATE instead: this will inform the context switch
code that the current CPU registers don't contain the SVE/FPSIMD
state of the current task, preventing writeback to the task_struct
during context switch.

To avoid an intervening context switch from spontaneously clearing
TIF_FOREIGN_FPSTATE again while doing this,
fpsimd_flush_task_state() is also called beforehand.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/signal.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 619dca5..20bc312 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -256,10 +256,10 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 	if (vl != sve_get_vl())
 		return -EINVAL;
 
-	preempt_disable();
-
+	fpsimd_flush_task_state(current);
+	barrier();
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
-	set_thread_flag(TIF_SVE);
+	barrier();
 
 	BUG_ON(SVE_SIG_REGS_SIZE(vq) > sizeof(*task_sve_regs));
 	BUG_ON(round_up(SVE_SIG_REGS_SIZE(vq), 16) < sizeof(*task_sve_regs));
@@ -270,7 +270,7 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 					SVE_SIG_REGS_OFFSET,
 			       SVE_SIG_REGS_SIZE(vq));
 	if (err)
-		goto out_preempt;
+		return err;
 
 	/* copy the FP and status/control registers */
 	/* restore_sigframe() already checked that user->fpsimd != NULL. */
@@ -279,13 +279,13 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 	__get_user_error(fpsimd.fpsr, &user->fpsimd->fpsr, err);
 	__get_user_error(fpsimd.fpcr, &user->fpsimd->fpcr, err);
 
+	barrier();
+	set_thread_flag(TIF_SVE);
+
 	/* load the hardware registers from the fpsimd_state structure */
 	if (!err)
 		fpsimd_update_current_state(&fpsimd);
 
-out_preempt:
-	preempt_enable();
-
 	return err;
 }
 
-- 
2.1.4
