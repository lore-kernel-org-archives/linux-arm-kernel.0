From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:36 +0100
Subject: [RFT PATCH v2 36/42] PCI: host-common: Drop pci_fixup_irqs()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-37-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, through struct pci_host_bridge.map/swizzle_irq hooks, IRQs
are now allocated in the pci_assign_irq() callback automatically,
PCI host bridge drivers can stop relying on pci_fixup_irqs()
for IRQ allocation.

Drop pci_fixup_irqs() usage from PCI host-common bridge driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 drivers/pci/host/pci-host-common.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/host/pci-host-common.c b/drivers/pci/host/pci-host-common.c
index 8e2614ba..44a47d4 100644
--- a/drivers/pci/host/pci-host-common.c
+++ b/drivers/pci/host/pci-host-common.c
@@ -149,6 +149,8 @@ int pci_host_common_probe(struct platform_device *pdev,
 	bridge->sysdata = cfg;
 	bridge->busnr = cfg->busr.start;
 	bridge->ops = &ops->pci_ops;
+	bridge->map_irq = of_irq_parse_and_map_pci;
+	bridge->swizzle_irq = pci_common_swizzle;
 
 	ret = pci_scan_root_bus_bridge(bridge);
 	if (ret < 0) {
@@ -158,10 +160,6 @@ int pci_host_common_probe(struct platform_device *pdev,
 
 	bus = bridge->bus;
 
-#ifdef CONFIG_ARM
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
-#endif
-
 	/*
 	 * We insert PCI resources into the iomem_resource and
 	 * ioport_resource trees in either pci_bus_claim_resources()
-- 
2.10.0
