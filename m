From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 28 Sep 2015 17:42:58 +0100
Subject: [PATCH v4 5/9] acpi/gsi: Add acpi_set_irq_model to initialize the GSI
 layer
In-Reply-To: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
References: <1443458582-7497-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1443458582-7497-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to start embrassing irqdomains at the GSI level, introduce
a new initializer:

void acpi_set_irq_model(enum acpi_irq_model_id model,
			struct fwnode_handle *fwnode,
			int (*populate)(struct acpi_gsi_descriptor *,
					u32, unsigned int));

where:
- model is the value assigned to acpi_irq_model
- fwnode is the identifier for the irqdomain mapping
  GSI interrupts
- populate is a function provided by the interrupt controller,
  populating a struct acpi_gsi_descriptor based on a GSI and
  the interrupt trigger information

As nobody calls this code yet, the current code is left in place.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/gsi.c   | 32 ++++++++++++++++++++++++++++++++
 include/linux/acpi.h |  5 +++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 6232d55..7905840 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -17,6 +17,9 @@ enum acpi_irq_model_id acpi_irq_model;
 
 static struct device_node *acpi_gsi_domain_id;
 
+static int (*acpi_gsi_descriptor_populate)(struct acpi_gsi_descriptor *data,
+					   u32 gsi, unsigned int irq_type);
+
 static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
 {
 	switch (polarity) {
@@ -72,10 +75,20 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
+	int err;
 	unsigned int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
 	struct irq_domain *d = irq_find_host(acpi_gsi_domain_id);
 
+	if (acpi_gsi_descriptor_populate) {
+		struct acpi_gsi_descriptor data;
+		err = acpi_gsi_descriptor_populate(&data, gsi, irq_type);
+		if (err)
+			return err;
+
+		return irq_create_acpi_mapping(d, &data);
+	}
+
 	irq = irq_create_mapping(d, gsi);
 	if (!irq)
 		return -EINVAL;
@@ -100,3 +113,22 @@ void acpi_unregister_gsi(u32 gsi)
 	irq_dispose_mapping(irq);
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
+/**
+ * acpi_set_irq_model - Setup the GSI irqdomain information
+ * @model: the value assigned to acpi_irq_model
+ * @fwnode: the irq_domain identifier for mapping and looking up
+ *          GSI interrupts
+ * @populate: provided by the interrupt controller, populating a
+ *            struct acpi_gsi_descriptor based on a GSI and
+ *            the interrupt trigger information
+ */
+void __init acpi_set_irq_model(enum acpi_irq_model_id model,
+			       struct fwnode_handle *fwnode,
+			       int (*populate)(struct acpi_gsi_descriptor *,
+					       u32, unsigned int))
+{
+	acpi_irq_model = model;
+	acpi_gsi_domain_id = to_of_node(fwnode);
+	acpi_gsi_descriptor_populate = populate;
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4db2f01..1423b21 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -210,6 +210,11 @@ struct acpi_gsi_descriptor {
 unsigned int irq_create_acpi_mapping(struct irq_domain *d,
 				     struct acpi_gsi_descriptor *irq_data);
 
+void acpi_set_irq_model(enum acpi_irq_model_id model,
+			struct fwnode_handle *fwnode,
+			int (*populate)(struct acpi_gsi_descriptor *,
+					u32, unsigned int));
+
 #ifdef CONFIG_X86_IO_APIC
 extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
 #else
-- 
2.1.4
