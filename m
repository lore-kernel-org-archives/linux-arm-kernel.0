From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 18:52:15 +0100
Subject: [PATCH 3/4] PCI/MSI: Add support for the new definition of
 "msi-parent"
In-Reply-To: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1442944336-11754-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 126b16e2ad98 ("Docs: dt: add generic MSI bindings"),
the definition of "msi-parent" has evolved, while maintaining
some degree of compatibility. It can now express multiple MSI
controllers as parents, as well as some sideband data being
communicated to the controller.

This patch revamps the parsing of the property, iterating over
the multiple parents until a suitable irqdomain is found.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 2e99a50..c3c6c18 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -64,27 +64,38 @@ struct device_node * __weak pcibios_get_phb_of_node(struct pci_bus *bus)
 struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
 {
 #ifdef CONFIG_IRQ_DOMAIN
-	struct device_node *np;
+	struct of_phandle_args args;
 	struct irq_domain *d;
+	int index = 0;
 
 	if (!bus->dev.of_node)
 		return NULL;
 
 	/* Start looking for a phandle to an MSI controller. */
-	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
+	while (!of_parse_phandle_with_opt_args(bus->dev.of_node,
+					       "msi-parent", "#msi-cells",
+					       index, &args)) {
+		d = irq_find_matching_host(args.np, DOMAIN_BUS_PCI_MSI);
+		if (d)
+			return d;
+
+		d = irq_find_host(args.np);
+		if (d)
+			return d;
+
+		of_node_put(args.np);
+		index++;
+	}
 
 	/*
 	 * If we don't have an msi-parent property, look for a domain
 	 * directly attached to the host bridge.
 	 */
-	if (!np)
-		np = bus->dev.of_node;
-
-	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
+	d = irq_find_matching_host(bus->dev.of_node, DOMAIN_BUS_PCI_MSI);
 	if (d)
 		return d;
 
-	return irq_find_host(np);
+	return irq_find_host(bus->dev.of_node);
 #else
 	return NULL;
 #endif
-- 
2.1.4
