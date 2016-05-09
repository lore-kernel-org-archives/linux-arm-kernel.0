From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  9 May 2016 17:49:49 +0100
Subject: [PATCH 5/6] arm64: consolidate signal injection on emulation errors
In-Reply-To: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462812590-4494-6-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code for injecting a signal into userland if a trapped instruction
fails emulation due to a _userland_ error (like an illegal address)
will be used more often with the next patch.
Factor out the core functionality into a separate function and use
that both for the existing trap handler and for the deprecated
instructions emulation.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/traps.h       |  3 +++
 arch/arm64/kernel/armv8_deprecated.c | 13 ++++------
 arch/arm64/kernel/traps.c            | 46 ++++++++++++++++++++++++++----------
 3 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 0cc2f29..b20ce2f 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -34,6 +34,9 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
+void force_signal_inject(int signal, int code, struct pt_regs *regs,
+			 unsigned long address);
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 static inline int __in_irqentry_text(unsigned long ptr)
 {
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index c37202c..4003843 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -321,21 +321,18 @@ static void __init register_insn_emulation_sysctl(struct ctl_table *table)
  */
 static void set_segfault(struct pt_regs *regs, unsigned long addr)
 {
-	siginfo_t info;
+	int code;
 
 	down_read(&current->mm->mmap_sem);
 	if (find_vma(current->mm, addr) == NULL)
-		info.si_code = SEGV_MAPERR;
+		code = SEGV_MAPERR;
 	else
-		info.si_code = SEGV_ACCERR;
+		code = SEGV_ACCERR;
 	up_read(&current->mm->mmap_sem);
 
-	info.si_signo = SIGSEGV;
-	info.si_errno = 0;
-	info.si_addr  = (void *) instruction_pointer(regs);
-
 	pr_debug("SWP{B} emulation: access caused memory abort!\n");
-	arm64_notify_die("Illegal memory access", regs, &info, 0);
+
+	force_signal_inject(SIGSEGV, code, regs, addr);
 }
 
 static int emulate_swpX(unsigned int address, unsigned int *data,
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index c539208..03755a4 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -373,30 +373,50 @@ exit:
 	return fn ? fn(regs, instr) : 1;
 }
 
-asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
+void force_signal_inject(int signal, int code, struct pt_regs *regs,
+			 unsigned long address)
 {
 	siginfo_t info;
 	void __user *pc = (void __user *)instruction_pointer(regs);
+	const char *desc;
 
-	/* check for AArch32 breakpoint instructions */
-	if (!aarch32_break_handler(regs))
-		return;
-
-	if (call_undef_hook(regs) == 0)
-		return;
+	switch (signal) {
+	case SIGILL:
+		desc = "undefined instruction";
+		break;
+	case SIGSEGV:
+		desc = "illegal memory access";
+		break;
+	default:
+		desc = "bad mode";
+		break;
+	}
 
-	if (unhandled_signal(current, SIGILL) && show_unhandled_signals_ratelimited()) {
-		pr_info("%s[%d]: undefined instruction: pc=%p\n",
-			current->comm, task_pid_nr(current), pc);
+	if (unhandled_signal(current, signal) &&
+	    show_unhandled_signals_ratelimited()) {
+		pr_info("%s[%d]: %s: pc=%p\n",
+			current->comm, task_pid_nr(current), desc, pc);
 		dump_instr(KERN_INFO, regs);
 	}
 
-	info.si_signo = SIGILL;
+	info.si_signo = signal;
 	info.si_errno = 0;
-	info.si_code  = ILL_ILLOPC;
+	info.si_code  = code;
 	info.si_addr  = pc;
 
-	arm64_notify_die("Oops - undefined instruction", regs, &info, 0);
+	arm64_notify_die(desc, regs, &info, 0);
+}
+
+asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
+{
+	/* check for AArch32 breakpoint instructions */
+	if (!aarch32_break_handler(regs))
+		return;
+
+	if (call_undef_hook(regs) == 0)
+		return;
+
+	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
 long compat_arm_syscall(struct pt_regs *regs);
-- 
2.7.3
