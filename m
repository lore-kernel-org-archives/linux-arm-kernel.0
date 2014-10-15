From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 15 Oct 2014 11:07:01 +0800
Subject: [PATCH v3 13/27] x86/xen/MSI: Use MSI chip framework to configure
 MSI/MSI-X irq
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1413342435-7876-14-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use MSI chip framework instead of arch MSI functions to configure
MSI/MSI-X irq. So we can manage MSI/MSI-X irq in a unified framework.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Acked-by: David Vrabel <david.vrabel@citrix.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/x86/pci/xen.c |   58 +++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index e5b8b78..75067ca 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -157,7 +157,8 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
 
-static int xen_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int irq, ret, i;
 	struct msi_desc *msidesc;
@@ -219,7 +220,8 @@ static void xen_msi_compose_msg(struct pci_dev *pdev, unsigned int pirq,
 	msg->data = XEN_PIRQ_MSI_DATA;
 }
 
-static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_hvm_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int irq, pirq;
 	struct msi_desc *msidesc;
@@ -267,7 +269,8 @@ error:
 #ifdef CONFIG_XEN_DOM0
 static bool __read_mostly pci_seg_supported = true;
 
-static int xen_initdom_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int xen_initdom_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	int ret = 0;
 	struct msi_desc *msidesc;
@@ -349,7 +352,8 @@ out:
 	return ret;
 }
 
-static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
+static void xen_initdom_restore_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev)
 {
 	int ret = 0;
 
@@ -376,7 +380,13 @@ static void xen_initdom_restore_msi_irqs(struct pci_dev *dev)
 }
 #endif
 
-static void xen_teardown_msi_irqs(struct pci_dev *dev)
+static void xen_teardown_msi_irq(struct msi_chip *chip, unsigned int irq)
+{
+	xen_destroy_irq(irq);
+}
+
+static void xen_teardown_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev)
 {
 	struct msi_desc *msidesc;
 
@@ -386,14 +396,22 @@ static void xen_teardown_msi_irqs(struct pci_dev *dev)
 	else
 		xen_pci_frontend_disable_msi(dev);
 
-	/* Free the IRQ's and the msidesc using the generic code. */
-	default_teardown_msi_irqs(dev);
-}
+	list_for_each_entry(msidesc, &dev->msi_list, list) {
+		int i, nvec;
+		if (msidesc->irq == 0)
+			continue;
+		if (msidesc->nvec_used)
+			nvec = msidesc->nvec_used;
+		else
+			nvec = 1 << msidesc->msi_attrib.multiple;
+		for (i = 0; i < nvec; i++)
+			xen_teardown_msi_irq(chip, msidesc->irq + i);
+	}
 
-static void xen_teardown_msi_irq(unsigned int irq)
-{
-	xen_destroy_irq(irq);
 }
+
+struct msi_chip xen_msi_chip;
+
 #endif
 
 int __init pci_xen_init(void)
@@ -414,9 +432,9 @@ int __init pci_xen_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.teardown_msi_irqs = xen_teardown_msi_irqs;
+	xen_msi_chip.setup_irqs = xen_setup_msi_irqs;
+	xen_msi_chip.teardown_irqs = xen_teardown_msi_irqs;
+	x86_msi_chip = &xen_msi_chip;
 	pci_msi_ignore_mask = 1;
 #endif
 	return 0;
@@ -436,8 +454,9 @@ int __init pci_xen_hvm_init(void)
 #endif
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_hvm_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
+	xen_msi_chip.setup_irqs = xen_hvm_setup_msi_irqs;
+	xen_msi_chip.teardown_irq = xen_teardown_msi_irq;
+	x86_msi_chip = &xen_msi_chip;
 #endif
 	return 0;
 }
@@ -494,9 +513,10 @@ int __init pci_xen_initial_domain(void)
 	int irq;
 
 #ifdef CONFIG_PCI_MSI
-	x86_msi.setup_msi_irqs = xen_initdom_setup_msi_irqs;
-	x86_msi.teardown_msi_irq = xen_teardown_msi_irq;
-	x86_msi.restore_msi_irqs = xen_initdom_restore_msi_irqs;
+	xen_msi_chip.setup_irqs = xen_initdom_setup_msi_irqs;
+	xen_msi_chip.teardown_irq = xen_teardown_msi_irq;
+	xen_msi_chip.restore_irqs = xen_initdom_restore_msi_irqs;
+	x86_msi_chip = &xen_msi_chip;
 	pci_msi_ignore_mask = 1;
 #endif
 	xen_setup_acpi_sci();
-- 
1.7.1
