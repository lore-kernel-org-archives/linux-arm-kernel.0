From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu,  8 Jun 2017 15:13:07 +0100
Subject: [RFT PATCH v2 07/42] drivers: pci: host: ftpci100: Fix host bridge
 memory leakage
In-Reply-To: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170608141342.2018-8-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When probing the PCI host controller driver, if an error condition
is trigger the probe function code does not free memory allocated
for the struct pci_host_bridge resulting in memory leakage.

Move the struct pci_host_bridge allocation over to the respective
devm interface to fix the issue.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/host/pci-ftpci100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 1c1fd60..89cbb1f 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -441,7 +441,7 @@ static int faraday_pci_probe(struct platform_device *pdev)
 	u32 val;
 	LIST_HEAD(res);
 
-	host = pci_alloc_host_bridge(sizeof(*p));
+	host = devm_pci_alloc_host_bridge(dev, sizeof(*p));
 	if (!host)
 		return -ENOMEM;
 
-- 
2.10.0
