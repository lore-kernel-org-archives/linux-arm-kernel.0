From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  1 Mar 2016 14:18:50 +0000
Subject: [PATCHv4] arm64: Rework valid_user_regs
Message-ID: <1456841930-16602-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/ptrace.h | 33 +++--------------
 arch/arm64/kernel/ptrace.c      | 80 +++++++++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/signal.c      |  4 +--
 arch/arm64/kernel/signal32.c    |  2 +-
 4 files changed, 85 insertions(+), 34 deletions(-)

Since v1 [1]:
* Clear the full complement of RES0 bits
* Treat IL as RES0
* Treat SS as RES0 when not tracing
* renames: s/aa64/native, s/aa32/compat/

Since v2 [2]:
* Kill PSR_{f,s,x} and refer to fields explicitly
* Add COMPAT_PSR_GE_MASK

Since v3 [3]:
* Add comment for AArch32 preserved bits

Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/406424.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/407386.html
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/408675.html

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e9e5467..a307eb6 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -58,6 +58,7 @@
 #define COMPAT_PSR_Z_BIT	0x40000000
 #define COMPAT_PSR_N_BIT	0x80000000
 #define COMPAT_PSR_IT_MASK	0x0600fc00	/* If-Then execution state mask */
+#define COMPAT_PSR_GE_MASK	0x000f0000
 
 #ifdef CONFIG_CPU_BIG_ENDIAN
 #define COMPAT_PSR_ENDSTATE	COMPAT_PSR_E_BIT
@@ -151,35 +152,9 @@ static inline unsigned long regs_return_value(struct pt_regs *regs)
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
index ff7f132..3f6cd5c 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -500,7 +500,7 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	if (ret)
 		return ret;
 
-	if (!valid_user_regs(&newregs))
+	if (!valid_user_regs(&newregs, target))
 		return -EINVAL;
 
 	task_pt_regs(target)->user_regs = newregs;
@@ -770,7 +770,7 @@ static int compat_gpr_set(struct task_struct *target,
 
 	}
 
-	if (valid_user_regs(&newregs.user_regs))
+	if (valid_user_regs(&newregs.user_regs, target))
 		*task_pt_regs(target) = newregs;
 	else
 		ret = -EINVAL;
@@ -1272,3 +1272,79 @@ asmlinkage void syscall_trace_exit(struct pt_regs *regs)
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
+	if (!system_supports_mixed_endian_el0()) {
+		if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
+			regs->pstate |= COMPAT_PSR_E_BIT;
+		else
+			regs->pstate &= ~COMPAT_PSR_E_BIT;
+	}
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
index e18c48c..a8eafdb 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -115,7 +115,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	 */
 	regs->syscallno = ~0UL;
 
-	err |= !valid_user_regs(&regs->user_regs);
+	err |= !valid_user_regs(&regs->user_regs, current);
 
 	if (err == 0) {
 		struct fpsimd_context *fpsimd_ctx =
@@ -307,7 +307,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	/*
 	 * Check that the resulting registers are actually sane.
 	 */
-	ret |= !valid_user_regs(&regs->user_regs);
+	ret |= !valid_user_regs(&regs->user_regs, current);
 
 	/*
 	 * Fast forward the stepping logic so we step into the signal
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 71ef6dc..1073356 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -356,7 +356,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	 */
 	regs->syscallno = ~0UL;
 
-	err |= !valid_user_regs(&regs->user_regs);
+	err |= !valid_user_regs(&regs->user_regs, current);
 
 	aux = (struct compat_aux_sigframe __user *) sf->uc.uc_regspace;
 	if (err == 0)
-- 
1.9.1
