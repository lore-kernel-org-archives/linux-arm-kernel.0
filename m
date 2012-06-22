From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:07:00 +0100
Subject: [RFC PATCH 2/8] Revert "arm: new way of handling
 ERESTART_RESTARTBLOCK"
In-Reply-To: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
References: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
Message-ID: <1340377626-17075-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This reverts commit 6b5c8045ecc7e726cdaa2a9d9c8e5008050e1252.

Conflicts:

	arch/arm/kernel/ptrace.c

The new syscall restarting code can lead to problems if we take an
interrupt in userspace just before restarting the svc instruction. If
a signal is delivered when returning from the interrupt, the
TIF_SYSCALL_RESTARTSYS will remain set and cause any syscalls executed
from the signal handler to be treated as a restart of the previously
interrupted system call. This includes the final sigreturn call, meaning
that we may fail to exit from the signal context. Furthermore, if a
system call made from the signal handler requires a restart via the
restart_block, it is possible to clear the thread flag and fail to
restart the originally interrupted system call.

The right solution to this problem is to perform the restarting in the
kernel, avoiding the possibility of handling a further signal before the
restart is complete. Since we're almost at -rc4, let's revert the new
method for now and aim for in-kernel restarting at a later date.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/thread_info.h |    5 +----
 arch/arm/kernel/ptrace.c           |    3 ---
 arch/arm/kernel/signal.c           |   33 +++++++++++++++++++++++++++------
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index b79f8e9..af7b0bd 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -148,7 +148,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
 #define TIF_SYSCALL_TRACE	8
 #define TIF_SYSCALL_AUDIT	9
-#define TIF_SYSCALL_RESTARTSYS	10
 #define TIF_POLLING_NRFLAG	16
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
@@ -164,11 +163,9 @@ extern int vfp_restore_user_hwstate(struct user_vfp __user *,
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_USING_IWMMXT	(1 << TIF_USING_IWMMXT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
-#define _TIF_SYSCALL_RESTARTSYS	(1 << TIF_SYSCALL_RESTARTSYS)
 
 /* Checks for any syscall work in entry-common.S */
-#define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-			   _TIF_SYSCALL_RESTARTSYS)
+#define _TIF_SYSCALL_WORK (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT)
 
 /*
  * Change these and you break ASM code in entry-common.S
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 5700a7a..14e3826 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -25,7 +25,6 @@
 #include <linux/regset.h>
 #include <linux/audit.h>
 #include <linux/tracehook.h>
-#include <linux/unistd.h>
 
 #include <asm/pgtable.h>
 #include <asm/traps.h>
@@ -918,8 +917,6 @@ asmlinkage int syscall_trace(int why, struct pt_regs *regs, int scno)
 		audit_syscall_entry(AUDIT_ARCH_ARM, scno, regs->ARM_r0,
 				    regs->ARM_r1, regs->ARM_r2, regs->ARM_r3);
 
-	if (why == 0 && test_and_clear_thread_flag(TIF_SYSCALL_RESTARTSYS))
-		scno = __NR_restart_syscall - __NR_SYSCALL_BASE;
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return scno;
 
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 6d3bce5..536c5d6 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -605,10 +605,12 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		case -ERESTARTNOHAND:
 		case -ERESTARTSYS:
 		case -ERESTARTNOINTR:
-		case -ERESTART_RESTARTBLOCK:
 			regs->ARM_r0 = regs->ARM_ORIG_r0;
 			regs->ARM_pc = restart_addr;
 			break;
+		case -ERESTART_RESTARTBLOCK:
+			regs->ARM_r0 = -EINTR;
+			break;
 		}
 	}
 
@@ -624,14 +626,12 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		 * debugger has chosen to restart at a different PC.
 		 */
 		if (regs->ARM_pc == restart_addr) {
-			if (retval == -ERESTARTNOHAND ||
-			    retval == -ERESTART_RESTARTBLOCK
+			if (retval == -ERESTARTNOHAND
 			    || (retval == -ERESTARTSYS
 				&& !(ka.sa.sa_flags & SA_RESTART))) {
 				regs->ARM_r0 = -EINTR;
 				regs->ARM_pc = continue_addr;
 			}
-			clear_thread_flag(TIF_SYSCALL_RESTARTSYS);
 		}
 
 		handle_signal(signr, &ka, &info, regs);
@@ -645,8 +645,29 @@ static void do_signal(struct pt_regs *regs, int syscall)
 		 * ignore the restart.
 		 */
 		if (retval == -ERESTART_RESTARTBLOCK
-		    && regs->ARM_pc == restart_addr)
-			set_thread_flag(TIF_SYSCALL_RESTARTSYS);
+		    && regs->ARM_pc == continue_addr) {
+			if (thumb_mode(regs)) {
+				regs->ARM_r7 = __NR_restart_syscall - __NR_SYSCALL_BASE;
+				regs->ARM_pc -= 2;
+			} else {
+#if defined(CONFIG_AEABI) && !defined(CONFIG_OABI_COMPAT)
+				regs->ARM_r7 = __NR_restart_syscall;
+				regs->ARM_pc -= 4;
+#else
+				u32 __user *usp;
+
+				regs->ARM_sp -= 4;
+				usp = (u32 __user *)regs->ARM_sp;
+
+				if (put_user(regs->ARM_pc, usp) == 0) {
+					regs->ARM_pc = KERN_RESTART_CODE;
+				} else {
+					regs->ARM_sp += 4;
+					force_sigsegv(0, current);
+				}
+#endif
+			}
+		}
 	}
 
 	restore_saved_sigmask();
-- 
1.7.4.1
