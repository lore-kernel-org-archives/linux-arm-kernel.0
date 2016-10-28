From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Fri, 28 Oct 2016 16:48:15 -0400
Subject: [PATCH V6 2/3] ACPI: Add support for ResourceSource/IRQ domain mapping
In-Reply-To: <1477687696-1509-1-git-send-email-agustinv@codeaurora.org>
References: <1477687696-1509-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1477687696-1509-3-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows irqchip drivers to associate an ACPI DSDT device to
an IRQ domain and provides support for using the ResourceSource
in Extended IRQ Resources to find the domain and map the IRQs
specified on that domain.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/irqdomain.c | 119 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/resource.c  |  21 +++++----
 include/linux/acpi.h     |  25 ++++++++++
 4 files changed, 157 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/irqdomain.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 9ed0878..880401b 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -57,6 +57,7 @@ acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += gsi.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
+acpi-$(CONFIG_IRQ_DOMAIN)	+= irqdomain.o
 
 # These are (potentially) separate modules
 
diff --git a/drivers/acpi/irqdomain.c b/drivers/acpi/irqdomain.c
new file mode 100644
index 0000000..11d3658
--- /dev/null
+++ b/drivers/acpi/irqdomain.c
@@ -0,0 +1,119 @@
+/*
+ * ACPI ResourceSource/IRQ domain mapping support
+ *
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+
+/**
+ * acpi_irq_domain_register_irq() - Register the mapping for an IRQ produced
+ *                                  by the given acpi_resource_source to a
+ *                                  Linux IRQ number
+ * @source: IRQ source
+ * @hwirq: Hardware IRQ number
+ * @trigger: trigger type of the IRQ number to be mapped
+ * @polarity: polarity of the IRQ to be mapped
+ *
+ * Returns: a valid linux IRQ number on success
+ *          -ENODEV if the given acpi_resource_source cannot be found
+ *          -EPROBE_DEFER if the IRQ domain has not been registered
+ *          -EINVAL for all other errors
+ */
+int acpi_irq_domain_register_irq(const struct acpi_resource_source *source,
+				 u32 hwirq, int trigger, int polarity)
+{
+	struct irq_fwspec fwspec;
+	struct acpi_device *device;
+	acpi_handle handle;
+	acpi_status status;
+	int ret;
+
+	/* An empty acpi_resource_source means it is a GSI */
+	if (!source->string_length)
+		return acpi_register_gsi(NULL, hwirq, trigger, polarity);
+
+	status = acpi_get_handle(NULL, source->string_ptr, &handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	device = acpi_bus_get_acpi_device(handle);
+	if (!device)
+		return -ENODEV;
+
+	if (irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY) == NULL) {
+		ret = -EPROBE_DEFER;
+		goto out_put_device;
+	}
+
+	fwspec.fwnode = &device->fwnode;
+	fwspec.param[0] = hwirq;
+	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
+	fwspec.param_count = 2;
+
+	ret = irq_create_fwspec_mapping(&fwspec);
+
+out_put_device:
+	acpi_bus_put_acpi_device(device);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_irq_domain_register_irq);
+
+/**
+ * acpi_irq_domain_unregister_irq() - Delete the mapping for an IRQ produced
+ *                                    by the given acpi_resource_source to a
+ *                                    Linux IRQ number
+ * @source: IRQ source
+ * @hwirq: Hardware IRQ number
+ *
+ * Returns: 0 on success
+ *          -ENODEV if the given acpi_resource_source cannot be found
+ *          -EINVAL for all other errors
+ */
+int acpi_irq_domain_unregister_irq(const struct acpi_resource_source *source,
+				   u32 hwirq)
+{
+	struct irq_domain *domain;
+	struct acpi_device *device;
+	acpi_handle handle;
+	acpi_status status;
+	int ret = 0;
+
+	if (!source->string_length) {
+		acpi_unregister_gsi(hwirq);
+		return 0;
+	}
+
+	status = acpi_get_handle(NULL, source->string_ptr, &handle);
+	if (ACPI_FAILURE(status))
+		return -ENODEV;
+
+	device = acpi_bus_get_acpi_device(handle);
+	if (!device)
+		return -ENODEV;
+
+	domain = irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY);
+	if (!domain) {
+		ret = -EINVAL;
+		goto out_put_device;
+	}
+
+	irq_dispose_mapping(irq_find_mapping(domain, hwirq));
+
+out_put_device:
+	acpi_bus_put_acpi_device(device);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_irq_domain_unregister_irq);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 4beda15..ccb6f4f 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -381,14 +381,15 @@ static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
 	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
 }
 
-static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
+static void acpi_dev_get_irqresource(struct resource *res, u32 hwirq,
+				     const struct acpi_resource_source *source,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
 {
 	int irq, p, t;
 
-	if (!valid_IRQ(gsi)) {
-		acpi_dev_irqresource_disabled(res, gsi);
+	if ((source->string_length == 0) && !valid_IRQ(hwirq)) {
+		acpi_dev_irqresource_disabled(res, hwirq);
 		return;
 	}
 
@@ -402,25 +403,25 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	 * using extended IRQ descriptors we take the IRQ configuration
 	 * from _CRS directly.
 	 */
-	if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
+	if (legacy && !acpi_get_override_irq(hwirq, &t, &p)) {
 		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
 		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
 
 		if (triggering != trig || polarity != pol) {
-			pr_warning("ACPI: IRQ %d override to %s, %s\n", gsi,
-				   t ? "level" : "edge", p ? "low" : "high");
+			pr_warn("ACPI: IRQ %d override to %s, %s\n", hwirq,
+				t ? "level" : "edge", p ? "low" : "high");
 			triggering = trig;
 			polarity = pol;
 		}
 	}
 
 	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
-	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
+	irq = acpi_irq_domain_register_irq(source, hwirq, triggering, polarity);
 	if (irq >= 0) {
 		res->start = irq;
 		res->end = irq;
 	} else {
-		acpi_dev_irqresource_disabled(res, gsi);
+		acpi_dev_irqresource_disabled(res, hwirq);
 	}
 }
 
@@ -446,6 +447,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 				 struct resource *res)
 {
+	const struct acpi_resource_source dummy = { 0, 0, NULL };
 	struct acpi_resource_irq *irq;
 	struct acpi_resource_extended_irq *ext_irq;
 
@@ -460,7 +462,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			acpi_dev_irqresource_disabled(res, 0);
 			return false;
 		}
-		acpi_dev_get_irqresource(res, irq->interrupts[index],
+		acpi_dev_get_irqresource(res, irq->interrupts[index], &dummy,
 					 irq->triggering, irq->polarity,
 					 irq->sharable, true);
 		break;
@@ -471,6 +473,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			return false;
 		}
 		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
+					 &ext_irq->resource_source,
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->sharable, false);
 		break;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 40213c4..ce30a12 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -321,6 +321,31 @@ void acpi_set_irq_model(enum acpi_irq_model_id model,
  */
 void acpi_unregister_gsi (u32 gsi);
 
+#ifdef CONFIG_IRQ_DOMAIN
+
+int acpi_irq_domain_register_irq(const struct acpi_resource_source *source,
+				 u32 hwirq, int trigger, int polarity);
+int acpi_irq_domain_unregister_irq(const struct acpi_resource_source *source,
+				   u32 hwirq);
+
+#else
+
+static inline int acpi_irq_domain_register_irq(
+	const struct acpi_resource_source *source, u32 hwirq, int trigger,
+	int polarity)
+{
+	return acpi_register_gsi(NULL, hwirq, trigger, polarity);
+}
+
+static inline int acpi_irq_domain_unregister_irq(
+	const struct acpi_resource_source *source,  u32 hwirq)
+{
+	acpi_unregister_gsi(hwirq);
+	return 0;
+}
+
+#endif /* CONFIG_IRQ_DOMAIN */
+
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
