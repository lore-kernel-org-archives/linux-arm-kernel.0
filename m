From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 11 Jan 2017 23:06:31 +0800
Subject: [PATCH v7 07/15] irqchip: gicv3-its: platform-msi: scan MADT to
 create platform msi domain
In-Reply-To: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
References: <1484147199-4267-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1484147199-4267-8-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of its_pmsi_init_one(), we can add some code
on top for ACPI support of platform MSI.

We are scanning the MADT table to get the ITS entry(ies), then use
the information to create the platform msi domain for devices connect
to it, just like the PCI MSI for ITS did.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Tomasz Nowicki <tn@semihalf.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its-platform-msi.c | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-platform-msi.c b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
index 3d9efd1..ebe933e 100644
--- a/drivers/irqchip/irq-gic-v3-its-platform-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-platform-msi.c
@@ -103,6 +103,41 @@ static int __init its_pmsi_init_one(struct fwnode_handle *fwnode,
 	return 0;
 }
 
+#ifdef CONFIG_ACPI
+static int __init
+its_pmsi_parse_madt(struct acpi_subtable_header *header,
+			const unsigned long end)
+{
+	struct acpi_madt_generic_translator *its_entry;
+	struct fwnode_handle *domain_handle;
+	const char *node_name;
+	int err = -ENXIO;
+
+	its_entry = (struct acpi_madt_generic_translator *)header;
+	node_name = kasprintf(GFP_KERNEL, "ITS at 0x%lx",
+			      (long)its_entry->base_address);
+	domain_handle = iort_find_domain_token(its_entry->translation_id);
+	if (!domain_handle) {
+		pr_err("%s: Unable to locate ITS domain handle\n", node_name);
+		goto out;
+	}
+
+	err = its_pmsi_init_one(domain_handle, node_name);
+
+out:
+	kfree(node_name);
+	return err;
+}
+
+static void __init its_pmsi_acpi_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
+			      its_pmsi_parse_madt, 0);
+}
+#else
+static inline void its_pmsi_acpi_init(void) { }
+#endif
+
 static void __init its_pmsi_of_init(void)
 {
 	struct device_node *np;
@@ -119,6 +154,7 @@ static void __init its_pmsi_of_init(void)
 static int __init its_pmsi_init(void)
 {
 	its_pmsi_of_init();
+	its_pmsi_acpi_init();
 	return 0;
 }
 early_initcall(its_pmsi_init);
-- 
1.9.1
