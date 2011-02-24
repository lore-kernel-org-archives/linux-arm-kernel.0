From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 24 Feb 2011 10:55:39 -0800
Subject: [TRIVIAL/PATCH] ARM: hw_breakpoint: Fix newlines in WARN messages
Message-ID: <1298573739-25144-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These warnings are missing newlines and spaces causing confusing
looking output when they trigger.

Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/hw_breakpoint.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index d600bd3..5aab00e 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -238,8 +238,8 @@ static int enable_monitor_mode(void)
 	ARM_DBG_READ(c1, 0, dscr);
 
 	/* Ensure that halting mode is disabled. */
-	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN, "halting debug mode enabled."
-				"Unable to access hardware resources.")) {
+	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN, "halting debug mode enabled. "
+				"Unable to access hardware resources.\n")) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -377,7 +377,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		}
 	}
 
-	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot")) {
+	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot\n")) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -423,7 +423,7 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 		}
 	}
 
-	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot"))
+	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot\n"))
 		return;
 
 	/* Reset the control register. */
@@ -635,7 +635,7 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	if (WARN_ONCE(!bp->overflow_handler &&
 		(arch_check_bp_in_kernelspace(bp) || !core_has_mismatch_brps()
 		 || !bp->hw.bp_target),
-			"overflow handler required but none found")) {
+			"overflow handler required but none found\n")) {
 		ret = -EINVAL;
 	}
 out:
@@ -917,7 +917,8 @@ static int __init arch_hw_breakpoint_init(void)
 	if (dscr & ARM_DSCR_HDBGEN) {
 		max_watchpoint_len = 4;
 		pr_warning("halting debug mode enabled. Assuming maximum "
-			   "watchpoint size of %u bytes.", max_watchpoint_len);
+			   "watchpoint size of %u bytes.\n",
+			   max_watchpoint_len);
 	} else {
 		/* Work out the maximum supported watchpoint length. */
 		max_watchpoint_len = get_max_wp_len();
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
