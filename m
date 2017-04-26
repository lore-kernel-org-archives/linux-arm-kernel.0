From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 26 Apr 2017 12:18:00 +0100
Subject: [RFC/RFT PATCH 09/18] PCI: aardvark: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
References: <20170426111809.19922-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170426111809.19922-10-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge().

Convert PCI aardvark host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
---
 drivers/pci/host/pci-aardvark.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-aardvark.c b/drivers/pci/host/pci-aardvark.c
index 4fce494..ee6fd51 100644
--- a/drivers/pci/host/pci-aardvark.c
+++ b/drivers/pci/host/pci-aardvark.c
@@ -917,6 +917,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	struct advk_pcie *pcie;
 	struct resource *res;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	struct msi_controller *msi;
 	struct device_node *msi_node;
 	int ret, irq;
@@ -968,14 +969,25 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	else
 		msi = NULL;
 
-	bus = pci_scan_root_bus_msi(dev, 0, &advk_pcie_ops,
-				    pcie, &pcie->resources, &pcie->msi);
-	if (!bus) {
-		advk_pcie_remove_msi_irq_domain(pcie);
-		advk_pcie_remove_irq_domain(pcie);
-		return -ENOMEM;
+	bridge = pci_alloc_host_bridge(0);
+	if (!bridge) {
+		ret = -ENOMEM;
+		goto error;
 	}
 
+	list_splice_init(&pcie->resources, &bridge->windows);
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = 0;
+	bridge->ops = &advk_pcie_ops;
+	bridge->msi = &pcie->msi;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
+		goto error_bridge;
+
+	bus = bridge->bus;
+
 	pci_bus_assign_resources(bus);
 
 	list_for_each_entry(child, &bus->children, node)
@@ -983,6 +995,15 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	pci_bus_add_devices(bus);
 	return 0;
+
+ error_bridge:
+	pci_free_host_bridge(bridge);
+
+ error:
+	advk_pcie_remove_msi_irq_domain(pcie);
+	advk_pcie_remove_irq_domain(pcie);
+
+	return ret;
 }
 
 static const struct of_device_id advk_pcie_of_match_table[] = {
-- 
2.10.0
