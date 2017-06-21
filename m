From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Jun 2017 23:53:01 +0200
Subject: [PATCH 3/4] PCI: versatile: fix typo
In-Reply-To: <20170621215323.3921382-1-arnd@arndb.de>
References: <20170621215323.3921382-1-arnd@arndb.de>
Message-ID: <20170621215323.3921382-3-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no 'dev' variable in this function:

drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
drivers/pci/host/pci-versatile.c:131:38: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?

This passes the device embedded in the platform_device instead.

Fixes: 433d2671da1b ("PCI: versatile: Convert PCI scan API to pci_scan_root_bus_bridge()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/pci/host/pci-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/host/pci-versatile.c b/drivers/pci/host/pci-versatile.c
index 3be25a9dd29a..f572c921cdd4 100644
--- a/drivers/pci/host/pci-versatile.c
+++ b/drivers/pci/host/pci-versatile.c
@@ -128,7 +128,7 @@ static int versatile_pci_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	LIST_HEAD(pci_res);
 
-	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	bridge = devm_pci_alloc_host_bridge(&pdev->dev, 0);
 	if (!bridge)
 		return -ENOMEM;
 
-- 
2.9.0
