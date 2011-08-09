From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  9 Aug 2011 10:56:41 +0100
Subject: [PATCH v11 3/4] ARM: local timers: drop local_timer_ack()
In-Reply-To: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
References: <1312883802-15022-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1312883802-15022-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only TWD uses local_timer_ack() to perform something useful.
Make it the real (private) interrupt handler, remove the
common interrupt handler as well as the useless stubs from
MCT and MSM.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: David Brown <davidb@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/localtimer.h |   12 ------------
 arch/arm/include/asm/smp_twd.h    |    1 -
 arch/arm/kernel/smp.c             |   14 --------------
 arch/arm/kernel/smp_twd.c         |   17 +++++++----------
 arch/arm/mach-exynos4/mct.c       |    6 ------
 arch/arm/mach-msm/timer.c         |    6 ------
 6 files changed, 7 insertions(+), 49 deletions(-)

diff --git a/arch/arm/include/asm/localtimer.h b/arch/arm/include/asm/localtimer.h
index 136a31b..f5e1cec 100644
--- a/arch/arm/include/asm/localtimer.h
+++ b/arch/arm/include/asm/localtimer.h
@@ -19,29 +19,17 @@ struct clock_event_device;
  */
 void percpu_timer_setup(void);
 
-/*
- * Per-cpu timer IRQ handler
- */
-irqreturn_t percpu_timer_handler(int irq, void *dev_id);
-
 #ifdef CONFIG_LOCAL_TIMERS
 
 #ifdef CONFIG_HAVE_ARM_TWD
 
 #include "smp_twd.h"
 
-#define local_timer_ack()	twd_timer_ack()
 #define local_timer_stop(c)	twd_timer_stop((c))
 
 #else
 
 /*
- * Platform provides this to acknowledge a local timer IRQ.
- * Returns true if the local timer IRQ is to be processed.
- */
-int local_timer_ack(void);
-
-/*
  * Stop the local timer
  */
 void local_timer_stop(struct clock_event_device *);
diff --git a/arch/arm/include/asm/smp_twd.h b/arch/arm/include/asm/smp_twd.h
index 6923037..ef9ffba 100644
--- a/arch/arm/include/asm/smp_twd.h
+++ b/arch/arm/include/asm/smp_twd.h
@@ -22,7 +22,6 @@ struct clock_event_device;
 
 extern void __iomem *twd_base;
 
-int twd_timer_ack(void);
 void twd_timer_setup(struct clock_event_device *);
 void twd_timer_stop(struct clock_event_device *);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 93b7c9a..5d1f2e2 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -469,20 +469,6 @@ static void ipi_timer(void)
 	irq_exit();
 }
 
-#ifdef CONFIG_LOCAL_TIMERS
-irqreturn_t percpu_timer_handler(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = dev_id;
-
-	if (local_timer_ack()) {
-		evt->event_handler(evt);
-		return IRQ_HANDLED;
-	}
-
-	return IRQ_NONE;
-}
-#endif
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 static void smp_timer_broadcast(const struct cpumask *mask)
 {
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 1bf0631..7156f09 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -65,20 +65,17 @@ static int twd_set_next_event(unsigned long evt,
 	return 0;
 }
 
-/*
- * local_timer_ack: checks for a local timer interrupt.
- *
- * If a local timer interrupt has occurred, acknowledge and return 1.
- * Otherwise, return 0.
- */
-int twd_timer_ack(void)
+static irqreturn_t twd_timer_handler(int irq, void *dev_id)
 {
+	struct clock_event_device *clk = dev_id;
+
 	if (__raw_readl(twd_base + TWD_TIMER_INTSTAT)) {
 		__raw_writel(1, twd_base + TWD_TIMER_INTSTAT);
-		return 1;
+		clk->event_handler(clk);
+		return IRQ_HANDLED;
 	}
 
-	return 0;
+	return IRQ_NONE;
 }
 
 void twd_timer_stop(struct clock_event_device *clk)
@@ -148,7 +145,7 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 
 	clockevents_register_device(clk);
 
-	err = gic_request_ppi(clk->irq, percpu_timer_handler, clk);
+	err = gic_request_ppi(clk->irq, twd_timer_handler, clk);
 	if (err)
 		pr_err("%s: can't register interrupt %d on cpu %d (%d)\n",
 		       clk->name, clk->irq, smp_processor_id(), err);
diff --git a/arch/arm/mach-exynos4/mct.c b/arch/arm/mach-exynos4/mct.c
index 1ae059b..194fc6d 100644
--- a/arch/arm/mach-exynos4/mct.c
+++ b/arch/arm/mach-exynos4/mct.c
@@ -393,12 +393,6 @@ void __cpuinit local_timer_setup(struct clock_event_device *evt)
 {
 	exynos4_mct_tick_init(evt);
 }
-
-int local_timer_ack(void)
-{
-	return 0;
-}
-
 #endif /* CONFIG_LOCAL_TIMERS */
 
 static void __init exynos4_timer_resources(void)
diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 1bcdf66..94e6fc5 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -309,12 +309,6 @@ void local_timer_stop(struct clock_event_device *evt)
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	gic_free_ppi(evt->irq, evt);
 }
-
-inline int local_timer_ack(void)
-{
-	return 1;
-}
-
 #endif
 
 struct sys_timer msm_timer = {
-- 
1.7.0.4
