From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 21 Aug 2017 18:55:07 +0100
Subject: [PATCH v6 4/6] irqchip: gic-v3: Use of_cpu_node_to_id helper
In-Reply-To: <1503338109-32540-1-git-send-email-suzuki.poulose@arm.com>
References: <1503338109-32540-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1503338109-32540-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new generic helper of_cpu_node_to_id() instead
of using our own version to map a device node to logical CPU
number.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V3:
 - Reflect the change in the helper name and return value.
---
 drivers/irqchip/irq-gic-v3.c | 29 ++---------------------------
 1 file changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 984c3ec..aebc179 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -988,31 +988,6 @@ static int __init gic_validate_dist_version(void __iomem *dist_base)
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
@@ -1063,8 +1038,8 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 			if (WARN_ON(!cpu_node))
 				continue;
 
-			cpu = get_cpu_number(cpu_node);
-			if (WARN_ON(cpu == -1))
+			cpu = of_cpu_node_to_id(cpu_node);
+			if (WARN_ON(cpu < 0))
 				continue;
 
 			pr_cont("%s[%d] ", cpu_node->full_name, cpu);
-- 
2.7.5
