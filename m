From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Mar 2015 20:39:41 +0800
Subject: [PATCH v10 15/21] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
In-Reply-To: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1426077587-1561-16-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce ACPI_IRQ_MODEL_GIC which is needed for ARM64 as GIC is
used, and then register device's gsi with the core IRQ subsystem.

acpi_register_gsi() is similar to DT based irq_of_parse_and_map(),
since gsi is unique in the system, so use hwirq number directly
for the mapping.

We are going to implement stacked domains when GICv2m, GICv3, ITS
support are added.

CC: Marc Zyngier <marc.zyngier@arm.com>
Originally-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Tested-by: Yijing Wang <wangyijing@huawei.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
Tested-by: Jon Masters <jcm@redhat.com>
Tested-by: Timur Tabi <timur@codeaurora.org>
Tested-by: Robert Richter <rrichter@cavium.com>
Acked-by: Robert Richter <rrichter@cavium.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Grant Likely <grant.likely@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c       |  3 ++
 include/linux/acpi.h     |  1 +
 3 files changed, 77 insertions(+)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index c9203c0..dec6f8a 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -76,6 +76,12 @@ static int __init dt_scan_depth1_nodes(unsigned long node,
 }
 
 /*
+ * Since we're on ARM, the default interrupt routing model
+ * clearly has to be GIC.
+ */
+enum acpi_irq_model_id acpi_irq_model = ACPI_IRQ_MODEL_GIC;
+
+/*
  * __acpi_map_table() will be called before page_init(), so early_ioremap()
  * or early_memremap() should be called here to for ACPI table mapping.
  */
@@ -218,6 +224,73 @@ void __init acpi_init_cpus(void)
 	pr_info("%d CPUs enabled, %d CPUs total\n", enabled_cpus, total_cpus);
 }
 
+int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
+{
+	*irq = irq_find_mapping(NULL, gsi);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
+
+/*
+ * success: return IRQ number (>0)
+ * failure: return =< 0
+ */
+int acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
+{
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
+	 * the hwirq directly for the mapping:
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
+}
+EXPORT_SYMBOL_GPL(acpi_register_gsi);
+
+void acpi_unregister_gsi(u32 gsi)
+{
+}
+EXPORT_SYMBOL_GPL(acpi_unregister_gsi);
+
 static int __init acpi_parse_fadt(struct acpi_table_header *table)
 {
 	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 8b67bd0..c412fdb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -448,6 +448,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_IOSAPIC:
 		message = "IOSAPIC";
 		break;
+	case ACPI_IRQ_MODEL_GIC:
+		message = "GIC";
+		break;
 	case ACPI_IRQ_MODEL_PLATFORM:
 		message = "platform specific model";
 		break;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6ec33c5..de4e86f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -73,6 +73,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOAPIC,
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
+	ACPI_IRQ_MODEL_GIC,
 	ACPI_IRQ_MODEL_COUNT
 };
 
-- 
1.9.1
