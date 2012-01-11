From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 11 Jan 2012 13:08:52 +0000
Subject: [PATCH 13/15] ARM: local timers: convert exynos to runtime
 registration interface
In-Reply-To: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1326287334-1905-14-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the Exynos MCT timers to the runtime registration interface.
Tested on Origen.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/mct.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 85b5527..1cf46eb 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -21,6 +21,7 @@
 #include <linux/percpu.h>
 
 #include <asm/hardware/gic.h>
+#include <asm/localtimer.h>
 
 #include <plat/cpu.h>
 
@@ -375,7 +376,7 @@ static struct irqaction mct_tick1_event_irq = {
 	.handler	= exynos4_mct_tick_isr,
 };
 
-static void exynos4_mct_tick_init(struct clock_event_device *evt)
+static int __cpuinit exynos4_local_timer_setup(struct clock_event_device *evt)
 {
 	struct mct_clock_event_device *mevt;
 	unsigned int cpu = smp_processor_id();
@@ -417,17 +418,11 @@ static void exynos4_mct_tick_init(struct clock_event_device *evt)
 	} else {
 		enable_percpu_irq(IRQ_MCT_LOCALTIMER, 0);
 	}
-}
-
-/* Setup the local clock events for a CPU */
-int __cpuinit local_timer_setup(struct clock_event_device *evt)
-{
-	exynos4_mct_tick_init(evt);
 
 	return 0;
 }
 
-void local_timer_stop(struct clock_event_device *evt)
+static void exynos4_local_timer_stop(struct clock_event_device *evt)
 {
 	unsigned int cpu = smp_processor_id();
 	evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
@@ -439,6 +434,11 @@ void local_timer_stop(struct clock_event_device *evt)
 	else
 		disable_percpu_irq(IRQ_MCT_LOCALTIMER);
 }
+
+static struct local_timer_ops exynos4_mct_tick_ops __initdata = {
+	.setup	= exynos4_local_timer_setup,
+	.stop	= exynos4_local_timer_stop,
+};
 #endif /* CONFIG_LOCAL_TIMERS */
 
 static void __init exynos4_timer_resources(void)
@@ -458,6 +458,8 @@ static void __init exynos4_timer_resources(void)
 		WARN(err, "MCT: can't request IRQ %d (%d)\n",
 		     IRQ_MCT_LOCALTIMER, err);
 	}
+
+	local_timer_register(&exynos4_mct_tick_ops);
 #endif /* CONFIG_LOCAL_TIMERS */
 }
 
-- 
1.7.7.1
