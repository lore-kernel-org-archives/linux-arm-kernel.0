From: wangyijing@huawei.com (Yijing Wang)
Date: Wed, 15 Oct 2014 11:06:59 +0800
Subject: [PATCH v3 11/27] PCI/MSI: Refactor struct msi_chip to make it become
 more common
In-Reply-To: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
References: <1413342435-7876-1-git-send-email-wangyijing@huawei.com>
Message-ID: <1413342435-7876-12-git-send-email-wangyijing@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now there are a lot of __weak arch functions in MSI code.
These functions make MSI driver complex. Thierry introduced
MSI chip framework to configure MSI/MSI-X irq in arm. Use
MSI chip framework to refactor all other platform MSI
code to eliminate weak arch MSI functions. This patch add
.restore_irqs(), .teardown_irqs() and .setup_irqs() to make it
become more common.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/msi.c   |   15 +++++++++++++++
 include/linux/msi.h |    4 ++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 56e54ad..5cbd774 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -61,6 +61,11 @@ int __weak arch_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
 	struct msi_desc *entry;
 	int ret;
+	struct msi_chip *chip;
+
+	chip = pci_msi_chip(dev->bus);
+	if (chip && chip->setup_irqs)
+		return chip->setup_irqs(chip, dev, nvec, type);
 
 	/*
 	 * If an architecture wants to support multiple MSI, it needs to
@@ -103,6 +108,11 @@ void default_teardown_msi_irqs(struct pci_dev *dev)
 
 void __weak arch_teardown_msi_irqs(struct pci_dev *dev)
 {
+	struct msi_chip *chip = pci_msi_chip(dev->bus);
+
+	if (chip && chip->teardown_irqs)
+		return chip->teardown_irqs(chip, dev);
+
 	return default_teardown_msi_irqs(dev);
 }
 
@@ -126,6 +136,11 @@ static void default_restore_msi_irq(struct pci_dev *dev, int irq)
 
 void __weak arch_restore_msi_irqs(struct pci_dev *dev)
 {
+	struct msi_chip *chip = pci_msi_chip(dev->bus);
+
+	if (chip && chip->restore_irqs)
+             return chip->restore_irqs(chip, dev);
+
 	return default_restore_msi_irqs(dev);
 }
 
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 175aa21..eb5ae36 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -74,7 +74,11 @@ struct msi_chip {
 
 	int (*setup_irq)(struct msi_chip *chip, struct pci_dev *dev,
 			 struct msi_desc *desc);
+	int (*setup_irqs)(struct msi_chip *chip, struct pci_dev *dev,
+			int nvec, int type);
 	void (*teardown_irq)(struct msi_chip *chip, unsigned int irq);
+	void (*teardown_irqs)(struct msi_chip *chip, struct pci_dev *dev);
+	void (*restore_irqs)(struct msi_chip *chip, struct pci_dev *dev);
 };
 
 #endif /* LINUX_MSI_H */
-- 
1.7.1
