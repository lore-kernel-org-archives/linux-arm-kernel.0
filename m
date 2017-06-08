From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:17 +0100
Subject: [RFT PATCH v2 17/42] PCI: altera: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-18-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI altera host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ley Foon Tan <lftan@altera.com>
---
 drivers/pci/host/pcie-altera.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pcie-altera.c b/drivers/pci/host/pcie-altera.c
index 75ec5ce..7f023b2 100644
--- a/drivers/pci/host/pcie-altera.c
+++ b/drivers/pci/host/pcie-altera.c
@@ -579,12 +579,14 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	struct altera_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
+	struct pci_host_bridge *bridge;
 	int ret;
 
-	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
-	if (!pcie)
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
 		return -ENOMEM;
 
+	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
 
 	ret = altera_pcie_parse_dt(pcie);
@@ -613,12 +615,20 @@ static int altera_pcie_probe(struct platform_device *pdev)
 	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
 	altera_pcie_host_init(pcie);
 
-	bus = pci_scan_root_bus(dev, pcie->root_bus_nr, &altera_pcie_ops,
-				pcie, &pcie->resources);
-	if (!bus)
-		return -ENOMEM;
+	list_splice_init(&pcie->resources, &bridge->windows);
+	bridge->dev.parent = dev;
+	bridge->sysdata = pcie;
+	bridge->busnr = pcie->root_bus_nr;
+	bridge->ops = &altera_pcie_ops;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
+		return ret;
+
+	bus = bridge->bus;
 
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+
 	pci_assign_unassigned_bus_resources(bus);
 
 	/* Configure PCI Express setting. */
-- 
2.10.0
