From: rrichter@cavium.com (Robert Richter)
Date: Wed, 28 Nov 2018 14:43:30 +0000
Subject: [PATCH v2 08/10] irqchip/gic-v3-its: Decouple its initialization from
 gic
In-Reply-To: <20181128144240.28727-1-rrichter@cavium.com>
References: <20181128144240.28727-1-rrichter@cavium.com>
Message-ID: <20181128144240.28727-9-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch separates its initialization from the gic. Probing and
initialization of its nodes is separate now. There is an own cpu
notifier for its now.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 58 +++++++++++++++++++++++++-------------
 drivers/irqchip/irq-gic-v3.c       | 14 ++++-----
 include/linux/cpuhotplug.h         |  1 +
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 4 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index c28f4158ff70..fd8561fcfdf3 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -167,6 +167,7 @@ static struct {
 } vpe_proxy;
 
 static LIST_HEAD(its_nodes);
+static LIST_HEAD(its_probed);
 static DEFINE_RAW_SPINLOCK(its_lock);
 static struct rdists *gic_rdists;
 static struct irq_domain *its_parent;
@@ -3482,20 +3483,13 @@ static int __init its_compute_its_list_map(struct its_node *its)
 
 static void its_free(struct its_node *its)
 {
-	raw_spin_lock(&its_lock);
-	list_del(&its->entry);
-	raw_spin_unlock(&its_lock);
-
 	kfree(its);
 }
 
-static int __init its_init_one(struct its_node *its);
-
 static int __init its_probe_one(struct resource *res,
 				struct fwnode_handle *handle, int numa_node)
 {
 	struct its_node *its;
-	int err;
 
 	its = kzalloc(sizeof(*its), GFP_KERNEL);
 	if (!its)
@@ -3510,16 +3504,12 @@ static int __init its_probe_one(struct resource *res,
 	its->numa_node = numa_node;
 
 	raw_spin_lock(&its_lock);
-	list_add_tail(&its->entry, &its_nodes);
+	list_add_tail(&its->entry, &its_probed);
 	raw_spin_unlock(&its_lock);
 
 	pr_info("ITS %pR\n", res);
 
-	err = its_init_one(its);
-	if (err)
-		its_free(its);
-
-	return err;
+	return 0;
 }
 
 static int __init its_init_one(struct its_node *its)
@@ -3717,7 +3707,7 @@ static int redist_disable_lpis(void)
 	return 0;
 }
 
-int its_cpu_init(void)
+static int its_cpu_init(unsigned int cpu)
 {
 	if (!list_empty(&its_nodes)) {
 		int ret;
@@ -3913,8 +3903,6 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
-static int __init its_init(void);
-
 int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 		     struct irq_domain *parent_domain)
 {
@@ -3929,23 +3917,51 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 
 	gic_rdists = rdists;
 
-	return its_init();
+	return 0;
 }
 
-static int __init its_init(void)
+int __init its_init(void)
 {
 	struct its_node *its;
 	bool has_v4 = false;
 	int err;
 
+	if (list_empty(&its_probed))
+		return 0;
+
+	raw_spin_lock(&its_lock);
+redo:
+	list_for_each_entry(its, &its_probed, entry) {
+		list_del_init(&its->entry);
+
+		raw_spin_unlock(&its_lock);
+
+		/* Needs to be called in non-atomic context */
+		err = its_init_one(its);
+		if (err)
+			its_free(its);
+
+		raw_spin_lock(&its_lock);
+
+		if (!err)
+			list_add_tail(&its->entry, &its_nodes);
+
+		goto redo;
+	}
+
+	raw_spin_unlock(&its_lock);
+
 	if (list_empty(&its_nodes)) {
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
 		return -ENXIO;
 	}
 
 	err = allocate_lpi_tables();
-	if (err)
+	if (err) {
+		pr_warn("ITS: Failed to initialize (%d), not enabling LPIs\n",
+			err);
 		return err;
+	}
 
 	list_for_each_entry(its, &its_nodes, entry)
 		has_v4 |= its->is_v4;
@@ -3960,5 +3976,9 @@ static int __init its_init(void)
 
 	register_syscore_ops(&its_syscore_ops);
 
+	cpuhp_setup_state(CPUHP_AP_IRQ_GIC_ITS_STARTING,
+			"irqchip/arm/gicv3-its:starting",
+			its_cpu_init, NULL);
+
 	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e04108b7c6b7..d2942efdb6d5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -685,9 +685,6 @@ static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
 
-	if (gic_dist_supports_lpis())
-		its_cpu_init();
-
 	return 0;
 }
 
@@ -815,7 +812,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #else
 #define gic_set_affinity	NULL
 #define gic_smp_init()		do { } while(0)
-#endif
+#endif	/* CONFIG_SMP */
 
 #ifdef CONFIG_CPU_PM
 /* Check whether it's single security state view */
@@ -1131,10 +1128,8 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	gic_cpu_init();
 	gic_cpu_pm_init();
 
-	if (gic_dist_supports_lpis()) {
+	if (gic_dist_supports_lpis())
 		its_probe(handle, &gic_data.rdists, gic_data.domain);
-		its_cpu_init();
-	}
 
 	return 0;
 
@@ -1327,6 +1322,9 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_of_setup_kvm_info(node);
+
+	its_init();
+
 	return 0;
 
 out_unmap_rdist:
@@ -1630,6 +1628,8 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	if (static_branch_likely(&supports_deactivate_key))
 		gic_acpi_setup_kvm_info();
 
+	its_init();
+
 	return 0;
 
 out_fwhandle_free:
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e0cd2baa8380..584f73585142 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -96,6 +96,7 @@ enum cpuhp_state {
 	CPUHP_AP_SCHED_STARTING,
 	CPUHP_AP_RCUTREE_DYING,
 	CPUHP_AP_IRQ_GIC_STARTING,
+	CPUHP_AP_IRQ_GIC_ITS_STARTING,
 	CPUHP_AP_IRQ_HIP04_STARTING,
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index a6fdb2910f73..f4348fa4260a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -602,9 +602,9 @@ struct rdists {
 
 struct irq_domain;
 struct fwnode_handle;
-int its_cpu_init(void);
 int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	      struct irq_domain *domain);
+int its_init(void);
 int mbi_init(struct fwnode_handle *fwnode, struct irq_domain *parent);
 
 static inline bool gic_enable_sre(void)
-- 
2.11.0
