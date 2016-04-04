From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon,  4 Apr 2016 10:52:54 +0200
Subject: [PATCH V4 6/7] its, pci,
 msi: Factor out code that might be reused for ACPI.
In-Reply-To: <1459759975-24097-1-git-send-email-tn@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
Message-ID: <1459759975-24097-7-git-send-email-tn@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Firmware agnostic code lands in common functions which do necessary
domain initialization based on unique domain handler. DT specific
code goes to DT specific init call.

Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 43 +++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index aee60ed..06165cb 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -106,34 +106,47 @@ static struct of_device_id its_device_id[] = {
 	{},
 };
 
-static int __init its_pci_msi_init(void)
+static int __init its_pci_msi_init_one(struct fwnode_handle *handle)
 {
-	struct device_node *np;
 	struct irq_domain *parent;
 
+	parent = irq_find_matching_fwnode(handle, DOMAIN_BUS_NEXUS);
+	if (!parent || !msi_get_domain_info(parent)) {
+		pr_err("Unable to locate ITS domain\n");
+		return -ENXIO;
+	}
+
+	if (!pci_msi_create_irq_domain(handle, &its_pci_msi_domain_info,
+				       parent)) {
+		pr_err("Unable to create PCI domain\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int __init its_pci_of_msi_init(void)
+{
+	struct device_node *np;
+
 	for (np = of_find_matching_node(NULL, its_device_id); np;
 	     np = of_find_matching_node(np, its_device_id)) {
 		if (!of_property_read_bool(np, "msi-controller"))
 			continue;
 
-		parent = irq_find_matching_host(np, DOMAIN_BUS_NEXUS);
-		if (!parent || !msi_get_domain_info(parent)) {
-			pr_err("%s: unable to locate ITS domain\n",
-			       np->full_name);
+		if (its_pci_msi_init_one(of_node_to_fwnode(np)))
 			continue;
-		}
-
-		if (!pci_msi_create_irq_domain(of_node_to_fwnode(np),
-					       &its_pci_msi_domain_info,
-					       parent)) {
-			pr_err("%s: unable to create PCI domain\n",
-			       np->full_name);
-			continue;
-		}
 
 		pr_info("PCI/MSI: %s domain created\n", np->full_name);
 	}
 
 	return 0;
 }
+
+static int __init its_pci_msi_init(void)
+{
+	its_pci_of_msi_init();
+	return 0;
+}
+
 early_initcall(its_pci_msi_init);
-- 
1.9.1
