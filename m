From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Nov 2010 17:08:16 +0000
Subject: [PATCH 1/4] ARM: hw_breakpoint: ensure OS lock is clear before
	writing to debug registers
In-Reply-To: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
References: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
Message-ID: <1290704899-13051-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv7 architects a system for saving and restoring the debug registers
across low-power modes. At the heart of this system is a lock register
which, when set, forbids writes to the debug registers. While locked,
writes to debug registers via the co-processor interface will result
in undefined instruction traps. Linux currently doesn't make use of
this feature because we update the debug registers on context switch
anyway, however the status of the lock is IMPLEMENTATION DEFINED on
reset.

This patch ensures that the lock is cleared during boot so that we
can write to the debug registers safely.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 21e3a4a..793959e 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -768,6 +768,23 @@ static void __init reset_ctrl_regs(void *unused)
 {
 	int i;
 
+	/*
+	 * v7 debug contains save and restore registers so that debug state
+	 * can be maintained across low-power modes without leaving
+	 * the debug logic powered up. It is IMPLEMENTATION DEFINED whether
+	 * we can write to the debug registers out of reset, so we must
+	 * unlock the OS Lock Access Register to avoid taking undefined
+	 * instruction exceptions later on.
+	 */
+	if (debug_arch >= ARM_DEBUG_ARCH_V7_ECP14) {
+		/*
+		 * Unconditionally clear the lock by writing a value
+		 * other than 0xC5ACCE55 to the access register.
+		 */
+		asm volatile("mcr p14, 0, %0, c1, c0, 4" : : "r" (0));
+		isb();
+	}
+
 	if (enable_monitor_mode())
 		return;
 
@@ -810,17 +827,17 @@ static int __init arch_hw_breakpoint_init(void)
 		pr_warning("halting debug mode enabled. Assuming maximum "
 				"watchpoint size of 4 bytes.");
 	} else {
-		/* Work out the maximum supported watchpoint length. */
-		max_watchpoint_len = get_max_wp_len();
-		pr_info("maximum watchpoint size is %u bytes.\n",
-				max_watchpoint_len);
-
 		/*
 		 * Reset the breakpoint resources. We assume that a halting
 		 * debugger will leave the world in a nice state for us.
 		 */
 		smp_call_function(reset_ctrl_regs, NULL, 1);
 		reset_ctrl_regs(NULL);
+
+		/* Work out the maximum supported watchpoint length. */
+		max_watchpoint_len = get_max_wp_len();
+		pr_info("maximum watchpoint size is %u bytes.\n",
+				max_watchpoint_len);
 	}
 
 	/* Register debug fault handler. */
-- 
1.7.0.4
