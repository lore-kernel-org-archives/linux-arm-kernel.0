From: wangyijing@huawei.com (Yijing Wang)
Date: Mon, 9 Mar 2015 10:34:21 +0800
Subject: [PATCH v6 24/30] PCI/tegra: Remove redundant tegra_pcie_scan_bus()
In-Reply-To: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
References: <1425868467-9667-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1425868467-9667-25-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now pci_scan_root_bus() is almost similar to
pci_create_root_bus() + pci_scan_child_bus().
So we could use common pci_scan_root_bus() in
pci_common_init_dev() to scan pci busses.
tegra_pcie_scan_bus() is redundant, remove it.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
CC: Thierry Reding <thierry.reding@gmail.com>
CC: linux-tegra at vger.kernel.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 00e9272..10c0571 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -630,21 +630,6 @@ static int tegra_pcie_map_irq(const struct pci_dev *pdev, u8 slot, u8 pin)
 	return irq;
 }
 
-static struct pci_bus *tegra_pcie_scan_bus(int nr, struct pci_sys_data *sys)
-{
-	struct tegra_pcie *pcie = sys_to_pcie(sys);
-	struct pci_bus *bus;
-
-	bus = pci_create_root_bus(pcie->dev, sys->busnr, &tegra_pcie_ops, sys,
-				  &sys->resources);
-	if (!bus)
-		return NULL;
-
-	pci_scan_child_bus(bus);
-
-	return bus;
-}
-
 static irqreturn_t tegra_pcie_isr(int irq, void *arg)
 {
 	const char *err_msg[] = {
@@ -1831,7 +1816,6 @@ static int tegra_pcie_enable(struct tegra_pcie *pcie)
 	hw.private_data = (void **)&pcie;
 	hw.setup = tegra_pcie_setup;
 	hw.map_irq = tegra_pcie_map_irq;
-	hw.scan = tegra_pcie_scan_bus;
 	hw.ops = &tegra_pcie_ops;
 
 	pci_common_init_dev(pcie->dev, &hw);
-- 
1.7.1
