From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 15 Oct 2014 11:06:54 +0800
Subject: [PATCH v3 06/27] PCI: designware: Save msi chip in pci_sys_data
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1413342435-7876-7-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save msi chip in pci_sys_data instead of assign
msi chip to every pci bus in .add_bus().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/host/pcie-designware.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
index dfed00a..56fa8ab 100644
--- a/drivers/pci/host/pcie-designware.c
+++ b/drivers/pci/host/pcie-designware.c
@@ -498,6 +498,10 @@ int __init dw_pcie_host_init(struct pcie_port *pp)
 	val |= PORT_LOGIC_SPEED_CHANGE;
 	dw_pcie_wr_own_conf(pp, PCIE_LINK_WIDTH_SPEED_CONTROL, 4, val);
 
+#ifdef CONFIG_PCI_MSI
+	dw_pcie_msi_chip.dev = pp->dev;
+	dw_pci.msi_chip = &dw_pcie_msi_chip;
+#endif
 	dw_pci.nr_controllers = 1;
 	dw_pci.private_data = (void **)&pp;
 
@@ -747,21 +751,10 @@ static int dw_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 	return irq;
 }
 
-static void dw_pcie_add_bus(struct pci_bus *bus)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		struct pcie_port *pp = sys_to_pcie(bus->sysdata);
-
-		dw_pcie_msi_chip.dev = pp->dev;
-		bus->msi = &dw_pcie_msi_chip;
-	}
-}
-
 static struct hw_pci dw_pci = {
 	.setup		= dw_pcie_setup,
 	.scan		= dw_pcie_scan_bus,
 	.map_irq	= dw_pcie_map_irq,
-	.add_bus	= dw_pcie_add_bus,
 };
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
-- 
1.7.1
