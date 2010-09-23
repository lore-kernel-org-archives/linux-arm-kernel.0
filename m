From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 23 Sep 2010 09:54:41 -0700
Subject: [PATCH] OMAP3: CPUidle: trigger early idle notification call chain
Message-ID: <mailman.0.1287687242.1544.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During the early part of the CPUidle path (state selection by the
governer, checking for device activity, etc.) there is no (good)
reason to have interrupts disabled.

Therefore, enable interrupts early in the CPUidle path and then
trigger the "early" idle notifier call chain after device activity
checks and the next power states have been programmed.  Interrupts are
then (re)disabled after the final state is selected.

Also adjust the timing measurements reported back to the CPUidle core
to ensure that time spent in the idle notifiers is included as part of
the accounted time.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c |   33 +++++++++++++++++++++++++++------
 1 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 0d50b45..6c806a8 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -30,6 +30,7 @@
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
 #include <plat/serial.h>
+#include <plat/common.h>
 
 #include "pm.h"
 #include "control.h"
@@ -128,12 +129,14 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	/* Used to keep track of the total time in idle */
 	getnstimeofday(&ts_preidle);
 
-	local_irq_disable();
-	local_fiq_disable();
-
 	pwrdm_set_next_pwrst(mpu_pd, mpu_state);
 	pwrdm_set_next_pwrst(core_pd, core_state);
 
+	omap_early_idle_notifier_start();
+
+	local_irq_disable();
+	local_fiq_disable();
+
 	if (omap_irq_pending() || need_resched())
 		goto return_sleep_time;
 
@@ -151,12 +154,14 @@ static int omap3_enter_idle(struct cpuidle_device *dev,
 	}
 
 return_sleep_time:
-	getnstimeofday(&ts_postidle);
-	ts_idle = timespec_sub(ts_postidle, ts_preidle);
-
 	local_irq_enable();
 	local_fiq_enable();
 
+	omap_early_idle_notifier_end();
+
+	getnstimeofday(&ts_postidle);
+	ts_idle = timespec_sub(ts_postidle, ts_preidle);
+
 	return ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_sec * USEC_PER_SEC;
 }
 
@@ -459,6 +464,21 @@ struct cpuidle_driver omap3_idle_driver = {
 	.owner = 	THIS_MODULE,
 };
 
+static int omap3_idle_prepare(struct cpuidle_device *dev)
+{
+	/*
+	 * Enable interrupts during the early part of the CPUidle path.
+	 * They are later (re)disabled when the final state is selected.
+	 *
+	 * The primary reason for this is to enable non-atomic idle
+	 * notifications to drivers that want to coordinate device
+	 * idle transitions with CPU idle transitions.
+	 */
+	local_irq_enable();
+
+	return 0;
+}
+
 /**
  * omap3_idle_init - Init routine for OMAP3 idle
  *
@@ -482,6 +502,7 @@ int __init omap3_idle_init(void)
 
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
 
+	dev->prepare = omap3_idle_prepare;
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
 		cx = &omap3_power_states[i];
 		state = &dev->states[count];
-- 
1.7.2.1
