From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Tue,  4 Nov 2014 20:01:54 +0800
Subject: [Patch Part2 v4 20/31] PCI/MSI: Kill redundant calling for
 irq_set_msi_desc() for MSIx interrupts
In-Reply-To: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1415102525-9898-21-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's arch_setup_msi_irq()/arch_setup_msi_irqs()'s responsibility to call
irq_set_msi_desc() to associate IRQ descriptors and MSI descriptors,
so kill the redundant call of irq_set_msi_desc() for MSIx interrupts
in PCI MSI core.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 drivers/pci/msi.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index afe974600c7d..da181c59394b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -685,7 +685,6 @@ static void msix_program_entries(struct pci_dev *dev,
 						PCI_MSIX_ENTRY_VECTOR_CTRL;
 
 		entries[i].vector = entry->irq;
-		irq_set_msi_desc(entry->irq, entry);
 		entry->masked = readl(entry->mask_base + offset);
 		msix_mask_irq(entry, 1);
 		i++;
-- 
1.7.10.4
