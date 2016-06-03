From: dave.long@linaro.org (David Long)
Date: Thu,  2 Jun 2016 23:26:18 -0400
Subject: [PATCH v13 04/10] arm64: Blacklist non-kprobe-able symbol
In-Reply-To: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
References: <1464924384-15269-1-git-send-email-dave.long@linaro.org>
Message-ID: <1464924384-15269-5-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pratyush Anand <panand@redhat.com>

Add all function symbols which are called from do_debug_exception under
NOKPROBE_SYMBOL, as they can not kprobed.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/arm64ksyms.c     |  2 ++
 arch/arm64/kernel/debug-monitors.c | 18 ++++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c  |  8 ++++++++
 arch/arm64/kernel/kgdb.c           |  4 ++++
 arch/arm64/mm/fault.c              |  1 +
 5 files changed, 33 insertions(+)

diff --git a/arch/arm64/kernel/arm64ksyms.c b/arch/arm64/kernel/arm64ksyms.c
index 678f30b0..b96ff1a 100644
--- a/arch/arm64/kernel/arm64ksyms.c
+++ b/arch/arm64/kernel/arm64ksyms.c
@@ -27,6 +27,7 @@
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/arm-smccc.h>
+#include <linux/kprobes.h>
 
 #include <asm/checksum.h>
 
@@ -68,6 +69,7 @@ EXPORT_SYMBOL(test_and_change_bit);
 
 #ifdef CONFIG_FUNCTION_TRACER
 EXPORT_SYMBOL(_mcount);
+NOKPROBE_SYMBOL(_mcount);
 #endif
 
 	/* arm-smccc */
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 4fbf3c5..65ee636 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/kprobes.h>
 #include <linux/ptrace.h>
 #include <linux/stat.h>
 #include <linux/uaccess.h>
@@ -48,6 +49,7 @@ static void mdscr_write(u32 mdscr)
 	asm volatile("msr mdscr_el1, %0" :: "r" (mdscr));
 	local_dbg_restore(flags);
 }
+NOKPROBE_SYMBOL(mdscr_write);
 
 static u32 mdscr_read(void)
 {
@@ -55,6 +57,7 @@ static u32 mdscr_read(void)
 	asm volatile("mrs %0, mdscr_el1" : "=r" (mdscr));
 	return mdscr;
 }
+NOKPROBE_SYMBOL(mdscr_read);
 
 /*
  * Allow root to disable self-hosted debug from userspace.
@@ -103,6 +106,7 @@ void enable_debug_monitors(enum dbg_active_el el)
 		mdscr_write(mdscr);
 	}
 }
+NOKPROBE_SYMBOL(enable_debug_monitors);
 
 void disable_debug_monitors(enum dbg_active_el el)
 {
@@ -123,6 +127,7 @@ void disable_debug_monitors(enum dbg_active_el el)
 		mdscr_write(mdscr);
 	}
 }
+NOKPROBE_SYMBOL(disable_debug_monitors);
 
 /*
  * OS lock clearing.
@@ -173,6 +178,7 @@ static void set_regs_spsr_ss(struct pt_regs *regs)
 	spsr |= DBG_SPSR_SS;
 	regs->pstate = spsr;
 }
+NOKPROBE_SYMBOL(set_regs_spsr_ss);
 
 static void clear_regs_spsr_ss(struct pt_regs *regs)
 {
@@ -182,6 +188,7 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 	spsr &= ~DBG_SPSR_SS;
 	regs->pstate = spsr;
 }
+NOKPROBE_SYMBOL(clear_regs_spsr_ss);
 
 /* EL1 Single Step Handler hooks */
 static LIST_HEAD(step_hook);
@@ -225,6 +232,7 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 
 	return retval;
 }
+NOKPROBE_SYMBOL(call_step_hook);
 
 static void send_user_sigtrap(int si_code)
 {
@@ -279,6 +287,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(single_step_handler);
 
 /*
  * Breakpoint handler is re-entrant as another breakpoint can
@@ -316,6 +325,7 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 
 	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }
+NOKPROBE_SYMBOL(call_break_hook);
 
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
@@ -329,6 +339,7 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(brk_handler);
 
 int aarch32_break_handler(struct pt_regs *regs)
 {
@@ -365,6 +376,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	send_user_sigtrap(TRAP_BRKPT);
 	return 0;
 }
+NOKPROBE_SYMBOL(aarch32_break_handler);
 
 static int __init debug_traps_init(void)
 {
@@ -386,6 +398,7 @@ void user_rewind_single_step(struct task_struct *task)
 	if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
 		set_regs_spsr_ss(task_pt_regs(task));
 }
+NOKPROBE_SYMBOL(user_rewind_single_step);
 
 void user_fastforward_single_step(struct task_struct *task)
 {
@@ -401,6 +414,7 @@ void kernel_enable_single_step(struct pt_regs *regs)
 	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
 	enable_debug_monitors(DBG_ACTIVE_EL1);
 }
+NOKPROBE_SYMBOL(kernel_enable_single_step);
 
 void kernel_disable_single_step(void)
 {
@@ -408,12 +422,14 @@ void kernel_disable_single_step(void)
 	mdscr_write(mdscr_read() & ~DBG_MDSCR_SS);
 	disable_debug_monitors(DBG_ACTIVE_EL1);
 }
+NOKPROBE_SYMBOL(kernel_disable_single_step);
 
 int kernel_active_single_step(void)
 {
 	WARN_ON(!irqs_disabled());
 	return mdscr_read() & DBG_MDSCR_SS;
 }
+NOKPROBE_SYMBOL(kernel_active_single_step);
 
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
@@ -421,8 +437,10 @@ void user_enable_single_step(struct task_struct *task)
 	set_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
 	set_regs_spsr_ss(task_pt_regs(task));
 }
+NOKPROBE_SYMBOL(user_enable_single_step);
 
 void user_disable_single_step(struct task_struct *task)
 {
 	clear_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP);
 }
+NOKPROBE_SYMBOL(user_disable_single_step);
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index ce21aa8..26a6bf7 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -24,6 +24,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/errno.h>
 #include <linux/hw_breakpoint.h>
+#include <linux/kprobes.h>
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/smp.h>
@@ -127,6 +128,7 @@ static u64 read_wb_reg(int reg, int n)
 
 	return val;
 }
+NOKPROBE_SYMBOL(read_wb_reg);
 
 static void write_wb_reg(int reg, int n, u64 val)
 {
@@ -140,6 +142,7 @@ static void write_wb_reg(int reg, int n, u64 val)
 	}
 	isb();
 }
+NOKPROBE_SYMBOL(write_wb_reg);
 
 /*
  * Convert a breakpoint privilege level to the corresponding exception
@@ -157,6 +160,7 @@ static enum dbg_active_el debug_exception_level(int privilege)
 		return -EINVAL;
 	}
 }
+NOKPROBE_SYMBOL(debug_exception_level);
 
 enum hw_breakpoint_ops {
 	HW_BREAKPOINT_INSTALL,
@@ -575,6 +579,7 @@ static void toggle_bp_registers(int reg, enum dbg_active_el el, int enable)
 		write_wb_reg(reg, i, ctrl);
 	}
 }
+NOKPROBE_SYMBOL(toggle_bp_registers);
 
 /*
  * Debug exception handlers.
@@ -654,6 +659,7 @@ unlock:
 
 	return 0;
 }
+NOKPROBE_SYMBOL(breakpoint_handler);
 
 static int watchpoint_handler(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
@@ -756,6 +762,7 @@ unlock:
 
 	return 0;
 }
+NOKPROBE_SYMBOL(watchpoint_handler);
 
 /*
  * Handle single-step exception.
@@ -813,6 +820,7 @@ int reinstall_suspended_bps(struct pt_regs *regs)
 
 	return !handled_exception;
 }
+NOKPROBE_SYMBOL(reinstall_suspended_bps);
 
 /*
  * Context-switcher for restoring suspended breakpoints.
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index b67531a..f9338543 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -22,6 +22,7 @@
 #include <linux/irq.h>
 #include <linux/kdebug.h>
 #include <linux/kgdb.h>
+#include <linux/kprobes.h>
 #include <asm/traps.h>
 
 struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
@@ -218,6 +219,7 @@ static int kgdb_brk_fn(struct pt_regs *regs, unsigned int esr)
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
+NOKPROBE_SYMBOL(kgdb_brk_fn)
 
 static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
@@ -226,12 +228,14 @@ static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
+NOKPROBE_SYMBOL(kgdb_step_brk_fn);
 
 static struct break_hook kgdb_brkpt_hook = {
 	.esr_mask	= 0xffffffff,
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 5954881..4359ca8 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -563,6 +563,7 @@ asmlinkage void __exception do_sp_pc_abort(unsigned long addr,
 	info.si_addr  = (void __user *)addr;
 	arm64_notify_die("Oops - SP/PC alignment exception", regs, &info, esr);
 }
+NOKPROBE_SYMBOL(do_debug_exception)
 
 int __init early_brk64(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs);
-- 
2.5.0
