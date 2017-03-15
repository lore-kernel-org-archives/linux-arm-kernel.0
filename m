From: dwmw2@infradead.org (David Woodhouse)
Date: Wed, 15 Mar 2017 17:17:46 +0000
Subject: [PATCH 1/3] arm64: enable pci resource mapping using sysfs
Message-ID: <1489598266.86622.12.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Brijesh Singh <brijess@amazon.com>

To support pci resource mapping from userspace, pci_mmap_page_range
implementation must be done for that platform. This support was
broken for arm64.

This patch copies existing implementation from arm to
enable sysfs mmap.

[dwmw2: Add WC support]
Reviewed-by: Erik Quanstrom <quanstro@amazon.com>
Reviewed-by: Anthony Liguori <aliguori@amazon.com>
Signed-off-by: Brijesh Singh <brijess@amazon.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/arm64/include/asm/pci.h |  4 ++++
 arch/arm64/kernel/pci.c      | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index b9a7ba9..f73734f 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -37,5 +37,9 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 }
 #endif  /* CONFIG_PCI */
 
+#define HAVE_PCI_MMAP
+extern int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			       enum pci_mmap_state mmap_state, int write_combine);
+
 #endif  /* __KERNEL__ */
 #endif  /* __ASM_PCI_H */
diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index 4f0e3eb..a9b6542 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -228,3 +228,22 @@ void pcibios_remove_bus(struct pci_bus *bus)
 }
 
 #endif
+
+int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
+			enum pci_mmap_state mmap_state, int write_combine)
+{
+	if (mmap_state == pci_mmap_io)
+		return -EINVAL;
+
+	if (write_combine)
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+			     vma->vm_end - vma->vm_start,
+			     vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
-- 
dwmw2
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4938 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170315/dfa57403/attachment-0001.bin>
