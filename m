From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 12:36:36 +0100
Subject: [PATCH 1/2] arm64: fpsimd: Fix FPSIMD corruption in rt_sigreturn with
 CONFIG_PREEMPT
Message-ID: <1442316997-32282-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave P Martin <Dave.Martin@arm.com>

The arm64 context switch implementation uses a flag
TIF_FOREIGN_FPSTATE to track whether the hardware FPSIMD regs are
out of sync with the logical state of current's registers.

During sigreturn, the registers and task_struct are temporarily out
of sync, between writing the task_struct and loading its contents
back into the FPSIMD registers -- however, TIF_FOREIGN_FPSTATE is
not set.  This can cause the context switch code to discard some or
all of the restored FPSIMD state if preemption occurs during the
critical region of rt_sigreturn.

This patch sets TIF_FOREIGN_FPSTATE before transferring the
sigframe's saved registers back to the task_struct, so that the
task_struct data will take precedence over the hardware registers
if a context switch occurs before everything is back in sync.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
[will: removed preempt_{enable,disable} calls, added compat version]
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/signal.c   | 3 +++
 arch/arm64/kernel/signal32.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e18c48cb6db1..6d50d839b6e9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -79,6 +79,9 @@ static int restore_fpsimd_context(struct fpsimd_context __user *ctx)
 	if (magic != FPSIMD_MAGIC || size != sizeof(struct fpsimd_context))
 		return -EINVAL;
 
+	/* Ensure we don't reload stale data from the hardware registers */
+	set_ti_thread_flag(current_thread_info(), TIF_FOREIGN_FPSTATE);
+
 	/* copy the FP and status/control registers */
 	err = __copy_from_user(fpsimd.vregs, ctx->vregs,
 			       sizeof(fpsimd.vregs));
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 948f0ad2de23..ae46ffad5aea 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -273,6 +273,8 @@ static int compat_restore_vfp_context(struct compat_vfp_sigframe __user *frame)
 	if (magic != VFP_MAGIC || size != VFP_STORAGE_SIZE)
 		return -EINVAL;
 
+	set_ti_thread_flag(current_thread_info(), TIF_FOREIGN_FPSTATE);
+
 	/*
 	 * Copy the FP registers into the start of the fpsimd_state.
 	 * FIXME: Won't work if big endian.
-- 
2.1.4
