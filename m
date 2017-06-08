From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:08 +0100
Subject: [RFT PATCH v2 08/42] drivers: pci: host: tegra: Fix host bridge
 memory leakage
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-9-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When probing the PCI host controller driver, if an error condition
is triggered the probe function code does not free memory allocated
for the struct pci_host_bridge resulting in memory leakage.

Move the struct pci_host_bridge allocation over to the respective
devm interface to fix the issue.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 2618f87..84c98a2 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -2238,7 +2238,7 @@ static int tegra_pcie_probe(struct platform_device *pdev)
 	struct pci_bus *child;
 	int err;
 
-	host = pci_alloc_host_bridge(sizeof(*pcie));
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
 	if (!host)
 		return -ENOMEM;
 
-- 
2.10.0
