From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Tue, 18 Oct 2016 13:41:48 -0400
Subject: [PATCH V5 1/2] ACPI: Add support for ResourceSource/IRQ domain mapping
In-Reply-To: <1476812509-2760-1-git-send-email-agustinv@codeaurora.org>
References: <1476812509-2760-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1476812509-2760-2-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows irqchip drivers to associate an ACPI DSDT device to
an IRQ domain and provides support for using the ResourceSource
in Extended IRQ Resources to find the domain and map the IRQs
specified on that domain.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/Makefile             |   1 +
 drivers/acpi/irqdomain.c          | 141 ++++++++++++++++++++++++++++++++++++++
 drivers/acpi/resource.c           |  21 +++---
 include/asm-generic/vmlinux.lds.h |   1 +
 include/linux/acpi.h              |  71 +++++++++++++++++++
 include/linux/irqchip.h           |  17 ++++-
 6 files changed, 240 insertions(+), 12 deletions(-)
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
index 0000000..c53b9f4
--- /dev/null
+++ b/drivers/acpi/irqdomain.c
@@ -0,0 +1,141 @@
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
+ * acpi_irq_domain_ensure_probed() - Check if the device has registered
+ *                                   an IRQ domain and probe as necessary
+ *
+ * @device: Device to check and probe
+ *
+ * Returns: 0 on success, -ENODEV otherwise
+ */
+static int acpi_irq_domain_ensure_probed(struct acpi_device *device)
+{
+	struct acpi_dsdt_probe_entry *entry;
+
+	if (irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY) != 0)
+		return 0;
+
+	for (entry = &__dsdt_acpi_probe_table;
+	     entry < &__dsdt_acpi_probe_table_end; entry++)
+		if (strcmp(entry->_hid, acpi_device_hid(device)) == 0)
+			return entry->probe(device);
+
+	return -ENODEV;
+}
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
+	ret = acpi_irq_domain_ensure_probed(device);
+	if (ret)
+		goto out_put_device;
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
index 56241eb..3fb7abf 100644
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
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 3074796..f808afdc 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -563,6 +563,7 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(clksrc)					\
+	ACPI_PROBE_TABLE(dsdt)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddbeda6..bb1a838 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -26,6 +26,7 @@
 #include <linux/resource_ext.h>
 #include <linux/device.h>
 #include <linux/property.h>
+#include <linux/irqdomain.h>
 
 #ifndef _LINUX
 #define _LINUX
@@ -321,6 +322,31 @@ void acpi_set_irq_model(enum acpi_irq_model_id model,
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
@@ -1024,6 +1050,34 @@ struct acpi_probe_entry {
 					  (&ACPI_PROBE_TABLE_END(t) -	\
 					   &ACPI_PROBE_TABLE(t)));	\
 	})
+
+/* Length of Hardware ID field in DSDT entries as per ACPI spec */
+#define ACPI_HID_LEN 9
+
+typedef int (*acpi_dsdt_handler)(struct acpi_device *);
+
+/**
+ * struct acpi_probe_dsdt_entry - boot-time probing entry for DSDT devices
+ * @hid:		_HID of the device
+ * @fn:		Callback to the driver being probed
+ * @driver_data:	Sideband data provided back to the driver
+ */
+struct acpi_dsdt_probe_entry {
+	__u8 _hid[ACPI_HID_LEN];
+	acpi_dsdt_handler probe;
+};
+
+#define ACPI_DECLARE_DSDT_PROBE_ENTRY(name, hid, fn)			\
+	static const struct acpi_dsdt_probe_entry __acpi_probe_##name	\
+		__used __section(__dsdt_acpi_probe_table) =		\
+		{							\
+			._hid = hid,					\
+			.probe = fn,					\
+		}
+
+extern struct acpi_dsdt_probe_entry __dsdt_acpi_probe_table;
+extern struct acpi_dsdt_probe_entry __dsdt_acpi_probe_table_end;
+
 #else
 static inline int acpi_dev_get_property(struct acpi_device *adev,
 					const char *name, acpi_object_type type,
@@ -1101,8 +1155,25 @@ static inline struct fwnode_handle *acpi_get_next_subnode(struct device *dev,
 		     (void *) data }
 
 #define acpi_probe_device_table(t)	({ int __r = 0; __r;})
+
+#define ACPI_DECLARE_DSDT_PROBE_ENTRY(name, hid, fn)			\
+	static const void *__acpi_probe_##name[]			\
+		__attribute__((unused))				\
+		 = { (void *) hid,					\
+		     (void *) fn }
+
 #endif
 
+#define MADT_IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
+	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT,		\
+				 subtable, validate, data, fn)
+
+#define DSDT_IRQCHIP_ACPI_DECLARE(name, hid, fn)	\
+	ACPI_DECLARE_DSDT_PROBE_ENTRY(name, hid, fn)
+
+#define __IRQCHIP_ACPI_DECLARE(_a1, _a2, _a3, _a4, _a5, type, ...)	\
+	type##_IRQCHIP_ACPI_DECLARE
+
 #ifdef CONFIG_ACPI_TABLE_UPGRADE
 void acpi_table_upgrade(void);
 #else
diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index 89c34b2..c2d0c12 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -29,6 +29,10 @@
 /*
  * This macro must be used by the different irqchip drivers to declare
  * the association between their version and their initialization function.
+ * Two syntaxes are supported depending on the table where the irqchip device
+ * is declared:
+ *
+ * - MADT irqchip syntax, which requires the following five arguments:
  *
  * @name: name that must be unique accross all IRQCHIP_ACPI_DECLARE of the
  * same file.
@@ -37,10 +41,17 @@
  *            Can be NULL.
  * @data: data to be checked by the validate function.
  * @fn: initialization function
+ *
+ * - DSDT irqchip syntax, which requires the following three arguments:
+ *
+ * @name: name that must be unique across all IRQCHIP_ACPI_DECLARE of the
+ * same file.
+ * @hid: _HID of the DSDT device
+ * @fn: initialization function
  */
-#define IRQCHIP_ACPI_DECLARE(name, subtable, validate, data, fn)	\
-	ACPI_DECLARE_PROBE_ENTRY(irqchip, name, ACPI_SIG_MADT, 		\
-				 subtable, validate, data, fn)
+
+#define IRQCHIP_ACPI_DECLARE(...)					\
+	__IRQCHIP_ACPI_DECLARE(__VA_ARGS__, MADT, _unused, DSDT)(__VA_ARGS__)
 
 #ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
