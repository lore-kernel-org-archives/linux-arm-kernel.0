From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:32 +0100
Subject: [PATCH v2 04/17] irqdomain: Introduce a firmware-specific IRQ
 specifier structure
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far the closest thing to a generic IRQ specifier structure is
of_phandle_args, which happens to be pretty OF specific (the of_node
pointer in there is quite annoying).

Let's introduce 'struct irq_fwspec' that can be used in place of
of_phandle_args for OF, but also for other firmware implementations
(that'd be ACPI). This is used together with a new 'translate' method
that is the pendent of 'xlate'.

We convert irq_create_of_mapping to use this new structure (with a
small hack that will be removed later).

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/irqdomain.h | 20 ++++++++++++++++
 kernel/irq/irqdomain.c    | 59 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 68 insertions(+), 11 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 607c185..533c974 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -46,6 +46,24 @@ struct irq_data;
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
 
+#define IRQ_DOMAIN_IRQ_SPEC_PARAMS 16
+
+/**
+ * struct irq_fwspec - generic IRQ specifier structure
+ *
+ * @fwnode:		Pointer to a firmware-specific descriptor
+ * @param_count:	Number of device-specific parameters
+ * @param:		Device-specific parameters
+ *
+ * This structure, directly modeled after of_phandle_args, is used to
+ * pass a device-specific description of an interrupt.
+ */
+struct irq_fwspec {
+	struct fwnode_handle *fwnode;
+	int param_count;
+	u32 param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
+};
+
 /*
  * Should several domains have the same device node, but serve
  * different purposes (for example one domain is for PCI/MSI, and the
@@ -92,6 +110,8 @@ struct irq_domain_ops {
 		     unsigned int nr_irqs);
 	void (*activate)(struct irq_domain *d, struct irq_data *irq_data);
 	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
+	int (*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
+			 unsigned long *out_hwirq, unsigned int *out_type);
 #endif
 };
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 023ab6d..86dfd40 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -484,30 +484,67 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
 }
 EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
 
+static int irq_domain_translate(struct irq_domain *d,
+				struct irq_fwspec *fwspec,
+				irq_hw_number_t *hwirq, unsigned int *type)
+{
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	if (d->ops->translate)
+		return d->ops->translate(d, fwspec, hwirq, type);
+#endif
+	if (d->ops->xlate)
+		return d->ops->xlate(d, to_of_node(fwspec->fwnode),
+				     fwspec->param, fwspec->param_count,
+				     hwirq, type);
+
+	/* If domain has no translation, then we assume interrupt line */
+	*hwirq = fwspec->param[0];
+	return 0;
+}
+
+static void of_phandle_args_to_fwspec(struct of_phandle_args *irq_data,
+				      struct irq_fwspec *fwspec)
+{
+	int i;
+
+	fwspec->fwnode = irq_data->np ? &irq_data->np->fwnode : NULL;
+	fwspec->param_count = irq_data->args_count;
+
+	for (i = 0; i < irq_data->args_count; i++)
+		fwspec->param[i] = irq_data->args[i];
+}
+
 unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 {
+	struct irq_fwspec fwspec;
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
 
-	domain = irq_data->np ? irq_find_host(irq_data->np) : irq_default_domain;
+	of_phandle_args_to_fwspec(irq_data, &fwspec);
+
+	if (fwspec.fwnode)
+		domain = irq_find_matching_fwnode(fwspec.fwnode, DOMAIN_BUS_ANY);
+	else
+		domain = irq_default_domain;
+
 	if (!domain) {
 		pr_warn("no irq domain found for %s !\n",
-			of_node_full_name(irq_data->np));
+			of_node_full_name(to_of_node(fwspec.fwnode)));
 		return 0;
 	}
 
-	/* If domain has no translation, then we assume interrupt line */
-	if (domain->ops->xlate == NULL)
-		hwirq = irq_data->args[0];
-	else {
-		if (domain->ops->xlate(domain, irq_data->np, irq_data->args,
-					irq_data->args_count, &hwirq, &type))
-			return 0;
-	}
+	if (irq_domain_translate(domain, &fwspec, &hwirq, &type))
+		return 0;
 
 	if (irq_domain_is_hierarchy(domain)) {
+		/* Temporary hack */
+		void *desc = &fwspec;
+#ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
+		if (!domain->ops->translate)
+			desc = irq_data;
+#endif
 		/*
 		 * If we've already configured this interrupt,
 		 * don't do it again, or hell will break loose.
@@ -516,7 +553,7 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 		if (virq)
 			return virq;
 
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
+		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, desc);
 		if (virq <= 0)
 			return 0;
 	} else {
-- 
2.1.4
