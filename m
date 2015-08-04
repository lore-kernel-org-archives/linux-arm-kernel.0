From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 04 Aug 2015 16:54:57 -0500
Subject: [PATCH v5 9/9] PCI: xgene: Use pci_scan_root_bus_msi()
In-Reply-To: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150804214234.9189.42548.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Message-ID: <20150804215457.9189.27595.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previously there was no way to specify the MSI controller when creating a
new PCI root bus, so we had to create the bus, set its MSI controller, then
scan the bus.  With the new pci_scan_root_bus_msi() interface, we can
specify the MSI controller up front and get rid of that intermediate step.

Look up the MSI controller first, then use pci_scan_root_bus_msi() to
create and scan the root PCI bus.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 3cb58a3..514f41b 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -68,6 +68,7 @@
 struct xgene_pcie_port {
 	struct device_node	*node;
 	struct device		*dev;
+	struct msi_controller	*msi;
 	struct clk		*clk;
 	void __iomem		*csr_base;
 	void __iomem		*cfg_base;
@@ -501,8 +502,7 @@ static int xgene_pcie_setup(struct xgene_pcie_port *port,
 	return 0;
 }
 
-static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
-				 struct pci_bus *bus)
+static int xgene_pcie_msi_enable(struct xgene_pcie_port *port)
 {
 	struct device_node *msi_node;
 
@@ -510,12 +510,12 @@ static int xgene_pcie_msi_enable(struct xgene_pcie_port *port,
 	if (!msi_node)
 		return -ENODEV;
 
-	bus->msi = of_pci_find_msi_chip_by_node(msi_node);
-	if (!bus->msi)
+	port->msi = of_pci_find_msi_chip_by_node(msi_node);
+	if (!port->msi)
 		return -ENODEV;
 
 	of_node_put(msi_node);
-	bus->msi->dev = &port->dev;
+	port->msi->dev = &port->dev;
 	return 0;
 }
 
@@ -554,16 +554,15 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	bus = pci_create_root_bus(&pdev->dev, 0,
-					&xgene_pcie_ops, port, &res);
-	if (!bus)
-		return -ENOMEM;
-
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		if (xgene_pcie_msi_enable(port, bus))
+		if (xgene_pcie_msi_enable(port))
 			dev_info(port->dev, "failed to enable MSI\n");
 
-	pci_scan_child_bus(bus);
+	bus = pci_scan_root_bus_msi(&pdev->dev, 0, &xgene_pcie_ops, port,
+				    &res, port->msi);
+	if (!bus)
+		return -ENOMEM;
+
 	pci_assign_unassigned_bus_resources(bus);
 	pci_bus_add_devices(bus);
 
