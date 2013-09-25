From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 25 Sep 2013 22:49:38 +0800
Subject: [PATCH] clockevent: exynos_mct: fix lockdep warning
Message-ID: <1380120578-17458-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves request_irq() out of cpu notifier callback
to fix below lockdep warning:

[    0.249513] ------------[ cut here ]------------
[    0.249525] WARNING: CPU: 1 PID: 0 at kernel/lockdep.c:2740 lockdep_trace_alloc+0xc8/0x10c()
[    0.249534] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[    0.249538] Modules linked in:
[    0.249548] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.0-rc1-next-20130923+ #338
[    0.249564] [<c00165d0>] (unwind_backtrace+0x0/0xec) from [<c0012b48>] (show_stack+0x20/0x24)
[    0.249577] [<c0012b48>] (show_stack+0x20/0x24) from [<c04ebf0c>] (dump_stack+0x74/0xb4)
[    0.249591] [<c04ebf0c>] (dump_stack+0x74/0xb4) from [<c00237a8>] (warn_slowpath_common+0x78/0x9c)
[    0.249604] [<c00237a8>] (warn_slowpath_common+0x78/0x9c) from [<c0023888>] (warn_slowpath_fmt+0x40/0x48)
[    0.249615] [<c0023888>] (warn_slowpath_fmt+0x40/0x48) from [<c007f194>] (lockdep_trace_alloc+0xc8/0x10c)
[    0.249626] [<c007f194>] (lockdep_trace_alloc+0xc8/0x10c) from [<c01173b0>] (kmem_cache_alloc_trace+0x38/0x2
24)
[    0.249638] [<c01173b0>] (kmem_cache_alloc_trace+0x38/0x224) from [<c006bc4c>] (request_threaded_irq+0x90/0x130)
[    0.249651] [<c006bc4c>] (request_threaded_irq+0x90/0x130) from [<c0408c60>] (exynos4_local_timer_setup+0xdc/0x140)
[    0.249663] [<c0408c60>] (exynos4_local_timer_setup+0xdc/0x140) from [<c0408d78>] (exynos4_mct_cpu_notify+0x40/0xb0)
[    0.249675] [<c0408d78>] (exynos4_mct_cpu_notify+0x40/0xb0) from [<c04f4e18>] (notifier_call_chain+0x48/0x78)
[    0.249688] [<c04f4e18>] (notifier_call_chain+0x48/0x78) from [<c004abb0>] (__raw_notifier_call_chain+0x24/0x2c)
[    0.249700] [<c004abb0>] (__raw_notifier_call_chain+0x24/0x2c) from [<c0023908>] (__cpu_notify+0x3c/0x58)
[    0.249713] [<c0023908>] (__cpu_notify+0x3c/0x58) from [<c0023944>] (cpu_notify+0x20/0x24)
[    0.249725] [<c0023944>] (cpu_notify+0x20/0x24) from [<c002407c>] (notify_cpu_starting+0x58/0x60)
[    0.249737] [<c002407c>] (notify_cpu_starting+0x58/0x60) from [<c00143cc>] (secondary_start_kernel+0xec/0x13
8)
[    0.249748] [<c00143cc>] (secondary_start_kernel+0xec/0x138) from [<40008664>] (0x40008664)
[    0.249767] ---[ end trace 3406ff24bd97382e ]---

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/clocksource/exynos_mct.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 5b34768..94b35aa 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -419,19 +419,10 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 
 	exynos4_mct_write(TICK_BASE_CNT, mevt->base + MCT_L_TCNTB_OFFSET);
 
-	if (mct_int_type == MCT_INT_SPI) {
-		evt->irq = mct_irqs[MCT_L0_IRQ + cpu];
-		if (request_irq(evt->irq, exynos4_mct_tick_isr,
-				IRQF_TIMER | IRQF_NOBALANCING,
-				evt->name, mevt)) {
-			pr_err("exynos-mct: cannot register IRQ %d\n",
-				evt->irq);
-			return -EIO;
-		}
-		irq_set_affinity(evt->irq, cpumask_of(cpu));
-	} else {
+	if (mct_int_type == MCT_INT_PPI)
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
-	}
+	else
+		enable_irq(evt->irq);
 
 	return 0;
 }
@@ -440,7 +431,7 @@ static void exynos4_local_timer_stop(struct clock_event_device *evt)
 {
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
 	if (mct_int_type == MCT_INT_SPI)
-		free_irq(evt->irq, this_cpu_ptr(&percpu_mct_tick));
+		disable_irq(evt->irq);
 	else
 		disable_percpu_irq(mct_irqs[MCT_L0_IRQ]);
 }
@@ -500,6 +491,23 @@ static void __init exynos4_timer_resources(struct device_node *np, void __iomem
 					 &percpu_mct_tick);
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     mct_irqs[MCT_L0_IRQ], err);
+	} else {
+		int cpu;
+
+		for_each_possible_cpu(cpu) {
+			struct mct_clock_event_device *mevt =
+				&per_cpu(percpu_mct_tick, cpu);
+
+			mevt->evt.irq = mct_irqs[MCT_L0_IRQ + cpu];
+			if (request_irq(mevt->evt.irq, exynos4_mct_tick_isr,
+					IRQF_TIMER | IRQF_NOBALANCING,
+					mevt->evt.name, mevt)) {
+				WARN(1, "exynos-mct: cannot register IRQ %d\n",
+				     mevt->evt.irq);
+			}
+			irq_set_affinity(mevt->evt.irq, cpumask_of(cpu));
+			disable_irq(mevt->evt.irq);
+		}
 	}
 
 	err = register_cpu_notifier(&exynos4_mct_cpu_nb);
-- 
1.7.9.5
