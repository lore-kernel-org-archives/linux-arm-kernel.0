From: wangyijing@huawei.com (Yijing Wang)
Date: Tue, 12 Aug 2014 15:26:07 +0800
Subject: [RFC PATCH 14/20] Powerpc/MSI: Use msi_chip instead of arch func to
 configure MSI/MSI-X
In-Reply-To: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
References: <1407828373-24322-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1407828373-24322-15-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce a new struct msi_chip ppc_msi_chip instead of weak arch
functions to configure MSI/MSI-X.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/powerpc/kernel/msi.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/msi.c b/arch/powerpc/kernel/msi.c
index 8bbc12d..170b02c 100644
--- a/arch/powerpc/kernel/msi.c
+++ b/arch/powerpc/kernel/msi.c
@@ -13,7 +13,7 @@
 
 #include <asm/machdep.h>
 
-int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
+int ppc_msi_check_device(struct device *dev, int nvec, int type)
 {
 	if (!ppc_md.setup_msi_irqs || !ppc_md.teardown_msi_irqs) {
 		pr_debug("msi: Platform doesn't provide MSI callbacks.\n");
@@ -26,18 +26,29 @@ int arch_msi_check_device(struct pci_dev* dev, int nvec, int type)
 
 	if (ppc_md.msi_check_device) {
 		pr_debug("msi: Using platform check routine.\n");
-		return ppc_md.msi_check_device(dev, nvec, type);
+		return ppc_md.msi_check_device(to_pci_dev(dev), nvec, type);
 	}
 
         return 0;
 }
 
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+int ppc_setup_msi_irqs(struct device *dev, int nvec, int type)
 {
-	return ppc_md.setup_msi_irqs(dev, nvec, type);
+	return ppc_md.setup_msi_irqs(to_pci_dev(dev), nvec, type);
 }
 
-void arch_teardown_msi_irqs(struct pci_dev *dev)
+void ppc_teardown_msi_irqs(struct device *dev)
 {
-	ppc_md.teardown_msi_irqs(dev);
+	ppc_md.teardown_msi_irqs(to_pci_dev(dev));
+}
+
+struct msi_chip ppc_msi_chip = {
+	.setup_irqs = ppc_setup_msi_irqs,
+	.teardown_irqs = ppc_teardown_msi_irqs,
+	.check_device = ppc_msi_check_device,
+};
+
+struct msi_chip *arch_get_match_msi_chip(struct device *dev)
+{
+	return &ppc_msi_chip;
 }
-- 
1.7.1
