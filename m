From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 27 Oct 2014 15:48:43 +0800
Subject: [PATCH 06/10] PCI: rcar: Save MSI controller in pci_sys_data
In-Reply-To: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
References: <1414396127-30023-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1414396127-30023-7-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save MSI controller in pci_sys_data instead of
assigning MSI controller pointer to every pci bus
in .add_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pcie-rcar.c |   13 +++----------
 1 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 48221aa..0dd9c75 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -380,20 +380,10 @@ static int rcar_pcie_setup(int nr, struct pci_sys_data *sys)
 	return 1;
 }
 
-static void rcar_pcie_add_bus(struct pci_bus *bus)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		struct rcar_pcie *pcie = sys_to_pcie(bus->sysdata);
-
-		bus->msi = &pcie->msi.ctrl;
-	}
-}
-
 struct hw_pci rcar_pci = {
 	.setup          = rcar_pcie_setup,
 	.map_irq        = of_irq_parse_and_map_pci,
 	.ops            = &rcar_pcie_ops,
-	.add_bus        = rcar_pcie_add_bus,
 };
 
 static void rcar_pcie_enable(struct rcar_pcie *pcie)
@@ -402,6 +392,9 @@ static void rcar_pcie_enable(struct rcar_pcie *pcie)
 
 	rcar_pci.nr_controllers = 1;
 	rcar_pci.private_data = (void **)&pcie;
+#ifdef CONFIG_PCI_MSI
+	rcar_pci.msi_ctrl = &pcie->msi.ctrl;
+#endif
 
 	pci_common_init_dev(&pdev->dev, &rcar_pci);
 #ifdef CONFIG_PCI_DOMAINS
-- 
1.7.1
