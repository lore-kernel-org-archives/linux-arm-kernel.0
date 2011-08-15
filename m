From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2011 18:41:57 +0100
Subject: [PATCH v2 5/5] ARM: hw_breakpoint: reduce the number of WARN_ONCE
	invocations
In-Reply-To: <1313430117-3439-1-git-send-email-will.deacon@arm.com>
References: <1313430117-3439-1-git-send-email-will.deacon@arm.com>
Message-ID: <1313430117-3439-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM hw_breakpoint backend is currently a bit too noisy when things
start to go awry.

This patch removes a couple of over-zealous WARN_ONCE invocations and
replaces then with pr_warnings instead.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 64ac5c6..5a46225 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -136,10 +136,11 @@ static u8 get_debug_arch(void)
 	u32 didr;
 
 	/* Do we implement the extended CPUID interface? */
-	if (WARN_ONCE((((read_cpuid_id() >> 16) & 0xf) != 0xf),
-	    "CPUID feature registers not supported. "
-	    "Assuming v6 debug is present.\n"))
+	if (((read_cpuid_id() >> 16) & 0xf) != 0xf) {
+		pr_warning("CPUID feature registers not supported. "
+			   "Assuming v6 debug is present.\n");
 		return ARM_DEBUG_ARCH_V6;
+	}
 
 	ARM_DBG_READ(c0, 0, didr);
 	return (didr >> 16) & 0xf;
@@ -231,7 +232,7 @@ static int enable_monitor_mode(void)
 
 	/* Ensure that halting mode is disabled. */
 	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN,
-			"halting debug mode enabled. Unable to access hardware resources.\n")) {
+		"halting debug mode enabled. Unable to access hardware resources.\n")) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -626,10 +627,9 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * we can use the mismatch feature as a poor-man's hardware
 	 * single-step, but this only works for per-task breakpoints.
 	 */
-	if (WARN_ONCE(!bp->overflow_handler &&
-		(arch_check_bp_in_kernelspace(bp) || !core_has_mismatch_brps()
-		 || !bp->hw.bp_target),
-			"overflow handler required but none found\n")) {
+	if (!bp->overflow_handler && (arch_check_bp_in_kernelspace(bp) ||
+	    !core_has_mismatch_brps() || !bp->hw.bp_target)) {
+		pr_warning("overflow handler required but none found\n");
 		ret = -EINVAL;
 	}
 out:
-- 
1.7.0.4
