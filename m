From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:17:59 +0100
Subject: [RFC/RFT PATCH 08/18] PCI: designware: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-9-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

Convert PCI designware host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 36 +++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 5ba3349..e43c21a 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -279,9 +279,9 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct device_node *np = dev->of_node;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	struct resource *cfg_res;
 	int i, ret;
-	LIST_HEAD(res);
 	struct resource_entry *win, *tmp;
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
@@ -294,16 +294,21 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		dev_err(dev, "missing *config* reg space\n");
 	}
 
-	ret = of_pci_get_host_bridge_resources(np, 0, 0xff, &res, &pp->io_base);
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return  -ENOMEM;
+
+	ret = of_pci_get_host_bridge_resources(np, 0, 0xff,
+					&bridge->windows, &pp->io_base);
 	if (ret)
 		return ret;
 
-	ret = devm_request_pci_bus_resources(dev, &res);
+	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
 	if (ret)
 		goto error;
 
 	/* Get the I/O and memory ranges from DT */
-	resource_list_for_each_entry_safe(win, tmp, &res) {
+	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
 		switch (resource_type(win->res)) {
 		case IORESOURCE_IO:
 			ret = pci_remap_iospace(win->res, pp->io_base);
@@ -397,19 +402,22 @@ int dw_pcie_host_init(struct pcie_port *pp)
 		pp->ops->host_init(pp);
 
 	pp->root_bus_nr = pp->busn->start;
+
+	bridge->dev.parent = dev;
+	bridge->sysdata = pp;
+	bridge->busnr = pp->root_bus_nr;
+	bridge->ops = &dw_pcie_ops;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		bus = pci_scan_root_bus_msi(dev, pp->root_bus_nr,
-					    &dw_pcie_ops, pp, &res,
-					    &dw_pcie_msi_chip);
+		bridge->msi = &dw_pcie_msi_chip;
 		dw_pcie_msi_chip.dev = dev;
-	} else
-		bus = pci_scan_root_bus(dev, pp->root_bus_nr, &dw_pcie_ops,
-					pp, &res);
-	if (!bus) {
-		ret = -ENOMEM;
-		goto error;
 	}
 
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret)
+		goto error;
+
+	bus = bridge->bus;
+
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
@@ -428,7 +436,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	return 0;
 
 error:
-	pci_free_resource_list(&res);
+	pci_free_host_bridge(bridge);
 	return ret;
 }
 
-- 
2.10.0
