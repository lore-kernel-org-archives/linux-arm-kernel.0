From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:09 +0800
Subject: [PATCH 15/20] ACPI / ARM64: Update acpi_register_gsi to register with
 the core IRQ subsystem
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-16-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This API is similar to DT based irq_of_parse_and_map but does link
parent/child IRQ controllers. This is tested for primary GIC PPI and GIC SPI
interrupts and not for secondary child irq controllers.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 drivers/acpi/plat/arm-core.c |   48 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/plat/arm-core.c b/drivers/acpi/plat/arm-core.c
index 2ff00b0..22c8235 100644
--- a/drivers/acpi/plat/arm-core.c
+++ b/drivers/acpi/plat/arm-core.c
@@ -84,7 +84,7 @@ enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
 
 static unsigned int gsi_to_irq(unsigned int gsi)
 {
-	int irq = irq_create_mapping(NULL, gsi);
+	int irq = irq_find_mapping(NULL, gsi);
 
 	return irq;
 }
@@ -350,7 +350,51 @@ EXPORT_SYMBOL(acpi_unregister_ioapic);
  */
 int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
 {
-	return -1;
+	unsigned int irq;
+	unsigned int irq_type;
+
+	/*
+	 * ACPI have no bindings to indicate SPI or PPI, so we
+	 * use different mappings from DT in ACPI.
+	 *
+	 * For FDT
+	 * PPI interrupt: in the range [0, 15];
+	 * SPI interrupt: in the range [0, 987];
+	 *
+	 * For ACPI, GSI should be unique so using
+	 * identity mapping for hwirq:
+	 * PPI interrupt: in the range [16, 31];
+	 * SPI interrupt: in the range [32, 1019];
+	 */
+
+	if (trigger == ACPI_EDGE_SENSITIVE &&
+				polarity == ACPI_ACTIVE_LOW)
+		irq_type = IRQ_TYPE_EDGE_FALLING;
+	else if (trigger == ACPI_EDGE_SENSITIVE &&
+				polarity == ACPI_ACTIVE_HIGH)
+		irq_type = IRQ_TYPE_EDGE_RISING;
+	else if (trigger == ACPI_LEVEL_SENSITIVE &&
+				polarity == ACPI_ACTIVE_LOW)
+		irq_type = IRQ_TYPE_LEVEL_LOW;
+	else if (trigger == ACPI_LEVEL_SENSITIVE &&
+				polarity == ACPI_ACTIVE_HIGH)
+		irq_type = IRQ_TYPE_LEVEL_HIGH;
+	else
+		irq_type = IRQ_TYPE_NONE;
+
+	/*
+	 * Since only one GIC is supported in ACPI 5.0, we can
+	 * create mapping refer to the default domain
+	 */
+	irq = irq_create_mapping(NULL, gsi);
+	if (!irq)
+		return irq;
+
+	/* Set irq type if specified and different than the current one */
+	if (irq_type != IRQ_TYPE_NONE &&
+		irq_type != irq_get_trigger_type(irq))
+		irq_set_irq_type(irq, irq_type);
+	return irq;
 }
 EXPORT_SYMBOL_GPL(acpi_register_gsi);
 
-- 
1.7.9.5
