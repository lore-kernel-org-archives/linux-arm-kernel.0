From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Nov 2012 11:44:39 +0000
Subject: [PATCH] ARM: sp804: set cpumask to cpu_possible_mask for clock event
 device
Message-ID: <1353584679-28583-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SP804 driver statically initialises the cpumask of the clock event
device to be cpu_all_mask, which is derived from the compile-time
constant NR_CPUS. This breaks SMP_ON_UP systems where the interrupt
controller handling the sp804 doesn't have the irq_set_affinity callback
on the irq_chip, because the common timer code fails to identify the
device as cpu-local and ends up treating it as a broadcast device
instead.

This patch fixes the problem by using cpu_possible_mask at runtime,
which will correctly represent the possible CPUs when SMP_ON_UP is being
used.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/common/timer-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/timer-sp.c b/arch/arm/common/timer-sp.c
index df13a3f..9d2d3ba 100644
--- a/arch/arm/common/timer-sp.c
+++ b/arch/arm/common/timer-sp.c
@@ -162,7 +162,6 @@ static struct clock_event_device sp804_clockevent = {
 	.set_mode	= sp804_set_mode,
 	.set_next_event	= sp804_set_next_event,
 	.rating		= 300,
-	.cpumask	= cpu_all_mask,
 };
 
 static struct irqaction sp804_timer_irq = {
@@ -185,6 +184,7 @@ void __init sp804_clockevents_init(void __iomem *base, unsigned int irq,
 	clkevt_reload = DIV_ROUND_CLOSEST(rate, HZ);
 	evt->name = name;
 	evt->irq = irq;
+	evt->cpumask = cpu_possible_mask;
 
 	setup_irq(irq, &sp804_timer_irq);
 	clockevents_config_and_register(evt, rate, 0xf, 0xffffffff);
-- 
1.8.0
