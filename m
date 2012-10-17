From: will.deacon@arm.com (Will Deacon)
Date: Wed, 17 Oct 2012 16:31:40 +0100
Subject: [PATCH 6/7] ARM: hw_breakpoint: check if monitor mode is enabled
 during validation
In-Reply-To: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
References: <1350487901-3108-1-git-send-email-will.deacon@arm.com>
Message-ID: <1350487901-3108-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than attempt to enable monitor mode explicitly when scheduling in
a breakpoint event (which could raise an undefined exception trap when
accessing DBGDSCRext), instead check that DBGDSCRint.MDBGen is set
during event validation and report an error to the caller if not.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/hw_breakpoint.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
index f267120..3127ae4 100644
--- a/arch/arm/kernel/hw_breakpoint.c
+++ b/arch/arm/kernel/hw_breakpoint.c
@@ -227,6 +227,13 @@ static int get_num_brps(void)
  * be put into halting debug mode at any time by an external debugger
  * but there is nothing we can do to prevent that.
  */
+static int monitor_mode_enabled(void)
+{
+	u32 dscr;
+	ARM_DBG_READ(c1, 0, dscr);
+	return !!(dscr & ARM_DSCR_MDBGEN);
+}
+
 static int enable_monitor_mode(void)
 {
 	u32 dscr;
@@ -320,14 +327,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 {
 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
 	struct perf_event **slot, **slots;
-	int i, max_slots, ctrl_base, val_base, ret = 0;
+	int i, max_slots, ctrl_base, val_base;
 	u32 addr, ctrl;
 
-	/* Ensure that we are in monitor mode and halting mode is disabled. */
-	ret = enable_monitor_mode();
-	if (ret)
-		goto out;
-
 	addr = info->address;
 	ctrl = encode_ctrl_reg(info->ctrl) | 0x1;
 
@@ -354,10 +356,8 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 		}
 	}
 
-	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot\n")) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (WARN_ONCE(i == max_slots, "Can't find any breakpoint slot\n"))
+		return -EBUSY;
 
 	/* Override the breakpoint data with the step data. */
 	if (info->step_ctrl.enabled) {
@@ -375,9 +375,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 
 	/* Setup the control register. */
 	write_wb_reg(ctrl_base + i, ctrl);
-
-out:
-	return ret;
+	return 0;
 }
 
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
@@ -588,6 +586,10 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	int ret = 0;
 	u32 offset, alignment_mask = 0x3;
 
+	/* Ensure that we are in monitor debug mode. */
+	if (!monitor_mode_enabled())
+		return -ENODEV;
+
 	/* Build the arch_hw_breakpoint. */
 	ret = arch_build_bp_info(bp);
 	if (ret)
-- 
1.7.4.1
