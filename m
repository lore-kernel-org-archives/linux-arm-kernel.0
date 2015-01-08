From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  8 Jan 2015 17:06:08 +0000
Subject: [PATCH v2 4/8] PCI/MSI: of: Allow msi_domain lookup using the PHB node
In-Reply-To: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
References: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1420736772-11088-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of platforms do not need to use the msi-parent property,
as the host bridge itself provides the MSI controller.

Allow this configuration by performing an irq domain lookup based
on the PHB node if it doesn't have a valid msi-parent property.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/pci/of.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index d8d1274..75bfb85 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -68,9 +68,14 @@ void pci_set_phb_of_msi_domain(struct pci_bus *bus)
 
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
 	dev_set_msi_domain(&bus->dev, irq_find_host(np));
 #endif
 }
-- 
2.1.4
