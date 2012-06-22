From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:07:05 +0100
Subject: [RFC PATCH 7/8] ARM: signal: perform restart_block system call
 restarting in the kernel
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377626-17075-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves the restart_block system call restarting into the
kernel and avoids a problematic return to userspace when restarting
system calls failing with -ERESTART_RESTARTBLOCK.

Rather than fake up an svc invocation from kernel space, this patch
jumps directly to a wrapper around sys_restart_syscall on the return
to userspace path if a restart is pending. This allows us to enable
interrupts during do_signal (required by the freezer code) and also
correctly abort a pending restart if we process further signals that
invalidate the restart requirements.

Heavily-inspired-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/ptrace.h      |    3 +
 arch/arm/include/asm/thread_info.h |    6 ++-
 arch/arm/kernel/calls.S            |    2 +-
 arch/arm/kernel/entry-common.S     |    5 ++
 arch/arm/kernel/signal.c           |   86 ++++++++++++++++++------------------
 5 files changed, 57 insertions(+), 45 deletions(-)

diff --git a/arch/arm/include/asm/ptrace.h b/arch/arm/include/asm/ptrace.h
index 355ece5..93908d5 100644
--- a/arch/arm/include/asm/ptrace.h
+++ b/arch/arm/include/asm/ptrace.h
@@ -254,6 +254,9 @@ static inline unsigned long user_stack_pointer(struct pt_regs *regs)
 	return regs->ARM_sp;
 }
 
+extern int syscall_trace_enter(struct pt_regs *regs, int scno);
+extern int syscall_trace_exit(struct pt_regs *regs, int scno);
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index af7b0bd..d3d1689 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -65,6 +65,7 @@ struct thread_info {
 #ifdef CONFIG_ARM_THUMBEE
 	unsigned long		thumbee_state;	/* ThumbEE Handler Base register */
 #endif
+	unsigned long		restart_addr;
 	struct restart_block	restart_block;
 };
 
@@ -136,7 +137,8 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 /*
  * thread information flags:
  *  TIF_SYSCALL_TRACE	- syscall trace active
- *  TIF_SYSCAL_AUDIT	- syscall auditing active
+ *  TIF_SYSCALL_AUDIT	- syscall auditing active
+ *  TIF_SYSCALL_RESTART - syscall restart in progress
  *  TIF_SIGPENDING	- signal pending
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_NOTIFY_RESUME	- callback before returning to user
@@ -148,6 +150,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
+#define TIF_SYSCALL_RESTART	10
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -160,6 +163,7 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_SYSCALL_RESTART	(1 << TIF_SYSCALL_RESTART)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
index 463ff4a..252a140 100644
--- a/arch/arm/kernel/calls.S
+++ b/arch/arm/kernel/calls.S
@@ -9,7 +9,7 @@
  *
  *  This file is included thrice in entry-common.S
  */
-/* 0 */		CALL(sys_restart_syscall)
+/* 0 */		CALL(sys_ni_syscall)		/* was sys_restart_syscall */
 		CALL(sys_exit)
 		CALL(sys_fork_wrapper)
 		CALL(sys_read)
diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
index 49d9f93..c2085bf 100644
--- a/arch/arm/kernel/entry-common.S
+++ b/arch/arm/kernel/entry-common.S
@@ -51,6 +51,7 @@ ret_fast_syscall:
 fast_work_pending:
 	str	r0, [sp, #S_R0+S_OFF]!		@ returned r0
 work_pending:
+	enable_irq
 	tst	r1, #_TIF_NEED_RESCHED
 	bne	work_resched
 	/*
@@ -79,6 +80,10 @@ ENTRY(ret_to_user_from_irq)
 	tst	r1, #_TIF_WORK_MASK
 	bne	work_pending
 no_work_pending:
+	tst	r1, #_TIF_SYSCALL_RESTART
+	adrne	lr, ret_slow_syscall
+	movne	why, #1
+	bne	do_sys_restart_syscall
 #if defined(CONFIG_IRQSOFF_TRACER)
 	asm_trace_hardirqs_on
 #endif
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 536c5d6..8250475 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -11,6 +11,7 @@
 #include <linux/signal.h>
 #include <linux/personality.h>
 #include <linux/freezer.h>
+#include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 
@@ -584,17 +585,17 @@ handle_signal(unsigned long sig, struct k_sigaction *ka,
  */
 static void do_signal(struct pt_regs *regs, int syscall)
 {
-	unsigned int retval = 0, continue_addr = 0, restart_addr = 0;
+	unsigned int retval = 0;
 	struct k_sigaction ka;
 	siginfo_t info;
 	int signr;
+	struct thread_info *thread = current_thread_info();
 
 	/*
 	 * If we were from a system call, check for system call restarting...
 	 */
 	if (syscall) {
-		continue_addr = regs->ARM_pc;
-		restart_addr = continue_addr - (thumb_mode(regs) ? 2 : 4);
+		thread->restart_addr = regs->ARM_pc - (thumb_mode(regs) ? 2 : 4);
 		retval = regs->ARM_r0;
 
 		/*
@@ -605,11 +606,9 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
-			regs->ARM_r0 = regs->ARM_ORIG_r0;
-			regs->ARM_pc = restart_addr;
-			break;
 		case -ERESTART_RESTARTBLOCK:
-			regs->ARM_r0 = -EINTR;
+			regs->ARM_r0 = regs->ARM_ORIG_r0;
+			regs->ARM_pc = thread->restart_addr;
 			break;
 		}
 	}
@@ -625,12 +624,17 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		 * decision to restart the system call.  But skip this if a
 		 * debugger has chosen to restart at a different PC.
 		 */
-		if (regs->ARM_pc == restart_addr) {
-			if (retval == -ERESTARTNOHAND
-			    || (retval == -ERESTARTSYS
-				&& !(ka.sa.sa_flags & SA_RESTART))) {
+		if (regs->ARM_pc == thread->restart_addr) {
+			switch (retval) {
+			case -ERESTARTSYS:
+				if (ka.sa.sa_flags & SA_RESTART)
+					break;
+			case -ERESTARTNOHAND:
+			case -ERESTART_RESTARTBLOCK:
 				regs->ARM_r0 = -EINTR;
-				regs->ARM_pc = continue_addr;
+				regs->ARM_pc += thumb_mode(regs) ? 2 : 4;
+				thread->restart_addr = 0;
+				clear_thread_flag(TIF_SYSCALL_RESTART);
 			}
 		}
 
@@ -638,37 +642,14 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		return;
 	}
 
-	if (syscall) {
-		/*
-		 * Handle restarting a different system call.  As above,
-		 * if a debugger has chosen to restart at a different PC,
-		 * ignore the restart.
-		 */
-		if (retval == -ERESTART_RESTARTBLOCK
-		    && regs->ARM_pc == continue_addr) {
-			if (thumb_mode(regs)) {
-				regs->ARM_r7 = __NR_restart_syscall - __NR_SYSCALL_BASE;
-				regs->ARM_pc -= 2;
-			} else {
-#if defined(CONFIG_AEABI) && !defined(CONFIG_OABI_COMPAT)
-				regs->ARM_r7 = __NR_restart_syscall;
-				regs->ARM_pc -= 4;
-#else
-				u32 __user *usp;
-
-				regs->ARM_sp -= 4;
-				usp = (u32 __user *)regs->ARM_sp;
-
-				if (put_user(regs->ARM_pc, usp) == 0) {
-					regs->ARM_pc = KERN_RESTART_CODE;
-				} else {
-					regs->ARM_sp += 4;
-					force_sigsegv(0, current);
-				}
-#endif
-			}
-		}
-	}
+	/*
+	 * Handle restarting a different system call.  As above,
+	 * if a debugger has chosen to restart at a different PC,
+	 * ignore the restart.
+	 */
+	if (syscall && retval == -ERESTART_RESTARTBLOCK &&
+	    regs->ARM_pc == thread->restart_addr)
+		set_thread_flag(TIF_SYSCALL_RESTART);
 
 	restore_saved_sigmask();
 }
@@ -684,3 +665,22 @@ do_notify_resume(struct pt_regs *regs, unsigned int thread_flags, int syscall)
 		tracehook_notify_resume(regs);
 	}
 }
+
+asmlinkage void
+do_sys_restart_syscall(void)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	regs->ARM_pc += thumb_mode(regs) ? 2 : 4;
+
+	syscall_trace_enter(regs, __NR_restart_syscall);
+
+	if (test_and_clear_thread_flag(TIF_SYSCALL_RESTART)) {
+		local_irq_enable();
+		regs->ARM_r0 = sys_restart_syscall();
+	} else {
+		pr_warning("Attempt to restart syscall without thread flag set!\n");
+		regs->ARM_r0 = -EINTR;
+	}
+
+	syscall_trace_exit(regs, __NR_restart_syscall);
+}
-- 
1.7.4.1
