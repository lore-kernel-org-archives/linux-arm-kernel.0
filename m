From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:30 +0100
Subject: [RFT PATCH v2 30/42] PCI: tegra: Drop pci_fixup_irqs()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-31-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, through struct pci_host_bridge.map/swizzle_irq hooks, IRQs
are now allocated in the pci_assign_irq() callback automatically,
PCI host bridge drivers can stop relying on pci_fixup_irqs()
for IRQ allocation

Drop pci_fixup_irqs() usage from PCI tegra host bridge driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pci/host/pci-tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 0383418..0dadb81 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2284,6 +2284,8 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	host->busnr = pcie->busn.start;
 	host->dev.parent = &pdev->dev;
 	host->ops = &tegra_pcie_ops;
+	host->map_irq = tegra_pcie_map_irq;
+	host->swizzle_irq = pci_common_swizzle;
 
 	err = pci_scan_root_bus_bridge(host);
 	if (err < 0) {
@@ -2291,7 +2293,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 		goto disable_msi;
 	}
 
-	pci_fixup_irqs(pci_common_swizzle, tegra_pcie_map_irq);
 	pci_bus_size_bridges(host->bus);
 	pci_bus_assign_resources(host->bus);
 
-- 
2.10.0
