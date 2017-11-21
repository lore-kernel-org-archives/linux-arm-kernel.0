From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Nov 2017 15:49:31 +0000
Subject: [PATCH] PCI: xgene: Remove leftover pci_scan_child_bus() call
Message-ID: <20171121154931.7724-1-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changes in commit 9af275be15f7 ("PCI: xgene: Convert PCI scan API to
pci_scan_root_bus_bridge()") converted the xgene PCI host driver to
the new pci_scan_root_bus_bridge() bus scanning API but erroneously left
the existing pci_scan_child_bus() call in place which resulted in duplicate
PCI bus enumerations.

Remove the leftover pci_scan_child_bus() call to properly complete the API
conversion.

Fixes: 9af275be15f7 ("PCI: xgene: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 465aa2a..e60c457 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -668,7 +668,6 @@ static int xgene_pcie_probe(struct platform_device *pdev)
 
 	bus = bridge->bus;
 
-	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
-- 
2.9.5
