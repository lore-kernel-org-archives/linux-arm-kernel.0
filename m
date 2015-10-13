From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:33 +0100
Subject: [PATCH v2 05/17] irqchip: Convert all alloc/xlate users from of_node
 to fwnode
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we now have a generic data structure to express an
interrupt specifier, convert all hierarchical irqchips that
are OF based to use a fwnode_handle as part of their alloc
and xlate (which becomes translate) callbacks.

As most of these drivers have dependencies (they exchange IRQ
specifiers), change them all in a single, massive patch...

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-exynos/suspend.c       | 55 ++++++++++++++++---------------
 arch/arm/mach-imx/gpc.c              | 55 ++++++++++++++++---------------
 arch/arm/mach-omap2/omap-wakeupgen.c | 55 ++++++++++++++++---------------
 drivers/irqchip/irq-crossbar.c       | 62 ++++++++++++++++++----------------
 drivers/irqchip/irq-gic-v2m.c        | 18 ++++++----
 drivers/irqchip/irq-gic-v3-its.c     | 20 ++++++-----
 drivers/irqchip/irq-gic-v3.c         | 49 +++++++++++++--------------
 drivers/irqchip/irq-gic.c            | 33 ++++++++++++++++---
 drivers/irqchip/irq-imx-gpcv2.c      | 64 ++++++++++++++++--------------------
 drivers/irqchip/irq-mtk-sysirq.c     | 49 ++++++++++++++-------------
 drivers/irqchip/irq-nvic.c           | 18 +++++++---
 drivers/irqchip/irq-tegra.c          | 55 ++++++++++++++++---------------
 drivers/irqchip/irq-vf610-mscm-ir.c  | 42 +++++++++++++++--------
 13 files changed, 323 insertions(+), 252 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index af97afc..5a7e47c 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -177,54 +177,57 @@ static struct irq_chip exynos_pmu_chip = {
 #endif
 };
 
-static int exynos_pmu_domain_xlate(struct irq_domain *domain,
-				   struct device_node *controller,
-				   const u32 *intspec,
-				   unsigned int intsize,
-				   unsigned long *out_hwirq,
-				   unsigned int *out_type)
+static int exynos_pmu_domain_translate(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       unsigned long *hwirq,
+				       unsigned int *type)
 {
-	if (irq_domain_get_of_node(domain) != controller)
-		return -EINVAL;	/* Shouldn't happen, really... */
-	if (intsize != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (intspec[0] != 0)
-		return -EINVAL;	/* No PPI should point to this domain */
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2];
-	return 0;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int exynos_pmu_domain_alloc(struct irq_domain *domain,
 				   unsigned int virq,
 				   unsigned int nr_irqs, void *data)
 {
-	struct of_phandle_args *args = data;
-	struct of_phandle_args parent_args;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	int i;
 
-	if (args->args_count != 3)
+	if (fwspec->param_count != 3)
 		return -EINVAL;	/* Not GIC compliant */
-	if (args->args[0] != 0)
+	if (fwspec->param[0] != 0)
 		return -EINVAL;	/* No PPI should point to this domain */
 
-	hwirq = args->args[1];
+	hwirq = fwspec->param[1];
 
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      &exynos_pmu_chip, NULL);
 
-	parent_args = *args;
-	parent_args.np = irq_domain_get_of_node(domain->parent);
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
 }
 
 static const struct irq_domain_ops exynos_pmu_domain_ops = {
-	.xlate	= exynos_pmu_domain_xlate,
-	.alloc	= exynos_pmu_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
+	.translate	= exynos_pmu_domain_translate,
+	.alloc		= exynos_pmu_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
 };
 
 static int __init exynos_pmu_irq_init(struct device_node *node,
diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 7b32255..10bf715 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -181,40 +181,42 @@ static struct irq_chip imx_gpc_chip = {
 #endif
 };
 
-static int imx_gpc_domain_xlate(struct irq_domain *domain,
-				struct device_node *controller,
-				const u32 *intspec,
-				unsigned int intsize,
-				unsigned long *out_hwirq,
-				unsigned int *out_type)
+static int imx_gpc_domain_translate(struct irq_domain *d,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
 {
-	if (irq_domain_get_of_node(domain) != controller)
-		return -EINVAL;	/* Shouldn't happen, really... */
-	if (intsize != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (intspec[0] != 0)
-		return -EINVAL;	/* No PPI should point to this domain */
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2];
-	return 0;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int imx_gpc_domain_alloc(struct irq_domain *domain,
 				  unsigned int irq,
 				  unsigned int nr_irqs, void *data)
 {
-	struct of_phandle_args *args = data;
-	struct of_phandle_args parent_args;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	int i;
 
-	if (args->args_count != 3)
+	if (fwspec->param_count != 3)
 		return -EINVAL;	/* Not GIC compliant */
-	if (args->args[0] != 0)
+	if (fwspec->param[0] != 0)
 		return -EINVAL;	/* No PPI should point to this domain */
 
-	hwirq = args->args[1];
+	hwirq = fwspec->param[1];
 	if (hwirq >= GPC_MAX_IRQS)
 		return -EINVAL;	/* Can't deal with this */
 
@@ -222,15 +224,16 @@ static int imx_gpc_domain_alloc(struct irq_domain *domain,
 		irq_domain_set_hwirq_and_chip(domain, irq + i, hwirq + i,
 					      &imx_gpc_chip, NULL);
 
-	parent_args = *args;
-	parent_args.np = irq_domain_get_of_node(domain->parent);
-	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
+					    &parent_fwspec);
 }
 
 static const struct irq_domain_ops imx_gpc_domain_ops = {
-	.xlate	= imx_gpc_domain_xlate,
-	.alloc	= imx_gpc_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
+	.translate	= imx_gpc_domain_translate,
+	.alloc		= imx_gpc_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
 };
 
 static int __init imx_gpc_init(struct device_node *node,
diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index f0f7ffd..db7e0ba 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -399,40 +399,42 @@ static struct irq_chip wakeupgen_chip = {
 #endif
 };
 
-static int wakeupgen_domain_xlate(struct irq_domain *domain,
-				  struct device_node *controller,
-				  const u32 *intspec,
-				  unsigned int intsize,
-				  unsigned long *out_hwirq,
-				  unsigned int *out_type)
+static int wakeupgen_domain_translate(struct irq_domain *d,
+				      struct irq_fwspec *fwspec,
+				      unsigned long *hwirq,
+				      unsigned int *type)
 {
-	if (irq_domain_get_of_node(domain) != controller)
-		return -EINVAL;	/* Shouldn't happen, really... */
-	if (intsize != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (intspec[0] != 0)
-		return -EINVAL;	/* No PPI should point to this domain */
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2];
-	return 0;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int wakeupgen_domain_alloc(struct irq_domain *domain,
 				  unsigned int virq,
 				  unsigned int nr_irqs, void *data)
 {
-	struct of_phandle_args *args = data;
-	struct of_phandle_args parent_args;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
 	int i;
 
-	if (args->args_count != 3)
+	if (fwspec->param_count != 3)
 		return -EINVAL;	/* Not GIC compliant */
-	if (args->args[0] != 0)
+	if (fwspec->param[0] != 0)
 		return -EINVAL;	/* No PPI should point to this domain */
 
-	hwirq = args->args[1];
+	hwirq = fwspec->param[1];
 	if (hwirq >= MAX_IRQS)
 		return -EINVAL;	/* Can't deal with this */
 
@@ -440,15 +442,16 @@ static int wakeupgen_domain_alloc(struct irq_domain *domain,
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      &wakeupgen_chip, NULL);
 
-	parent_args = *args;
-	parent_args.np = irq_domain_get_of_node(domain->parent);
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
 }
 
 static const struct irq_domain_ops wakeupgen_domain_ops = {
-	.xlate	= wakeupgen_domain_xlate,
-	.alloc	= wakeupgen_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
+	.translate	= wakeupgen_domain_translate,
+	.alloc		= wakeupgen_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
 };
 
 /*
diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index f1d666a..75573fa 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -78,10 +78,13 @@ static struct irq_chip crossbar_chip = {
 static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 			    irq_hw_number_t hwirq)
 {
-	struct of_phandle_args args;
+	struct irq_fwspec fwspec;
 	int i;
 	int err;
 
+	if (!irq_domain_get_of_node(domain->parent))
+		return -EINVAL;
+
 	raw_spin_lock(&cb->lock);
 	for (i = cb->int_max - 1; i >= 0; i--) {
 		if (cb->irq_map[i] == IRQ_FREE) {
@@ -94,13 +97,13 @@ static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 	if (i < 0)
 		return -ENODEV;
 
-	args.np = irq_domain_get_of_node(domain->parent);
-	args.args_count = 3;
-	args.args[0] = 0;	/* SPI */
-	args.args[1] = i;
-	args.args[2] = IRQ_TYPE_LEVEL_HIGH;
+	fwspec.fwnode = domain->parent->fwnode;
+	fwspec.param_count = 3;
+	fwspec.param[0] = 0;	/* SPI */
+	fwspec.param[1] = i;
+	fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
 
-	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &args);
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (err)
 		cb->irq_map[i] = IRQ_FREE;
 	else
@@ -112,16 +115,16 @@ static int allocate_gic_irq(struct irq_domain *domain, unsigned virq,
 static int crossbar_domain_alloc(struct irq_domain *d, unsigned int virq,
 				 unsigned int nr_irqs, void *data)
 {
-	struct of_phandle_args *args = data;
+	struct irq_fwspec *fwspec = data;
 	irq_hw_number_t hwirq;
 	int i;
 
-	if (args->args_count != 3)
+	if (fwspec->param_count != 3)
 		return -EINVAL;	/* Not GIC compliant */
-	if (args->args[0] != 0)
+	if (fwspec->param[0] != 0)
 		return -EINVAL;	/* No PPI should point to this domain */
 
-	hwirq = args->args[1];
+	hwirq = fwspec->param[1];
 	if ((hwirq + nr_irqs) > cb->max_crossbar_sources)
 		return -EINVAL;	/* Can't deal with this */
 
@@ -166,28 +169,31 @@ static void crossbar_domain_free(struct irq_domain *domain, unsigned int virq,
 	raw_spin_unlock(&cb->lock);
 }
 
-static int crossbar_domain_xlate(struct irq_domain *d,
-				 struct device_node *controller,
-				 const u32 *intspec, unsigned int intsize,
-				 unsigned long *out_hwirq,
-				 unsigned int *out_type)
+static int crossbar_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq,
+				     unsigned int *type)
 {
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;	/* Shouldn't happen, really... */
-	if (intsize != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (intspec[0] != 0)
-		return -EINVAL;	/* No PPI should point to this domain */
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2];
-	return 0;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static const struct irq_domain_ops crossbar_domain_ops = {
-	.alloc	= crossbar_domain_alloc,
-	.free	= crossbar_domain_free,
-	.xlate	= crossbar_domain_xlate,
+	.alloc		= crossbar_domain_alloc,
+	.free		= crossbar_domain_free,
+	.translate	= crossbar_domain_translate,
 };
 
 static int __init crossbar_of_init(struct device_node *node)
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 7c268ee..3b88e17 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -124,17 +124,21 @@ static int gicv2m_irq_gic_domain_alloc(struct irq_domain *domain,
 				       unsigned int virq,
 				       irq_hw_number_t hwirq)
 {
-	struct of_phandle_args args;
+	struct irq_fwspec fwspec;
 	struct irq_data *d;
 	int err;
 
-	args.np = irq_domain_get_of_node(domain->parent);
-	args.args_count = 3;
-	args.args[0] = 0;
-	args.args[1] = hwirq - 32;
-	args.args[2] = IRQ_TYPE_EDGE_RISING;
+	if (is_of_node(domain->parent->fwnode)) {
+		fwspec.fwnode = domain->parent->fwnode;
+		fwspec.param_count = 3;
+		fwspec.param[0] = 0;
+		fwspec.param[1] = hwirq - 32;
+		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else {
+		return -EINVAL;
+	}
 
-	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &args);
+	err = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 	if (err)
 		return err;
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 3cfafab..e23d1d1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1265,15 +1265,19 @@ static int its_irq_gic_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    irq_hw_number_t hwirq)
 {
-	struct of_phandle_args args;
-
-	args.np = irq_domain_get_of_node(domain->parent);
-	args.args_count = 3;
-	args.args[0] = GIC_IRQ_TYPE_LPI;
-	args.args[1] = hwirq;
-	args.args[2] = IRQ_TYPE_EDGE_RISING;
+	struct irq_fwspec fwspec;
+
+	if (irq_domain_get_of_node(domain->parent)) {
+		fwspec.fwnode = domain->parent->fwnode;
+		fwspec.param_count = 3;
+		fwspec.param[0] = GIC_IRQ_TYPE_LPI;
+		fwspec.param[1] = hwirq;
+		fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
+	} else {
+		return -EINVAL;
+	}
 
-	return irq_domain_alloc_irqs_parent(domain, virq, 1, &args);
+	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
 }
 
 static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5793880..05d010b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -737,32 +737,30 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	return 0;
 }
 
-static int gic_irq_domain_xlate(struct irq_domain *d,
-				struct device_node *controller,
-				const u32 *intspec, unsigned int intsize,
-				unsigned long *out_hwirq, unsigned int *out_type)
+static int gic_irq_domain_translate(struct irq_domain *d,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
 {
-	if (irq_domain_get_of_node(d) != controller)
-		return -EINVAL;
-	if (intsize < 3)
-		return -EINVAL;
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count < 3)
+			return -EINVAL;
 
-	switch(intspec[0]) {
-	case 0:			/* SPI */
-		*out_hwirq = intspec[1] + 32;
-		break;
-	case 1:			/* PPI */
-		*out_hwirq = intspec[1] + 16;
-		break;
-	case GIC_IRQ_TYPE_LPI:	/* LPI */
-		*out_hwirq = intspec[1];
-		break;
-	default:
-		return -EINVAL;
+		/* Get the interrupt number and add 16 to skip over SGIs */
+		*hwirq = fwspec->param[1] + 16;
+
+		/*
+		 * For SPIs, we need to add 16 more to get the GIC irq
+		 * ID number
+		 */
+		if (!fwspec->param[0])
+			*hwirq += 16;
+
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		return 0;
 	}
 
-	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
-	return 0;
+	return -EINVAL;
 }
 
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -771,10 +769,9 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i, ret;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	struct of_phandle_args *irq_data = arg;
+	struct irq_fwspec *fwspec = arg;
 
-	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
-				   irq_data->args_count, &hwirq, &type);
+	ret = gic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -797,7 +794,7 @@ static void gic_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops gic_irq_domain_ops = {
-	.xlate = gic_irq_domain_xlate,
+	.translate = gic_irq_domain_translate,
 	.alloc = gic_irq_domain_alloc,
 	.free = gic_irq_domain_free,
 };
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index abdccfb..9262bb9 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -940,6 +940,32 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 	return ret;
 }
 
+static int gic_irq_domain_translate(struct irq_domain *d,
+				    struct irq_fwspec *fwspec,
+				    unsigned long *hwirq,
+				    unsigned int *type)
+{
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count < 3)
+			return -EINVAL;
+
+		/* Get the interrupt number and add 16 to skip over SGIs */
+		*hwirq = fwspec->param[1] + 16;
+
+		/*
+		 * For SPIs, we need to add 16 more to get the GIC irq
+		 * ID number
+		 */
+		if (!fwspec->param[0])
+			*hwirq += 16;
+
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 #ifdef CONFIG_SMP
 static int gic_secondary_init(struct notifier_block *nfb, unsigned long action,
 			      void *hcpu)
@@ -965,10 +991,9 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	int i, ret;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	struct of_phandle_args *irq_data = arg;
+	struct irq_fwspec *fwspec = arg;
 
-	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
-				   irq_data->args_count, &hwirq, &type);
+	ret = gic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -979,7 +1004,7 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops gic_irq_domain_hierarchy_ops = {
-	.xlate = gic_irq_domain_xlate,
+	.translate = gic_irq_domain_translate,
 	.alloc = gic_irq_domain_alloc,
 	.free = irq_domain_free_irqs_top,
 };
diff --git a/drivers/irqchip/irq-imx-gpcv2.c b/drivers/irqchip/irq-imx-gpcv2.c
index 05302ce..15af9a9 100644
--- a/drivers/irqchip/irq-imx-gpcv2.c
+++ b/drivers/irqchip/irq-imx-gpcv2.c
@@ -150,49 +150,42 @@ static struct irq_chip gpcv2_irqchip_data_chip = {
 #endif
 };
 
-static int imx_gpcv2_domain_xlate(struct irq_domain *domain,
-				struct device_node *controller,
-				const u32 *intspec,
-				unsigned int intsize,
-				unsigned long *out_hwirq,
-				unsigned int *out_type)
+static int imx_gpcv2_domain_translate(struct irq_domain *d,
+				      struct irq_fwspec *fwspec,
+				      unsigned long *hwirq,
+				      unsigned int *type)
 {
-	/* Shouldn't happen, really... */
-	if (irq_domain_get_of_node(domain) != controller)
-		return -EINVAL;
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	/* Not GIC compliant */
-	if (intsize != 3)
-		return -EINVAL;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
 
-	/* No PPI should point to this domain */
-	if (intspec[0] != 0)
-		return -EINVAL;
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2];
-	return 0;
+	return -EINVAL;
 }
 
 static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
 				  unsigned int irq, unsigned int nr_irqs,
 				  void *data)
 {
-	struct of_phandle_args *args = data;
-	struct of_phandle_args parent_args;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
 	irq_hw_number_t hwirq;
+	unsigned int type;
+	int err;
 	int i;
 
-	/* Not GIC compliant */
-	if (args->args_count != 3)
-		return -EINVAL;
-
-	/* No PPI should point to this domain */
-	if (args->args[0] != 0)
-		return -EINVAL;
+	err = imx_gpcv2_domain_translate(domain, fwspec, &hwirq, &type);
+	if (err)
+		return err;
 
-	/* Can't deal with this */
-	hwirq = args->args[1];
 	if (hwirq >= GPC_MAX_IRQS)
 		return -EINVAL;
 
@@ -201,15 +194,16 @@ static int imx_gpcv2_domain_alloc(struct irq_domain *domain,
 				&gpcv2_irqchip_data_chip, domain->host_data);
 	}
 
-	parent_args = *args;
-	parent_args.np = irq_domain_get_of_node(domain->parent);
-	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs, &parent_args);
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	return irq_domain_alloc_irqs_parent(domain, irq, nr_irqs,
+					    &parent_fwspec);
 }
 
 static struct irq_domain_ops gpcv2_irqchip_data_domain_ops = {
-	.xlate	= imx_gpcv2_domain_xlate,
-	.alloc	= imx_gpcv2_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
+	.translate	= imx_gpcv2_domain_translate,
+	.alloc		= imx_gpcv2_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
 };
 
 static int __init imx_gpcv2_irqchip_init(struct device_node *node,
diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index b072166..63ac73b 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -67,22 +67,25 @@ static struct irq_chip mtk_sysirq_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static int mtk_sysirq_domain_xlate(struct irq_domain *d,
-				   struct device_node *controller,
-				   const u32 *intspec, unsigned int intsize,
-				   unsigned long *out_hwirq,
-				   unsigned int *out_type)
+static int mtk_sysirq_domain_translate(struct irq_domain *d,
+				       struct irq_fwspec *fwspec,
+				       unsigned long *hwirq,
+				       unsigned int *type)
 {
-	if (intsize != 3)
-		return -EINVAL;
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	/* sysirq doesn't support PPI */
-	if (intspec[0])
-		return -EINVAL;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
-	return 0;
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
@@ -90,30 +93,30 @@ static int mtk_sysirq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	int i;
 	irq_hw_number_t hwirq;
-	struct of_phandle_args *irq_data = arg;
-	struct of_phandle_args gic_data = *irq_data;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec gic_fwspec = *fwspec;
 
-	if (irq_data->args_count != 3)
+	if (fwspec->param_count != 3)
 		return -EINVAL;
 
 	/* sysirq doesn't support PPI */
-	if (irq_data->args[0])
+	if (fwspec->param[0])
 		return -EINVAL;
 
-	hwirq = irq_data->args[1];
+	hwirq = fwspec->param[1];
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      &mtk_sysirq_chip,
 					      domain->host_data);
 
-	gic_data.np = irq_domain_get_of_node(domain->parent);
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_data);
+	gic_fwspec.fwnode = domain->parent->fwnode;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
 }
 
 static const struct irq_domain_ops sysirq_domain_ops = {
-	.xlate = mtk_sysirq_domain_xlate,
-	.alloc = mtk_sysirq_domain_alloc,
-	.free = irq_domain_free_irqs_common,
+	.translate	= mtk_sysirq_domain_translate,
+	.alloc		= mtk_sysirq_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
 };
 
 static int __init mtk_sysirq_of_init(struct device_node *node,
diff --git a/drivers/irqchip/irq-nvic.c b/drivers/irqchip/irq-nvic.c
index a878b8d..b177710 100644
--- a/drivers/irqchip/irq-nvic.c
+++ b/drivers/irqchip/irq-nvic.c
@@ -48,16 +48,26 @@ nvic_handle_irq(irq_hw_number_t hwirq, struct pt_regs *regs)
 	handle_IRQ(irq, regs);
 }
 
+static int nvic_irq_domain_translate(struct irq_domain *d,
+				     struct irq_fwspec *fwspec,
+				     unsigned long *hwirq, unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 1))
+		return -EINVAL;
+	*hwirq = fwspec->param[0];
+	*type = IRQ_TYPE_NONE;
+	return 0;
+}
+
 static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
 	int i, ret;
 	irq_hw_number_t hwirq;
 	unsigned int type = IRQ_TYPE_NONE;
-	struct of_phandle_args *irq_data = arg;
+	struct irq_fwspec *fwspec = arg;
 
-	ret = irq_domain_xlate_onecell(domain, irq_data->np, irq_data->args,
-				   irq_data->args_count, &hwirq, &type);
+	ret = nvic_irq_domain_translate(domain, fwspec, &hwirq, &type);
 	if (ret)
 		return ret;
 
@@ -68,7 +78,7 @@ static int nvic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops nvic_irq_domain_ops = {
-	.xlate = irq_domain_xlate_onecell,
+	.translate = nvic_irq_domain_translate,
 	.alloc = nvic_irq_domain_alloc,
 	.free = irq_domain_free_irqs_top,
 };
diff --git a/drivers/irqchip/irq-tegra.c b/drivers/irqchip/irq-tegra.c
index 7bbf226..557e15e 100644
--- a/drivers/irqchip/irq-tegra.c
+++ b/drivers/irqchip/irq-tegra.c
@@ -220,41 +220,43 @@ static struct irq_chip tegra_ictlr_chip = {
 #endif
 };
 
-static int tegra_ictlr_domain_xlate(struct irq_domain *domain,
-				    struct device_node *controller,
-				    const u32 *intspec,
-				    unsigned int intsize,
-				    unsigned long *out_hwirq,
-				    unsigned int *out_type)
+static int tegra_ictlr_domain_translate(struct irq_domain *d,
+					struct irq_fwspec *fwspec,
+					unsigned long *hwirq,
+					unsigned int *type)
 {
-	if (irq_domain_get_of_node(domain) != controller)
-		return -EINVAL;	/* Shouldn't happen, really... */
-	if (intsize != 3)
-		return -EINVAL;	/* Not GIC compliant */
-	if (intspec[0] != GIC_SPI)
-		return -EINVAL;	/* No PPI should point to this domain */
+	if (is_of_node(fwspec->fwnode)) {
+		if (fwspec->param_count != 3)
+			return -EINVAL;
 
-	*out_hwirq = intspec[1];
-	*out_type = intspec[2];
-	return 0;
+		/* No PPI should point to this domain */
+		if (fwspec->param[0] != 0)
+			return -EINVAL;
+
+		*hwirq = fwspec->param[1];
+		*type = fwspec->param[2];
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq,
 				    unsigned int nr_irqs, void *data)
 {
-	struct of_phandle_args *args = data;
-	struct of_phandle_args parent_args;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec parent_fwspec;
 	struct tegra_ictlr_info *info = domain->host_data;
 	irq_hw_number_t hwirq;
 	unsigned int i;
 
-	if (args->args_count != 3)
+	if (fwspec->param_count != 3)
 		return -EINVAL;	/* Not GIC compliant */
-	if (args->args[0] != GIC_SPI)
+	if (fwspec->param[0] != GIC_SPI)
 		return -EINVAL;	/* No PPI should point to this domain */
 
-	hwirq = args->args[1];
+	hwirq = fwspec->param[1];
 	if (hwirq >= (num_ictlrs * 32))
 		return -EINVAL;
 
@@ -266,9 +268,10 @@ static int tegra_ictlr_domain_alloc(struct irq_domain *domain,
 					      info->base[ictlr]);
 	}
 
-	parent_args = *args;
-	parent_args.np = irq_domain_get_of_node(domain->parent);
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_args);
+	parent_fwspec = *fwspec;
+	parent_fwspec.fwnode = domain->parent->fwnode;
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
 }
 
 static void tegra_ictlr_domain_free(struct irq_domain *domain,
@@ -284,9 +287,9 @@ static void tegra_ictlr_domain_free(struct irq_domain *domain,
 }
 
 static const struct irq_domain_ops tegra_ictlr_domain_ops = {
-	.xlate	= tegra_ictlr_domain_xlate,
-	.alloc	= tegra_ictlr_domain_alloc,
-	.free	= tegra_ictlr_domain_free,
+	.translate	= tegra_ictlr_domain_translate,
+	.alloc		= tegra_ictlr_domain_alloc,
+	.free		= tegra_ictlr_domain_free,
 };
 
 static int __init tegra_ictlr_init(struct device_node *node,
diff --git a/drivers/irqchip/irq-vf610-mscm-ir.c b/drivers/irqchip/irq-vf610-mscm-ir.c
index ae82d7e..56b5e3c 100644
--- a/drivers/irqchip/irq-vf610-mscm-ir.c
+++ b/drivers/irqchip/irq-vf610-mscm-ir.c
@@ -130,35 +130,51 @@ static int vf610_mscm_ir_domain_alloc(struct irq_domain *domain, unsigned int vi
 {
 	int i;
 	irq_hw_number_t hwirq;
-	struct of_phandle_args *irq_data = arg;
-	struct of_phandle_args gic_data;
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec parent_fwspec;
 
-	if (irq_data->args_count != 2)
+	if (!irq_domain_get_of_node(domain->parent))
 		return -EINVAL;
 
-	hwirq = irq_data->args[0];
+	if (fwspec->param_count != 2)
+		return -EINVAL;
+
+	hwirq = fwspec->param[0];
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
 					      &vf610_mscm_ir_irq_chip,
 					      domain->host_data);
 
-	gic_data.np = irq_domain_get_of_node(domain->parent);
+	parent_fwspec.fwnode = domain->parent->fwnode;
 
 	if (mscm_ir_data->is_nvic) {
-		gic_data.args_count = 1;
-		gic_data.args[0] = irq_data->args[0];
+		parent_fwspec.param_count = 1;
+		parent_fwspec.param[0] = fwspec->param[0];
 	} else {
-		gic_data.args_count = 3;
-		gic_data.args[0] = GIC_SPI;
-		gic_data.args[1] = irq_data->args[0];
-		gic_data.args[2] = irq_data->args[1];
+		parent_fwspec.param_count = 3;
+		parent_fwspec.param[0] = GIC_SPI;
+		parent_fwspec.param[1] = fwspec->param[0];
+		parent_fwspec.param[2] = fwspec->param[1];
 	}
 
-	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_data);
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs,
+					    &parent_fwspec);
+}
+
+static int vf610_mscm_ir_domain_translate(struct irq_domain *d,
+					  struct irq_fwspec *fwspec,
+					  unsigned long *hwirq,
+					  unsigned int *type)
+{
+	if (WARN_ON(fwspec->param_count < 2))
+		return -EINVAL;
+	*hwirq = fwspec->param[0];
+	*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	return 0;
 }
 
 static const struct irq_domain_ops mscm_irq_domain_ops = {
-	.xlate = irq_domain_xlate_twocell,
+	.translate = vf610_mscm_ir_domain_translate,
 	.alloc = vf610_mscm_ir_domain_alloc,
 	.free = irq_domain_free_irqs_common,
 };
-- 
2.1.4
