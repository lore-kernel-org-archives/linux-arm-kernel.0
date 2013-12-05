From: wangyijing@huawei.com (Yijing Wang)
Date: Thu, 5 Dec 2013 20:03:25 +0800
Subject: [PATCH 8/9] arm/mach-ixp4xx: Use dev_is_pci() to check whether it is
 pci device
Message-ID: <1386245005-32096-1-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use PCI standard marco dev_is_pci() instead of directly compare
pci_bus_type to check whether it is pci device.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/arm/mach-ixp4xx/common-pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 6d6bde3..e45559a 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -326,7 +326,7 @@ static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t s
  */
 static int ixp4xx_pci_platform_notify(struct device *dev)
 {
-	if(dev->bus == &pci_bus_type) {
+	if (dev_is_pci(dev)) {
 		*dev->dma_mask =  SZ_64M - 1;
 		dev->coherent_dma_mask = SZ_64M - 1;
 		dmabounce_register_dev(dev, 2048, 4096, ixp4xx_needs_bounce);
@@ -336,9 +336,9 @@ static int ixp4xx_pci_platform_notify(struct device *dev)
 
 static int ixp4xx_pci_platform_notify_remove(struct device *dev)
 {
-	if(dev->bus == &pci_bus_type) {
+	if (dev_is_pci(dev))
 		dmabounce_unregister_dev(dev);
-	}
+
 	return 0;
 }
 
-- 
1.7.1
