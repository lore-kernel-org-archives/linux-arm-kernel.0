From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 26 Aug 2013 18:33:56 +0200
Subject: [PATCH] clocksource: exynos_mct: Set IRQ affinity when the CPU goes
 online
Message-ID: <1377534836-21682-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some variants of Exynos MCT, namely exynos4210-mct at the moment, use
normal, shared interrupts for local timers. This means that each
interrupt must have correct affinity set to fire only on CPU
corresponding to given local timer.

However after recent conversion of clocksource drivers to not use the
local timer API for local timer initialization any more, the point of
time when local timers get initialized changed and irq_set_affinity()
fails because the CPU is not marked as online yet.

This patch fixes this by moving the call to irq_set_affinity() to
CPU_ONLINE notification, so the affinity is being set when the CPU goes
online.

This fixes a problem with Exynos4210 failing to boot, present since commit
	ee98d27df6 ARM: EXYNOS4: Divorce mct from local timer API
due to failing irq_set_affinity().

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 5b34768..62b0de6 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -428,7 +428,6 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 				evt->irq);
 			return -EIO;
 		}
-		irq_set_affinity(evt->irq, cpumask_of(cpu));
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
@@ -449,6 +448,7 @@ static int exynos4_mct_cpu_notify(struct notifier_block *self,
 					   unsigned long action, void *hcpu)
 {
 	struct mct_clock_event_device *mevt;
+	unsigned int cpu;
 
 	/*
 	 * Grab cpu pointer in each case to avoid spurious
@@ -459,6 +459,12 @@ static int exynos4_mct_cpu_notify(struct notifier_block *self,
 		mevt = this_cpu_ptr(&percpu_mct_tick);
 		exynos4_local_timer_setup(&mevt->evt);
 		break;
+	case CPU_ONLINE:
+		cpu = (unsigned long)hcpu;
+		if (mct_int_type == MCT_INT_SPI)
+			irq_set_affinity(mct_irqs[MCT_L0_IRQ + cpu],
+						cpumask_of(cpu));
+		break;
 	case CPU_DYING:
 		mevt = this_cpu_ptr(&percpu_mct_tick);
 		exynos4_local_timer_stop(&mevt->evt);
@@ -500,6 +506,8 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     mct_irqs[MCT_L0_IRQ], err);
+	} else {
+		irq_set_affinity(mct_irqs[MCT_L0_IRQ], cpumask_of(0));
 	}
 
 	err = register_cpu_notifier(&exynos4_mct_cpu_nb);
-- 
1.8.3.2
