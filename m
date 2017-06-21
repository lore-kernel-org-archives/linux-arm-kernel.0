From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Jun 2017 16:00:43 +0100
Subject: [PATCH 2/3] arm64: ptrace: Flush FPSIMD regs back to thread_struct
 before reading
In-Reply-To: <1498057010-12028-1-git-send-email-Dave.Martin@arm.com>
References: <1498057010-12028-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1498057264-12211-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When reading the FPSIMD state of current (which occurs when dumping
core), it is possible that userspace has modified the FPSIMD
registers since the time the task was last scheduled out.  Such
changes are not guaranteed to be reflected immedately in
thread_struct.

As a result, a coredump can contain stale values for these
registers.  Reading the registers of a stopped task via ptrace is
unaffected.

This patch explicitly flushes the CPU state back to thread_struct
before dumping when operating on current, thus ensuring that
coredump contents are up to date.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/ptrace.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 0e5aaec..eeef01a 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -623,6 +623,10 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 {
 	struct user_fpsimd_state *uregs;
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
+
+	if (target == current)
+		fpsimd_preserve_current_state();
+
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, uregs, 0, -1);
 }
 
@@ -898,6 +902,9 @@ static int compat_vfp_get(struct task_struct *target,
 
 	uregs = &target->thread.fpsimd_state.user_fpsimd;
 
+	if (target == current)
+		fpsimd_preserve_current_state();
+
 	/*
 	 * The VFP registers are packed into the fpsimd_state, so they all sit
 	 * nicely together for us. We just need to create the fpscr separately.
-- 
2.1.4
