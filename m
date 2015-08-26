From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 26 Aug 2015 10:22:39 +0530
Subject: [PATCH v2 RESEND] irqchip, gicv3-its,
 numa: Workaround for Cavium ThunderX erratum 23144
Message-ID: <1440564759-3786-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements a workaround for gicv3-its erratum 23144 on Cavium's
ThunderX dual-socket platforms, where LPI cannot be routed to a
redistributors present on a foreign node.

Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---

The patch below is on top of Robert's recent gicv3 errata patch
submission v4 and my arm64 numa patches v5.

v2:
updatated as per Marc Zyngier's review comments.

 drivers/irqchip/irq-gic-v3-its.c | 49 ++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b83b132..47fded0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -39,7 +39,8 @@
 #include "irqchip.h"
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
-#define ITS_FLAGS_CAVIUM_THUNDERX		(1ULL << 1)
+#define ITS_WORKAROUND_CAVIUM_22375            (1ULL << 1)
+#define ITS_WORKAROUND_CAVIUM_23144            (1ULL << 2)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -72,6 +73,7 @@ struct its_node {
 	struct list_head	its_device_list;
 	u64			flags;
 	u32			ite_size;
+	int			numa_node;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -606,11 +608,20 @@ static void its_eoi_irq(struct irq_data *d)
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu;
+	const struct cpumask *cpu_mask = cpu_online_mask;
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_collection *target_col;
 	u32 id = its_get_event_id(d);
 
+	/* lpi cannot be routed to a redistributor that is on a foreign node */
+	if (its_dev->its->flags & ITS_WORKAROUND_CAVIUM_23144) {
+		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
+		if (!cpumask_intersects(mask_val, cpu_mask))
+			return -EINVAL;
+	}
+
+	cpu = cpumask_any_and(mask_val, cpu_mask);
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
@@ -842,7 +853,7 @@ static int its_alloc_tables(struct its_node *its)
 	u64 typer;
 	u32 ids;
 
-	if (its->flags & ITS_FLAGS_CAVIUM_THUNDERX) {
+	if (its->flags & ITS_WORKAROUND_CAVIUM_22375) {
 		/*
 		 * erratum 22375: only alloc 8MB table size
 		 * erratum 24313: ignore memory access type
@@ -1349,9 +1360,14 @@ static void its_irq_domain_activate(struct irq_domain *domain,
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
+	const struct cpumask *cpu_mask = cpu_online_mask;
+
+	/* get the cpu_mask of local node */
+	if (IS_ENABLED(CONFIG_NUMA))
+		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	its_dev->event_map.col_map[event] = cpumask_first(cpu_online_mask);
+	its_dev->event_map.col_map[event] = cpumask_first(cpu_mask);
 
 	/* Map the GIC IRQ and event to the device */
 	its_send_mapvi(its_dev, d->hwirq, event);
@@ -1434,11 +1450,19 @@ static int its_force_quiescent(void __iomem *base)
 	}
 }
 
-static void its_enable_cavium_thunderx(void *data)
+static void its_enable_cavium_thunderx_22375(void *data)
 {
 	struct its_node *its = data;
 
-	its->flags |= ITS_FLAGS_CAVIUM_THUNDERX;
+	its->flags |= ITS_WORKAROUND_CAVIUM_22375;
+}
+
+static void its_enable_cavium_thunderx_23144(void *data)
+{
+	struct its_node *its = data;
+
+	if (num_possible_nodes() > 1)
+		its->flags |= ITS_WORKAROUND_CAVIUM_23144;
 }
 
 static const struct gic_capabilities its_errata[] = {
@@ -1446,7 +1470,13 @@ static const struct gic_capabilities its_errata[] = {
 		.desc	= "ITS: Cavium errata 22375, 24313",
 		.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
 		.mask	= 0xffff0fff,
-		.init	= its_enable_cavium_thunderx,
+		.init	= its_enable_cavium_thunderx_22375,
+	},
+	{
+		.desc	= "ITS: Cavium errata 23144",
+		.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
+		.mask	= 0xffff0fff,
+		.init	= its_enable_cavium_thunderx_23144,
 	},
 	{
 	}
@@ -1465,6 +1495,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	u32 val;
 	u64 baser, tmp;
 	int err;
+	int numa_node;
 
 	err = of_address_to_resource(node, 0, &res);
 	if (err) {
@@ -1472,6 +1503,9 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 		return -ENXIO;
 	}
 
+	/* get numa affinity of its node*/
+	numa_node = of_node_to_nid(node);
+
 	its_base = ioremap(res.start, resource_size(&res));
 	if (!its_base) {
 		pr_warn("%s: unable to map registers\n", node->full_name);
@@ -1507,6 +1541,7 @@ static int its_probe(struct device_node *node, struct irq_domain *parent)
 	its->phys_base = res.start;
 	its->msi_chip.of_node = node;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
+	its->numa_node = numa_node;
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
 	if (!its->cmd_base) {
-- 
1.8.1.4
