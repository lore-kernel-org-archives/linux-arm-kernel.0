From: wangnan0@huawei.com (Wang Nan)
Date: Wed, 23 Dec 2015 08:42:12 +0000
Subject: [PATCH] arm64: Store breakpoint single step state into pstate
Message-ID: <1450860132-194276-1-git-send-email-wangnan0@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Two 'perf test' fail on arm64:

 # perf test overflow
 17: Test breakpoint overflow signal handler                  : FAILED!
 18: Test breakpoint overflow sampling                        : FAILED!

When breakpoint raises, after perf_bp_event, breakpoint_handler()
temporary disables breakpoint and enables single step. Then in
single_step_handler(), reenable breakpoint. Without doing this
the breakpoint would be triggered again.

However, if there's a pending signal and it have signal handler,
control would be transfer to signal handler, so single step handler
would be applied to the first instruction of signal handler. After
the handler return, the instruction triggered the breakpoint would be
executed again. At this time the breakpoint is enabled, so the
breakpoint is triggered again.

There was similar problem on x86, so we have following two commits:

commit 24cda10996f5420ab962f91cd03c15869a3a94b1("x86/signals: Clear RF
EFLAGS bit for signal handler"),

commit 5e219b3c671b34b2d79468fe89c44c0460c0f02b("x86/signals: Propagate
RF EFLAGS bit through the signal restore call").

When breakpoint handler enables single step, task is in a special state
that, the breakpoint should be disabled, the single step should be
enabled, and they should be toggled in single step handler.
This state should be cleared when entering signal handler and restored
after signal return like other program state. Considering the
situation that signal raises inside signal handler, the only safe way
to avoid the problem is to save this state into signal frame, like what
x86 does.

Different from x86 which has an RF EFLAGS bit to control debug
behavior, there's no such bits on ARM64. Creating new fields in signal
frame makes trouble because it is part of user API. Fortunately, on
ARM64, we use a 64 bits pstate but the hardware only utilises the
lowest 32 bits. The other 32 bits can be used by kernel to record this
state.

This patch create two bits in pstate to record the special state caused
by breakpoint and watchpoint. In handle_signal, the state is checked
and the bits are set accordingly, then the hardware is restored.
When signal return, single step can be reenabled based on these bits.

After this patch:

 # perf test overflow
 17: Test breakpoint overflow signal handler                  : Ok
 18: Test breakpoint overflow sampling                        : Ok

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Hanjun Guo <guohanjun@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/debug-monitors.h |  9 ++++++
 arch/arm64/include/uapi/asm/ptrace.h    | 12 ++++++++
 arch/arm64/kernel/hw_breakpoint.c       | 50 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c              |  2 ++
 4 files changed, 73 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 279c85b5..bd6f873 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -132,11 +132,20 @@ int kernel_active_single_step(void);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
+u64 signal_toggle_single_step(void);
+void signal_reinstall_single_step(u64 pstate);
 #else
 static inline int reinstall_suspended_bps(struct pt_regs *regs)
 {
 	return -ENODEV;
 }
+static u64 signal_toggle_single_step(void)
+{
+	return 0;
+}
+void signal_reinstall_single_step(void)
+{
+}
 #endif
 
 int aarch32_break_handler(struct pt_regs *regs);
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 208db3d..bfb90f6 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -52,6 +52,18 @@
 #define PSR_N_BIT	0x80000000
 
 /*
+ * pstat in pt_regs and user_pt_regs are 64 bits. The highest 32 bits
+ * of it can be utilized by other. One user of them is signal handler.
+ */
+#define PSR_LINUX_MASK		(0xffffffffUL << 32)
+/* Single step and disable breakpoints */
+#define PSR_LINUX_HW_BP_SS	(1UL << 32)
+/* Single step and disable watchpoints */
+#define PSR_LINUX_HW_WP_SS	(2UL << 32)
+
+#define PSR_LINUX_HW_SS	(PSR_LINUX_HW_BP_SS | PSR_LINUX_HW_WP_SS)
+
+/*
  * Groups of PSR bits
  */
 #define PSR_f		0xff000000	/* Flags		*/
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index b45c95d..e5a0998 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -954,3 +954,53 @@ int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 {
 	return NOTIFY_DONE;
 }
+
+u64 signal_toggle_single_step(void)
+{
+	struct debug_info *debug_info = &current->thread.debug;
+	u64 retval = 0;
+
+	if (likely(!debug_info->bps_disabled && !debug_info->wps_disabled))
+		return 0;
+
+	if (debug_info->bps_disabled) {
+		retval |= PSR_LINUX_HW_BP_SS;
+		toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL0, 1);
+		debug_info->bps_disabled = 0;
+	}
+
+	if (debug_info->wps_disabled) {
+		retval |= PSR_LINUX_HW_WP_SS;
+		toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 1);
+		debug_info->wps_disabled = 0;
+	}
+
+	if (debug_info->suspended_step)
+		debug_info->suspended_step = 0;
+	else
+		user_disable_single_step(current);
+	return retval;
+}
+
+void signal_reinstall_single_step(u64 pstate)
+{
+	struct debug_info *debug_info = &current->thread.debug;
+
+	if (likely(!(pstate & PSR_LINUX_HW_SS)))
+		return;
+
+	if (pstate & PSR_LINUX_HW_BP_SS) {
+		debug_info->bps_disabled = 1;
+		toggle_bp_registers(AARCH64_DBG_REG_BCR, DBG_ACTIVE_EL0, 0);
+	}
+
+	if (pstate & PSR_LINUX_HW_WP_SS) {
+		debug_info->wps_disabled = 1;
+		toggle_bp_registers(AARCH64_DBG_REG_WCR, DBG_ACTIVE_EL0, 0);
+	}
+
+	if (test_thread_flag(TIF_SINGLESTEP))
+		debug_info->suspended_step = 1;
+	else
+		user_enable_single_step(current);
+}
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index e18c48c..1737710 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -151,6 +151,7 @@ asmlinkage long sys_rt_sigreturn(struct pt_regs *regs)
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	signal_reinstall_single_step(regs->pstate);
 	return regs->regs[0];
 
 badframe:
@@ -292,6 +293,7 @@ static void handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	int usig = ksig->sig;
 	int ret;
 
+	regs->pstate |= signal_toggle_single_step();
 	/*
 	 * Set up the stack frame
 	 */
-- 
1.8.3.4
