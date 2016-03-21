From: hekuang@huawei.com (He Kuang)
Date: Mon, 21 Mar 2016 08:37:50 +0000
Subject: [PATCH 2/2] arm64: Fix watchpoint recursion when single-step is
 wrongly triggered in irq
In-Reply-To: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
Message-ID: <1458549470-124791-2-git-send-email-hekuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On arm64, watchpoint handler enables single-step to bypass the next
instruction for not recursive enter. If an irq is triggered right
after the watchpoint, a single-step will be wrongly triggered in irq
handler, which causes the watchpoint address not stepped over and
system hang.

Problem can be found at the following URL:
"http://thread.gmane.org/gmane.linux.kernel/2167918"

This patch pushes watchpoint status and disables single step if it is
triggered in irq handler and restores them back after irq is handled.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Signed-off-by: He Kuang <hekuang@huawei.com>
---
 arch/arm64/include/asm/debug-monitors.h |  9 +++++++
 arch/arm64/kernel/debug-monitors.c      | 13 ++++++++++
 arch/arm64/kernel/entry.S               |  6 +++++
 arch/arm64/kernel/hw_breakpoint.c       | 44 +++++++++++++++++++++++++++++++--
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index b5902e8..fe6939e 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -133,7 +133,10 @@ int kernel_active_single_step(void);
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
 u64 signal_single_step_enable_bps(void);
+u64 irq_single_step_enable_bps(void);
+
 void signal_reinstall_single_step(u64 pstate);
+void irq_reinstall_single_step(struct pt_regs *regs);
 #else
 static inline int reinstall_suspended_bps(struct pt_regs *regs)
 {
@@ -145,7 +148,13 @@ static inline u64 signal_single_step_enable_bps(void)
 	return 0;
 }
 
+static inline u64 irq_single_step_enable_bps(void)
+{
+	return 0;
+}
+
 static inline void signal_reinstall_single_step(u64 pstate) { }
+static inline void irq_reinstall_single_step(struct pt_regs *regs) { }
 #endif
 
 int aarch32_break_handler(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index c536c9e..fab1faa 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -245,9 +245,22 @@ static void send_user_sigtrap(int si_code)
 	force_sig_info(SIGTRAP, &info, current);
 }
 
+extern unsigned long el1_irq_ss_entry[];
+
 static int single_step_handler(unsigned long addr, unsigned int esr,
 			       struct pt_regs *regs)
 {
+	void *pc = (void *)instruction_pointer(regs);
+
+	if (pc == &el1_irq_ss_entry) {
+		struct pt_regs *irq_regs = (struct pt_regs *)(regs->sp);
+
+		irq_regs->pstate |= irq_single_step_enable_bps();
+		kernel_disable_single_step();
+
+		return 0;
+	}
+
 	/*
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 1f7f5a2..836d98e 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -402,12 +402,18 @@ ENDPROC(el1_sync)
 el1_irq:
 	kernel_entry 1
 	enable_dbg
+	.global el1_irq_ss_entry
+el1_irq_ss_entry:
 #ifdef CONFIG_TRACE_IRQFLAGS
 	bl	trace_hardirqs_off
 #endif
 
 	get_thread_info tsk
 	irq_handler
+#ifdef CONFIG_HAVE_HW_BREAKPOINT
+	mov	x0, sp
+	bl	irq_reinstall_single_step
+#endif
 
 #ifdef CONFIG_PREEMPT
 	ldr	w24, [tsk, #TI_PREEMPT]		// get preempt count
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 18fd3d3..0cf13ee 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -540,11 +540,12 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
  * exception level at the register level.
  * This is used when single-stepping after a breakpoint exception.
  */
-static void toggle_bp_registers(int reg, enum dbg_active_el el, int enable)
+static bool toggle_bp_registers(int reg, enum dbg_active_el el, int enable)
 {
 	int i, max_slots, privilege;
 	u32 ctrl;
 	struct perf_event **slots;
+	bool origin_state = false;
 
 	switch (reg) {
 	case AARCH64_DBG_REG_BCR:
@@ -556,7 +557,7 @@ static void toggle_bp_registers(int reg, enum dbg_active_el el, int enable)
 		max_slots = core_num_wrps;
 		break;
 	default:
-		return;
+		return false;
 	}
 
 	for (i = 0; i < max_slots; ++i) {
@@ -568,12 +569,16 @@ static void toggle_bp_registers(int reg, enum dbg_active_el el, int enable)
 			continue;
 
 		ctrl = read_wb_reg(reg, i);
+		if (ctrl & 0x1)
+			origin_state = true;
 		if (enable)
 			ctrl |= 0x1;
 		else
 			ctrl &= ~0x1;
 		write_wb_reg(reg, i, ctrl);
 	}
+
+	return origin_state;
 }
 
 /*
@@ -982,6 +987,41 @@ u64 signal_single_step_enable_bps(void)
 	return retval;
 }
 
+u64 irq_single_step_enable_bps(void)
+{
+	u64 retval = 0;
+
+	if (!toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL1, 1))
+		retval |= PSR_LINUX_HW_WP_SS;
+
+	if (!toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL1, 1))
+		retval |= PSR_LINUX_HW_BP_SS;
+
+	return retval;
+}
+
+void irq_reinstall_single_step(struct pt_regs *regs)
+{
+	u64 pstate = regs->pstate;
+
+	if (likely(!(regs->pstate & PSR_LINUX_HW_SS)))
+		return;
+
+	if (!user_mode(regs)) {
+		if (pstate & PSR_LINUX_HW_BP_SS)
+			toggle_bp_registers(AARCH64_DBG_REG_BCR,
+					    DBG_ACTIVE_EL1, 0);
+		if (pstate & PSR_LINUX_HW_WP_SS)
+			toggle_bp_registers(AARCH64_DBG_REG_WCR,
+					    DBG_ACTIVE_EL1, 0);
+
+		if (!kernel_active_single_step()) {
+			asm volatile ("msr     daifset, #8\n");
+			kernel_enable_single_step(regs);
+		}
+	}
+}
+
 void signal_reinstall_single_step(u64 pstate)
 {
 	struct debug_info *debug_info = &current->thread.debug;
-- 
1.8.5.2
