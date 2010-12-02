From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Dec 2010 13:45:57 +0000
Subject: [PATCH 06/11] ARM: hw_breakpoint: do not allocate new breakpoints
	with preemption disabled
In-Reply-To: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
References: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291297562-8052-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchpoint single-stepping code calls register_user_hw_breakpoint to
register a mismatch breakpoint for stepping over the watchpoint. This is
performed with preemption disabled, which is unsafe as we may end up scheduling
whilst in_atomic(). Furthermore, using the perf API is rather overkill since
we are already in the hw-breakpoint backend and only require access to reserved
breakpoints anyway.

This patch reworks the watchpoint stepping code so that we don't require
another perf_event for the mismatch breakpoint. Instead, we hold a separate
arch_hw_breakpoint_ctrl struct inside the watchpoint which is used exclusively
for stepping. We can check whether or not stepping is enabled when installing
or uninstalling the watchpoint and operate on the breakpoint accordingly.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/hw_breakpoint.h |    2 +-
 arch/arm/kernel/hw_breakpoint.c      |  134 +++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 58 deletions(-)

diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/hw_breakpoint.h
index 4d8ae9d..881429d 100644
--- a/arch/arm/include/asm/hw_breakpoint.h
+++ b/arch/arm/include/asm/hw_breakpoint.h
@@ -20,7 +20,7 @@ struct arch_hw_breakpoint_ctrl {
 struct arch_hw_breakpoint {
 	u32	address;
 	u32	trigger;
-	struct perf_event *suspended_wp;
+	struct arch_hw_breakpoint_ctrl step_ctrl;
 	struct arch_hw_breakpoint_ctrl ctrl;
 };
 
diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index b16c456..81b63e9 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -316,23 +316,6 @@ u8 arch_get_max_wp_len(void)
 }
 
 /*
- * Handler for reactivating a suspended watchpoint when the single
- * step `mismatch' breakpoint is triggered.
- */
-static void wp_single_step_handler(struct perf_event *bp, int unused,
-				   struct perf_sample_data *data,
-				   struct pt_regs *regs)
-{
-	perf_event_enable(counter_arch_bp(bp)->suspended_wp);
-	unregister_hw_breakpoint(bp);
-}
-
-static int bp_is_single_step(struct perf_event *bp)
-{
-	return bp->overflow_handler == wp_single_step_handler;
-}
-
-/*
  * Install a perf counter breakpoint.
  */
 int arch_install_hw_breakpoint(struct perf_event *bp)
@@ -340,29 +323,35 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event **slot, **slots;
 	int i, max_slots, ctrl_base, val_base, ret = 0;
+	u32 addr, ctrl;
 
 	/* Ensure that we are in monitor mode and halting mode is disabled. */
 	ret = enable_monitor_mode();
 	if (ret)
 		goto out;
 
+	addr = info->address;
+	ctrl = encode_ctrl_reg(info->ctrl) | 0x1;
+
 	if (info->ctrl.type == ARM_BREAKPOINT_EXECUTE) {
 		/* Breakpoint */
 		ctrl_base = ARM_BASE_BCR;
 		val_base = ARM_BASE_BVR;
 		slots = __get_cpu_var(bp_on_reg);
 		max_slots = core_num_brps;
-
-		if (bp_is_single_step(bp)) {
-			info->ctrl.mismatch = 1;
-			i = max_slots;
-			slots[i] = bp;
-			goto setup;
-		}
 	} else {
 		/* Watchpoint */
-		ctrl_base = ARM_BASE_WCR;
-		val_base = ARM_BASE_WVR;
+		if (info->step_ctrl.enabled) {
+			/* Install into the reserved breakpoint region. */
+			ctrl_base = ARM_BASE_BCR + core_num_brps;
+			val_base = ARM_BASE_BVR + core_num_brps;
+			/* Override the watchpoint data with the step data. */
+			addr = info->trigger & ~0x3;
+			ctrl = encode_ctrl_reg(info->step_ctrl);
+		} else {
+			ctrl_base = ARM_BASE_WCR;
+			val_base = ARM_BASE_WVR;
+		}
 		slots = __get_cpu_var(wp_on_reg);
 		max_slots = core_num_wrps;
 	}
@@ -381,12 +370,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		goto out;
 	}
 
-setup:
 	/* Setup the address register. */
-	write_wb_reg(val_base + i, info->address);
+	write_wb_reg(val_base + i, addr);
 
 	/* Setup the control register. */
-	write_wb_reg(ctrl_base + i, encode_ctrl_reg(info->ctrl) | 0x1);
+	write_wb_reg(ctrl_base + i, ctrl);
 
 out:
 	return ret;
@@ -403,15 +391,12 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 		base = ARM_BASE_BCR;
 		slots = __get_cpu_var(bp_on_reg);
 		max_slots = core_num_brps;
-
-		if (bp_is_single_step(bp)) {
-			i = max_slots;
-			slots[i] = NULL;
-			goto reset;
-		}
 	} else {
 		/* Watchpoint */
-		base = ARM_BASE_WCR;
+		if (info->step_ctrl.enabled)
+			base = ARM_BASE_BCR + core_num_brps;
+		else
+			base = ARM_BASE_WCR;
 		slots = __get_cpu_var(wp_on_reg);
 		max_slots = core_num_wrps;
 	}
@@ -429,7 +414,6 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot"))
 		return;
 
-reset:
 	/* Reset the control register. */
 	write_wb_reg(base + i, 0);
 }
@@ -579,7 +563,7 @@ static int arch_build_bp_info(struct perf_event *bp)
 
 	/* Privilege */
 	info->ctrl.privilege = ARM_BREAKPOINT_USER;
-	if (arch_check_bp_in_kernelspace(bp) && !bp_is_single_step(bp))
+	if (arch_check_bp_in_kernelspace(bp))
 		info->ctrl.privilege |= ARM_BREAKPOINT_PRIV;
 
 	/* Enabled? */
@@ -664,22 +648,18 @@ static void update_mismatch_flag(int idx, int flag)
 static void watchpoint_handler(unsigned long unknown, struct pt_regs *regs)
 {
 	int i;
-	struct perf_event *bp, **slots = __get_cpu_var(wp_on_reg);
+	struct perf_event *wp, **slots = __get_cpu_var(wp_on_reg);
 	struct arch_hw_breakpoint *info;
-	struct perf_event_attr attr;
 
 	/* Without a disassembler, we can only handle 1 watchpoint. */
 	BUG_ON(core_num_wrps > 1);
 
-	hw_breakpoint_init(&attr);
-	attr.bp_addr	= regs->ARM_pc & ~0x3;
-	attr.bp_len	= HW_BREAKPOINT_LEN_4;
-	attr.bp_type	= HW_BREAKPOINT_X;
-
 	for (i = 0; i < core_num_wrps; ++i) {
 		rcu_read_lock();
 
-		if (slots[i] == NULL) {
+		wp = slots[i];
+
+		if (wp == NULL) {
 			rcu_read_unlock();
 			continue;
 		}
@@ -689,24 +669,60 @@ static void watchpoint_handler(unsigned long unknown, struct pt_regs *regs)
 		 * single watchpoint, we can set the trigger to the lowest
 		 * possible faulting address.
 		 */
-		info = counter_arch_bp(slots[i]);
-		info->trigger = slots[i]->attr.bp_addr;
+		info = counter_arch_bp(wp);
+		info->trigger = wp->attr.bp_addr;
 		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
-		perf_bp_event(slots[i], regs);
+		perf_bp_event(wp, regs);
 
 		/*
 		 * If no overflow handler is present, insert a temporary
 		 * mismatch breakpoint so we can single-step over the
 		 * watchpoint trigger.
 		 */
-		if (!slots[i]->overflow_handler) {
-			bp = register_user_hw_breakpoint(&attr,
-							 wp_single_step_handler,
-							 current);
-			counter_arch_bp(bp)->suspended_wp = slots[i];
-			perf_event_disable(slots[i]);
+		if (!wp->overflow_handler) {
+			arch_uninstall_hw_breakpoint(wp);
+			info->step_ctrl.mismatch  = 1;
+			info->step_ctrl.len	  = ARM_BREAKPOINT_LEN_4;
+			info->step_ctrl.type	  = ARM_BREAKPOINT_EXECUTE;
+			info->step_ctrl.privilege = info->ctrl.privilege;
+			info->step_ctrl.enabled	  = 1;
+			info->trigger		  = regs->ARM_pc;
+			arch_install_hw_breakpoint(wp);
+		}
+
+		rcu_read_unlock();
+	}
+}
+
+static void watchpoint_single_step_handler(unsigned long pc)
+{
+	int i;
+	struct perf_event *wp, **slots = __get_cpu_var(wp_on_reg);
+	struct arch_hw_breakpoint *info;
+
+	for (i = 0; i < core_num_reserved_brps; ++i) {
+		rcu_read_lock();
+
+		wp = slots[i];
+
+		if (wp == NULL)
+			goto unlock;
+
+		info = counter_arch_bp(wp);
+		if (!info->step_ctrl.enabled)
+			goto unlock;
+
+		/*
+		 * Restore the original watchpoint if we've completed the
+		 * single-step.
+		 */
+		if (info->trigger != pc) {
+			arch_uninstall_hw_breakpoint(wp);
+			info->step_ctrl.enabled = 0;
+			arch_install_hw_breakpoint(wp);
 		}
 
+unlock:
 		rcu_read_unlock();
 	}
 }
@@ -723,7 +739,8 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 	/* The exception entry code places the amended lr in the PC. */
 	addr = regs->ARM_pc;
 
-	for (i = 0; i < core_num_brps + core_num_reserved_brps; ++i) {
+	/* Check the currently installed breakpoints first. */
+	for (i = 0; i < core_num_brps; ++i) {
 		rcu_read_lock();
 
 		bp = slots[i];
@@ -750,7 +767,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
 		}
 
 unlock:
-		if ((mismatch && !info->ctrl.mismatch) || bp_is_single_step(bp)) {
+		if (mismatch && !info->ctrl.mismatch) {
 			pr_debug("breakpoint fired: address = 0x%x\n", addr);
 			perf_bp_event(bp, regs);
 		}
@@ -758,6 +775,9 @@ unlock:
 		update_mismatch_flag(i, mismatch);
 		rcu_read_unlock();
 	}
+
+	/* Handle any pending watchpoint single-step breakpoints. */
+	watchpoint_single_step_handler(addr);
 }
 
 /*
-- 
1.7.0.4
