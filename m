From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 10 Jul 2015 18:45:10 +0800
Subject: [PATCH v3 4/8] irqchip / gic: Add stacked irqdomain support for ACPI
 based GICv2 init
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1436525114-14425-5-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For now, ACPI based GICv2 is using the irq_default_domain as the
ACPI core domain which is not scalable, also we don't support
stacked irq domains in ACPI, this patch is trying to implement that.

Firstly, we need to find the irqdomain with GSI, because we use
different model of mapping interrupt with device in ACPI than DT,
in DT, we using the interrupt parent property to get the device
node of irqchip for devices, that's why we need the matching function
that match the device node with the one associated with the irqdomain.
But for ACPI, we only can get the GSI which the device is using, no
interrupt parent will be specified, then we need a mechanism to find
GSI's (also the device's) irqdomain to make the code scalable.

Thanks to the usage of GSI, it is a flat hwirq number which is unique
in the system, then we can get its associated irq domain by matching
the GSI supported by this irqchip (see drawings below), then we can
live without the token pointer matching the interrupt controller as
DT did.

                  ------------      ---> gsi_base0
                 |            |
                 |            |
  irqdomain <----| irqchip 0  |
                 |            |
                 |            |
                 |____________|     ---> gsi_end0

                  ------------      ---> gsi_base1 (probably gsi_end0+1)
                 |            |
                 |            |
  irqdomain <----| irqchip 1  |
                 |            |
                 |            |
                 |____________|     ---> gsi_end1

                  .....

if a device is using GSI n, then we can find GSI's irqdomain by matching
gsi_base <= n <= gsi_end.

For GIC, we only have one GICD, but the above model still valid. GICD
structure in ACPI MADT defines System Vector Base in the GICD entry,
which means the global system interrupt number where this GIC
Distributor?s interrupt inputs start, then we can get the hwirq numbers
supported by reading the register, so we can explictly get the GSI's
associated irqdomain if the GSI is within the range of hwirq supported
by this GICD.

Secondly, pass the GSI as the arg for domain's ops alloc() function
when register the GSI, then we can take advantage of stacked irqdomains.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/gsi.c        | 78 ++++++++++++++++++++++++++++++++++++++---------
 drivers/irqchip/irq-gic.c | 37 +++++++++++++---------
 include/linux/acpi.h      |  5 +++
 3 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 38208f2..ba7de7f 100644
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
@@ -14,6 +15,54 @@
 
 enum acpi_irq_model_id acpi_irq_model;
 
+struct gsi_cfg_data {
+	struct list_head list;
+	u32 gsi_base;
+	u32 gsi_end;
+	struct irq_domain *domain;
+};
+
+static LIST_HEAD(gsi_cfg_data_list);
+static DEFINE_MUTEX(gsi_mutex);
+
+/* Init the gsi cfg data which is called by irqchip drivers */
+int gsi_cfg_data_add(struct irq_domain *domain, u32 gsi_base, u32 gsi_end)
+{
+	struct gsi_cfg_data *data;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->domain = domain;
+	data->gsi_base = gsi_base;
+	data->gsi_end = gsi_end;
+
+	mutex_lock(&gsi_mutex);
+	list_add(&data->list, &gsi_cfg_data_list);
+	mutex_unlock(&gsi_mutex);
+
+	return 0;
+}
+
+/* Find irqdomain with GSI (hwirq number) */
+static struct irq_domain *acpi_find_irqdomain(u32 gsi)
+{
+	struct gsi_cfg_data *data;
+	struct irq_domain *domain = NULL;
+
+	mutex_lock(&gsi_mutex);
+	list_for_each_entry(data, &gsi_cfg_data_list, list) {
+		if (gsi >= data->gsi_base && gsi <= data->gsi_end) {
+			domain = data->domain;
+			break;
+		}
+	}
+	mutex_unlock(&gsi_mutex);
+
+	return domain;
+}
+
 static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
 {
 	switch (polarity) {
@@ -45,12 +94,9 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	/*
-	 * Only default domain is supported at present, always find
-	 * the mapping corresponding to default domain by passing NULL
-	 * as irq_domain parameter
-	 */
-	*irq = irq_find_mapping(NULL, gsi);
+	struct irq_domain *domain = acpi_find_irqdomain(gsi);
+
+	*irq = irq_find_mapping(domain, gsi);
 	/*
 	 * *irq == 0 means no mapping, that should
 	 * be reported as a failure
@@ -72,16 +118,17 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
-	unsigned int irq;
+	int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
+	struct irq_domain *domain = acpi_find_irqdomain(gsi);
 
-	/*
-	 * There is no way at present to look-up the IRQ domain on ACPI,
-	 * hence always create mapping referring to the default domain
-	 * by passing NULL as irq_domain parameter
-	 */
-	irq = irq_create_mapping(NULL, gsi);
-	if (!irq)
+	irq = irq_find_mapping(domain, gsi);
+	if (irq > 0)
+		return irq;
+
+	/* pass gsi as the hwirq num and get it in the domain's alloc() ops */
+	irq = irq_domain_alloc_irqs(domain, 1, dev_to_node(dev), &gsi);
+	if (irq <= 0)
 		return -EINVAL;
 
 	/* Set irq type if specified and different than the current one */
@@ -98,7 +145,8 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	int irq = irq_find_mapping(NULL, gsi);
+	struct irq_domain *domain = acpi_find_irqdomain(gsi);
+	int irq = irq_find_mapping(domain, gsi);
 
 	irq_dispose_mapping(irq);
 }
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 58a7112..39c1b0d 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -852,15 +852,22 @@ static struct notifier_block gic_cpu_notifier = {
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
+	if (acpi_disabled) {	/* DT case */
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
@@ -946,11 +953,11 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 		gic_irqs = 1020;
 	gic->gic_irqs = gic_irqs;
 
-	if (node) {		/* DT case */
+	if (node || !acpi_disabled) {	/* DT or ACPI case */
 		gic->domain = irq_domain_add_linear(node, gic_irqs,
 						    &gic_irq_domain_hierarchy_ops,
 						    gic);
-	} else {		/* Non-DT case */
+	} else {		/* Non-DT and Non-ACPI case */
 		/*
 		 * For primary GICs, skip over SGIs.
 		 * For secondary GICs, skip over PPIs, too.
@@ -1044,6 +1051,7 @@ IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
 
 #ifdef CONFIG_ACPI
 static phys_addr_t dist_phy_base, cpu_phy_base __initdata;
+static u32 gsi_base __initdata;
 
 static int __init
 gic_acpi_parse_madt_cpu(struct acpi_subtable_header *header,
@@ -1082,6 +1090,7 @@ gic_acpi_parse_madt_distributor(struct acpi_subtable_header *header,
 	if (BAD_MADT_ENTRY(dist, end))
 		return -EINVAL;
 
+	gsi_base = dist->global_irq_base;
 	dist_phy_base = dist->base_address;
 	return 0;
 }
@@ -1131,13 +1140,11 @@ gic_v2_acpi_init(struct acpi_table_header *table)
 		return -ENOMEM;
 	}
 
-	/*
-	 * Initialize zero GIC instance (no multi-GIC support). Also, set GIC
-	 * as default IRQ domain to allow for GSI registration and GSI to IRQ
-	 * number translation (see acpi_register_gsi() and acpi_gsi_to_irq()).
-	 */
 	gic_init_bases(0, -1, dist_base, cpu_base, 0, NULL);
-	irq_set_default_host(gic_data[0].domain);
+
+	/* since we have only one GICD, we can safely use gic_data[0] here */
+	gsi_cfg_data_add(gic_data[0].domain, gsi_base,
+			 gsi_base + gic_data[0].gic_irqs);
 
 	acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 	return 0;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7b058f0..6e84714 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -204,6 +204,11 @@ extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
  */
 void acpi_unregister_gsi (u32 gsi);
 
+#ifdef CONFIG_ACPI_GENERIC_GSI
+struct irq_domain;
+int gsi_cfg_data_add(struct irq_domain *domain, u32 gsi_base, u32 gsi_end);
+#endif
+
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
-- 
1.9.1
