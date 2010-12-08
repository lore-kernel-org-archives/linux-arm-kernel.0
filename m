From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  8 Dec 2010 14:40:40 -0800
Subject: [PATCH v3] OMAP2+: PM/serial: fix console semaphore acquire during
	suspend
Message-ID: <1291848040-23394-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
hold console semaphore while OMAP UARTs are disabled) added use of the
console semaphore to protect UARTs from being accessed after disabled
during idle, but this causes problems in suspend.

During suspend, the console semaphore is acquired by the console
suspend method (console_suspend()) so the try_acquire_console_sem()
will always fail and suspend will be aborted.

To fix, introduce a check so the console semaphore is only attempted
during idle, and not during suspend.  Also use the same check so that
the console semaphore is not prematurely released during resume.

Thanks to Paul Walmsley for suggesting adding the same check during
resume.

Cc: Paul Walmsley <paul@pwsan.com>
Tested-by: Jean Pihet <j-pihet@ti.com>
Tested-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to Tony's omap-fixes branch, and recommended for -rc series.

 arch/arm/mach-omap2/pm24xx.c |   35 ++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/pm34xx.c |   27 ++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index c85923e..1e031d0 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -53,6 +53,19 @@
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
 
+#ifdef CONFIG_SUSPEND
+static suspend_state_t suspend_state = PM_SUSPEND_ON;
+static inline bool is_suspending(void)
+{
+	return (suspend_state != PM_SUSPEND_ON);
+}
+#else
+static inline bool is_suspending(void)
+{
+	return false;
+}
+#endif
+
 static void (*omap2_sram_idle)(void);
 static void (*omap2_sram_suspend)(u32 dllctrl, void __iomem *sdrc_dlla_ctrl,
 				  void __iomem *sdrc_power);
@@ -120,8 +133,9 @@ static void omap2_enter_full_retention(void)
 		goto no_sleep;
 
 	/* Block console output in case it is on one of the OMAP UARTs */
-	if (try_acquire_console_sem())
-		goto no_sleep;
+	if (!is_suspending())
+		if (try_acquire_console_sem())
+			goto no_sleep;
 
 	omap_uart_prepare_idle(0);
 	omap_uart_prepare_idle(1);
@@ -136,7 +150,8 @@ static void omap2_enter_full_retention(void)
 	omap_uart_resume_idle(1);
 	omap_uart_resume_idle(0);
 
-	release_console_sem();
+	if (!is_suspending())
+		release_console_sem();
 
 no_sleep:
 	if (omap2_pm_debug) {
@@ -284,6 +299,12 @@ out:
 	local_irq_enable();
 }
 
+static int omap2_pm_begin(suspend_state_t state)
+{
+	suspend_state = state;
+	return 0;
+}
+
 static int omap2_pm_prepare(void)
 {
 	/* We cannot sleep in idle until we have resumed */
@@ -333,10 +354,18 @@ static void omap2_pm_finish(void)
 	enable_hlt();
 }
 
+static void omap2_pm_end(void)
+{
+	suspend_state = PM_SUSPEND_ON;
+	return;
+}
+
 static struct platform_suspend_ops omap_pm_ops = {
+	.begin		= omap2_pm_begin,
 	.prepare	= omap2_pm_prepare,
 	.enter		= omap2_pm_enter,
 	.finish		= omap2_pm_finish,
+	.end		= omap2_pm_end,
 	.valid		= suspend_valid_only_mem,
 };
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0ec8a04..648b8c5 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -50,6 +50,19 @@
 #include "sdrc.h"
 #include "control.h"
 
+#ifdef CONFIG_SUSPEND
+static suspend_state_t suspend_state = PM_SUSPEND_ON;
+static inline bool is_suspending(void)
+{
+	return (suspend_state != PM_SUSPEND_ON);
+}
+#else
+static inline bool is_suspending(void)
+{
+	return false;
+}
+#endif
+
 /* Scratchpad offsets */
 #define OMAP343X_TABLE_ADDRESS_OFFSET	   0xc4
 #define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
@@ -387,10 +400,11 @@ void omap_sram_idle(void)
 	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
-	if (per_next_state < PWRDM_POWER_ON ||
-	    core_next_state < PWRDM_POWER_ON)
-		if (try_acquire_console_sem())
-			goto console_still_active;
+	if (!is_suspending())
+		if (per_next_state < PWRDM_POWER_ON ||
+		    core_next_state < PWRDM_POWER_ON)
+			if (try_acquire_console_sem())
+				goto console_still_active;
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -470,7 +484,8 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(3);
 	}
 
-	release_console_sem();
+	if (!is_suspending())
+		release_console_sem();
 
 console_still_active:
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -514,8 +529,6 @@ out:
 }
 
 #ifdef CONFIG_SUSPEND
-static suspend_state_t suspend_state;
-
 static int omap3_pm_prepare(void)
 {
 	disable_hlt();
-- 
1.7.2.1
