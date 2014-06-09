From: jslaby@suse.cz (Jiri Slaby)
Date: Mon,  9 Jun 2014 10:49:12 +0200
Subject: [PATCH 3.12 017/146] clocksource: Exynos_mct: Use
 irq_force_affinity() in cpu bringup
In-Reply-To: <ebe219e45dcf94c1a34281167427cff4d742faef.1402303820.git.jslaby@suse.cz>
References: <ebe219e45dcf94c1a34281167427cff4d742faef.1402303820.git.jslaby@suse.cz>
Message-ID: <0ba79d6efc90465ed75f41e723b27aff79a7baae.1402303820.git.jslaby@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit 30ccf03b4a6a2102a2219058bdc6d779dc637dd7 upstream.

The starting cpu is not yet in the online mask so irq_set_affinity()
fails which results in per cpu timers for this cpu ending up on some
other online cpu, ususally cpu 0.

Use irq_force_affinity() which disables the online mask check and
makes things work.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Tomasz Figa <t.figa@samsung.com>,
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org,
Link: http://lkml.kernel.org/r/20140416143316.106665251 at linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/clocksource/exynos_mct.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 62b0de6a1837..b17b3e0981f0 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -428,6 +428,7 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
 				evt->irq);
 			return -EIO;
 		}
+		irq_force_affinity(mct_irqs[MCT_L0_IRQ + cpu], cpumask_of(cpu));
 	} else {
 		enable_percpu_irq(mct_irqs[MCT_L0_IRQ], 0);
 	}
@@ -448,7 +449,6 @@ static int exynos4_mct_cpu_notify(struct notifier_block *self,
 					   unsigned long action, void *hcpu)
 {
 	struct mct_clock_event_device *mevt;
-	unsigned int cpu;
 
 	/*
 	 * Grab cpu pointer in each case to avoid spurious
@@ -459,12 +459,6 @@ static int exynos4_mct_cpu_notify(struct notifier_block *self,
 		mevt = this_cpu_ptr(&percpu_mct_tick);
 		exynos4_local_timer_setup(&mevt->evt);
 		break;
-	case CPU_ONLINE:
-		cpu = (unsigned long)hcpu;
-		if (mct_int_type == MCT_INT_SPI)
-			irq_set_affinity(mct_irqs[MCT_L0_IRQ + cpu],
-						cpumask_of(cpu));
-		break;
 	case CPU_DYING:
 		mevt = this_cpu_ptr(&percpu_mct_tick);
 		exynos4_local_timer_stop(&mevt->evt);
-- 
1.9.3
