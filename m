From: jerin.jacob@caviumnetworks.com (Jerin Jacob)
Date: Thu, 14 Apr 2016 02:40:56 +0530
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
Message-ID: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain X11 servers and user space network drivers frameworks
need PCI mmaped /sys/bus/pci/devices/B:D:F/resourceX file to
access PCI bar address space from user space.

Signed-off-by: Jerin Jacob <jerin.jacob@caviumnetworks.com>
---
Changes in v2:
  - Rebased to 4.6.0-rc3.
  - Tested and verified the change on Thunderx and xgene1 arm64 platforms

 arch/arm64/include/asm/pci.h |  6 ++++++
 arch/arm64/kernel/pci.c      | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b9a7ba9..9d7e460 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -37,5 +37,11 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif  /* CONFIG_PCI */
 
+#define HAVE_PCI_MMAP
+
+extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+	enum pci_mmap_state mmap_state, int write_combine);
+
+
 #endif  /* __KERNEL__ */
 #endif  /* __ASM_PCI_H */
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index c72de66..be7ddf1 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -82,3 +82,23 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	return NULL;
 }
 #endif
+
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+		enum pci_mmap_state mmap_state, int write_combine)
+{
+	/*
+	* I/O space can be accessed via normal processor loads and stores on
+	* this platform but for now we elect not to do this and portable
+	* drivers should not do this anyway.
+	*/
+	if (mmap_state == pci_mmap_io)
+		return -EINVAL;
+
+	if (write_combine)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+	       vma->vm_end - vma->vm_start, vma->vm_page_prot);
+}
-- 
2.1.0
