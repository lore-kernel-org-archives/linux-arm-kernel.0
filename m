From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 11:18:37 +0200
Subject: [PATCHv3 1/3] ARM: mm: allow sub-architectures to override PCI I/O
 memory type
In-Reply-To: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400145519-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400145519-28530-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a design incompatibility between the PCIe Marvell controller
and the Cortex-A9, stressing PCIe devices with a lot of traffic
quickly causes a deadlock.

One part of the workaround for this is to have all PCIe regions mapped
as strongly-ordered (MT_UNCACHED) instead of the default
MT_DEVICE. While the arch_ioremap_caller() mechanism allows
sub-architecture code to override ioremap(), used to map PCIe memory
regions, there isn't such a mechanism to override the behavior of
pci_ioremap_io().

This commit adds the arch_pci_ioremap_mem_type variable, initialized
to MT_DEVICE by default, and that sub-architecture code can
override. We have chosen to expose a single variable rather than
offering the possibility of overriding the entire pci_ioremap_io(),
because implementing pci_ioremap_io() requires calling functions
(get_mem_type()) that are private to the arch/arm/mm/ code.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/io.h | 6 ++++++
 arch/arm/mm/ioremap.c     | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 8aa4cca..3d23418 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -179,6 +179,12 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 /* PCI fixed i/o mapping */
 #define PCI_IO_VIRT_BASE	0xfee00000
 
+#if defined(CONFIG_PCI)
+void pci_ioremap_set_mem_type(int mem_type);
+#else
+static inline void pci_ioremap_set_mem_type(int mem_type) {}
+#endif
+
 extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
 
 /*
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f9c32ba..d1e5ad7 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -438,6 +438,13 @@ void __arm_iounmap(volatile void __iomem *io_addr)
 EXPORT_SYMBOL(__arm_iounmap);
 
 #ifdef CONFIG_PCI
+static int pci_ioremap_mem_type = MT_DEVICE;
+
+void pci_ioremap_set_mem_type(int mem_type)
+{
+	pci_ioremap_mem_type = mem_type;
+}
+
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
 	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
@@ -445,7 +452,7 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
 				  PCI_IO_VIRT_BASE + offset + SZ_64K,
 				  phys_addr,
-				  __pgprot(get_mem_type(MT_DEVICE)->prot_pte));
+				  __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_io);
 #endif
-- 
1.9.3
