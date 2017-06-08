From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:34 +0100
Subject: [RFT PATCH v2 34/42] PCI: designware-host: Drop pci_fixup_irqs()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-35-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, through struct pci_host_bridge.map/swizzle_irq hooks, IRQs
are now allocated in the pci_assign_irq() callback automatically,
PCI host bridge drivers can stop relying on pci_fixup_irqs()
for IRQ allocation.

Drop pci_fixup_irqs() usage from PCI designware host bridge driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Joao Pinto <Joao.Pinto@synopsys.com>
---
 drivers/pci/dwc/pcie-designware-host.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/dwc/pcie-designware-host.c b/drivers/pci/dwc/pcie-designware-host.c
index 351a277..d29c020 100644
--- a/drivers/pci/dwc/pcie-designware-host.c
+++ b/drivers/pci/dwc/pcie-designware-host.c
@@ -410,6 +410,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	bridge->sysdata = pp;
 	bridge->busnr = pp->root_bus_nr;
 	bridge->ops = &dw_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		bridge->msi = &dw_pcie_msi_chip;
 		dw_pcie_msi_chip.dev = dev;
@@ -424,11 +426,6 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	if (pp->ops->scan_bus)
 		pp->ops->scan_bus(pp);
 
-#ifdef CONFIG_ARM
-	/* support old dtbs that incorrectly describe IRQs */
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-#endif
-
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
-- 
2.10.0
