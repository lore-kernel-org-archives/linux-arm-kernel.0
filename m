From: yangyingliang@huawei.com (Yang Yingliang)
Date: Tue, 5 Jun 2018 14:30:25 +0800
Subject: [PATCH] irqchip/gic-v3-its: fix ITS queue timeout
Message-ID: <1528180225-16144-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the kernel booted with maxcpus=x, 'x' is smaller
than actual cpu numbers, the TAs of offline cpus won't
be set to its->collection.

If LPI is bind to offline cpu, sync cmd will use zero TA,
it leads to ITS queue timeout.  Fix this by choosing a
online cpu, if there is no online cpu in cpu_mask.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5416f2b..edd92a9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2309,7 +2309,9 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first(cpu_mask);
+	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
+	if (!cpu_online(cpu))
+		cpu = cpumask_first(cpu_online_mask);
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
@@ -2466,7 +2468,10 @@ static int its_vpe_set_affinity(struct irq_data *d,
 				bool force)
 {
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
-	int cpu = cpumask_first(mask_val);
+	int cpu = cpumask_first_and(mask_val, cpu_online_mask);
+
+	if (!cpu_online(cpu))
+		cpu = cpumask_first(cpu_online_mask);
 
 	/*
 	 * Changing affinity is mega expensive, so let's be as lazy as
-- 
1.8.3
