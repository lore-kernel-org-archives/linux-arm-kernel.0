From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Dec 2010 13:45:58 +0000
Subject: [PATCH 07/11] ARM: hw_breakpoint: unify single-stepping code for
	watchpoints and breakpoints
In-Reply-To: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
References: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291297562-8052-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The single-stepping code is currently different depending on whether
we are stepping over a breakpoint or a watchpoint. There is no good
reason for this, so let's sort it out.

This patch adds functions for enabling/disabling single-step for
a particular hw_breakpoint and integrates this with the exception
handling code.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hw_breakpoint.h |    4 +-
 arch/arm/kernel/hw_breakpoint.c      |   81 +++++++++++++++++-----------------
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index 881429d..f389b27 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -20,8 +20,8 @@ struct arch_hw_breakpoint_ctrl {
 struct arch_hw_breakpoint {
 	u32	address;
 	u32	trigger;
-	struct arch_hw_breakpoint_ctrl step_ctrl;
-	struct arch_hw_breakpoint_ctrl ctrl;
+	struct	arch_hw_breakpoint_ctrl step_ctrl;
+	struct	arch_hw_breakpoint_ctrl ctrl;
 };
 
 static inline u32 encode_ctrl_reg(struct arch_hw_breakpoint_ctrl ctrl)
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 81b63e9..36cd768 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -339,6 +339,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		val_base = ARM_BASE_BVR;
 		slots = __get_cpu_var(bp_on_reg);
 		max_slots = core_num_brps;
+		if (info->step_ctrl.enabled) {
+			/* Override the breakpoint data with the step data. */
+			addr = info->trigger & ~0x3;
+			ctrl = encode_ctrl_reg(info->step_ctrl);
+		}
 	} else {
 		/* Watchpoint */
 		if (info->step_ctrl.enabled) {
@@ -628,21 +633,28 @@ out:
 	return ret;
 }
 
-static void update_mismatch_flag(int idx, int flag)
+/*
+ * Enable/disable single-stepping over the breakpoint bp at address addr.
+ */
+static void enable_single_step(struct perf_event *bp, u32 addr)
 {
-	struct perf_event *bp = __get_cpu_var(bp_on_reg[idx]);
-	struct arch_hw_breakpoint *info;
-
-	if (bp == NULL)
-		return;
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 
-	info = counter_arch_bp(bp);
+	arch_uninstall_hw_breakpoint(bp);
+	info->step_ctrl.mismatch  = 1;
+	info->step_ctrl.len	  = ARM_BREAKPOINT_LEN_4;
+	info->step_ctrl.type	  = ARM_BREAKPOINT_EXECUTE;
+	info->step_ctrl.privilege = info->ctrl.privilege;
+	info->step_ctrl.enabled	  = 1;
+	info->trigger		  = addr;
+	arch_install_hw_breakpoint(bp);
+}
 
-	/* Update the mismatch field to enter/exit `single-step' mode */
-	if (!bp->overflow_handler && info->ctrl.mismatch != flag) {
-		info->ctrl.mismatch = flag;
-		write_wb_reg(ARM_BASE_BCR + idx, encode_ctrl_reg(info->ctrl) | 0x1);
-	}
+static void disable_single_step(struct perf_event *bp)
+{
+	arch_uninstall_hw_breakpoint(bp);
+	counter_arch_bp(bp)->step_ctrl.enabled = 0;
+	arch_install_hw_breakpoint(bp);
 }
 
 static void watchpoint_handler(unsigned long unknown, struct pt_regs *regs)
@@ -679,16 +691,8 @@ static void watchpoint_handler(unsigned long unknown, struct pt_regs *regs)
 		 * mismatch breakpoint so we can single-step over the
 		 * watchpoint trigger.
 		 */
-		if (!wp->overflow_handler) {
-			arch_uninstall_hw_breakpoint(wp);
-			info->step_ctrl.mismatch  = 1;
-			info->step_ctrl.len	  = ARM_BREAKPOINT_LEN_4;
-			info->step_ctrl.type	  = ARM_BREAKPOINT_EXECUTE;
-			info->step_ctrl.privilege = info->ctrl.privilege;
-			info->step_ctrl.enabled	  = 1;
-			info->trigger		  = regs->ARM_pc;
-			arch_install_hw_breakpoint(wp);
-		}
+		if (!wp->overflow_handler)
+			enable_single_step(wp, instruction_pointer(regs));
 
 		rcu_read_unlock();
 	}
@@ -716,11 +720,8 @@ static void watchpoint_single_step_handler(unsigned long pc)
 		 * Restore the original watchpoint if we've completed the
 		 * single-step.
 		 */
-		if (info->trigger != pc) {
-			arch_uninstall_hw_breakpoint(wp);
-			info->step_ctrl.enabled = 0;
-			arch_install_hw_breakpoint(wp);
-		}
+		if (info->trigger != pc)
+			disable_single_step(wp);
 
 unlock:
 		rcu_read_unlock();
@@ -730,7 +731,6 @@ unlock:
 static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 {
 	int i;
-	int mismatch;
 	u32 ctrl_reg, val, addr;
 	struct perf_event *bp, **slots = __get_cpu_var(bp_on_reg);
 	struct arch_hw_breakpoint *info;
@@ -745,34 +745,33 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 
 		bp = slots[i];
 
-		if (bp == NULL) {
-			rcu_read_unlock();
-			continue;
-		}
+		if (bp == NULL)
+			goto unlock;
 
-		mismatch = 0;
+		info = counter_arch_bp(bp);
 
 		/* Check if the breakpoint value matches. */
 		val = read_wb_reg(ARM_BASE_BVR + i);
 		if (val != (addr & ~0x3))
-			goto unlock;
+			goto mismatch;
 
 		/* Possible match, check the byte address select to confirm. */
 		ctrl_reg = read_wb_reg(ARM_BASE_BCR + i);
 		decode_ctrl_reg(ctrl_reg, &ctrl);
 		if ((1 << (addr & 0x3)) & ctrl.len) {
-			mismatch = 1;
-			info = counter_arch_bp(bp);
 			info->trigger = addr;
-		}
-
-unlock:
-		if (mismatch && !info->ctrl.mismatch) {
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
+			if (!bp->overflow_handler)
+				enable_single_step(bp, addr);
+			goto unlock;
 		}
 
-		update_mismatch_flag(i, mismatch);
+mismatch:
+		/* If we're stepping a breakpoint, it can now be restored. */
+		if (info->step_ctrl.enabled)
+			disable_single_step(bp);
+unlock:
 		rcu_read_unlock();
 	}
 
-- 
1.7.0.4
