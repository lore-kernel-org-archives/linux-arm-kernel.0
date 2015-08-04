From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:42 -0500
Subject: [PATCH v5 7/9] PCI: xgene: Set msi_controller->dev to
 platform_device, not pci_bus
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215442.9189.83038.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Other users of struct msi_controller set msi->dev to the platform_device of
the PCI host controller, not the device of the pci_bus for the root bus.

Set X-Gene's msi_controller->dev to the PCI host controller platform_device
as other platforms do.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 4c2fb1f..5e0d6de 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -501,7 +501,8 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static int xgene_pcie_msi_enable(struct pci_bus *bus)
+static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
+				 struct pci_bus *bus)
 {
 	struct device_node *msi_node;
 
@@ -515,7 +516,7 @@ static int xgene_pcie_msi_enable(struct pci_bus *bus)
 		return -ENODEV;
 
 	of_node_put(msi_node);
-	bus->msi->dev = &bus->dev;
+	bus->msi->dev = &port->dev;
 	return 0;
 }
 
@@ -560,7 +561,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 		return -ENOMEM;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		if (xgene_pcie_msi_enable(bus))
+		if (xgene_pcie_msi_enable(port, bus))
 			dev_info(port->dev, "failed to enable MSI\n");
 
 	pci_scan_child_bus(bus);
