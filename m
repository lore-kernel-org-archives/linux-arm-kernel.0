From: wangyijing@huawei.com (Yijing Wang)
Date: Fri, 5 Sep 2014 18:09:50 +0800
Subject: [PATCH v1 05/21] PCI/MSI: Introduce weak arch_find_msi_chip() to find
 MSI chip
In-Reply-To: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
References: <1409911806-10519-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1409911806-10519-6-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce weak arch_find_msi_chip() to find the match msi_chip.
Currently, MSI chip associates pci bus to msi_chip. Because in
ARM platform, there may be more than one MSI controller in system.
Associate pci bus to msi_chip help pci device to find the match
msi_chip and setup MSI/MSI-X irq correctly. But in other platform,
like in x86. we only need one MSI chip, because all device use
the same MSI address/data and irq etc. So it's no need to associate
pci bus to MSI chip, just use a arch function, arch_find_msi_chip()
to return the MSI chip for simplicity. The default weak
arch_find_msi_chip() used in ARM platform, find the MSI chip
by pci bus.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/pci/msi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a77e7f7..539c11d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -29,9 +29,14 @@ static int pci_msi_enable = 1;
 
 /* Arch hooks */
 
+struct msi_chip * __weak arch_find_msi_chip(struct pci_dev *dev)
+{
+	return dev->bus->msi;
+}
+
 int __weak arch_setup_msi_irq(struct pci_dev *dev, struct msi_desc *desc)
 {
-	struct msi_chip *chip = dev->bus->msi;
+	struct msi_chip *chip = arch_find_msi_chip(dev);
 	int err;
 
 	if (!chip || !chip->setup_irq)
-- 
1.7.1
