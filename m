From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:41 +0100
Subject: [RFT PATCH v2 41/42] PCI: xilinx-nwl: Move to struct pci_host_bridge
 IRQ mapping functions
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-42-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct pci_host_bridge gained hooks to map/swizzle IRQs, so that
the IRQ mapping can be done automatically by PCI core code through
the pci_assign_irq() function instead of resorting to per-arch
specific implementation callbacks to carry out the same task which
force PCI host bridge drivers implementation to implement per-arch
kludges to carry out a task that is inherently architecture agnostic.

Add map/swizzle IRQs hooks to the xilinx-nwl PCI host driver to move
the IRQ allocation into core code and stop relying on arch specific
callbacks.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/host/pcie-xilinx-nwl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-xilinx-nwl.c b/drivers/pci/host/pcie-xilinx-nwl.c
index e8a5894..d1f7e4c 100644
--- a/drivers/pci/host/pcie-xilinx-nwl.c
+++ b/drivers/pci/host/pcie-xilinx-nwl.c
@@ -838,6 +838,8 @@ static int nwl_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = pcie;
 	bridge->busnr = pcie->root_busno;
 	bridge->ops = &nwl_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		err = nwl_pcie_enable_msi(pcie);
-- 
2.10.0
