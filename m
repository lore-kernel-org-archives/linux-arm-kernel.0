From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon, 17 Nov 2014 19:03:14 +0800
Subject: [Patch V3 1/9] PCI, MSI: Fix errors caused by commit e5f1a59c4e12
In-Reply-To: <1416222202-28002-1-git-send-email-jiang.liu@linux.intel.com>
References: <1416222202-28002-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1416222202-28002-2-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Better to fold into commit e5f1a59c4e12 ("PCI/MSI: Rename write_msi_msg()
to pci_write_msi_msg()").

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/msi.c   |    2 +-
 include/linux/msi.h |    2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 564850b1316e..9c53b865cb1b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1084,7 +1084,7 @@ void pci_msi_domain_write_msg(struct irq_data *irq_data, struct msi_msg *msg)
 	 * MSI message denotes a contiguous group of IRQs, written for 0th IRQ.
 	 */
 	if (desc->irq == irq_data->irq)
-		pci_write_msi_msg(desc, msg);
+		__pci_write_msi_msg(desc, msg);
 }
 
 /*
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8112a17cdca1..190c7abbec84 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -44,11 +44,9 @@ struct msi_desc {
 	struct msi_msg msg;
 };
 
-#ifdef CONFIG_PCI_MSI
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void pci_write_msi_msg(unsigned int irq, struct msi_msg *msg);
-#endif
 
 /*
  * The arch hooks to setup up msi irqs. Those functions are
-- 
1.7.10.4
