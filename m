From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue,  7 Jul 2015 18:17:56 +0100
Subject: [PATCH v3 06/15] PCI/MSI: of: Allow msi_domain lookup using the host
 bridge node
In-Reply-To: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
References: <1436289485-28230-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1436289485-28230-7-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of platforms do not need to use the msi-parent property,
as the host bridge itself provides the MSI controller.

Allow this configuration by performing an irq domain lookup based
on the host bridge node if it doesn't have a valid msi-parent property.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 09df465..9d61cef 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -69,9 +69,14 @@ void pci_set_phb_of_msi_domain(struct pci_bus *bus)
 
 	if (!bus->dev.of_node)
 		return;
+	/* Start looking for a phandle to an MSI controller. */
 	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
+	/*
+	 * If we don't have an msi-parent property, look for a domain
+	 * directly attached to the host bridge.
+	 */
 	if (!np)
-		return;
+		np = bus->dev.of_node;
 	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
 	if (!d)
 		d = irq_find_host(np);
-- 
2.1.4
