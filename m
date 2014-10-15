From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 15 Oct 2014 13:03:41 +0100
Subject: [PATCH RFC 2/2] arm: kernel: fix pci_mmap_page_range() offset
 calculation
In-Reply-To: <1413374624-30066-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1413374624-30066-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1413374624-30066-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pci_mmap_page_range() API should be written to expect offset
values representing PCI memory resource addresses as seen by user space,
through the pci_resource_to_user() API.

ARM relies on the standard implementation of pci_resource_to_user()
which actually is an identity map and exports to user space
PCI memory resources as they are stored in PCI devices resources (ie BARs)
which represent CPU physical addresses (fixed-up using BUS to CPU
address conversions) not PCI bus addresses.

On platforms where the mapping between CPU and BUS address is not a 1:1
mapping this is erroneous, in that an additional shift is applied to
an already fixed-up offset passed from userspace.

Hence, this patch removes the mem_offset from the pgoff calculation
since the offset as passed from user space already represents
the CPU physical address corresponding to the resource to be mapped,
ie no additional offset should be applied.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/kernel/bios32.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 17a26c1..b56fa2d 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -626,21 +626,15 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
 {
-	struct pci_sys_data *root = dev->sysdata;
-	unsigned long phys;
-
-	if (mmap_state == pci_mmap_io) {
+	if (mmap_state == pci_mmap_io)
 		return -EINVAL;
-	} else {
-		phys = vma->vm_pgoff + (root->mem_offset >> PAGE_SHIFT);
-	}
 
 	/*
 	 * Mark this as IO
 	 */
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	if (remap_pfn_range(vma, vma->vm_start, phys,
+	if (remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
 			     vma->vm_end - vma->vm_start,
 			     vma->vm_page_prot))
 		return -EAGAIN;
-- 
2.1.2
