From: dave.long@linaro.org (David Long)
Date: Wed, 27 Apr 2016 14:52:59 -0400
Subject: [PATCH v12 04/10] arm64: Blacklist non-kprobe-able symbols
In-Reply-To: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
References: <1461783185-9056-1-git-send-email-dave.long@linaro.org>
Message-ID: <1461783185-9056-5-git-send-email-dave.long@linaro.org>
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
index c45f296..8f9afe3 100644
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
@@ -174,6 +179,7 @@ static void set_regs_spsr_ss(struct pt_regs *regs)
 	spsr |= DBG_SPSR_SS;
 	regs->pstate = spsr;
 }
+NOKPROBE_SYMBOL(set_regs_spsr_ss);
 
 static void clear_regs_spsr_ss(struct pt_regs *regs)
 {
@@ -183,6 +189,7 @@ static void clear_regs_spsr_ss(struct pt_regs *regs)
 	spsr &= ~DBG_SPSR_SS;
 	regs->pstate = spsr;
 }
+NOKPROBE_SYMBOL(clear_regs_spsr_ss);
 
 /* EL1 Single Step Handler hooks */
 static LIST_HEAD(step_hook);
@@ -226,6 +233,7 @@ static int call_step_hook(struct pt_regs *regs, unsigned int esr)
 
 	return retval;
 }
+NOKPROBE_SYMBOL(call_step_hook);
 
 static void send_user_sigtrap(int si_code)
 {
@@ -280,6 +288,7 @@ static int single_step_handler(unsigned long addr, unsigned int esr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(single_step_handler);
 
 /*
  * Breakpoint handler is re-entrant as another breakpoint can
@@ -317,6 +326,7 @@ static int call_break_hook(struct pt_regs *regs, unsigned int esr)
 
 	return fn ? fn(regs, esr) : DBG_HOOK_ERROR;
 }
+NOKPROBE_SYMBOL(call_break_hook);
 
 static int brk_handler(unsigned long addr, unsigned int esr,
 		       struct pt_regs *regs)
@@ -330,6 +340,7 @@ static int brk_handler(unsigned long addr, unsigned int esr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(brk_handler);
 
 int aarch32_break_handler(struct pt_regs *regs)
 {
@@ -366,6 +377,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	send_user_sigtrap(TRAP_BRKPT);
 	return 0;
 }
+NOKPROBE_SYMBOL(aarch32_break_handler);
 
 static int __init debug_traps_init(void)
 {
@@ -387,6 +399,7 @@ void user_rewind_single_step(struct task_struct *task)
 	if (test_ti_thread_flag(task_thread_info(task), TIF_SINGLESTEP))
 		set_regs_spsr_ss(task_pt_regs(task));
 }
+NOKPROBE_SYMBOL(user_rewind_single_step);
 
 void user_fastforward_single_step(struct task_struct *task)
 {
@@ -402,6 +415,7 @@ void kernel_enable_single_step(struct pt_regs *regs)
 	mdscr_write(mdscr_read() | DBG_MDSCR_SS);
 	enable_debug_monitors(DBG_ACTIVE_EL1);
 }
+NOKPROBE_SYMBOL(kernel_enable_single_step);
 
 void kernel_disable_single_step(void)
 {
@@ -409,12 +423,14 @@ void kernel_disable_single_step(void)
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
@@ -422,8 +438,10 @@ void user_enable_single_step(struct task_struct *task)
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
index b45c95d..367a954 100644
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
index 95df28b..34ed040 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -570,6 +570,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 
 	return 0;
 }
+NOKPROBE_SYMBOL(do_debug_exception)
 
 #ifdef CONFIG_ARM64_PAN
 void cpu_enable_pan(void *__unused)
-- 
2.5.0
