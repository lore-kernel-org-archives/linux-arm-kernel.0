From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Sep 2015 17:44:04 +0100
Subject: [PATCH v3 5/8] acpi: gsi: Always perform an irq domain lookup
In-Reply-To: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442249047-21182-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of directly passing NULL to the various irq_domain functions,
start by looking up the domain with a domain_token.

As domain_token is permanently set to NULL, the lookup function will
return the same value (no domain found) and the default will be used,
preserving the current behaviour.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/acpi/gsi.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/gsi.c b/drivers/acpi/gsi.c
index 38208f2..b2af93b 100644
--- a/drivers/acpi/gsi.c
+++ b/drivers/acpi/gsi.c
@@ -14,6 +14,8 @@
 
 enum acpi_irq_model_id acpi_irq_model;
 
+static void *acpi_gsi_domain_token;
+
 static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
 {
 	switch (polarity) {
@@ -45,12 +47,9 @@ static unsigned int acpi_gsi_get_irq_type(int trigger, int polarity)
  */
 int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
 {
-	/*
-	 * Only default domain is supported at present, always find
-	 * the mapping corresponding to default domain by passing NULL
-	 * as irq_domain parameter
-	 */
-	*irq = irq_find_mapping(NULL, gsi);
+	struct irq_domain *d = irq_find_host(acpi_gsi_domain_token);
+
+	*irq = irq_find_mapping(d, gsi);
 	/*
 	 * *irq == 0 means no mapping, that should
 	 * be reported as a failure
@@ -74,13 +73,9 @@ int acpi_register_gsi(struct device *dev, u32 gsi, int trigger,
 {
 	unsigned int irq;
 	unsigned int irq_type = acpi_gsi_get_irq_type(trigger, polarity);
+	struct irq_domain *d = irq_find_host(acpi_gsi_domain_token);
 
-	/*
-	 * There is no way at present to look-up the IRQ domain on ACPI,
-	 * hence always create mapping referring to the default domain
-	 * by passing NULL as irq_domain parameter
-	 */
-	irq = irq_create_mapping(NULL, gsi);
+	irq = irq_create_mapping(d, gsi);
 	if (!irq)
 		return -EINVAL;
 
@@ -98,7 +93,8 @@ EXPORT_SYMBOL_GPL(acpi_register_gsi);
  */
 void acpi_unregister_gsi(u32 gsi)
 {
-	int irq = irq_find_mapping(NULL, gsi);
+	struct irq_domain *d = irq_find_host(acpi_gsi_domain_token);
+	int irq = irq_find_mapping(d, gsi);
 
 	irq_dispose_mapping(irq);
 }
-- 
2.1.4
