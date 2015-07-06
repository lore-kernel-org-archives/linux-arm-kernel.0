From: panand@redhat.com (Pratyush Anand)
Date: Mon,  6 Jul 2015 10:33:21 +0530
Subject: [PATCH 1/2] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <cover.1436158027.git.panand@redhat.com>
References: <cover.1436158027.git.panand@redhat.com>
Message-ID: <9994841a0b0a8194a6dcc1b6af148ba358488c62.1436158027.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add all function symbols which are called from do_debug_exception under
NOKPROBE_SYMBOL, as they can not kprobed.

Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/debug-monitors.c | 18 ++++++++++++++++++
 arch/arm64/kernel/hw_breakpoint.c  |  8 ++++++++
 arch/arm64/kernel/kgdb.c           |  4 ++++
 arch/arm64/mm/fault.c              |  1 +
 4 files changed, 31 insertions(+)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 237a21f675fd..6d356b2cc674 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -22,6 +22,7 @@
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
+#include <linux/kprobes.h>
 #include <linux/ptrace.h>
 #include <linux/kprobes.h>
 #include <linux/stat.h>
@@ -47,6 +48,7 @@ static void mdscr_write(u32 mdscr)
 	asm volatile("msr mdscr_el1, %0" :: "r" (mdscr));
 	local_dbg_restore(flags);
 }
+NOKPROBE_SYMBOL(mdscr_write);
 
 static u32 mdscr_read(void)
 {
@@ -54,6 +56,7 @@ static u32 mdscr_read(void)
 	asm volatile("mrs %0, mdscr_el1" : "=r" (mdscr));
 	return mdscr;
 }
+NOKPROBE_SYMBOL(mdscr_read);
 
 /*
  * Allow root to disable self-hosted debug from userspace.
@@ -102,6 +105,7 @@ void enable_debug_monitors(enum debug_elx el)
 		mdscr_write(mdscr);
 	}
 }
+NOKPROBE_SYMBOL(enable_debug_monitors);
 
 void disable_debug_monitors(enum debug_elx el)
 {
@@ -122,6 +126,7 @@ void disable_debug_monitors(enum debug_elx el)
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
@@ -224,6 +231,7 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 
 	return retval;
 }
+NOKPROBE_SYMBOL(call_step_hook);
 
 static int single_step_handler(unsigned long addr, unsigned int esr,
 			       struct pt_regs *regs)
@@ -270,6 +278,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(single_step_handler);
 
 /*
  * Breakpoint handler is re-entrant as another breakpoint can
@@ -306,6 +315,7 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 
 	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }
+NOKPROBE_SYMBOL(call_break_hook);
 
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
@@ -338,6 +348,7 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(brk_handler);
 
 int aarch32_break_handler(struct pt_regs *regs)
 {
@@ -382,6 +393,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	force_sig_info(SIGTRAP, &info, current);
 	return 0;
 }
+NOKPROBE_SYMBOL(aarch32_break_handler);
 
 static int __init debug_traps_init(void)
 {
@@ -403,6 +415,7 @@ void user_rewind_single_step(struct task_struct *task)
 	if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
 		set_regs_spsr_ss(task_pt_regs(task));
 }
+NOKPROBE_SYMBOL(user_rewind_single_step);
 
 void user_fastforward_single_step(struct task_struct *task)
 {
@@ -418,6 +431,7 @@ void kernel_enable_single_step(struct pt_regs *regs)
 	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
 	enable_debug_monitors(DBG_ACTIVE_EL1);
 }
+NOKPROBE_SYMBOL(kernel_enable_single_step);
 
 void kernel_disable_single_step(void)
 {
@@ -425,12 +439,14 @@ void kernel_disable_single_step(void)
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
@@ -438,8 +454,10 @@ void user_enable_single_step(struct task_struct *task)
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
index 43b74a3ddaef..91b4c418abcb 100644
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
@@ -139,6 +140,7 @@ static u64 read_wb_reg(int reg, int n)
 
 	return val;
 }
+NOKPROBE_SYMBOL(read_wb_reg);
 
 static void write_wb_reg(int reg, int n, u64 val)
 {
@@ -152,6 +154,7 @@ static void write_wb_reg(int reg, int n, u64 val)
 	}
 	isb();
 }
+NOKPROBE_SYMBOL(write_wb_reg);
 
 /*
  * Convert a breakpoint privilege level to the corresponding exception
@@ -169,6 +172,7 @@ static enum debug_elx debug_exception_level(int privilege)
 		return -EINVAL;
 	}
 }
+NOKPROBE_SYMBOL(debug_exception_level);
 
 enum hw_breakpoint_ops {
 	HW_BREAKPOINT_INSTALL,
@@ -573,6 +577,7 @@ static void toggle_bp_registers(int reg, enum debug_elx el, int enable)
 		write_wb_reg(reg, i, ctrl);
 	}
 }
+NOKPROBE_SYMBOL(toggle_bp_registers);
 
 /*
  * Debug exception handlers.
@@ -652,6 +657,7 @@ unlock:
 
 	return 0;
 }
+NOKPROBE_SYMBOL(breakpoint_handler);
 
 static int watchpoint_handler(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
@@ -754,6 +760,7 @@ unlock:
 
 	return 0;
 }
+NOKPROBE_SYMBOL(watchpoint_handler);
 
 /*
  * Handle single-step exception.
@@ -811,6 +818,7 @@ int reinstall_suspended_bps(struct pt_regs *regs)
 
 	return !handled_exception;
 }
+NOKPROBE_SYMBOL(reinstall_suspended_bps);
 
 /*
  * Context-switcher for restoring suspended breakpoints.
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 9469465a5e03..faa4d442688c 100644
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
@@ -226,6 +228,7 @@ static int kgdb_compiled_brk_fn(struct pt_regs *regs, unsigned int esr)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(kgdb_compiled_brk_fn);
 
 static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 {
@@ -235,6 +238,7 @@ static int kgdb_step_brk_fn(struct pt_regs *regs, unsigned int esr)
 	kgdb_handle_exception(1, SIGTRAP, 0, regs);
 	return 0;
 }
+NOKPROBE_SYMBOL(kgdb_step_brk_fn);
 
 static struct break_hook kgdb_brkpt_hook = {
 	.esr_mask	= 0xffffffff,
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 75750a91907a..0d0b02ce2074 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -561,3 +561,4 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(do_debug_exception)
-- 
2.4.3
