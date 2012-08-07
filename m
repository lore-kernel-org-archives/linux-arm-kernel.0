From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Aug 2012 16:49:47 +0100
Subject: [PATCH 1/2] ARM: hw_breakpoint: don't rely on dfsr to show watchpoint
 access type
Message-ID: <1344354588-28153-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From ARM debug architecture v7.1 onwards, a watchpoint exception causes
the DFAR to be updated with the faulting data address. However, DFSR.WnR
takes an UNKNOWN value and therefore cannot be used in general to
determine the access type that triggered the watchpoint.

This patch forbids watchpoints without an overflow handler from
specifying a specific access type (load/store). Those with overflow
handlers must be able to handle false positives potentially triggered by
a watchpoint of a different access type on the same address. For
SIGTRAP-based handlers (i.e. ptrace), this should have no impact.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   54 ++++++++++++++++++++++++++++-----------
 1 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index ba386bd..418d980 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -159,6 +159,12 @@ static int debug_arch_supported(void)
 		arch >= ARM_DEBUG_ARCH_V7_1;
 }
 
+/* Can we determine the watchpoint access type from the fsr? */
+static int debug_exception_updates_fsr(void)
+{
+	return 0;
+}
+
 /* Determine number of WRP registers available. */
 static int get_num_wrp_resources(void)
 {
@@ -619,18 +625,34 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	info->address &= ~alignment_mask;
 	info->ctrl.len <<= offset;
 
-	/*
-	 * Currently we rely on an overflow handler to take
-	 * care of single-stepping the breakpoint when it fires.
-	 * In the case of userspace breakpoints on a core with V7 debug,
-	 * we can use the mismatch feature as a poor-man's hardware
-	 * single-step, but this only works for per-task breakpoints.
-	 */
-	if (!bp->overflow_handler && (arch_check_bp_in_kernelspace(bp) ||
-	    !core_has_mismatch_brps() || !bp->hw.bp_target)) {
-		pr_warning("overflow handler required but none found\n");
-		ret = -EINVAL;
+	if (!bp->overflow_handler) {
+		/*
+		 * Mismatch breakpoints are required for single-stepping
+		 * breakpoints.
+		 */
+		if (!core_has_mismatch_brps())
+			return -EINVAL;
+
+		/* We don't allow mismatch breakpoints in kernel space. */
+		if (arch_check_bp_in_kernelspace(bp))
+			return -EPERM;
+
+		/*
+		 * Per-cpu breakpoints are not supported by our stepping
+		 * mechanism. */
+		if (!bp->hw.bp_target)
+			return -EINVAL;
+
+		/*
+		 * We only support specific access types if the fsr
+		 * reports them.
+		 */
+		if (!debug_exception_updates_fsr() &&
+		    (info->ctrl.type == ARM_BREAKPOINT_LOAD ||
+		     info->ctrl.type == ARM_BREAKPOINT_STORE))
+			return -EINVAL;
 	}
+
 out:
 	return ret;
 }
@@ -706,10 +728,12 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
 				goto unlock;
 
 			/* Check that the access type matches. */
-			access = (fsr & ARM_FSR_ACCESS_MASK) ? HW_BREAKPOINT_W :
-				 HW_BREAKPOINT_R;
-			if (!(access & hw_breakpoint_type(wp)))
-				goto unlock;
+			if (debug_exception_updates_fsr()) {
+				access = (fsr & ARM_FSR_ACCESS_MASK) ?
+					  HW_BREAKPOINT_W : HW_BREAKPOINT_R;
+				if (!(access & hw_breakpoint_type(wp)))
+					goto unlock;
+			}
 
 			/* We have a winner. */
 			info->trigger = addr;
-- 
1.7.4.1
