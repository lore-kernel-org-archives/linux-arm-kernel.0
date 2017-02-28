From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 28 Feb 2017 15:31:15 +0100
Subject: [PATCH v3 2/3] pci: pci-mvebu: remove useless MSI enabling code
In-Reply-To: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488292276-11106-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1488292276-11106-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit fcc392d501bd2 ("irqchip/armada-370-xp: Use the generic MSI
infrastructure"), the irqchip driver used on Armada 370, XP, 375, 38x,
39x for the MPIC interrupt controller has been converted to use the
generic MSI infrastructure.

Since this commit, it is no longer registering an msi_controller
structure with the of_pci_msi_chip_add() function. Therefore, having the
PCI driver used on the same platform calling
of_pci_find_msi_chip_by_node() is pretty useless.

The MSI resolution is now done in the generic interrupt resolution code,
since the MSI controller is an irq domain attached to the interrupt
controller node, which is pointed to by the msi-parent DT property in
the PCIe controller node.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
Changes since v2:
 - Rebased on v4.10.

Changes since v1:
 - Rebased on v4.9.
---
 drivers/pci/host/pci-mvebu.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index 45a89d9..2100dbd 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -986,22 +986,6 @@ static int mvebu_get_tgt_attr(struct device_node *np, int devfn,
 	return -ENOENT;
 }
 
-static void mvebu_pcie_msi_enable(struct mvebu_pcie *pcie)
-{
-	struct device_node *msi_node;
-
-	msi_node = of_parse_phandle(pcie->pdev->dev.of_node,
-				    "msi-parent", 0);
-	if (!msi_node)
-		return;
-
-	pcie->msi = of_pci_find_msi_chip_by_node(msi_node);
-	of_node_put(msi_node);
-
-	if (pcie->msi)
-		pcie->msi->dev = &pcie->pdev->dev;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int mvebu_pcie_suspend(struct device *dev)
 {
@@ -1279,7 +1263,6 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	for (i = 0; i < (IO_SPACE_LIMIT - SZ_64K); i += SZ_64K)
 		pci_ioremap_io(i, pcie->io.start + i);
 
-	mvebu_pcie_msi_enable(pcie);
 	mvebu_pcie_enable(pcie);
 
 	platform_set_drvdata(pdev, pcie);
-- 
2.7.4
