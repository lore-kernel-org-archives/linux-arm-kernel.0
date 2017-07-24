From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 24 Jul 2017 11:29:19 +0100
Subject: [PATCH v2 4/6] irqchip: gic-v3: Use of_device_node_get_cpu helper
In-Reply-To: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
References: <1500892161-17634-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1500892161-17634-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new generic helper of_device_node_get_cpu() instead
of using our own version to map a device node to logical CPU
number.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dbffb7a..b7ce12b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -25,6 +25,7 @@
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/percpu.h>
 #include <linux/slab.h>
@@ -978,31 +979,6 @@ static int __init gic_validate_dist_version(void __iomem *dist_base)
 	return 0;
 }
 
-static int get_cpu_number(struct device_node *dn)
-{
-	const __be32 *cell;
-	u64 hwid;
-	int i;
-
-	cell = of_get_property(dn, "reg", NULL);
-	if (!cell)
-		return -1;
-
-	hwid = of_read_number(cell, of_n_addr_cells(dn));
-
-	/*
-	 * Non affinity bits must be set to 0 in the DT
-	 */
-	if (hwid & ~MPIDR_HWID_BITMASK)
-		return -1;
-
-	for (i = 0; i < num_possible_cpus(); i++)
-		if (cpu_logical_map(i) == hwid)
-			return i;
-
-	return -1;
-}
-
 /* Create all possible partitions@boot time */
 static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 {
@@ -1053,8 +1029,8 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 			if (WARN_ON(!cpu_node))
 				continue;
 
-			cpu = get_cpu_number(cpu_node);
-			if (WARN_ON(cpu == -1))
+			cpu = of_device_node_get_cpu(cpu_node);
+			if (WARN_ON(cpu >= nr_cpu_ids))
 				continue;
 
 			pr_cont("%s[%d] ", cpu_node->full_name, cpu);
-- 
2.7.5
