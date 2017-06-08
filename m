From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:35 +0100
Subject: [RFT PATCH v2 35/42] PCI: ftpci100: Drop pci_fixup_irqs()
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-36-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since, through struct pci_host_bridge.map/swizzle_irq hooks, IRQs
are now allocated in the pci_assign_irq() callback automatically,
PCI host bridge drivers can stop relying on pci_fixup_irqs()
for IRQ allocation.

Drop pci_fixup_irqs() usage from PCI ftpci100 host bridge driver.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pci/host/pci-ftpci100.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 435a646..9cfc90a 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -449,6 +449,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	host->ops = &faraday_pci_ops;
 	host->busnr = 0;
 	host->msi = NULL;
+	host->map_irq = of_irq_parse_and_map_pci;
+	host->swizzle_irq = pci_common_swizzle;
 	p = pci_host_bridge_priv(host);
 	host->sysdata = p;
 	p->dev = dev;
@@ -527,7 +529,6 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	}
 	p->bus = host->bus;
 
-	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
 	pci_bus_assign_resources(p->bus);
 	pci_bus_add_devices(p->bus);
 	pci_free_resource_list(&res);
-- 
2.10.0
