From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue,  5 May 2015 21:50:54 +0800
Subject: [RFC PATCH 6/9] ACPI / gsi: Add gsi_mutex to synchronize
 acpi_register_gsi()/acpi_unregister_gsi()
In-Reply-To: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
References: <1430833857-30736-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1430833857-30736-7-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a mutex for acpi_register_gsi()/acpi_unregister_gsi() to avoid
concurrency issues.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/gsi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index f4110d8..f0f219c 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -14,6 +14,7 @@
 
 enum acpi_irq_model_id acpi_irq_model;
 struct irq_domain *acpi_irq_domain;
+static DEFINE_MUTEX(gsi_mutex);
 
 static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
 {
@@ -71,20 +72,24 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 	int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
 
+	mutex_lock(&gsi_mutex);
 	irq = irq_find_mapping(acpi_irq_domain, gsi);
 	if (irq > 0)
-		return irq;
+		goto out;
 
 	irq = irq_domain_alloc_irqs(acpi_irq_domain, 1, dev_to_node(dev),
 				    &gsi);
 	if (irq <= 0)
-		return -EINVAL;
+		goto out;
 
 	/* Set irq type if specified and different than the current one */
 	if (irq_type != IRQ_TYPE_NONE &&
 		irq_type != irq_get_trigger_type(irq))
 		irq_set_irq_type(irq, irq_type);
-	return irq;
+
+out:
+	mutex_unlock(&gsi_mutex);
+	return irq > 0 ? irq : -EINVAL;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
@@ -94,8 +99,12 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	int irq = irq_find_mapping(acpi_irq_domain, gsi);
+	int irq;
+
+	mutex_lock(&gsi_mutex);
+	irq = irq_find_mapping(acpi_irq_domain, gsi);
 
 	irq_dispose_mapping(irq);
+	mutex_unlock(&gsi_mutex);
 }
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
-- 
1.9.1
