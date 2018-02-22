From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:53 +0000
Subject: [PATCH 5/9] arm64: Pass user fault info to arm64_notify_die instead
 of printing it
In-Reply-To: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
References: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
Message-ID: <1519308057-4953-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need for callers of arm64_notify_die to print information
about user faults. Instead, they can pass a string to arm64_notify_die
which will be printed subject to show_unhandled_signals.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/fault.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index bff11553eb05..fd5928afd9cd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -582,8 +582,6 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 	const struct fault_info *inf;
 
 	inf = esr_to_fault_info(esr);
-	pr_err("Synchronous External Abort: %s (0x%08x) at 0x%016lx\n",
-		inf->name, esr, addr);
 
 	/*
 	 * Synchronous aborts may interrupt code which had interrupts masked.
@@ -607,7 +605,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
 		info.si_addr = NULL;
 	else
 		info.si_addr  = (void __user *)addr;
-	arm64_notify_die("", regs, &info, esr);
+	arm64_notify_die(inf->name, regs, &info, esr);
 
 	return 0;
 }
@@ -698,19 +696,17 @@ asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
 	if (!inf->fn(addr, esr, regs))
 		return;
 
-	pr_alert("Unhandled fault: %s at 0x%016lx\n",
-		 inf->name, addr);
-
-	mem_abort_decode(esr);
-
-	if (!user_mode(regs))
+	if (!user_mode(regs)) {
+		pr_alert("Unhandled fault at 0x%016lx\n", addr);
+		mem_abort_decode(esr);
 		show_pte(addr);
+	}
 
 	info.si_signo = inf->sig;
 	info.si_errno = 0;
 	info.si_code  = inf->code;
 	info.si_addr  = (void __user *)addr;
-	arm64_notify_die("", regs, &info, esr);
+	arm64_notify_die(inf->name, regs, &info, esr);
 }
 
 asmlinkage void __exception do_el0_irq_bp_hardening(void)
@@ -741,7 +737,6 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 					   struct pt_regs *regs)
 {
 	struct siginfo info;
-	struct task_struct *tsk = current;
 
 	if (user_mode(regs)) {
 		if (instruction_pointer(regs) > TASK_SIZE)
@@ -749,17 +744,11 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 		local_irq_enable();
 	}
 
-	if (show_unhandled_signals && unhandled_signal(tsk, SIGBUS))
-		pr_info_ratelimited("%s[%d]: %s exception: pc=%p sp=%p\n",
-				    tsk->comm, task_pid_nr(tsk),
-				    esr_get_class_string(esr), (void *)regs->pc,
-				    (void *)regs->sp);
-
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code  = BUS_ADRALN;
 	info.si_addr  = (void __user *)addr;
-	arm64_notify_die("Oops - SP/PC alignment exception", regs, &info, esr);
+	arm64_notify_die("SP/PC alignment exception", regs, &info, esr);
 }
 
 int __init early_brk64(unsigned long addr, unsigned int esr,
@@ -814,14 +803,11 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (!inf->fn(addr, esr, regs)) {
 		rv = 1;
 	} else {
-		pr_alert("Unhandled debug exception: %s (0x%08x) at 0x%016lx\n",
-			 inf->name, esr, addr);
-
 		info.si_signo = inf->sig;
 		info.si_errno = 0;
 		info.si_code  = inf->code;
 		info.si_addr  = (void __user *)addr;
-		arm64_notify_die("", regs, &info, 0);
+		arm64_notify_die(inf->name, regs, &info, esr);
 		rv = 0;
 	}
 
-- 
2.1.4
