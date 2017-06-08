From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:32 +0100
Subject: [RFT PATCH v2 32/42] PCI: rcar: Drop pci_fixup_irqs()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-33-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, through struct pci_host_bridge.map/swizzle_irq hooks, IRQs
are now allocated in the pci_assign_irq() callback automatically,
PCI host bridge drivers can stop relying on pci_fixup_irqs()
for IRQ allocation.

Drop pci_fixup_irqs() usage from PCI rcar host bridge driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Simon Horman <horms@verge.net.au>
---
 drivers/pci/host/pcie-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 8380274..246d485 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -465,6 +465,8 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_bus_nr;
 	bridge->ops = &rcar_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 	if (IS_ENABLED(CONFIG_PCI_MSI))
 		bridge->msi = &pcie->msi.chip;
 
@@ -476,8 +478,6 @@ static int rcar_pcie_enable(struct rcar_pcie *pcie)
 
 	bus = bridge->bus;
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
-- 
2.10.0
