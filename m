From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  8 Apr 2014 18:45:08 -0700
Subject: [PATCH] arm64: Add user_debug command line option
Message-ID: <1397007908-17993-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm had a useful command line option to print out debug
information on user signals. This is somewhat like a more verbose
version of show_unhandled_signals. Add the user_debug command line
option to print out more information in a similar manner to
arm.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/include/asm/system_misc.h | 25 +++++++++++++++++++++++++
 arch/arm64/kernel/traps.c            | 13 ++++++++++---
 arch/arm64/mm/fault.c                |  3 +--
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 7a18fab..2f95589 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -50,6 +50,31 @@ extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 #define UDBG_SEGV	(1 << 3)
 #define UDBG_BUS	(1 << 4)
 
+extern unsigned int user_debug;
+extern int show_unhandled_signals;
+
+static inline bool print_user_debug(unsigned int signum, unsigned int mask)
+{
+	int ret = 0;
+	bool sig_assert = false;
+
+	ret |= show_unhandled_signals &&
+		(signum ? unhandled_signal(current, signum) : 1);
+	if (mask & UDBG_SEGV) {
+		sig_assert = true;
+		ret |= (user_debug & mask) && signum == SIGSEGV;
+	}
+	if (mask & UDBG_BUS) {
+		sig_assert = true;
+		ret |= (user_debug & mask) && signum == SIGBUS;
+	}
+	if (sig_assert)
+		ret |= (user_debug & mask);
+
+	return ret ? printk_ratelimit() : false;
+}
+
+
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index a6740d0..5519ef1 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -48,6 +48,14 @@ static const char *handler[]= {
 };
 
 int show_unhandled_signals = 1;
+unsigned int user_debug;
+
+static int __init user_debug_setup(char *str)
+{
+	get_option(&str, &user_debug);
+	return 1;
+}
+__setup("user_debug=", user_debug_setup);
 
 /*
  * Dump out the contents of some memory nicely...
@@ -270,8 +278,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 
 	trace_undef_instr(regs, (void *)pc);
 
-	if (show_unhandled_signals && unhandled_signal(current, SIGILL) &&
-	    printk_ratelimit()) {
+	if (print_user_debug(SIGILL, UDBG_UNDEFINED)) {
 		pr_info("%s[%d]: undefined instruction: pc=%p\n",
 			current->comm, task_pid_nr(current), pc);
 		dump_instr(KERN_INFO, regs);
@@ -298,7 +305,7 @@ asmlinkage long do_ni_syscall(struct pt_regs *regs)
 	}
 #endif
 
-	if (show_unhandled_signals && printk_ratelimit()) {
+	if (print_user_debug(0, UDBG_SYSCALL)) {
 		pr_info("%s[%d]: syscall %d\n", current->comm,
 			task_pid_nr(current), (int)regs->syscallno);
 		dump_instr("", regs);
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 8e783eb..bbef0b5 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -117,8 +117,7 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
 
 	trace_user_fault(tsk, addr, esr);
 
-	if (show_unhandled_signals && unhandled_signal(tsk, sig) &&
-	    printk_ratelimit()) {
+	if (print_user_debug(sig, UDBG_BUS | UDBG_SEGV)) {
 		pr_info("%s[%d]: unhandled %s (%d) at 0x%08lx, esr 0x%03x\n",
 			tsk->comm, task_pid_nr(tsk), fault_name(esr), sig,
 			addr, esr);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
