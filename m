From: gkulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Wed, 16 Mar 2016 18:40:38 +0530
Subject: [PATCH v4] irqchip, gicv3-its,
 numa: Enable workaround for Cavium thunderx erratum 23144
Message-ID: <1458133838-20697-1-git-send-email-gkulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The erratum fixes the hang of ITS SYNC command by avoiding inter node
io and collections/cpu mapping on thunderx dual-socket platform.

This fix is only applicable for Cavium's ThunderX dual-socket platform.

This is based on NUMA v15 series.
http://comments.gmane.org/gmane.linux.kernel/2172411

v4:
updated silicon-errata.txt
updated as per Robert Richter review comment.

v3:
updatated as per Marc Zyngier's review comments.
http://www.spinics.net/lists/arm-kernel/msg443462.html

v2:
updatated as per Marc Zyngier's review comments.

Reviewed-by: Robert Richter <rrichter@cavium.com>
Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     |  9 +++++++
 drivers/irqchip/irq-gic-v3-its.c       | 48 ++++++++++++++++++++++++++++++++--
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 58b71dd..5e620a0 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -55,4 +55,5 @@ stable kernels.
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
 |                |                 |                 |                         |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
+| Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144    |
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..57595f7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -422,6 +422,15 @@ config CAVIUM_ERRATUM_22375
 
 	  If unsure, say Y.
 
+config CAVIUM_ERRATUM_23144
+	bool "Cavium erratum 23144: ITS SYNC hang on dual socket system"
+	depends on NUMA
+	default y
+	help
+	  ITS SYNC command hang for cross node io and collections/cpu mapping.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_23154
 	bool "Cavium erratum 23154: Access to ICC_IAR1_EL1 is not sync'ed"
 	default y
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3926179..35ab325 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -41,6 +41,7 @@
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 
@@ -74,6 +75,7 @@ struct its_node {
 	struct list_head	its_device_list;
 	u64			flags;
 	u32			ite_size;
+	int			numa_node;
 };
 
 #define ITS_ITT_ALIGN		SZ_256
@@ -605,11 +607,21 @@ static void its_unmask_irq(struct irq_data *d)
 static int its_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 			    bool force)
 {
-	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
+	unsigned int cpu;
+	const struct cpumask *cpu_mask = cpu_online_mask;
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	struct its_collection *target_col;
 	u32 id = its_get_event_id(d);
 
+       /* lpi cannot be routed to a redistributor that is on a foreign node */
+	if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
+		if (!cpumask_intersects(mask_val, cpu_mask))
+			return -EINVAL;
+	}
+
+	cpu = cpumask_any_and(mask_val, cpu_mask);
+
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
@@ -1090,6 +1102,16 @@ static void its_cpu_init_collection(void)
 	list_for_each_entry(its, &its_nodes, entry) {
 		u64 target;
 
+		/* avoid cross node collections and its mapping */
+		if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+			struct device_node *cpu_node;
+
+			cpu_node = of_get_cpu_node(cpu, NULL);
+			if (its->numa_node != NUMA_NO_NODE &&
+			its->numa_node != of_node_to_nid(cpu_node))
+				continue;
+		}
+
 		/*
 		 * We now have to bind each collection to its target
 		 * redistributor.
@@ -1317,9 +1339,14 @@ static void its_irq_domain_activate(struct irq_domain *domain,
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
@@ -1409,6 +1436,13 @@ static void __maybe_unused its_enable_quirk_cavium_22375(void *data)
 	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_22375;
 }
 
+static void __maybe_unused its_enable_quirk_cavium_23144(void *data)
+{
+	struct its_node *its = data;
+
+	its->flags |= ITS_FLAGS_WORKAROUND_CAVIUM_23144;
+}
+
 static const struct gic_quirk its_quirks[] = {
 #ifdef CONFIG_CAVIUM_ERRATUM_22375
 	{
@@ -1418,6 +1452,15 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_cavium_22375,
 	},
 #endif
+
+#ifdef CONFIG_CAVIUM_ERRATUM_23144
+	{
+		.desc	= "ITS: Cavium erratum 23144",
+		.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
+		.mask	= 0xffff0fff,
+		.init	= its_enable_quirk_cavium_23144,
+	},
+#endif
 	{
 	}
 };
@@ -1480,6 +1523,7 @@ static int __init its_probe(struct device_node *node,
 	its->base = its_base;
 	its->phys_base = res.start;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
+	its->numa_node = of_node_to_nid(node);
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
 	if (!its->cmd_base) {
-- 
1.8.1.4
