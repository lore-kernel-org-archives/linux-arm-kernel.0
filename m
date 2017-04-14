From: fu.wei@linaro.org (fu.wei at linaro.org)
Date: Sat, 15 Apr 2017 02:40:11 +0800
Subject: [PATCH v24 08/11] acpi: Introduce acpi_unregister_irq function
In-Reply-To: <20170414184014.8524-1-fu.wei@linaro.org>
References: <20170414184014.8524-1-fu.wei@linaro.org>
Message-ID: <20170414184014.8524-9-fu.wei@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fu Wei <fu.wei@linaro.org>

This patch introduces acpi_unregister_irq function to free a
linux IRQ number<->GSI mapping by a given linux IRQ number.

Even we have successfully registered the GSI, when some error occurs, we
may need to unmap it for freeing the IRQ resource. But in some cases, we
only have IRQ, but not GSI.

This patch is the preparation for memory-mapped timer support in GTDT
driver.

Signed-off-by: Fu Wei <fu.wei@linaro.org>
---
 drivers/acpi/irq.c   | 10 ++++++++++
 include/linux/acpi.h |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
index 830299a..59de777 100644
--- a/drivers/acpi/irq.c
+++ b/drivers/acpi/irq.c
@@ -85,6 +85,16 @@ void acpi_unregister_gsi(u32 gsi)
 EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
 
 /**
+ * acpi_unregister_irq() - Free a linux IRQ number<->GSI mapping
+ * @irq: linux IRQ number
+ */
+void acpi_unregister_irq(int irq)
+{
+	irq_dispose_mapping(irq);
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_irq);
+
+/**
  * acpi_get_irq_source_fwhandle() - Retrieve fwhandle from IRQ resource source.
  * @source: acpi_resource_source to use for the lookup.
  *
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4b5c146..728d1ed 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -336,6 +336,13 @@ extern int acpi_get_override_irq(u32 gsi, int *trigger, int *polarity);
  */
 void acpi_unregister_gsi (u32 gsi);
 
+/*
+ * This function undoes the effect of one call to acpi_register_gsi().
+ * The irq should be the return value of acpi_register_gsi().
+ * If the irq is valid, free a linux IRQ number<->GSI mapping.
+ */
+void acpi_unregister_irq(int irq);
+
 struct pci_dev;
 
 int acpi_pci_irq_enable (struct pci_dev *dev);
-- 
2.9.3
