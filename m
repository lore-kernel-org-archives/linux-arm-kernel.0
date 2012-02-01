From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  1 Feb 2012 16:59:35 +0000
Subject: [PATCH v2 4/4] ARM: architected timers: add support for UP timer
In-Reply-To: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
References: <1328115575-24866-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1328115575-24866-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If CONFIG_LOCAL_TIMERS is not defined, let the architected timer
driver register a single clock_event_device that is used as a
global timer.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kernel/arch_timer.c |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
index 6cb7d39..a6a3aee 100644
--- a/arch/arm/kernel/arch_timer.c
+++ b/arch/arm/kernel/arch_timer.c
@@ -229,6 +229,7 @@ static struct clocksource clocksource_counter = {
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+#ifdef CONFIG_LOCAL_TIMERS
 static void __cpuinit arch_timer_stop(struct clock_event_device *clk)
 {
 	pr_debug("arch_timer_teardown disable IRQ%d cpu #%d\n",
@@ -243,6 +244,9 @@ static struct local_timer_ops arch_timer_ops __cpuinitdata = {
 	.setup	= arch_timer_setup,
 	.stop	= arch_timer_stop,
 };
+#else
+static struct clock_event_device arch_timer_global_evt;
+#endif
 
 static int __init arch_timer_common_register(void)
 {
@@ -277,7 +281,16 @@ static int __init arch_timer_common_register(void)
 		}
 	}
 
-	err = local_timer_register(&arch_timer_ops);
+#ifdef CONFIG_LOCAL_TIMERS
+	if (is_smp())
+		err = local_timer_register(&arch_timer_ops);
+	else
+#endif
+	{
+		arch_timer_global_evt.cpumask = cpumask_of(0);
+		err = arch_timer_setup(&arch_timer_global_evt);
+	}
+
 	if (err)
 		goto out_free_irq;
 
-- 
1.7.7.1
