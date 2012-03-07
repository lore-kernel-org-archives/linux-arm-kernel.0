From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 07 Mar 2012 15:32:24 -0700
Subject: [PATCH v3 04/34] arm/PCI: remove arch pci_flags definition
In-Reply-To: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
References: <20120307222436.25669.52282.stgit@bhelgaas.mtv.corp.google.com>
Message-ID: <20120307223224.25669.89103.stgit@bhelgaas.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCI core provides a pci_flags definition (currently __weak), so drop
the arm definition in favor of that.

arm previously had EXPORT_SYMBOL(pci_flags), but no other architecture does
this, and no modules reference it, so I removed the export.

CC: Rob Herring <rob.herring@calxeda.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: linux-arm-kernel at lists.infradead.org
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm/kernel/bios32.c |    1 +
 arch/arm/mm/iomap.c      |    3 ---
 2 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index f58ba35..d13b6c2 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -525,6 +525,7 @@ void __init pci_common_init(struct hw_pci *hw)
 
 	INIT_LIST_HEAD(&hw->buses);
 
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 	if (hw->preinit)
 		hw->preinit();
 	pcibios_init_hw(hw);
diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index e62956e..4614208 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -32,9 +32,6 @@ EXPORT_SYMBOL(pcibios_min_io);
 unsigned long pcibios_min_mem = 0x01000000;
 EXPORT_SYMBOL(pcibios_min_mem);
 
-unsigned int pci_flags = PCI_REASSIGN_ALL_RSRC;
-EXPORT_SYMBOL(pci_flags);
-
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
 	if ((unsigned long)addr >= VMALLOC_START &&
