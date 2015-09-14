From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 17:44:07 +0100
Subject: [PATCH v3 8/8] acpi: gsi: Cleanup acpi_register_gsi
In-Reply-To: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442249047-21182-9-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the only user of drivers/acpi/gsi.c is now using acpi_set_irq_model
to set acpi_gsi_descriptor_populate to something meaningful, we can
always rely on that information to be present (its absence is an error),
and guarantee that new interrupt controllers will use this API.

Take this opportunity to cleanup acpi_register_gsi.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/gsi.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 07f5fef5..2dde6a1 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -75,28 +75,20 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 		      int polarity)
 {
 	int err;
-	unsigned int irq;
+	struct acpi_gsi_descriptor data;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
 	struct irq_domain *d = irq_find_host(acpi_gsi_domain_token);
 
-	if (acpi_gsi_descriptor_populate) {
-		struct acpi_gsi_descriptor data;
-		err = acpi_gsi_descriptor_populate(&data, gsi, irq_type);
-		if (err)
-			return err;
-
-		return irq_create_acpi_mapping(d, &data);
+	if (WARN_ON(!acpi_gsi_descriptor_populate)) {
+		pr_warn("GSI: No registered irqchip, giving up\n");
+		return -EINVAL;
 	}
 
-	irq = irq_create_mapping(d, gsi);
-	if (!irq)
-		return -EINVAL;
+	err = acpi_gsi_descriptor_populate(&data, gsi, irq_type);
+	if (err)
+		return err;
 
-	/* Set irq type if specified and different than the current one */
-	if (irq_type != IRQ_TYPE_NONE &&
-		irq_type != irq_get_trigger_type(irq))
-		irq_set_irq_type(irq, irq_type);
-	return irq;
+	return irq_create_acpi_mapping(d, &data);
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
-- 
2.1.4
