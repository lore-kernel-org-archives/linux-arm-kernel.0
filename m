From: hekuang@huawei.com (He Kuang)
Date: Mon, 21 Mar 2016 08:37:49 +0000
Subject: [PATCH 1/2] arm64: Store breakpoint single step state into pstate
Message-ID: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wang Nan <wangnan0@huawei.com>

Store breakpoint single step state into pstate to fix the
recursion issue on ARM64.

Signed-off-by: Kaixu Xia <xiakaixu@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/debug-monitors.h |  9 ++++++
 arch/arm64/include/uapi/asm/ptrace.h    | 10 +++++++
 arch/arm64/kernel/hw_breakpoint.c       | 49 +++++++++++++++++++++++++++++++++
 arch/arm64/kernel/signal.c              |  2 ++
 4 files changed, 70 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 279c85b5..b5902e8 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -132,11 +132,20 @@ int kernel_active_single_step(void);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
+u64 signal_single_step_enable_bps(void);
+void signal_reinstall_single_step(u64 pstate);
 #else
 static inline int reinstall_suspended_bps(struct pt_regs *regs)
 {
 	return -ENODEV;
 }
+
+static inline u64 signal_single_step_enable_bps(void)
+{
+	return 0;
+}
+
+static inline void signal_reinstall_single_step(u64 pstate) { }
 #endif
 
 int aarch32_break_handler(struct pt_regs *regs);
diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index 208db3d..8dbfdac 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -52,6 +52,16 @@
 #define PSR_N_BIT	0x80000000
 
 /*
+ * pstat in pt_regs and user_pt_regs are 64 bits. The highest 32 bits
+ * of it can be used by kernel. One user of them is signal handler.
+ */
+#define PSR_LINUX_MASK        0xffffffff00000000UL
+#define PSR_LINUX_HW_BP_SS    0x0000000100000000UL    /* Single step and disable breakpoints */
+#define PSR_LINUX_HW_WP_SS    0x0000000200000000UL    /* Single step and disable watchpoints */
+
+#define PSR_LINUX_HW_SS    (PSR_LINUX_HW_BP_SS | PSR_LINUX_HW_WP_SS)
+
+/*
  * Groups of PSR bits
  */
 #define PSR_f		0xff000000	/* Flags		*/
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index b45c95d..18fd3d3 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -954,3 +954,52 @@ int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 {
 	return NOTIFY_DONE;
 }
+
+u64 signal_single_step_enable_bps(void)
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
index e18c48c..6cb1e49 100644
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
 
+	regs->pstate |= signal_single_step_enable_bps();
 	/*
 	 * Set up the stack frame
 	 */
-- 
1.8.5.2
