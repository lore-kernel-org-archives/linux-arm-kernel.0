From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 15 Oct 2014 11:07:03 +0800
Subject: [PATCH v3 15/27] x86/MSI: Remove unused MSI weak arch functions
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1413342435-7876-16-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we can clean up MSI weak arch functions in x86.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 arch/x86/include/asm/pci.h      |    5 +----
 arch/x86/include/asm/x86_init.h |    4 ----
 arch/x86/kernel/apic/io_apic.c  |   21 +++++----------------
 arch/x86/kernel/x86_init.c      |   24 ------------------------
 4 files changed, 6 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index f41b58a..3a5cf19 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -108,14 +108,11 @@ extern void pci_iommu_alloc(void);
 #ifdef CONFIG_PCI_MSI
 /* implemented in arch/x86/kernel/apic/io_apic. */
 struct msi_desc;
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type);
-void native_teardown_msi_irq(unsigned int irq);
-void native_restore_msi_irqs(struct pci_dev *dev);
+void native_teardown_msi_irq(struct msi_chip *chip, unsigned int irq);
 int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 		  unsigned int irq_base, unsigned int irq_offset);
 extern struct msi_chip *x86_msi_chip;
 #else
-#define native_setup_msi_irqs		NULL
 #define native_teardown_msi_irq		NULL
 #endif
 
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index f58a9c7..2514f67 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -174,13 +174,9 @@ struct pci_dev;
 struct msi_msg;
 
 struct x86_msi_ops {
-	int (*setup_msi_irqs)(struct pci_dev *dev, int nvec, int type);
 	void (*compose_msi_msg)(struct pci_dev *dev, unsigned int irq,
 				unsigned int dest, struct msi_msg *msg,
 			       u8 hpet_id);
-	void (*teardown_msi_irq)(unsigned int irq);
-	void (*teardown_msi_irqs)(struct pci_dev *dev);
-	void (*restore_msi_irqs)(struct pci_dev *dev);
 	int  (*setup_hpet_msi)(unsigned int irq, unsigned int id);
 };
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ec79b38..11d353f 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -3200,7 +3200,8 @@ int setup_msi_irq(struct pci_dev *dev, struct msi_desc *msidesc,
 	return 0;
 }
 
-int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+static int native_setup_msi_irqs(struct msi_chip *chip,
+		struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *msidesc;
 	unsigned int irq;
@@ -3227,26 +3228,14 @@ int native_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 	return 0;
 }
 
-static int __native_setup_msi_irqs(struct msi_chip *chip, 
-		struct pci_dev *dev, int nvec, int type)
-{
-	return native_setup_msi_irqs(dev, nvec, type);
-}
-
-void native_teardown_msi_irq(unsigned int irq)
+void native_teardown_msi_irq(struct msi_chip *chip, unsigned int irq)
 {
 	irq_free_hwirq(irq);
 }
 
-static void __native_teardown_msi_irq(struct msi_chip *chip, 
-		unsigned int irq)
-{
-	native_teardown_msi_irq(irq);
-}
-
 static struct msi_chip native_msi_chip = {
-	.setup_irqs = __native_setup_msi_irqs,
-	.teardown_irq = __native_teardown_msi_irq,
+	.setup_irqs = native_setup_msi_irqs,
+	.teardown_irq = native_teardown_msi_irq,
 };
 
 struct msi_chip *x86_msi_chip = &native_msi_chip;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 234b072..cc32568 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -110,34 +110,10 @@ EXPORT_SYMBOL_GPL(x86_platform);
 
 #if defined(CONFIG_PCI_MSI)
 struct x86_msi_ops x86_msi = {
-	.setup_msi_irqs		= native_setup_msi_irqs,
 	.compose_msi_msg	= native_compose_msi_msg,
-	.teardown_msi_irq	= native_teardown_msi_irq,
-	.teardown_msi_irqs	= default_teardown_msi_irqs,
-	.restore_msi_irqs	= default_restore_msi_irqs,
 	.setup_hpet_msi		= default_setup_hpet_msi,
 };
 
-/* MSI arch specific hooks */
-int arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
-{
-	return x86_msi.setup_msi_irqs(dev, nvec, type);
-}
-
-void arch_teardown_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.teardown_msi_irqs(dev);
-}
-
-void arch_teardown_msi_irq(unsigned int irq)
-{
-	x86_msi.teardown_msi_irq(irq);
-}
-
-void arch_restore_msi_irqs(struct pci_dev *dev)
-{
-	x86_msi.restore_msi_irqs(dev);
-}
 #endif
 
 struct x86_io_apic_ops x86_io_apic_ops = {
-- 
1.7.1
