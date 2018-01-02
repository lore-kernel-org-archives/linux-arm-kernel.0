From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue,  2 Jan 2018 12:00:22 -0500
Subject: [PATCH V3 5/6] PCI: Add a return type for
 pci_reset_bridge_secondary_bus()
In-Reply-To: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
References: <1514912423-13341-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1514912423-13341-6-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Getting ready to return an error from pci_reset_bridge_secondary_bus() when
device is unreachable.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pci.c   | 4 +++-
 include/linux/pci.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 09eae93..eae04aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4157,9 +4157,11 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
  * Use the bridge control register to assert reset on the secondary bus.
  * Devices on the secondary bus are left in power-on state.
  */
-void pci_reset_bridge_secondary_bus(struct pci_dev *dev)
+int pci_reset_bridge_secondary_bus(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_reset_bridge_secondary_bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0c1335a..dbd2ad2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1094,7 +1094,7 @@ int pcie_get_minimum_link(struct pci_dev *dev, enum pci_bus_speed *speed,
 int pci_try_reset_bus(struct pci_bus *bus);
 void pci_reset_secondary_bus(struct pci_dev *dev);
 void pcibios_reset_secondary_bus(struct pci_dev *dev);
-void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
+int pci_reset_bridge_secondary_bus(struct pci_dev *dev);
 void pci_update_resource(struct pci_dev *dev, int resno);
 int __must_check pci_assign_resource(struct pci_dev *dev, int i);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
-- 
1.9.1
