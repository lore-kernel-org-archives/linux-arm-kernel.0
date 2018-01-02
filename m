From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  2 Jan 2018 11:25:29 +0000
Subject: [PATCH v11 4/8] irqchip: gic-v3: Use of_cpu_node_to_id helper
In-Reply-To: <20180102112533.13640-1-suzuki.poulose@arm.com>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
Message-ID: <20180102112533.13640-5-suzuki.poulose@arm.com>
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
index b56c3e23f0af..9a7a15049903 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1070,31 +1070,6 @@ static int __init gic_validate_dist_version(void __iomem *dist_base)
 	return 0;
 }
 
-static int get_cpu_number(struct device_node *dn)
-{
-	const __be32 *cell;
-	u64 hwid;
-	int cpu;
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
-	for_each_possible_cpu(cpu)
-		if (cpu_logical_map(cpu) == hwid)
-			return cpu;
-
-	return -1;
-}
-
 /* Create all possible partitions at boot time */
 static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 {
@@ -1145,8 +1120,8 @@ static void __init gic_populate_ppi_partitions(struct device_node *gic_node)
 			if (WARN_ON(!cpu_node))
 				continue;
 
-			cpu = get_cpu_number(cpu_node);
-			if (WARN_ON(cpu == -1))
+			cpu = of_cpu_node_to_id(cpu_node);
+			if (WARN_ON(cpu < 0))
 				continue;
 
 			pr_cont("%pOF[%d] ", cpu_node, cpu);
-- 
2.13.6
