From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:36:02 +0100
Subject: [RFC PATCH 10/14] arm64: kernel: refactor code to install/uninstall
 breakpoints
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-11-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the code executed to install and uninstall breakpoints is
common and can be factored out in a function that through a runtime
operations type provides the requested implementation.

This patch creates a common function that can be used to install/uninstall
breakpoints and defines the set of operations that can be carried out
through it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 142 +++++++++++++++++++++++---------------
 1 file changed, 88 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 329218c..84d1e62 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -169,15 +169,63 @@ static enum debug_el debug_exception_level(int privilege)
 	}
 }
 
-/*
- * Install a perf counter breakpoint.
+enum hw_breakpoint_ops {
+	HW_BREAKPOINT_INSTALL,
+	HW_BREAKPOINT_UNINSTALL
+};
+
+/**
+ * hw_breakpoint_slot_setup - Find and setup a perf slot according to
+ *			      operations
+ *
+ * @slots: pointer to array of slots
+ * @max_slots: max number of slots
+ * @bp: perf_event to setup
+ * @ops: operation to be carried out on the slot
+ *
+ * Return:
+ *	slot index on success
+ *	-ENOSPC if no slot is available/matches
+ *	-EINVAL on wrong operations parameter
  */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int hw_breakpoint_slot_setup(struct perf_event **slots, int max_slots,
+				    struct perf_event *bp,
+				    enum hw_breakpoint_ops ops)
+{
+	int i;
+	struct perf_event **slot;
+
+	for (i = 0; i < max_slots; ++i) {
+		slot = &slots[i];
+		switch (ops) {
+		case HW_BREAKPOINT_INSTALL:
+			if (!*slot) {
+				*slot = bp;
+				return i;
+			}
+			break;
+		case HW_BREAKPOINT_UNINSTALL:
+			if (*slot == bp) {
+				*slot = NULL;
+				return i;
+			}
+			break;
+		default:
+			pr_warn_once("Unhandled hw breakpoint ops %d\n", ops);
+			return -EINVAL;
+		}
+	}
+	return -ENOSPC;
+}
+
+static int hw_breakpoint_control(struct perf_event *bp,
+				 enum hw_breakpoint_ops ops)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	struct perf_event **slot, **slots;
+	struct perf_event **slots;
 	struct debug_info *debug_info = &current->thread.debug;
 	int i, max_slots, ctrl_reg, val_reg, reg_enable;
+	enum debug_el dbg_el = debug_exception_level(info->ctrl.privilege);
 	u32 ctrl;
 
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
@@ -196,67 +244,53 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		reg_enable = !debug_info->wps_disabled;
 	}
 
-	for (i = 0; i < max_slots; ++i) {
-		slot = &slots[i];
+	i = hw_breakpoint_slot_setup(slots, max_slots, bp, ops);
 
-		if (!*slot) {
-			*slot = bp;
-			break;
-		}
-	}
+	if (WARN_ONCE(i < 0, "Can't find any breakpoint slot"))
+		return i;
 
-	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot"))
-		return -ENOSPC;
+	switch (ops) {
+	case HW_BREAKPOINT_INSTALL:
+		/*
+		 * Ensure debug monitors are enabled at the correct exception
+		 * level.
+		 */
+		enable_debug_monitors(dbg_el);
 
-	/* Ensure debug monitors are enabled@the correct exception level.  */
-	enable_debug_monitors(debug_exception_level(info->ctrl.privilege));
+		/* Setup the address register. */
+		write_wb_reg(val_reg, i, info->address);
 
-	/* Setup the address register. */
-	write_wb_reg(val_reg, i, info->address);
+		/* Setup the control register. */
+		ctrl = encode_ctrl_reg(info->ctrl);
+		write_wb_reg(ctrl_reg, i,
+			     reg_enable ? ctrl | 0x1 : ctrl & ~0x1);
+		break;
+	case HW_BREAKPOINT_UNINSTALL:
+		/* Reset the control register. */
+		write_wb_reg(ctrl_reg, i, 0);
 
-	/* Setup the control register. */
-	ctrl = encode_ctrl_reg(info->ctrl);
-	write_wb_reg(ctrl_reg, i, reg_enable ? ctrl | 0x1 : ctrl & ~0x1);
+		/*
+		 * Release the debug monitors for the correct exception
+		 * level.
+		 */
+		disable_debug_monitors(dbg_el);
+		break;
+	}
 
 	return 0;
 }
 
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+/*
+ * Install a perf counter breakpoint.
+ */
+int arch_install_hw_breakpoint(struct perf_event *bp)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	struct perf_event **slot, **slots;
-	int i, max_slots, base;
-
-	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
-		/* Breakpoint */
-		base = AARCH64_DBG_REG_BCR;
-		slots = __get_cpu_var(bp_on_reg);
-		max_slots = core_num_brps;
-	} else {
-		/* Watchpoint */
-		base = AARCH64_DBG_REG_WCR;
-		slots = __get_cpu_var(wp_on_reg);
-		max_slots = core_num_wrps;
-	}
-
-	/* Remove the breakpoint. */
-	for (i = 0; i < max_slots; ++i) {
-		slot = &slots[i];
-
-		if (*slot == bp) {
-			*slot = NULL;
-			break;
-		}
-	}
-
-	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot"))
-		return;
-
-	/* Reset the control register. */
-	write_wb_reg(base, i, 0);
+	return hw_breakpoint_control(bp, HW_BREAKPOINT_INSTALL);
+}
 
-	/* Release the debug monitors for the correct exception level.  */
-	disable_debug_monitors(debug_exception_level(info->ctrl.privilege));
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	hw_breakpoint_control(bp, HW_BREAKPOINT_UNINSTALL);
 }
 
 static int get_hbp_len(u8 hbp_len)
-- 
1.8.3.4
