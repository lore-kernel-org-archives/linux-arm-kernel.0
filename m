From: rrichter@caviumnetworks.com (Robert Richter)
Date: Fri, 15 Apr 2016 21:15:34 +0200
Subject: [PATCH] irqchip, gicv3-its,
 numa: Enable workaround for Cavium thunderx erratum 23144
Message-ID: <1460747734-25833-1-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>

The erratum fixes the hang of ITS SYNC command by avoiding inter node
io and collections/cpu mapping on thunderx dual-socket platform.

This fix is only applicable for Cavium's ThunderX dual-socket platform.

This is based on NUMA v16 series.
Message-Id: <1460155828-8690-1-git-send-email-ddaney.cavm@gmail.com>

v5 (by Robert Richter):
fixed use of cpumask_of_node() only for (node >= 0)
minor style fixes

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
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     |  9 +++++++
 drivers/irqchip/irq-gic-v3-its.c       | 49 ++++++++++++++++++++++++++++++++--
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index ba4b6acfc545..ab19e709d05e 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -55,5 +55,6 @@ stable kernels.
 | ARM            | Cortex-A57      | #834220         | ARM64_ERRATUM_834220    |
 |                |                 |                 |                         |
 | Cavium         | ThunderX ITS    | #22375, #24313  | CAVIUM_ERRATUM_22375    |
+| Cavium         | ThunderX ITS    | #23144          | CAVIUM_ERRATUM_23144    |
 | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154    |
 | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456    |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a578080ae7a0..40efc0e29d62 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -426,6 +426,15 @@ config CAVIUM_ERRATUM_22375
 
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
index 39261798c59f..75f258fbf1d0 100644
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
@@ -605,11 +607,23 @@ static void its_unmask_irq(struct irq_data *d)
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
+		if (its_dev->its->numa_node >= 0) {
+			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
+			if (!cpumask_intersects(mask_val, cpu_mask))
+				return -EINVAL;
+		}
+	}
+
+	cpu = cpumask_any_and(mask_val, cpu_mask);
+
 	if (cpu >= nr_cpu_ids)
 		return -EINVAL;
 
@@ -1090,6 +1104,16 @@ static void its_cpu_init_collection(void)
 	list_for_each_entry(its, &its_nodes, entry) {
 		u64 target;
 
+		/* avoid cross node collections and its mapping */
+		if (its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144) {
+			struct device_node *cpu_node;
+
+			cpu_node = of_get_cpu_node(cpu, NULL);
+			if (its->numa_node != NUMA_NO_NODE &&
+				its->numa_node != of_node_to_nid(cpu_node))
+				continue;
+		}
+
 		/*
 		 * We now have to bind each collection to its target
 		 * redistributor.
@@ -1317,9 +1341,14 @@ static void its_irq_domain_activate(struct irq_domain *domain,
 {
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
 	u32 event = its_get_event_id(d);
+	const struct cpumask *cpu_mask = cpu_online_mask;
+
+	/* get the cpu_mask of local node */
+	if (its_dev->its->numa_node >= 0)
+		cpu_mask = cpumask_of_node(its_dev->its->numa_node);
 
 	/* Bind the LPI to the first possible CPU */
-	its_dev->event_map.col_map[event] = cpumask_first(cpu_online_mask);
+	its_dev->event_map.col_map[event] = cpumask_first(cpu_mask);
 
 	/* Map the GIC IRQ and event to the device */
 	its_send_mapvi(its_dev, d->hwirq, event);
@@ -1409,6 +1438,13 @@ static void __maybe_unused its_enable_quirk_cavium_22375(void *data)
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
@@ -1418,6 +1454,14 @@ static const struct gic_quirk its_quirks[] = {
 		.init	= its_enable_quirk_cavium_22375,
 	},
 #endif
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
@@ -1480,6 +1524,7 @@ static int __init its_probe(struct device_node *node,
 	its->base = its_base;
 	its->phys_base = res.start;
 	its->ite_size = ((readl_relaxed(its_base + GITS_TYPER) >> 4) & 0xf) + 1;
+	its->numa_node = of_node_to_nid(node);
 
 	its->cmd_base = kzalloc(ITS_CMD_QUEUE_SZ, GFP_KERNEL);
 	if (!its->cmd_base) {
-- 
2.7.0.rc3
