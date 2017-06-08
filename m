From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:40 +0100
Subject: [RFT PATCH v2 40/42] PCI: rockchip: Move to struct pci_host_bridge
 IRQ mapping functions
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-41-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

struct pci_host_bridge gained hooks to map/swizzle IRQs, so that
the IRQ mapping can be done automatically by PCI core code through
the pci_assign_irq() function instead of resorting to per-arch
specific implementation callbacks to carry out the same task which
force PCI host bridge drivers implementation to implement per-arch
kludges to carry out a task that is inherently architecture agnostic.

Add map/swizzle IRQs hooks to the rockchip PCI host driver to move
the IRQ allocation into core code and stop relying on arch specific
callbacks.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Wenrui Li <wenrui.li@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/host/pcie-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/host/pcie-rockchip.c b/drivers/pci/host/pcie-rockchip.c
index cae5a6d..29332ba 100644
--- a/drivers/pci/host/pcie-rockchip.c
+++ b/drivers/pci/host/pcie-rockchip.c
@@ -1404,6 +1404,8 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	bridge->sysdata = rockchip;
 	bridge->busnr = 0;
 	bridge->ops = &rockchip_pcie_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	err = pci_scan_root_bus_bridge(bridge);
 	if (!err)
-- 
2.10.0
