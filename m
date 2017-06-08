From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:19 +0100
Subject: [RFT PATCH v2 19/42] PCI: xgene: Convert PCI scan API to
 pci_scan_root_bus_bridge()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-20-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The introduction of pci_scan_root_bus_bridge() provides a PCI core
API to scan a PCI root bus backed by an already initialized
struct pci_host_bridge object, which simplifies the bus scan
interface and makes the PCI scan root bus interface easier to
generalize as members are added to the struct pci_host_bridge.

Convert PCI xgene host code to pci_scan_root_bus_bridge() to
improve the PCI root bus scanning interface.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
---
 drivers/pci/host/pci-xgene.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 8cae013..262bedf 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -636,13 +636,16 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	struct xgene_pcie_port *port;
 	resource_size_t iobase = 0;
 	struct pci_bus *bus, *child;
+	struct pci_host_bridge *bridge;
 	int ret;
 	LIST_HEAD(res);
 
-	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
-	if (!port)
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
+	if (!bridge)
 		return -ENOMEM;
 
+	port = pci_host_bridge_priv(bridge);
+
 	port->node = of_node_get(dn);
 	port->dev = dev;
 
@@ -670,11 +673,17 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	if (ret)
 		goto error;
 
-	bus = pci_create_root_bus(dev, 0, &xgene_pcie_ops, port, &res);
-	if (!bus) {
-		ret = -ENOMEM;
+	list_splice_init(&res, &bridge->windows);
+	bridge->dev.parent = dev;
+	bridge->sysdata = port;
+	bridge->busnr = 0;
+	bridge->ops = &xgene_pcie_ops;
+
+	ret = pci_scan_root_bus_bridge(bridge);
+	if (ret < 0)
 		goto error;
-	}
+
+	bus = bridge->bus;
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
-- 
2.10.0
