From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Mon, 18 May 2015 20:59:15 +0800
Subject: [PATCH 05/11] irqchip / gic: Add stacked irqdomain support for ACPI
 based GICv2 init
In-Reply-To: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1431953961-22706-6-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce acpi_irq_domain for GICv2 core domain instead of referring
to the irq_default_domain, based on that, pass gsi as the argument and
get the gsi in gic_irq_domain_alloc() to add stacked irqdomain support
for ACPI based GICv2 init.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/gsi.c                   | 28 +++++++++++++---------------
 drivers/irqchip/irq-gic.c            | 32 +++++++++++++++++---------------
 include/linux/irqchip/arm-gic-acpi.h |  2 ++
 3 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 38208f2..55b5f31 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -3,6 +3,7 @@
  *
  * Copyright (C) 2015 ARM Ltd.
  * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *         Hanjun Guo <hanjun.guo@linaro.org> for stacked irqdomains support
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -13,6 +14,8 @@
 #include <linux/irqdomain.h>
 
 enum acpi_irq_model_id acpi_irq_model;
+/* ACPI core domian pointing to GICv2/3 core domain */
+struct irq_domain *acpi_irq_domain __read_mostly;
 
 static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
 {
@@ -45,12 +48,7 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	/*
-	 * Only default domain is supported at present, always find
-	 * the mapping corresponding to default domain by passing NULL
-	 * as irq_domain parameter
-	 */
-	*irq = irq_find_mapping(NULL, gsi);
+	*irq = irq_find_mapping(acpi_irq_domain, gsi);
 	/*
 	 * *irq == 0 means no mapping, that should
 	 * be reported as a failure
@@ -72,16 +70,16 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
-	unsigned int irq;
+	int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
 
-	/*
-	 * There is no way at present to look-up the IRQ domain on ACPI,
-	 * hence always create mapping referring to the default domain
-	 * by passing NULL as irq_domain parameter
-	 */
-	irq = irq_create_mapping(NULL, gsi);
-	if (!irq)
+	irq = irq_find_mapping(acpi_irq_domain, gsi);
+	if (irq > 0)
+		return irq;
+
+	irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev),
+				    &gsi);
+	if (irq <= 0)
 		return -EINVAL;
 
 	/* Set irq type if specified and different than the current one */
@@ -98,7 +96,7 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	int irq = irq_find_mapping(NULL, gsi);
+	int irq = irq_find_mapping(acpi_irq_domain, gsi);
 
 	irq_dispose_mapping(irq);
 }
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index fefbcb5..869a69f 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -851,15 +851,22 @@ static struct notifier_block gic_cpu_notifier = {
 static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				unsigned int nr_irqs, void *arg)
 {
-	int i, ret;
+	int i;
 	irq_hw_number_t hwirq;
-	unsigned int type = IRQ_TYPE_NONE;
-	struct of_phandle_args *irq_data = arg;
 
-	ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
-				   irq_data->args_count, &hwirq, &type);
-	if (ret)
-		return ret;
+	if (domain->of_node) {	/* DT case */
+		int ret;
+		unsigned int type = IRQ_TYPE_NONE;
+		struct of_phandle_args *irq_data = arg;
+
+		ret = gic_irq_domain_xlate(domain, irq_data->np,
+					irq_data->args,
+					irq_data->args_count, &hwirq, &type);
+		if (ret)
+			return ret;
+	} else {	/* ACPI case */
+		hwirq = (irq_hw_number_t)*(u32 *)arg;
+	}
 
 	for (i = 0; i < nr_irqs; i++)
 		gic_irq_domain_map(domain, virq + i, hwirq + i);
@@ -945,11 +952,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (node) {		/* DT case */
+	if (node || !acpi_disabled) {		/* DT or ACPI case */
 		gic->domain = irq_domain_add_linear(node, gic_irqs,
 						    &gic_irq_domain_hierarchy_ops,
 						    gic);
-	} else {		/* Non-DT case */
+	} else {		/* Non-DT and ACPI case */
 		/*
 		 * For primary GICs, skip over SGIs.
 		 * For secondary GICs, skip over PPIs, too.
@@ -1133,13 +1140,8 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 		return -ENOMEM;
 	}
 
-	/*
-	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
-	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
-	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
-	 */
 	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	irq_set_default_host(gic_data[0].domain);
+	acpi_irq_domain = gic_data[0].domain;
 
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 	return 0;
diff --git a/include/linux/irqchip/arm-gic-acpi.h b/include/linux/irqchip/arm-gic-acpi.h
index 021e8e8..245386d 100644
--- a/include/linux/irqchip/arm-gic-acpi.h
+++ b/include/linux/irqchip/arm-gic-acpi.h
@@ -21,6 +21,8 @@
 #define ACPI_GIC_CPU_IF_MEM_SIZE	(SZ_8K)
 #define ACPI_GICV3_DIST_MEM_SIZE	(SZ_64K)
 
+extern struct irq_domain *acpi_irq_domain;
+
 int acpi_gic_version_init(void);
 u8 acpi_gic_version(void);
 #endif /* CONFIG_ACPI */
-- 
1.9.1
