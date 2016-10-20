From: panand@redhat.com (Pratyush Anand)
Date: Thu, 20 Oct 2016 11:18:15 +0530
Subject: [PATCH V2 3/5] arm64: hw_breakpoint: Handle inexact watchpoint
 addresses
In-Reply-To: <cover.1476941895.git.panand@redhat.com>
References: <cover.1476941895.git.panand@redhat.com>
Message-ID: <22f4d20911e39efa0b8a6f7082d6839b80bb16b0.1476941895.git.panand@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pavel Labath <test.tberghammer@gmail.com>

Arm64 hardware does not always report a watchpoint hit address that
matches one of the watchpoints set. It can also report an address
"near" the watchpoint if a single instruction access both watched and
unwatched addresses. There is no straight-forward way, short of
disassembling the offending instruction, to map that address back to
the watchpoint.

Previously, when the hardware reported a watchpoint hit on an address
that did not match our watchpoint (this happens in case of instructions
which access large chunks of memory such as "stp") the process would
enter a loop where we would be continually resuming it (because we did
not recognise that watchpoint hit) and it would keep hitting the
watchpoint again and again. The tracing process would never get
notified of the watchpoint hit.

This commit fixes the problem by looking at the watchpoints near the
address reported by the hardware. If the address does not exactly match
one of the watchpoints we have set, it attributes the hit to the
nearest watchpoint we have.  This heuristic is a bit dodgy, but I don't
think we can do much more, given the hardware limitations.

[panand: reworked to rebase on his patches]

Signed-off-by: Pavel Labath <labath@google.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 arch/arm64/kernel/hw_breakpoint.c | 94 +++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 28 deletions(-)

diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 3c2b96803eba..c57bc90b8286 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -662,11 +662,46 @@ unlock:
 }
 NOKPROBE_SYMBOL(breakpoint_handler);
 
+/*
+ * Arm64 hardware does not always report a watchpoint hit address that matches
+ * one of the watchpoints set. It can also report an address "near" the
+ * watchpoint if a single instruction access both watched and unwatched
+ * addresses. There is no straight-forward way, short of disassembling the
+ * offending instruction, to map that address back to the watchpoint. This
+ * function computes the distance of the memory access from the watchpoint as a
+ * heuristic for the likelyhood that a given access triggered the watchpoint.
+ *
+ * See Section D2.10.5 "Determining the memory location that caused a Watchpoint
+ * exception" of ARMv8 Architecture Reference Manual for details.
+ *
+ * The function returns the distance of the address from the bytes watched by
+ * the watchpoint. In case of an exact match, it returns 0.
+ */
+static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
+					struct arch_hw_breakpoint_ctrl *ctrl)
+{
+	u64 wp_low, wp_high;
+	u32 lens, lene;
+
+	lens = ffs(ctrl->len) - 1;
+	lene = fls(ctrl->len) - 1;
+
+	wp_low = val + lens;
+	wp_high = val + lene;
+	if (addr < wp_low)
+		return wp_low - addr;
+	else if (addr > wp_high)
+		return addr - wp_high;
+	else
+		return 0;
+}
+
 static int watchpoint_handler(unsigned long addr, unsigned int esr,
 			      struct pt_regs *regs)
 {
-	int i, step = 0, *kernel_step, access;
-	u32 ctrl_reg, lens, lene;
+	int i, step = 0, *kernel_step, access, closest_match = 0;
+	u64 min_dist = -1, dist;
+	u32 ctrl_reg;
 	u64 val;
 	struct perf_event *wp, **slots;
 	struct debug_info *debug_info;
@@ -676,31 +711,15 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 	slots = this_cpu_ptr(wp_on_reg);
 	debug_info = &current->thread.debug;
 
+	/*
+	 * Find all watchpoints that match the reported address. If no exact
+	 * match is found. Attribute the hit to the closest watchpoint.
+	 */
+	rcu_read_lock();
 	for (i = 0; i < core_num_wrps; ++i) {
-		rcu_read_lock();
-
 		wp = slots[i];
-
 		if (wp == NULL)
-			goto unlock;
-
-		info = counter_arch_bp(wp);
-
-		/* Check if the watchpoint value and byte select match. */
-		val = read_wb_reg(AARCH64_DBG_REG_WVR, i);
-		ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
-		decode_ctrl_reg(ctrl_reg, &ctrl);
-		lens = ffs(ctrl.len) - 1;
-		lene = fls(ctrl.len) - 1;
-		/*
-		 * FIXME: reported address can be anywhere between "the
-		 * lowest address accessed by the memory access that
-		 * triggered the watchpoint" and "the highest watchpointed
-		 * address accessed by the memory access". So, it may not
-		 * lie in the interval of watchpoint address range.
-		 */
-		if (addr < val + lens || addr > val + lene)
-			goto unlock;
+			continue;
 
 		/*
 		 * Check that the access type matches.
@@ -709,18 +728,37 @@ static int watchpoint_handler(unsigned long addr, unsigned int esr,
 		access = (esr & AARCH64_ESR_ACCESS_MASK) ? HW_BREAKPOINT_W :
 			 HW_BREAKPOINT_R;
 		if (!(access & hw_breakpoint_type(wp)))
-			goto unlock;
+			continue;
+
+		/* Check if the watchpoint value and byte select match. */
+		val = read_wb_reg(AARCH64_DBG_REG_WVR, i);
+		ctrl_reg = read_wb_reg(AARCH64_DBG_REG_WCR, i);
+		decode_ctrl_reg(ctrl_reg, &ctrl);
+		dist = get_distance_from_watchpoint(addr, val, &ctrl);
+		if (dist < min_dist) {
+			min_dist = dist;
+			closest_match = i;
+		}
+		/* Is this an exact match? */
+		if (dist != 0)
+			continue;
 
+		info = counter_arch_bp(wp);
 		info->trigger = addr;
 		perf_bp_event(wp, regs);
 
 		/* Do we need to handle the stepping? */
 		if (is_default_overflow_handler(wp))
 			step = 1;
-
-unlock:
-		rcu_read_unlock();
 	}
+	if (min_dist > 0 && min_dist != -1) {
+		/* No exact match found. */
+		wp = slots[closest_match];
+		info = counter_arch_bp(wp);
+		info->trigger = addr;
+		perf_bp_event(wp, regs);
+	}
+	rcu_read_unlock();
 
 	if (!step)
 		return 0;
-- 
2.7.4
