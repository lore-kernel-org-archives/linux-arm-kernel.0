From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:25:32 +0100
Subject: [PATCH 01/54] ARM: core irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130132532.GB15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/kernel/irq.c     |   17 ++++++++++-------
 arch/arm/kernel/smp_twd.c |    2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 36ad3be..f4333c2 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -79,7 +79,7 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_printf(p, "%3d: ", i);
 		for_each_present_cpu(cpu)
 			seq_printf(p, "%10u ", kstat_irqs_cpu(i, cpu));
-		seq_printf(p, " %10s", desc->chip->name ? : "-");
+		seq_printf(p, " %10s", desc->irq_data.chip->name ? : "-");
 		seq_printf(p, "  %s", action->name);
 		for (action = action->next; action; action = action->next)
 			seq_printf(p, ", %s", action->name);
@@ -169,10 +169,11 @@ int __init arch_probe_nr_irqs(void)
 
 static void route_irq(struct irq_desc *desc, unsigned int irq, unsigned int cpu)
 {
-	pr_debug("IRQ%u: moving from cpu%u to cpu%u\n", irq, desc->node, cpu);
+	pr_debug("IRQ%u: moving from cpu%u to cpu%u\n", irq, desc->irq_data.node, cpu);
 
 	raw_spin_lock_irq(&desc->lock);
-	desc->chip->set_affinity(irq, cpumask_of(cpu));
+	desc->irq_data.chip->irq_set_affinity(&desc->irq_data,
+					      cpumask_of(cpu), false);
 	raw_spin_unlock_irq(&desc->lock);
 }
 
@@ -187,16 +188,18 @@ void migrate_irqs(void)
 	struct irq_desc *desc;
 
 	for_each_irq_desc(i, desc) {
-		if (desc->node == cpu) {
-			unsigned int newcpu = cpumask_any_and(desc->affinity,
+		struct irq_data *d = &desc->irq_data;
+
+		if (d->node == cpu) {
+			unsigned int newcpu = cpumask_any_and(d->affinity,
 							      cpu_online_mask);
 			if (newcpu >= nr_cpu_ids) {
 				if (printk_ratelimit())
 					printk(KERN_INFO "IRQ%u no longer affine to CPU%u\n",
 					       i, cpu);
 
-				cpumask_setall(desc->affinity);
-				newcpu = cpumask_any_and(desc->affinity,
+				cpumask_setall(d->affinity);
+				newcpu = cpumask_any_and(d->affinity,
 							 cpu_online_mask);
 			}
 
diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 35882fb..a0742eb 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -145,7 +145,7 @@ void __cpuinit twd_timer_setup(struct clock_event_device *clk)
 	/* Make sure our local interrupt controller has this enabled */
 	local_irq_save(flags);
 	irq_to_desc(clk->irq)->status |= IRQ_NOPROBE;
-	get_irq_chip(clk->irq)->unmask(clk->irq);
+	get_irq_chip(clk->irq)->irq_unmask(irq_get_irq_data(clk->irq));
 	local_irq_restore(flags);
 
 	clockevents_register_device(clk);
-- 
1.7.1
