From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 17:44:03 +0100
Subject: [PATCH v3 4/8] genirq: irqdomain: Add irq_create_acpi_mapping
In-Reply-To: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442249047-21182-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to help ACPI on arm64 to make use of most of the irqdomain
goodies, add a new entry point (irq_create_acpi_mapping) which
mimics irq_create_of_mapping, except that it takes a new
struct acpi_gsi_descriptor, which is the pendent of of_phandle_args
in the OF world.

We assume that the way the acpi_gsi_descriptor is populated matches
that of of_phandle_args, as the latter is still the building block
for interrupt descriptor in the whole kernel.

Eventually, these two representations should be merged in a single
structure, but that's probably for another day.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 include/linux/acpi.h   |  9 +++++++++
 kernel/irq/irqdomain.c | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7235c48..4db2f01 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -201,6 +201,15 @@ int acpi_register_gsi (struct device *dev, u32 gsi, int triggering, int polarity
 int acpi_gsi_to_irq (u32 gsi, unsigned int *irq);
 int acpi_isa_irq_to_gsi (unsigned isa_irq, u32 *gsi);
 
+#define MAX_GSI_DESC_PARAMS 16
+struct acpi_gsi_descriptor {
+	int param_count;
+	u32 param[MAX_GSI_DESC_PARAMS];
+};
+
+unsigned int irq_create_acpi_mapping(struct irq_domain *d,
+				     struct acpi_gsi_descriptor *irq_data);
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 619552a..ca1301b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1,5 +1,6 @@
 #define pr_fmt(fmt)  "irq: " fmt
 
+#include <linux/acpi.h>
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/idr.h>
@@ -687,6 +688,23 @@ unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 }
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
 
+#ifdef CONFIG_ACPI
+unsigned int irq_create_acpi_mapping(struct irq_domain *d,
+				     struct acpi_gsi_descriptor *irq_data)
+{
+	struct of_phandle_args args;
+	int i;
+
+	for (i = 0; i < min(irq_data->param_count, MAX_PHANDLE_ARGS); i++)
+		args.args[i] = irq_data->param[i];
+
+	args.np = d ? d->domain_token : NULL;
+	args.args_count = i;
+
+	return irq_create_of_mapping(&args);
+}
+#endif
+
 /**
  * irq_dispose_mapping() - Unmap an interrupt
  * @virq: linux irq number of the interrupt to unmap
-- 
2.1.4
