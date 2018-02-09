From: tony@atomide.com (Tony Lindgren)
Date: Fri,  9 Feb 2018 08:15:53 -0800
Subject: [PATCH] ARM: OMAP3: Fix prm wake interrupt for resume
Message-ID: <20180209161553.19129-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For platform_suspend_ops, the finish call is too late to re-enable wake
irqs and we need re-enable wake irqs on wake call instead.

Otherwise noirq resume for devices has already happened. And then
dev_pm_disarm_wake_irq() has already disabled the dedicated wake irqs
when the interrupt triggers and the wake irq is never handled.

For devices that are already in PM runtime suspended state when we
enter suspend this means that a possible wake irq will never trigger.

And this can lead into a situation where a device has a pending padconf
wake irq, and the device will stay unresponsive to any further wake
irqs.

This issue can be easily reproduced by setting serial console log level
to zero, letting the serial console idle, and suspend the system from
an ssh terminal. Then try to wake up the system by typing to the serial
console.

Note that this affects only omap3 PRM interrupt as that's currently
the only omap variant that does anything in omap_pm_wake().

In general, for the wake irqs to work, the interrupt must have either
IRQF_NO_SUSPEND or IRQF_EARLY_RESUME set for it to trigger before
dev_pm_disarm_wake_irq() disables the wake irqs.

Reported-by: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -186,7 +186,7 @@ static void omap_pm_end(void)
 	cpu_idle_poll_ctrl(false);
 }
 
-static void omap_pm_finish(void)
+static void omap_pm_wake(void)
 {
 	if (soc_is_omap34xx())
 		omap_prcm_irq_complete();
@@ -196,7 +196,7 @@ static const struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap_pm_begin,
 	.end		= omap_pm_end,
 	.enter		= omap_pm_enter,
-	.finish		= omap_pm_finish,
+	.wake		= omap_pm_wake,
 	.valid		= suspend_valid_only_mem,
 };
 
-- 
2.16.1
