From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:36 +0100
Subject: [PATCH 2/7] ARM: hw_breakpoint: fix monitor mode detection with v7.1
In-Reply-To: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350487901-3108-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Detecting whether halting debug is enabled is no longer possible via
the DBGDSCR in v7.1, returning an UNKNOWN value for the HDBGen bit via
CP14 when the OS lock is clear.

This patch removes the halting mode check and ensures that accesses to
the internal and external views of the DBGDSCR are serialised with an
instruction barrier.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index ec16ada..169dcce 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -235,13 +235,6 @@ static int enable_monitor_mode(void)
 
 	ARM_DBG_READ(c1, 0, dscr);
 
-	/* Ensure that halting mode is disabled. */
-	if (WARN_ONCE(dscr & ARM_DSCR_HDBGEN,
-		"halting debug mode enabled. Unable to access hardware resources.\n")) {
-		ret = -EPERM;
-		goto out;
-	}
-
 	/* If monitor mode is already enabled, just return. */
 	if (dscr & ARM_DSCR_MDBGEN)
 		goto out;
@@ -255,6 +248,7 @@ static int enable_monitor_mode(void)
 	case ARM_DEBUG_ARCH_V7_ECP14:
 	case ARM_DEBUG_ARCH_V7_1:
 		ARM_DBG_WRITE(c2, 2, (dscr | ARM_DSCR_MDBGEN));
+		isb();
 		break;
 	default:
 		ret = -ENODEV;
@@ -1000,8 +994,6 @@ static struct notifier_block __cpuinitdata dbg_reset_nb = {
 
 static int __init arch_hw_breakpoint_init(void)
 {
-	u32 dscr;
-
 	debug_arch = get_debug_arch();
 
 	if (!debug_arch_supported()) {
@@ -1036,17 +1028,10 @@ static int __init arch_hw_breakpoint_init(void)
 		core_num_brps, core_has_mismatch_brps() ? "(+1 reserved) " :
 		"", core_num_wrps);
 
-	ARM_DBG_READ(c1, 0, dscr);
-	if (dscr & ARM_DSCR_HDBGEN) {
-		max_watchpoint_len = 4;
-		pr_warning("halting debug mode enabled. Assuming maximum watchpoint size of %u bytes.\n",
-			   max_watchpoint_len);
-	} else {
-		/* Work out the maximum supported watchpoint length. */
-		max_watchpoint_len = get_max_wp_len();
-		pr_info("maximum watchpoint size is %u bytes.\n",
-				max_watchpoint_len);
-	}
+	/* Work out the maximum supported watchpoint length. */
+	max_watchpoint_len = get_max_wp_len();
+	pr_info("maximum watchpoint size is %u bytes.\n",
+			max_watchpoint_len);
 
 	/* Register debug fault handler. */
 	hook_fault_code(FAULT_CODE_DEBUG, hw_breakpoint_pending, SIGTRAP,
-- 
1.7.4.1
