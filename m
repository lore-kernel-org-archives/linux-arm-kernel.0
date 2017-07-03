From: panand@redhat.com (Pratyush Anand)
Date: Tue,  4 Jul 2017 00:40:27 +0530
Subject: [PATCH 2/2] arm64: disable irq between breakpoint and step exception
In-Reply-To: <cover.1499107909.git.panand@redhat.com>
References: <cover.1499107909.git.panand@redhat.com>
Message-ID: <082c1ea9eebfd3e08bae5f26c2ba70f15c361664.1499107909.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an interrupt is generated between breakpoint and step handler then
step handler can not get correct step address. This situation can easily
be invoked by samples/hw_breakpoint/data_breakpoint.c. It can also be
reproduced if we insert any printk() statement or dump_stack() in perf
overflow_handler. So, it seems that perf is working fine just luckily.
If the CPU which is handling perf breakpoint handler receives any
interrupt then, perf step handler will not execute sanely.

This patch improves do_debug_exception() handling, which enforces now,
that exception handler function:
- should return 0 for any software breakpoint and hw
breakpoint/watchpoint handler if it does not expect a single step stage
- should return 1 if it expects single step.
- A single step handler should always return 0.
- All handler should return a -ve error in any other case.

Now, we can know in do_debug_exception() that whether a step exception
will be followed or not. If there will a step exception then disable
irq. Re-enable it after single step handling.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/debug-monitors.c |  3 +++
 arch/arm64/kernel/hw_breakpoint.c  |  4 ++--
 arch/arm64/mm/fault.c              | 22 ++++++++++++++++++----
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index d618e25c3de1..16f29f853b54 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -325,6 +325,9 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 		return -EFAULT;
 	}
 
+	if (kernel_active_single_step() || test_thread_flag(TIF_SINGLESTEP))
+		return 1;
+
 	return 0;
 }
 NOKPROBE_SYMBOL(brk_handler);
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 46dbbf94f72d..cb0d6cbdb767 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -698,7 +698,7 @@ static int breakpoint_handler(unsigned long unused, unsigned int esr,
 		}
 	}
 
-	return 0;
+	return 1;
 }
 NOKPROBE_SYMBOL(breakpoint_handler);
 
@@ -843,7 +843,7 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 		}
 	}
 
-	return 0;
+	return 1;
 }
 NOKPROBE_SYMBOL(watchpoint_handler);
 
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 37b95dff0b07..ce5290dacba3 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -653,6 +653,13 @@ static struct fault_info __refdata debug_fault_info[] = {
 	{ do_bad,	SIGBUS,		0,		"unknown 7"		},
 };
 
+/*
+ * fn should return 0 from any software breakpoint and hw
+ * breakpoint/watchpoint handler if it does not expect a single step stage
+ * and 1 if it expects single step followed by its execution. A single step
+ * handler should always return 0. All handler should return a -ve error in
+ * any other case.
+ */
 void __init hook_debug_fault_code(int nr,
 				  int (*fn)(unsigned long, unsigned int, struct pt_regs *),
 				  int sig, int code, const char *name)
@@ -665,6 +672,8 @@ void __init hook_debug_fault_code(int nr,
 	debug_fault_info[nr].name	= name;
 }
 
+static DEFINE_PER_CPU(bool, irq_enable_needed);
+
 asmlinkage int __exception do_debug_exception(unsigned long addr,
 					      unsigned int esr,
 					      struct pt_regs *regs)
@@ -672,6 +681,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	const struct fault_info *inf = debug_fault_info + DBG_ESR_EVT(esr);
 	struct siginfo info;
 	int rv;
+	bool *irq_en_needed = this_cpu_ptr(&irq_enable_needed);
 
 	/*
 	 * Tell lockdep we disabled irqs in entry.S. Do nothing if they were
@@ -680,9 +690,8 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 	if (interrupts_enabled(regs))
 		trace_hardirqs_off();
 
-	if (!inf->fn(addr, esr, regs)) {
-		rv = 1;
-	} else {
+	rv = inf->fn(addr, esr, regs);
+	if (rv < 0) {
 		pr_alert("Unhandled debug exception: %s (0x%08x)@0x%016lx\n",
 			 inf->name, esr, addr);
 
@@ -691,7 +700,12 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 		info.si_code  = inf->code;
 		info.si_addr  = (void __user *)addr;
 		arm64_notify_die("", regs, &info, 0);
-		rv = 0;
+	} else if (rv == 1 && interrupts_enabled(regs)) {
+		regs->pstate |= PSR_I_BIT;
+		*irq_en_needed = true;
+	} else if (rv == 0 && *irq_en_needed) {
+		regs->pstate &= ~PSR_I_BIT;
+		*irq_en_needed = false;
 	}
 
 	if (interrupts_enabled(regs))
-- 
2.9.3
