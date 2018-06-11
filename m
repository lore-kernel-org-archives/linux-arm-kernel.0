From: yangyingliang@huawei.com (Yang Yingliang)
Date: Mon, 11 Jun 2018 20:25:09 +0800
Subject: [PATCH v3] irqchip/gic-v3-its: fix ITS queue timeout
Message-ID: <1528719909-16572-1-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On a NUMA system, if an ITS is local to an offline
node, the ITS driver may pick an offline CPU to bind
the LPI. In this case, we need to pick an online CPU.
But on some systems, binding LPI to non-local node
CPU will cause deadlock. In this case, we don't
bind the LPI to any online CPU and return an error code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 5416f2b..137c433 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2309,7 +2309,13 @@ static int its_irq_domain_activate(struct irq_domain *domain,
 		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	cpu = cpumask_first(cpu_mask);
+	cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
+	if (cpu >= nr_cpu_ids) {
+		if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
+			return -EINVAL;
+
+		cpu = cpumask_first(cpu_online_mask);
+	}
 	its_dev->event_map.col_map[event] = cpu;
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
-- 
1.8.3
