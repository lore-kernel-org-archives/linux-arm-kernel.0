From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 29 Jun 2018 11:16:20 +0200
Subject: [PATCH 2/2] PCI: aardvark: Convert to use pci_host_probe()
In-Reply-To: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
References: <20180629091620.31503-1-thomas.petazzoni@bootlin.com>
Message-ID: <20180629091620.31503-3-thomas.petazzoni@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the pci_bus_size_bridges() call has been added to
advk_pcie_probe(), the end of the function is exactly an open-coded
version of pci_host_probe(). So instead of duplicating this code, use
pci_host_probe() directly.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8e92231214e3..cea79e5ccd5d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -1000,7 +1000,6 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct advk_pcie *pcie;
 	struct resource *res;
-	struct pci_bus *bus, *child;
 	struct pci_host_bridge *bridge;
 	int ret, irq;
 
@@ -1056,22 +1055,13 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	bridge->map_irq = of_irq_parse_and_map_pci;
 	bridge->swizzle_irq = pci_common_swizzle;
 
-	ret = pci_scan_root_bus_bridge(bridge);
+	ret = pci_host_probe(bridge);
 	if (ret < 0) {
 		advk_pcie_remove_msi_irq_domain(pcie);
 		advk_pcie_remove_irq_domain(pcie);
 		return ret;
 	}
 
-	bus = bridge->bus;
-
-	pci_bus_size_bridges(bus);
-	pci_bus_assign_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	pci_bus_add_devices(bus);
 	return 0;
 }
 
-- 
2.14.4
