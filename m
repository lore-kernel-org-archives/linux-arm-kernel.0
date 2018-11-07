From: rrichter@cavium.com (Robert Richter)
Date: Wed, 7 Nov 2018 22:03:18 +0000
Subject: [PATCH 03/10] irqchip/irq-gic-v3-its-pci-msi: Remove domain init
 order dependencies
In-Reply-To: <20181107220254.6116-1-rrichter@cavium.com>
References: <20181107220254.6116-1-rrichter@cavium.com>
Message-ID: <20181107220254.6116-4-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use new irq_domain_request_host_*() interface which allows independent
parent and child initialization using an irq domain request handler.
This makes it possible to move its initialization to a later point
during boot. All domains can be initialized in the same initcall level
then.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 66 ++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index 8d6d009d1d58..7d7366d55d34 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -116,27 +116,50 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
-				       const char *name)
+static int __init its_pci_create_irq_domain(struct irq_domain *parent,
+					void *priv)
 {
-	struct irq_domain *parent;
+	char *name = priv;
+	int err = 0;
 
-	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
-	if (!parent || !msi_get_domain_info(parent)) {
-		pr_err("%s: Unable to locate ITS domain\n", name);
-		return -ENXIO;
+	if (!msi_get_domain_info(parent)) {
+		err = -ENODEV;
+		goto out;
 	}
 
-	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
+	if (!pci_msi_create_irq_domain(parent->fwnode, &its_pci_msi_domain_info,
 				       parent)) {
-		pr_err("%s: Unable to create PCI domain\n", name);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
-	return 0;
+	pr_info("PCI/MSI: %s domain created\n", name);
+out:
+	if (err)
+		pr_err("PCI/MSI: Failed to create %s domain: %d\n", name, err);
+
+	kfree(name);
+	return err;
+}
+
+static int __init its_pci_msi_init_one(struct fwnode_handle *handle,
+				       const char *name)
+{
+	void *priv = kstrdup(name, GFP_KERNEL);
+	int err;
+
+	err = irq_domain_request_fwnode(handle, DOMAIN_BUS_NEXUS,
+					its_pci_create_irq_domain, name, priv);
+	if (err) {
+		pr_err("PCI/MSI: Failed to register %s domain: %d\n",
+			name, err);
+		kfree(priv);
+	}
+
+	return err;
 }
 
-static int __init its_pci_of_msi_init(void)
+static void __init its_pci_of_msi_init(void)
 {
 	struct device_node *np;
 
@@ -147,13 +170,8 @@ static int __init its_pci_of_msi_init(void)
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		if (its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name))
-			continue;
-
-		pr_info("PCI/MSI: %pOF domain created\n", np);
+		its_pci_msi_init_one(of_node_to_fwnode(np), np->full_name);
 	}
-
-	return 0;
 }
 
 #ifdef CONFIG_ACPI
@@ -177,32 +195,24 @@ its_pci_msi_parse_madt(struct acpi_subtable_header *header,
 	}
 
 	err = its_pci_msi_init_one(dom_handle, node_name);
-	if (!err)
-		pr_info("PCI/MSI: %s domain created\n", node_name);
-
 out:
 	kfree(node_name);
 	return err;
 }
 
-static int __init its_pci_acpi_msi_init(void)
+static void __init its_pci_acpi_msi_init(void)
 {
 	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_TRANSLATOR,
 			      its_pci_msi_parse_madt, 0);
-	return 0;
 }
 #else
-static int __init its_pci_acpi_msi_init(void)
-{
-	return 0;
-}
+static void __init its_pci_acpi_msi_init(void) { }
 #endif
 
 static int __init its_pci_msi_init(void)
 {
 	its_pci_of_msi_init();
 	its_pci_acpi_msi_init();
-
 	return 0;
 }
 early_initcall(its_pci_msi_init);
-- 
2.11.0
