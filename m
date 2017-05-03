From: Bharat.Bhushan@nxp.com (Bharat Bhushan)
Date: Wed, 3 May 2017 21:18:58 +0530
Subject: [PATCH] ARM64/PCI: Allow userspace to mmap PCI resources
Message-ID: <1493826538-23785-1-git-send-email-Bharat.Bhushan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows user-space to mmap PCI resources. This
patch is inline to arm32 bit implementation.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
---
 arch/arm64/include/asm/pci.h |  4 ++++
 arch/arm64/kernel/pci.c      | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b9a7ba9..8a18915 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -31,6 +31,10 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 	return -ENODEV;
 }
 
+#define HAVE_PCI_MMAP
+extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			       enum pci_mmap_state mmap_state,
+			       int write_combine);
 static inline int pci_proc_domain(struct pci_bus *bus)
 {
 	return 1;
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index ce20f4c..2e45a83 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -97,6 +97,25 @@ int pcibios_check_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 	return count;
 }
 
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	if (mmap_state == pci_mmap_io)
+		return -EINVAL;
+
+	/*
+	 * Mark this as IO
+	 */
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			     vma->vm_end - vma->vm_start,
+			     vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
  */
-- 
1.9.3
