From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:39:07 +0000
Subject: [RFC PATCH 19/29] arm64/sve: Avoid corruption when replacing the SVE
 state
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-20-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If preemption occurs during replacement of the whole SVE state,
as occurs during execve() or rt_sigreturn(), then some or all of
the new state for the thread can be lost, due to erroneous saving
of the pre-existing state over the new data.

This patch disables preemption around the affected operations to
avoid this failure mode.

This should be reexamined later if the impact on preemption latency
proves to be excessive.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 4 ++++
 arch/arm64/kernel/signal.c | 9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index b1a8d3e..cda079e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -198,6 +198,8 @@ void fpsimd_thread_switch(struct task_struct *next)
 
 void fpsimd_flush_thread(void)
 {
+	preempt_disable();
+
 	fpsimd_flush_task_state(current);
 
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
@@ -213,6 +215,8 @@ void fpsimd_flush_thread(void)
 	}
 
 	set_thread_flag(TIF_FOREIGN_FPSTATE);
+
+	preempt_enable();
 }
 
 /*
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 2697d09..129b016 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -256,6 +256,10 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 	if (vl != sve_get_vl())
 		return -EINVAL;
 
+	preempt_disable();
+
+	set_thread_flag(TIF_FOREIGN_FPSTATE);
+
 	BUG_ON(SVE_SIG_REGS_SIZE(vq) > sizeof(*task_sve_regs));
 	BUG_ON(round_up(SVE_SIG_REGS_SIZE(vq), 16) < sizeof(*task_sve_regs));
 	BUG_ON(SVE_SIG_FFR_OFFSET(vq) - SVE_SIG_REGS_OFFSET !=
@@ -265,7 +269,7 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 					SVE_SIG_REGS_OFFSET,
 			       SVE_SIG_REGS_SIZE(vq));
 	if (err)
-		return err;
+		goto out_preempt;
 
 	/* copy the FP and status/control registers */
 	/* restore_sigframe() already checked that user->fpsimd != NULL. */
@@ -278,6 +282,9 @@ static int __restore_sve_fpsimd_context(struct user_ctxs *user,
 	if (!err)
 		fpsimd_update_current_state(&fpsimd);
 
+out_preempt:
+	preempt_enable();
+
 	return err;
 }
 
-- 
2.1.4
