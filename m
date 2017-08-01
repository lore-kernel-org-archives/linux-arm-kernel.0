From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  1 Aug 2017 15:35:54 +0100
Subject: [PATCH v2 REPOST 2/2] arm64: Abstract syscallno manipulation
In-Reply-To: <1501598154-1663-1-git-send-email-Dave.Martin@arm.com>
References: <1501598154-1663-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1501598154-1663-3-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The -1 "no syscall" value is written in various ways, shared with
the user ABI in some places, and generally obscure.

This patch attempts to make things a little more consistent and
readable by replacing all these uses with a single #define.  A
couple of symbolic helpers are provided to clarify the intent
further.

Because the in-syscall check in do_signal() is changed from >= 0 to
!= NO_SYSCALL by this patch, different behaviour may be observable
if syscallno is set to values less than -1 by a tracer.  However,
this is not different from the behaviour that is already observable
if a tracer sets syscallno to a value >= __NR_(compat_)syscalls.

It appears that this can cause spurious syscall restarting, but
that is not a new behaviour either, and does not appear harmful.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/include/asm/ptrace.h    | 21 +++++++++++++++++++++
 arch/arm64/kernel/entry.S          | 10 ++++------
 arch/arm64/kernel/ptrace.c         |  2 +-
 arch/arm64/kernel/signal.c         | 10 +++++-----
 arch/arm64/kernel/signal32.c       |  2 +-
 6 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 379def1..b7334f1 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -112,7 +112,7 @@ void tls_preserve_current_state(void);
 static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 {
 	memset(regs, 0, sizeof(*regs));
-	regs->syscallno = ~0;
+	forget_syscall(regs);
 	regs->pc = pc;
 }
 
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 21c87dc..4f64373 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -72,8 +72,19 @@
 #define COMPAT_PT_TEXT_ADDR		0x10000
 #define COMPAT_PT_DATA_ADDR		0x10004
 #define COMPAT_PT_TEXT_END_ADDR		0x10008
+
+/*
+ * If pt_regs.syscallno == NO_SYSCALL, then the thread is not executing
+ * a syscall -- i.e., its most recent entry into the kernel from
+ * userspace was not via SVC, or otherwise a tracer cancelled the syscall.
+ *
+ * This must have the value -1, for ABI compatibility with ptrace etc.
+ */
+#define NO_SYSCALL (-1)
+
 #ifndef __ASSEMBLY__
 #include <linux/bug.h>
+#include <linux/types.h>
 
 /* sizeof(struct user) for AArch32 */
 #define COMPAT_USER_SZ	296
@@ -128,6 +139,16 @@ struct pt_regs {
 	u64 unused;	// maintain 16 byte alignment
 };
 
+static inline bool in_syscall(struct pt_regs const *regs)
+{
+	return regs->syscallno != NO_SYSCALL;
+}
+
+static inline void forget_syscall(struct pt_regs *regs)
+{
+	regs->syscallno = NO_SYSCALL;
+}
+
 #define MAX_REG_OFFSET offsetof(struct pt_regs, pstate)
 
 #define arch_has_single_step()	(1)
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 3bf0bd7..cace76d 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -138,11 +138,9 @@ alternative_else_nop_endif
 
 	stp	x22, x23, [sp, #S_PC]
 
-	/*
-	 * Set syscallno to -1 by default (overridden later if real syscall).
-	 */
+	/* Not in a syscall by default (el0_svc overwrites for real syscall) */
 	.if	\el == 0
-	mvn	w21, wzr
+	mov	w21, #NO_SYSCALL
 	str	w21, [sp, #S_SYSCALLNO]
 	.endif
 
@@ -825,13 +823,13 @@ ENDPROC(el0_svc)
 	 * switches, and waiting for our parent to respond.
 	 */
 __sys_trace:
-	cmp     wscno, #-1			// user-issued syscall(-1)?
+	cmp     wscno, #NO_SYSCALL		// user-issued syscall(-1)?
 	b.ne	1f
 	mov	x0, #-ENOSYS			// set default errno if so
 	str	x0, [sp, #S_X0]
 1:	mov	x0, sp
 	bl	syscall_trace_enter
-	cmp	w0, #-1				// skip the syscall?
+	cmp	w0, #NO_SYSCALL			// skip the syscall?
 	b.eq	__sys_trace_return_skipped
 	mov	wscno, w0			// syscall number (possibly new)
 	mov	x1, sp				// pointer to regs
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index de77480..28619b5 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1363,7 +1363,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 	if (dir == PTRACE_SYSCALL_EXIT)
 		tracehook_report_syscall_exit(regs, 0);
 	else if (tracehook_report_syscall_entry(regs))
-		regs->syscallno = ~0;
+		forget_syscall(regs);
 
 	regs->regs[regno] = saved_reg;
 }
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 4d04b89..4991e87 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -36,6 +36,7 @@
 #include <asm/ucontext.h>
 #include <asm/unistd.h>
 #include <asm/fpsimd.h>
+#include <asm/ptrace.h>
 #include <asm/signal32.h>
 #include <asm/vdso.h>
 
@@ -387,7 +388,7 @@ static int restore_sigframe(struct pt_regs *regs,
 	/*
 	 * Avoid sys_rt_sigreturn() restarting.
 	 */
-	regs->syscallno = ~0;
+	forget_syscall(regs);
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 	if (err == 0)
@@ -673,13 +674,12 @@ static void do_signal(struct pt_regs *regs)
 {
 	unsigned long continue_addr = 0, restart_addr = 0;
 	int retval = 0;
-	int syscall = regs->syscallno;
 	struct ksignal ksig;
 
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
-	if (syscall >= 0) {
+	if (in_syscall(regs)) {
 		continue_addr = regs->pc;
 		restart_addr = continue_addr - (compat_thumb_mode(regs) ? 2 : 4);
 		retval = regs->regs[0];
@@ -687,7 +687,7 @@ static void do_signal(struct pt_regs *regs)
 		/*
 		 * Avoid additional syscall restarting via ret_to_user.
 		 */
-		regs->syscallno = ~0;
+		forget_syscall(regs);
 
 		/*
 		 * Prepare for system call restart. We do this here so that a
@@ -731,7 +731,7 @@ static void do_signal(struct pt_regs *regs)
 	 * Handle restarting a different system call. As above, if a debugger
 	 * has chosen to restart at a different PC, ignore the restart.
 	 */
-	if (syscall >= 0 && regs->pc == restart_addr) {
+	if (in_syscall(regs) && regs->pc == restart_addr) {
 		if (retval == -ERESTART_RESTARTBLOCK)
 			setup_restart_syscall(regs);
 		user_rewind_single_step(current);
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index d98ca76..4e5a664 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -354,7 +354,7 @@ static int compat_restore_sigframe(struct pt_regs *regs,
 	/*
 	 * Avoid compat_sys_sigreturn() restarting.
 	 */
-	regs->syscallno = ~0;
+	forget_syscall(regs);
 
 	err |= !valid_user_regs(&regs->user_regs, current);
 
-- 
2.1.4
