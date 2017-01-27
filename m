From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 27 Jan 2017 16:44:08 -0500
Subject: [PATCH 1/2] PCI: iproc: allow the MPS to be set
In-Reply-To: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
References: <1485553449-9345-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1485553449-9345-2-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pcie_bus_configure_settings() needs to be called on each of the root
ports to allow for the MPS to be configured for all of the children
devices.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 drivers/pci/host/pcie-iproc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
index 3ebc025..0f39bd2 100644
--- a/drivers/pci/host/pcie-iproc.c
+++ b/drivers/pci/host/pcie-iproc.c
@@ -1205,7 +1205,7 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	struct device *dev;
 	int ret;
 	void *sysdata;
-	struct pci_bus *bus;
+	struct pci_bus *bus, *child;
 
 	dev = pcie->dev;
 
@@ -1278,6 +1278,9 @@ int iproc_pcie_setup(struct iproc_pcie *pcie, struct list_head *res)
 	if (pcie->map_irq)
 		pci_fixup_irqs(pci_common_swizzle, pcie->map_irq);
 
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
 	pci_bus_add_devices(bus);
 
 	return 0;
-- 
2.7.4
