From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 27 Nov 2015 21:47:04 +0200
Subject: [PATCH v3] clocksource: arm_global_timer: fix suspend resume
Message-ID: <1448653624-25006-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now the System stall is observed on TI AM437x based board
(am437x-gp-evm) during resuming from System suspend when ARM Global
timer is selected as clocksource device (CPUIdle not enabled) - SysRq are working,
but nothing else.

The reason of stall is that ARM Global timer loses its contexts during
System suspend:
   GT_CONTROL.TIMER_ENABLE = 0 (unbanked)
   GT_COUNTERx = 0

Hence, update ARM Global timer driver to reflect above behaviour
- re-enable ARM Global timer on resume GT_CONTROL.TIMER_ENABLE = 1.

CC: Arnd Bergmann <arnd@arndb.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
Changes in v3:
 - dropped all DT specific code
Changes in v2:
 - suspend/resume simplified: nothing is stored any more and
   ARM GT just re-enabled
Link on v2:
 https://lkml.org/lkml/2015/11/20/355
Link on v1:
 https://lkml.org/lkml/2015/11/13/456

 drivers/clocksource/arm_global_timer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index a2cb6fa..10d1417 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -195,12 +195,19 @@ static cycle_t gt_clocksource_read(struct clocksource *cs)
 	return gt_counter_read();
 }
 
+static void gt_resume(struct clocksource *cs)
+{
+	/* re-enable timer on resume */
+	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
+}
+
 static struct clocksource gt_clocksource = {
 	.name	= "arm_global_timer",
 	.rating	= 300,
 	.read	= gt_clocksource_read,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.resume = gt_resume,
 };
 
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
-- 
2.6.3
