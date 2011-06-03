From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  3 Jun 2011 15:57:26 +0100
Subject: [PATCH v1 11/18] ARM: msm: dynamically register local timer
In-Reply-To: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
References: <1307113053-30209-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1307113053-30209-12-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/timer.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index b2747cc..8595b83 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -22,9 +22,11 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
+#include <asm/localtimer.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
 #include <mach/msm_iomap.h>
+
 #include <mach/cpu.h>
 
 #define TIMER_MATCH_VAL         0x0000
@@ -188,6 +190,17 @@ static struct msm_clock msm_clocks[] = {
 	}
 };
 
+#ifdef CONFIG_SMP
+static void __cpuinit msm_local_timer_setup(struct clock_event_device *evt);
+
+static struct local_timer_ops msm_timer_ops = {
+	.setup	= msm_local_timer_setup,
+};
+#define msm_timer_ops_ptr	(&msm_timer_ops)
+#else
+#define msm_timer_ops_ptr	NULL
+#endif
+
 static void __init msm_timer_init(void)
 {
 	int i;
@@ -216,6 +229,8 @@ static void __init msm_timer_init(void)
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 #endif
 
+	percpu_timer_register(msm_timer_ops_ptr);
+
 	for (i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
 		struct msm_clock *clock = &msm_clocks[i];
 		struct clock_event_device *ce = &clock->clockevent;
@@ -254,7 +269,7 @@ static void __init msm_timer_init(void)
 }
 
 #ifdef CONFIG_SMP
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
+static void __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
 {
 	static bool local_timer_inited;
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
@@ -262,7 +277,7 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 
 	/* Use existing clock_event for cpu 0 */
 	if (!smp_processor_id())
-		return 0;
+		return;
 
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 
@@ -289,19 +304,13 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 		if (res) {
 			pr_err("local_timer_setup: request_irq failed for %s\n",
 			       clock->clockevent.name);
-			return res;
+			return;
 		}
 		local_timer_inited = true;
 	} else
 		enable_irq(evt->irq);
 
 	clockevents_register_device(evt);
-	return 0;
-}
-
-inline int local_timer_ack(void)
-{
-	return 1;
 }
 
 #endif
-- 
1.7.0.4
