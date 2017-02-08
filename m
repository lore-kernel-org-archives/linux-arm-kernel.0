From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Wed,  8 Feb 2017 15:39:34 -0600
Subject: [PATCH v4 2/2] irqchip/gicv3: Don't register PM notifier if GIC
 security is enabled
In-Reply-To: <1486589974-6184-1-git-send-email-shankerd@codeaurora.org>
References: <1486589974-6184-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <1486589974-6184-2-git-send-email-shankerd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The commit ccd9432a5c 'irqchip/gicv3: Remove disabling redistributor
and group1 non-secure interrupts' was introduced to avoid GICR sleep
and wakeup steps on systems where GIC support two security states.
Unfortunately code was using the incorrect (GICD_CTLR.DS) information
to know GIC security state.

In case of two security states, it make sence the TZ/firmware is
responsible for GICR power management and preserve configuration
across power save modes. The GICR sleep/wake mechanism is not
allowed from Non-secure EL1/EL2 since GICR_WAKE is RAZ/WI. So,
don't register a CPU PM notifier to fix the problem, cleanup
gic_cpu_pm_notifier(), and also get rid of the unused function
gic_dist_security_disabled().

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
---
 drivers/irqchip/irq-gic-v3.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index ff5265e..9969ea5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -703,20 +703,13 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #endif
 
 #ifdef CONFIG_CPU_PM
-/* Check whether it's single security state view */
-static bool gic_dist_security_disabled(void)
-{
-	return readl_relaxed(gic_data.dist_base + GICD_CTLR) & GICD_CTLR_DS;
-}
-
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
 {
 	if (cmd == CPU_PM_EXIT) {
-		if (gic_dist_security_disabled())
-			gic_enable_redist(true);
+		gic_enable_redist(true);
 		gic_cpu_sys_reg_init();
-	} else if (cmd == CPU_PM_ENTER && gic_dist_security_disabled()) {
+	} else if (cmd == CPU_PM_ENTER) {
 		gic_write_grpen1(0);
 		gic_enable_redist(false);
 	}
@@ -729,6 +722,13 @@ static int gic_cpu_pm_notifier(struct notifier_block *self,
 
 static void gic_cpu_pm_init(void)
 {
+	/**
+	 * On systems with two security states, the TZ/firmware is
+	 * responsible for redistributor power management.
+	 */
+	if (gic_has_security_extn())
+		return;
+
 	cpu_pm_register_notifier(&gic_cpu_pm_notifier_block);
 }
 
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
