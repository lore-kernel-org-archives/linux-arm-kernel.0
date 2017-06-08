From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:16 +0100
Subject: [RFT PATCH v2 16/42] PCI: versatile: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-17-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI versatile host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Rob Herring <robh@kernel.org>
---
 drivers/pci/host/pci-versatile.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 9281eee..a67cf0b 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -125,8 +125,13 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	u32 val;
 	void __iomem *local_pci_cfg_base;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	LIST_HEAD(pci_res);
 
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return -ENOMEM;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	versatile_pci_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(versatile_pci_base))
@@ -199,11 +204,20 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	pci_add_flags(PCI_ENABLE_PROC_DOMAINS);
 	pci_add_flags(PCI_REASSIGN_ALL_BUS | PCI_REASSIGN_ALL_RSRC);
 
-	bus = pci_scan_root_bus(&pdev->dev, 0, &pci_versatile_ops, NULL, &pci_res);
-	if (!bus)
-		return -ENOMEM;
+	list_splice_init(&pci_res, &bridge->windows);
+	bridge->dev.parent = &pdev->dev;
+	bridge->sysdata = NULL;
+	bridge->busnr = 0;
+	bridge->ops = &pci_versatile_ops;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
+		return ret;
+
+	bus = bridge->bus;
 
 	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
+
 	pci_assign_unassigned_bus_resources(bus);
 	list_for_each_entry(child, &bus->children, node)
 		pcie_bus_configure_settings(child);
-- 
2.10.0
