From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:18:01 +0100
Subject: [RFC/RFT PATCH 10/18] PCI: rcar: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-11-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

Convert PCI rcar host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index cb07c45..051b4db 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -451,27 +451,35 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	struct pci_bus *bus, *child;
-	LIST_HEAD(res);
+	struct pci_host_bridge *bridge;
+	int ret;
+
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge)
+		return -ENOMEM;
 
 	/* Try setting 5 GT/s link speed */
 	rcar_pcie_force_speedup(pcie);
 
-	rcar_pcie_setup(&res, pcie);
+	rcar_pcie_setup(&bridge->windows, pcie);
 
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC | PCI_REASSIGN_ALL_BUS);
 
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = pcie->root_bus_nr;
+	bridge->ops = &rcar_pcie_ops;
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		bus = pci_scan_root_bus_msi(dev, pcie->root_bus_nr,
-				&rcar_pcie_ops, pcie, &res, &pcie->msi.chip);
-	else
-		bus = pci_scan_root_bus(dev, pcie->root_bus_nr,
-				&rcar_pcie_ops, pcie, &res);
+		bridge->msi = &pcie->msi.chip;
 
-	if (!bus) {
-		dev_err(dev, "Scanning rootbus failed");
-		return -ENODEV;
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0) {
+		kfree(bridge);
+		return ret;
 	}
 
+	bus = bridge->bus;
+
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 
 	pci_bus_size_bridges(bus);
-- 
2.10.0
