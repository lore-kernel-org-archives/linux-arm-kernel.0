From: will.deacon@arm.com (Will Deacon)
Date: Thu,  2 Dec 2010 13:46:02 +0000
Subject: [PATCH 11/11] ARM: hw_breakpoint: do not fail initcall if monitor
	mode is disabled
In-Reply-To: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
References: <1291297562-8052-1-git-send-email-will.deacon@arm.com>
Message-ID: <1291297562-8052-12-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The debug registers can only be manipulated from software if monitor
debug mode is enabled. On some cores, this can never be enabled (i.e.
the corresponding bit the the DSCR is RAZ/WI).

This patch ensures we can handle this hardware configuration and fail
gracefully, rather than blow up the kernel during boot.

Reported-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index 56ed9a6..da647d9 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -225,6 +225,9 @@ int hw_breakpoint_slots(int type)
 	 * We can be called early, so don't rely on
 	 * our static variables being initialised.
 	 */
+	if (enable_monitor_mode())
+		return 0;
+
 	switch (type) {
 	case TYPE_INST:
 		return get_num_brps();
@@ -272,10 +275,8 @@ static int enable_monitor_mode(void)
 
 	/* Check that the write made it through. */
 	ARM_DBG_READ(c1, 0, dscr);
-	if (WARN_ONCE(!(dscr & ARM_DSCR_MDBGEN),
-				"failed to enable monitor mode.")) {
+	if (!(dscr & ARM_DSCR_MDBGEN))
 		ret = -EPERM;
-	}
 
 out:
 	return ret;
@@ -294,9 +295,6 @@ static u8 get_max_wp_len(void)
 	if (debug_arch < ARM_DEBUG_ARCH_V7_ECP14)
 		goto out;
 
-	if (enable_monitor_mode())
-		goto out;
-
 	memset(&ctrl, 0, sizeof(ctrl));
 	ctrl.len = ARM_BREAKPOINT_LEN_8;
 	ctrl_reg = encode_ctrl_reg(ctrl);
@@ -879,15 +877,18 @@ static struct notifier_block __cpuinitdata dbg_reset_nb = {
 
 static int __init arch_hw_breakpoint_init(void)
 {
-	int ret = 0;
 	u32 dscr;
 
 	debug_arch = get_debug_arch();
 
 	if (debug_arch > ARM_DEBUG_ARCH_V7_ECP14) {
 		pr_info("debug architecture 0x%x unsupported.\n", debug_arch);
-		ret = -ENODEV;
-		goto out;
+		return 0;
+	}
+
+	if (enable_monitor_mode()) {
+		pr_warning("unable to activate monitor debug mode.\n");
+		return 0;
 	}
 
 	/* Determine how many BRPs/WRPs are available. */
@@ -928,8 +929,7 @@ static int __init arch_hw_breakpoint_init(void)
 
 	/* Register hotplug notifier. */
 	register_cpu_notifier(&dbg_reset_nb);
-out:
-	return ret;
+	return 0;
 }
 arch_initcall(arch_hw_breakpoint_init);
 
-- 
1.7.0.4
