From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 08 Feb 2017 16:49:48 -0600
Subject: [PATCH v1 3/3] PCI: xgene: Configure PCIe MPS settings
In-Reply-To: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170208224632.14351.89895.stgit@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170208224948.14351.64615.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bjorn Helgaas <bhelgaas@google.com>

Make sure PCIe MPS settings are valid when we enumerate a new hierarchy.

Based-on-patch-by: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-xgene.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
index 7c3b54b9eb17..8091a8778ae7 100644
--- a/drivers/pci/host/pci-xgene.c
+++ b/drivers/pci/host/pci-xgene.c
@@ -638,7 +638,7 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 	struct device_node *dn = dev->of_node;
 	struct xgene_pcie_port *port;
 	resource_size_t iobase = 0;
-	struct pci_bus *bus;
+	struct pci_bus *bus, *child;
 	int ret;
 	LIST_HEAD(res);
 
@@ -681,6 +681,8 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
 
 	pci_scan_child_bus(bus);
 	pci_assign_unassigned_bus_resources(bus);
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
 	pci_bus_add_devices(bus);
 	return 0;
 
