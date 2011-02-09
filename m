From: will.deacon@arm.com (Will Deacon)
Date: Wed,  9 Feb 2011 10:34:11 +0000
Subject: [PATCH] ARM: hw_breakpoint: avoid UNPREDICTABLE behaviour when
	reading DBGDSCR
Message-ID: <1297247651-11701-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reading baseline CP14 registers, other than DBGDIDR, when the OS Lock
is set leads to UNPREDICTABLE behaviour.

This patch ensures that we clear the OS lock before accessing anything
other than the DBGDIDR, thereby avoiding this behaviour.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index c9f3f04..19bedab 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -899,18 +899,18 @@ static int __init arch_hw_breakpoint_init(void)
 		pr_info("%d breakpoint(s) reserved for watchpoint "
 				"single-step.\n", core_num_reserved_brps);
 
+	/*
+	 * Reset the breakpoint resources. We assume that a halting
+	 * debugger will leave the world in a nice state for us.
+	 */
+	on_each_cpu(reset_ctrl_regs, NULL, 1);
+
 	ARM_DBG_READ(c1, 0, dscr);
 	if (dscr & ARM_DSCR_HDBGEN) {
+		max_watchpoint_len = 4;
 		pr_warning("halting debug mode enabled. Assuming maximum "
-				"watchpoint size of 4 bytes.");
+			   "watchpoint size of %u bytes.", max_watchpoint_len);
 	} else {
-		/*
-		 * Reset the breakpoint resources. We assume that a halting
-		 * debugger will leave the world in a nice state for us.
-		 */
-		smp_call_function(reset_ctrl_regs, NULL, 1);
-		reset_ctrl_regs(NULL);
-
 		/* Work out the maximum supported watchpoint length. */
 		max_watchpoint_len = get_max_wp_len();
 		pr_info("maximum watchpoint size is %u bytes.\n",
-- 
1.7.0.4
