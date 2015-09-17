From: dhdang@apm.com (Duc Dang)
Date: Wed, 16 Sep 2015 17:31:40 -0700
Subject: [PATCH 1/1] PCI/MSI: X-Gene: Remove msi_controller assignment in
 X-Gene PCIe driver
Message-ID: <1442449900-30842-1-git-send-email-dhdang@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With commit 8d63bc7beaee ("PCI/MSI: pci-xgene-msi: Get rid of
struct msi_controller"), it is no longer required to assign
msi_controller for X-Gene PCIe host bridge to support MSI. This
patch removes this unnecessary code and also helps avoid a warning
message ("failed to enable MSI") during boot.

Signed-off-by: Duc Dang <dhdang@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 0236ab9..ae00ce2 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -509,24 +509,6 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static int xgene_pcie_msi_enable(struct pci_bus *bus)
-{
-	struct device_node *msi_node;
-
-	msi_node = of_parse_phandle(bus->dev.of_node,
-					"msi-parent", 0);
-	if (!msi_node)
-		return -ENODEV;
-
-	bus->msi = of_pci_find_msi_chip_by_node(msi_node);
-	if (!bus->msi)
-		return -ENODEV;
-
-	of_node_put(msi_node);
-	bus->msi->dev = &bus->dev;
-	return 0;
-}
-
 static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 {
 	struct device_node *dn = pdev->dev.of_node;
@@ -567,10 +549,6 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (!bus)
 		return -ENOMEM;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		if (xgene_pcie_msi_enable(bus))
-			dev_info(port->dev, "failed to enable MSI\n");
-
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
-- 
1.9.1
