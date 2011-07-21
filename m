From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 16:25:15 +0100
Subject: [PATCH 3/4] ARM: CPU hotplug: pass in proper affinity mask on IRQ
	migration
In-Reply-To: <20110721151413.GD28942@n2100.arm.linux.org.uk>
References: <20110721151413.GD28942@n2100.arm.linux.org.uk>
Message-ID: <E1Qjv7j-0003Ia-FD@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the GIC takes care of selecting a target interrupt from the
affinity mask, we don't need all this complexity in the core code
anymore.  Just detect when we need to break affinity.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/irq.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index d7aa5c9..ab63c05 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -133,17 +133,15 @@ int __init arch_probe_nr_irqs(void)
 
 static bool migrate_one_irq(struct irq_data *d)
 {
-	unsigned int cpu = cpumask_any_and(d->affinity, cpu_online_mask);
+	const struct cpumask *affinity = d->affinity;
 	bool ret = false;
 
-	if (cpu >= nr_cpu_ids) {
-		cpu = cpumask_any(cpu_online_mask);
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+		affinity cpu_online_mask;
 		ret = true;
 	}
 
-	pr_debug("IRQ%u: moving from cpu%u to cpu%u\n", d->irq, d->node, cpu);
-
-	d->chip->irq_set_affinity(d, cpumask_of(cpu), true);
+	d->chip->irq_set_affinity(d, affinity, true);
 
 	return ret;
 }
-- 
1.7.4.4
