From: dingtianhong@huawei.com (Ding Tianhong)
Date: Thu, 17 Aug 2017 10:25:30 +0800
Subject: [PATCH net] PCI: fix the return value for the
 pci_find_pcie_root_port()
Message-ID: <1502936730-7368-1-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pci_find_pcie_root_port() would return NULL if the given
dev is already a Root Port, it looks like unfriendly to the
PCIe Root Port device, Thierry and Bjorn suggest to let this
function return the given dev under this circumstances.

Fixes: 0e405232871d6 ("PCI: fix oops when try to find Root Port for a PCI device")
Suggested-by: Thierry Reding <thierry.reding@gmail.com>
Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7e2022f..352bb53 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -514,7 +514,7 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
  */
 struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
 {
-	struct pci_dev *bridge, *highest_pcie_bridge = NULL;
+	struct pci_dev *bridge, *highest_pcie_bridge = dev;
 
 	bridge = pci_upstream_bridge(dev);
 	while (bridge && pci_is_pcie(bridge)) {
-- 
1.8.3.1
