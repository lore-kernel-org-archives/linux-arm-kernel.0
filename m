From: james.morse@arm.com (James Morse)
Date: Mon, 18 Jul 2016 13:27:25 +0100
Subject: [stable:PATCH] arm64: Rework valid_user_regs (v3.16)
In-Reply-To: <1468844845-6129-1-git-send-email-james.morse@arm.com>
References: <1468844845-6129-1-git-send-email-james.morse@arm.com>
Message-ID: <1468844845-6129-4-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

commit dbd4d7ca563fd0a8949718d35ce197e5642d5d9d upstream.

We validate pstate using PSR_MODE32_BIT, which is part of the
user-provided pstate (and cannot be trusted). Also, we conflate
validation of AArch32 and AArch64 pstate values, making the code
difficult to reason about.

Instead, validate the pstate value based on the associated task. The
task may or may not be current (e.g. when using ptrace), so this must be
passed explicitly by callers. To avoid circular header dependencies via
sched.h, is_compat_task is pulled out of asm/ptrace.h.

To make the code possible to reason about, the AArch64 and AArch32
validation is split into separate functions. Software must respect the
RES0 policy for SPSR bits, and thus the kernel mirrors the hardware
policy (RAZ/WI) for bits as-yet unallocated. When these acquire an
architected meaning writes may be permitted (potentially with additional
validation).

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
[ rebased for v3.16
  This avoids a user-triggerable Oops() if a task is switched to a mode
  not supported by the kernel (e.g. switching a 64-bit task to AArch32).

  v3.16 does not support SETEND, support for this was added by
  2d888f48e056 ("arm64: Emulate SETEND for AArch32 tasks") in v3.20
  This backport forces the kernel endianness on userspace.

  Added a DBG_SPSR_SS define hidden by #ifdefs to avoid conflicts with
  other backports.
]
Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> #3.16.x
---
For example, switching a task to 32bit mode, when the kernel
was not built with support for this will cause:
[   39.634111] Bad mode in Synchronous Abort handler detected, code 0x46000000
[   39.643381] CPU: 0 PID: 1712 Comm: inter Not tainted 3.16.36 #4514
[ ... ]
[   39.709287] Bad mode in Synchronous Abort handler detected, code 0x86000007
[   39.716180] CPU: 0 PID: 1712 Comm: inter Not tainted 3.16.36 #4514
[ ... ]
[   39.825750] Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
[   39.831608] Modules linked in:
[   39.834634] CPU: 0 PID: 1712 Comm: inter Not tainted 3.16.36 #4514

 arch/arm64/include/asm/ptrace.h | 34 +++--------------
 arch/arm64/kernel/ptrace.c      | 83 ++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/kernel/signal.c      |  4 +-
 arch/arm64/kernel/signal32.c    |  2 +-
 4 files changed, 89 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 88d6e2436808..300a382ed88f 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -58,6 +58,8 @@
 #define COMPAT_PSR_Z_BIT	0x40000000
 #define COMPAT_PSR_N_BIT	0x80000000
 #define COMPAT_PSR_IT_MASK	0x0600fc00	/* If-Then execution state mask */
+#define COMPAT_PSR_GE_MASK	0x000f0000
+
 /*
  * These are 'magic' values for PTRACE_PEEKUSR that return info about where a
  * process is located in memory.
@@ -144,35 +146,9 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
 	return regs->regs[0];
 }
 
-/*
- * Are the current registers suitable for user mode? (used to maintain
- * security in signal handlers)
- */
-static inline int valid_user_regs(struct user_pt_regs *regs)
-{
-	if (user_mode(regs) && (regs->pstate & PSR_I_BIT) == 0) {
-		regs->pstate &= ~(PSR_F_BIT | PSR_A_BIT);
-
-		/* The T bit is reserved for AArch64 */
-		if (!(regs->pstate & PSR_MODE32_BIT))
-			regs->pstate &= ~COMPAT_PSR_T_BIT;
-
-		return 1;
-	}
-
-	/*
-	 * Force PSR to something logical...
-	 */
-	regs->pstate &= PSR_f | PSR_s | (PSR_x & ~PSR_A_BIT) | \
-			COMPAT_PSR_T_BIT | PSR_MODE32_BIT;
-
-	if (!(regs->pstate & PSR_MODE32_BIT)) {
-		regs->pstate &= ~COMPAT_PSR_T_BIT;
-		regs->pstate |= PSR_MODE_EL0t;
-	}
-
-	return 0;
-}
+/* We must avoid circular header include via sched.h */
+struct task_struct;
+int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task);
 
 #define instruction_pointer(regs)	((unsigned long)(regs)->pc)
 
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index d2b9a3f7457d..e3360ad22fbc 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -45,6 +45,10 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
+#ifndef DBG_SPSR_SS
+#define DBG_SPSR_SS             (1 << 21)
+#endif
+
 /*
  * TODO: does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
@@ -497,7 +501,7 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	if (!valid_user_regs(&newregs))
+	if (!valid_user_regs(&newregs, target))
 		return -EINVAL;
 
 	task_pt_regs(target)->user_regs = newregs;
@@ -728,7 +732,7 @@ static int compat_gpr_set(struct task_struct *target,
 
 	}
 
-	if (valid_user_regs(&newregs.user_regs))
+	if (valid_user_regs(&newregs.user_regs, target))
 		*task_pt_regs(target) = newregs;
 	else
 		ret = -EINVAL;
@@ -1131,3 +1135,78 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_EXIT);
 }
+
+/*
+ * Bits which are always architecturally RES0 per ARM DDI 0487A.h
+ * Userspace cannot use these until they have an architectural meaning.
+ * We also reserve IL for the kernel; SS is handled dynamically.
+ */
+#define SPSR_EL1_AARCH64_RES0_BITS \
+	(GENMASK_ULL(63,32) | GENMASK_ULL(27, 22) | GENMASK_ULL(20, 10) | \
+	 GENMASK_ULL(5, 5))
+#define SPSR_EL1_AARCH32_RES0_BITS \
+	(GENMASK_ULL(63,32) | GENMASK_ULL(24, 22) | GENMASK_ULL(20,20))
+
+static int valid_compat_regs(struct user_pt_regs *regs)
+{
+	regs->pstate &= ~SPSR_EL1_AARCH32_RES0_BITS;
+
+	/* Force kernel endianness on user space */
+	if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+		regs->pstate |= COMPAT_PSR_E_BIT;
+	else
+		regs->pstate &= ~COMPAT_PSR_E_BIT;
+
+	if (user_mode(regs) && (regs->pstate & PSR_MODE32_BIT) &&
+	    (regs->pstate & COMPAT_PSR_A_BIT) == 0 &&
+	    (regs->pstate & COMPAT_PSR_I_BIT) == 0 &&
+	    (regs->pstate & COMPAT_PSR_F_BIT) == 0) {
+		return 1;
+	}
+
+	/*
+	 * Force PSR to a valid 32-bit EL0t, preserving the same bits as
+	 * arch/arm.
+	 */
+	regs->pstate &= COMPAT_PSR_N_BIT | COMPAT_PSR_Z_BIT |
+			COMPAT_PSR_C_BIT | COMPAT_PSR_V_BIT |
+			COMPAT_PSR_Q_BIT | COMPAT_PSR_IT_MASK |
+			COMPAT_PSR_GE_MASK | COMPAT_PSR_E_BIT |
+			COMPAT_PSR_T_BIT;
+	regs->pstate |= PSR_MODE32_BIT;
+
+	return 0;
+}
+
+static int valid_native_regs(struct user_pt_regs *regs)
+{
+	regs->pstate &= ~SPSR_EL1_AARCH64_RES0_BITS;
+
+	if (user_mode(regs) && !(regs->pstate & PSR_MODE32_BIT) &&
+	    (regs->pstate & PSR_D_BIT) == 0 &&
+	    (regs->pstate & PSR_A_BIT) == 0 &&
+	    (regs->pstate & PSR_I_BIT) == 0 &&
+	    (regs->pstate & PSR_F_BIT) == 0) {
+		return 1;
+	}
+
+	/* Force PSR to a valid 64-bit EL0t */
+	regs->pstate &= PSR_N_BIT | PSR_Z_BIT | PSR_C_BIT | PSR_V_BIT;
+
+	return 0;
+}
+
+/*
+ * Are the current registers suitable for user mode? (used to maintain
+ * security in signal handlers)
+ */
+int valid_user_regs(struct user_pt_regs *regs, struct task_struct *task)
+{
+	if (!test_tsk_thread_flag(task, TIF_SINGLESTEP))
+		regs->pstate &= ~DBG_SPSR_SS;
+
+	if (is_compat_thread(task_thread_info(task)))
+		return valid_compat_regs(regs);
+	else
+		return valid_native_regs(regs);
+}
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6357b9c6c90e..d1ae7c217ba9 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -115,7 +115,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	 */
 	regs->syscallno = ~0UL;
 
-	err |= !valid_user_regs(&regs->user_regs);
+	err |= !valid_user_regs(&regs->user_regs, current);
 
 	if (err == 0) {
 		struct fpsimd_context *fpsimd_ctx =
@@ -322,7 +322,7 @@ static void handle_signal(unsigned long sig, struct k_sigaction *ka,
 	/*
 	 * Check that the resulting registers are actually sane.
 	 */
-	ret |= !valid_user_regs(&regs->user_regs);
+	ret |= !valid_user_regs(&regs->user_regs, current);
 
 	if (ret != 0) {
 		force_sigsegv(sig, tsk);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index e3ac8f0c0fc7..03520c650701 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -350,7 +350,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	 */
 	regs->syscallno = ~0UL;
 
-	err |= !valid_user_regs(&regs->user_regs);
+	err |= !valid_user_regs(&regs->user_regs, current);
 
 	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
 	if (err == 0)
-- 
2.8.0.rc3
