From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 15 Oct 2014 11:07:04 +0800
Subject: [PATCH v3 16/27] Mips/MSI: Save msi chip in pci sysdata
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1413342435-7876-17-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Save msi chip in pci sysdata, add arch pci_find_msi_chip()
to extract out msi chip.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/mips/include/asm/pci.h |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/pci.h b/arch/mips/include/asm/pci.h
index 974b0e3..287661b 100644
--- a/arch/mips/include/asm/pci.h
+++ b/arch/mips/include/asm/pci.h
@@ -43,6 +43,9 @@ struct pci_controller {
 
 	int iommu;
 
+#ifdef CONFIG_PCI_MSI
+	struct msi_chip *msi_chip;
+#endif
 	/* Optional access methods for reading/writing the bus number
 	   of the PCI controller */
 	int (*get_busno)(void);
@@ -54,6 +57,17 @@ struct pci_controller {
  */
 extern void register_pci_controller(struct pci_controller *hose);
 
+#ifdef CONFIG_PCI_MSI
+
+static inline struct msi_chip *pci_msi_chip(struct pci_bus *bus)
+{
+	struct pci_controller *control = (struct pci_controller *)bus->sysdata;
+
+	return control->msi_chip;
+}
+
+#endif
+
 /*
  * board supplied pci irq fixup routine
  */
-- 
1.7.1
