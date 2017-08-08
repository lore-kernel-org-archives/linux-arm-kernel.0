From: rrichter@cavium.com (Robert Richter)
Date: Tue,  8 Aug 2017 14:22:54 +0200
Subject: [PATCH v3 4/8] irqchip/gic-v3-its: Decouple its initialization from
 gic
In-Reply-To: <20170808122259.6299-1-rrichter@cavium.com>
References: <20170808122259.6299-1-rrichter@cavium.com>
Message-ID: <20170808122259.6299-5-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch separates its initialization from the gic. Probing and
initialization of its nodes is separate now. There is an own cpu
notifier for its now.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 61 +++++++++++++++++++++++++++-----------
 drivers/irqchip/irq-gic-v3.c       | 11 +++----
 include/linux/cpuhotplug.h         |  1 +
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 4 files changed, 51 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b51a1208588b..5e2d4f2876d8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1676,20 +1676,13 @@ static int its_init_domain(struct its_node *its)
 
 static void its_free(struct its_node *its)
 {
-	spin_lock(&its_lock);
-	list_del(&its->entry);
-	spin_unlock(&its_lock);
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
@@ -1709,11 +1702,7 @@ static int __init its_probe_one(struct resource *res,
 
 	pr_info("ITS %pR\n", res);
 
-	err = its_init_one(its);
-	if (err)
-		its_free(its);
-
-	return err;
+	return 0;
 }
 
 static int __init its_init_one(struct its_node *its)
@@ -1816,7 +1805,7 @@ static bool gic_rdists_supports_plpis(void)
 	return !!(gic_read_typer(gic_data_rdist_rd_base() + GICR_TYPER) & GICR_TYPER_PLPIS);
 }
 
-int its_cpu_init(void)
+static int its_cpu_init(unsigned int cpu)
 {
 	if (!list_empty(&its_nodes)) {
 		if (!gic_rdists_supports_plpis()) {
@@ -1983,8 +1972,6 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
-static int __init its_init(void);
-
 int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 		     struct irq_domain *parent_domain)
 {
@@ -2004,10 +1991,48 @@ int __init its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 
 	gic_rdists = rdists;
 
-	return its_init();
+	return 0;
 }
 
-static int __init its_init(void)
+int __init its_init(void)
 {
-	return its_alloc_lpi_tables();
+	struct its_node *its, *tmp;
+	int err = 0, err2;
+
+	if (list_empty(&its_nodes))
+		return 0;
+
+	spin_lock(&its_lock);
+
+	list_for_each_entry(its, &its_nodes, entry) {
+		err2 = its_init_one(its);
+		if (!err && err2)
+			err = err2;
+	}
+
+	if (!err)
+		goto unlock;
+
+	list_for_each_entry_safe(its, tmp, &its_nodes, entry) {
+		list_del(&its->entry);
+		its_free(its);
+	}
+
+unlock:
+	spin_unlock(&its_lock);
+
+	if (!err)
+		err = its_alloc_lpi_tables();
+
+	if (err) {
+		pr_warn("ITS: Failed to initialize (%d), not enabling LPIs\n",
+			err);
+		return err;
+	}
+
+	cpuhp_setup_state(CPUHP_AP_IRQ_GIC_ITS_STARTING,
+			"irqchip/arm/gicv3-its:starting",
+			its_cpu_init, NULL);
+
+	return 0;
 }
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 886e70ab2159..1476ce12b3b8 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -536,10 +536,6 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
-	/* Give LPIs a spin */
-	if (IS_ENABLED(CONFIG_ARM_GIC_V3_ITS) && gic_dist_supports_lpis())
-		its_cpu_init();
-
 	/* initialise system registers */
 	gic_cpu_sys_reg_init();
 }
@@ -675,7 +671,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #else
 #define gic_set_affinity	NULL
 #define gic_smp_init()		do { } while(0)
-#endif
+#endif	/* CONFIG_SMP */
 
 #ifdef CONFIG_CPU_PM
 /* Check whether it's single security state view */
@@ -1171,6 +1167,9 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 
 	gic_populate_ppi_partitions(node);
 	gic_of_setup_kvm_info(node);
+
+	its_init();
+
 	return 0;
 
 out_unmap_rdist:
@@ -1460,6 +1459,8 @@ gic_acpi_init(struct acpi_subtable_header *header, const unsigned long end)
 	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC, domain_handle);
 	gic_acpi_setup_kvm_info();
 
+	its_init();
+
 	return 0;
 
 out_fwhandle_free:
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index b56573bf440d..6b2fc0e22efc 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -78,6 +78,7 @@ enum cpuhp_state {
 	CPUHP_AP_SCHED_STARTING,
 	CPUHP_AP_RCUTREE_DYING,
 	CPUHP_AP_IRQ_GIC_STARTING,
+	CPUHP_AP_IRQ_GIC_ITS_STARTING,
 	CPUHP_AP_IRQ_HIP04_STARTING,
 	CPUHP_AP_IRQ_ARMADA_XP_STARTING,
 	CPUHP_AP_IRQ_BCM2836_STARTING,
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index c4f9c968728f..15cbedbd82f1 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -491,9 +491,9 @@ struct rdists {
 
 struct irq_domain;
 struct fwnode_handle;
-int its_cpu_init(void);
 int its_probe(struct fwnode_handle *handle, struct rdists *rdists,
 	      struct irq_domain *domain);
+int its_init(void);
 
 static inline bool gic_enable_sre(void)
 {
-- 
2.11.0
