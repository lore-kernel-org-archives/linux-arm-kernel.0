From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 9 Mar 2015 10:34:20 +0800
Subject: [PATCH v6 23/30] PCI/mvebu: Use pci_common_init_dev() to simplify code
In-Reply-To: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425868467-9667-24-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mvebu_pcie_scan_bus() is not necessary, we could use
pci_common_init_dev() instead of pci_common_init(),
and pass the device pointer as the parent. Then
pci_scan_root_bus() will be called to scan the pci busses.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
CC: Jason Cooper <jason@lakedaemon.net>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-mvebu.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 1309cfb..d5a2b70 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -750,21 +750,6 @@ static int mvebu_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static struct pci_bus *mvebu_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct mvebu_pcie *pcie = sys_to_pcie(sys);
-	struct pci_bus *bus;
-
-	bus = pci_create_root_bus(&pcie->pdev->dev, sys->busnr,
-				  &mvebu_pcie_ops, sys, &sys->resources);
-	if (!bus)
-		return NULL;
-
-	pci_scan_child_bus(bus);
-
-	return bus;
-}
-
 static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
 						 const struct resource *res,
 						 resource_size_t start,
@@ -808,12 +793,11 @@ static void mvebu_pcie_enable(struct mvebu_pcie *pcie)
 	hw.nr_controllers = 1;
 	hw.private_data   = (void **)&pcie;
 	hw.setup          = mvebu_pcie_setup;
-	hw.scan           = mvebu_pcie_scan_bus;
 	hw.map_irq        = of_irq_parse_and_map_pci;
 	hw.ops            = &mvebu_pcie_ops;
 	hw.align_resource = mvebu_pcie_align_resource;
 
-	pci_common_init(&hw);
+	pci_common_init_dev(&pcie->pdev->dev, &hw);
 }
 
 /*
-- 
1.7.1
