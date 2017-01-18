From: agustinv@codeaurora.org (Agustin Vega-Frias)
Date: Wed, 18 Jan 2017 11:46:26 -0500
Subject: [PATCH V10 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI IRQs
 during bus scan
In-Reply-To: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
Message-ID: <1484757988-23739-2-git-send-email-agustinv@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI extended IRQ resources may contain a Resource Source field to specify
an alternate interrupt controller, attempting to map them as GSIs is
incorrect, so just disable the platform resource.

Since this field is currently ignored, we make this change conditional
on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
in case some existing ACPI tables are using this incorrectly.

Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
---
 drivers/acpi/resource.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index cb57962..69cd430 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -43,6 +43,19 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
 acpi_iospace_resource_valid(struct resource *res) { return true; }
 #endif
 
+#ifdef CONFIG_ACPI_GENERIC_GSI
+static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
+{
+	return ext_irq->resource_source.string_length == 0 &&
+	       ext_irq->producer_consumer == ACPI_CONSUMER;
+}
+#else
+static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
+{
+	return true;
+}
+#endif
+
 static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
 {
 	u64 reslen = end - start + 1;
@@ -470,9 +483,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 			acpi_dev_irqresource_disabled(res, 0);
 			return false;
 		}
-		acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
+		if (is_gsi(ext_irq))
+			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->sharable, false);
+		else
+			acpi_dev_irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
