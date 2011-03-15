From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2011 15:12:56 +0000
Subject: [RFC PATCHv2 13/20] ARM: msm: dynamically register local timer setup
	function
In-Reply-To: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
References: <1300201983-26124-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1300201983-26124-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-msm/timer.c |   22 +++++++++++++++++++---
 1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 56f920c..f4b6d54 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -22,8 +22,10 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
+#include <asm/localtimer.h>
 #include <asm/mach/time.h>
 #include <mach/msm_iomap.h>
+
 #include <mach/cpu.h>
 
 #define TIMER_MATCH_VAL         0x0000
@@ -200,6 +202,19 @@ static struct msm_clock msm_clocks[] = {
 	}
 };
 
+#ifdef CONFIG_SMP
+static void __cpuinit msm_local_timer_setup(struct clock_event_device *evt);
+static int msm_local_timer_ack(void);
+
+static struct local_timer_ops msm_timer_ops = {
+	.setup	= msm_local_timer_setup,
+	.ack	= msm_local_timer_ack,
+};
+#define msm_timer_ops_ptr	(&msm_timer_ops)
+#else
+#define msm_timer_ops_ptr	NULL
+#endif
+
 static void __init msm_timer_init(void)
 {
 	int i;
@@ -228,6 +243,8 @@ static void __init msm_timer_init(void)
 	writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
 #endif
 
+	percpu_timer_register(msm_timer_ops_ptr);
+
 	for (i = 0; i < ARRAY_SIZE(msm_clocks); i++) {
 		struct msm_clock *clock = &msm_clocks[i];
 		struct clock_event_device *ce = &clock->clockevent;
@@ -263,7 +280,7 @@ static void __init msm_timer_init(void)
 }
 
 #ifdef CONFIG_SMP
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
+static void __cpuinit msm_local_timer_setup(struct clock_event_device *evt)
 {
 	struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
 
@@ -295,10 +312,9 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
 	gic_enable_ppi(clock->irq.irq);
 
 	clockevents_register_device(evt);
-	return 0;
 }
 
-inline int local_timer_ack(void)
+static inline int msm_local_timer_ack(void)
 {
 	return 1;
 }
-- 
1.7.0.4
