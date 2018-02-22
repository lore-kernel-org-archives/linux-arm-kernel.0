From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:49 +0000
Subject: [PATCH 1/9] arm64: signal: Make force_signal_inject more robust
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

force_signal_inject is a little flakey:

  * It only knows about SIGILL and SIGSEGV, so can potentially deliver
    other signals based on a partially initialised siginfo_t

  * It sets si_addr to point at the PC for SIGSEGV

  * It always operates on current, so doesn't need the regs argument

This patch fixes these issues by always assigning the si_addr field to
the address parameter of the function and updates the callers (including
those that indirectly call via arm64_notify_segfault) accordingly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/traps.h |  6 ++----
 arch/arm64/kernel/fpsimd.c     |  5 ++---
 arch/arm64/kernel/traps.c      | 23 ++++++++++++-----------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 178e338d2889..1ee63dc38579 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -35,10 +35,8 @@ struct undef_hook {
 
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
-void force_signal_inject(int signal, int code, struct pt_regs *regs,
-			 unsigned long address);
-
-void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr);
+void force_signal_inject(int signal, int code, unsigned long address);
+void arm64_notify_segfault(unsigned long addr);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index e7226c4c7493..6964ff867d4a 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -285,8 +285,7 @@ static void task_fpsimd_save(void)
 				 * re-enter user with corrupt state.
 				 * There's no way to recover, so kill it:
 				 */
-				force_signal_inject(
-					SIGKILL, 0, current_pt_regs(), 0);
+				force_signal_inject(SIGKILL, 0, 0);
 				return;
 			}
 
@@ -831,7 +830,7 @@ asmlinkage void do_sve_acc(unsigned int esr, struct pt_regs *regs)
 {
 	/* Even if we chose not to use SVE, the hardware could still trap: */
 	if (unlikely(!system_supports_sve()) || WARN_ON(is_compat_task())) {
-		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
 		return;
 	}
 
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index eb2d15147e8d..c478d8e27649 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -311,12 +311,13 @@ static int call_undef_hook(struct pt_regs *regs)
 	return fn ? fn(regs, instr) : 1;
 }
 
-void force_signal_inject(int signal, int code, struct pt_regs *regs,
-			 unsigned long address)
+void force_signal_inject(int signal, int code, unsigned long address)
 {
 	siginfo_t info;
-	void __user *pc = (void __user *)instruction_pointer(regs);
 	const char *desc;
+	struct pt_regs *regs = current_pt_regs();
+
+	clear_siginfo(&info);
 
 	switch (signal) {
 	case SIGILL:
@@ -332,15 +333,15 @@ void force_signal_inject(int signal, int code, struct pt_regs *regs,
 
 	if (unhandled_signal(current, signal) &&
 	    show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: %s: pc=%p\n",
-			current->comm, task_pid_nr(current), desc, pc);
+		pr_info("%s[%d]: %s: pc=%08llx\n",
+			current->comm, task_pid_nr(current), desc, regs->pc);
 		dump_instr(KERN_INFO, regs);
 	}
 
 	info.si_signo = signal;
 	info.si_errno = 0;
 	info.si_code  = code;
-	info.si_addr  = pc;
+	info.si_addr  = (void __user *)address;
 
 	arm64_notify_die(desc, regs, &info, 0);
 }
@@ -348,7 +349,7 @@ void force_signal_inject(int signal, int code, struct pt_regs *regs,
 /*
  * Set up process info to signal segmentation fault - called on access error.
  */
-void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr)
+void arm64_notify_segfault(unsigned long addr)
 {
 	int code;
 
@@ -359,7 +360,7 @@ void arm64_notify_segfault(struct pt_regs *regs, unsigned long addr)
 		code = SEGV_ACCERR;
 	up_read(&current->mm->mmap_sem);
 
-	force_signal_inject(SIGSEGV, code, regs, addr);
+	force_signal_inject(SIGSEGV, code, addr);
 }
 
 asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
@@ -371,7 +372,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	if (call_undef_hook(regs) == 0)
 		return;
 
-	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+	force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
 }
 
 int cpu_enable_cache_maint_trap(void *__unused)
@@ -426,12 +427,12 @@ static void user_cache_maint_handler(unsigned int esr, struct pt_regs *regs)
 		__user_cache_maint("ic ivau", address, ret);
 		break;
 	default:
-		force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
+		force_signal_inject(SIGILL, ILL_ILLOPC, regs->pc);
 		return;
 	}
 
 	if (ret)
-		arm64_notify_segfault(regs, address);
+		arm64_notify_segfault(address);
 	else
 		arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
 }
-- 
2.1.4
