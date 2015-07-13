From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 13 Jul 2015 16:14:20 +0700
Subject: [RFCv2 PATCH 4/8] acpi: gsi: Adding acpi_init_irq_alloc_info() hook
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1436778864-17645-5-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds acpi_init_irq_alloc_info(), which is declared as
a weak symbol. This would allow arch-specific code to hook into
acpi_register_gsi().

Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
---
 drivers/acpi/gsi.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 02c8408..01a14c5 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -62,6 +62,13 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 }
 EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 
+int __weak
+acpi_init_irq_alloc_info(struct irq_domain *domain, u32 gsi,
+			 unsigned int irq_type, void **info)
+{
+	return 0;
+}
+
 /**
  * acpi_register_gsi() - Map a GSI to a linux IRQ number
  * @dev: device for which IRQ has to be mapped
@@ -75,22 +82,41 @@ EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
-	int irq;
+	unsigned int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
+	struct irq_data *d = NULL;
+	void *info = NULL;
+	int err;
 
 	irq = irq_find_mapping(acpi_irq_domain, gsi);
 	if (irq > 0)
 		return irq;
 
-	irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev),
-				    &gsi);
+	err = acpi_init_irq_alloc_info(acpi_irq_domain, gsi, irq_type, &info);
+	if (err)
+		return err;
+
+	if (!info)
+		/* Default to pass gsi directly to allocate irq */
+		info = &gsi;
+
+	irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev), info);
 	if (irq <= 0)
 		return -EINVAL;
 
+	d = irq_domain_get_irq_data(acpi_irq_domain, irq);
+	if (!d)
+		return -EFAULT;
+
 	/* Set irq type if specified and different than the current one */
 	if (irq_type != IRQ_TYPE_NONE &&
-		irq_type != irq_get_trigger_type(irq))
-		irq_set_irq_type(irq, irq_type);
+	    irq_type != irq_get_trigger_type(irq)) {
+		if (d)
+			d->chip->irq_set_type(d, irq_type);
+		else
+			irq_set_irq_type(irq, irq_type);
+	}
+
 	return irq;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
-- 
2.1.0
