From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 15 May 2014 16:59:32 +0200
Subject: [PATCHv4 1/3] ARM: mm: use MT_UNCACHED as the memory type for PCI I/O
 mappings
In-Reply-To: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400165974-9059-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400165974-9059-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann explains: "The PCI I/O space semantics require
non-posted writes, which is the main difference between device and
strongly-ordered mappings."

This patch therefore changes the memory type used for PCI I/O mappings
from MT_DEVICE to MT_UNCACHED. On Marvell EBU platforms, it is part of
a workaround for a deadlock situation occuring on Armada 375/38x
between PCIe/PL310 and hardware I/O coherency in SMP situations.

As Arnd Bergmann indicates: "the same fix is required both for mvebu
as a workaround for the deadlock as well as for everyone else as a fix
for an incorrect PCI behavior."

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mm/ioremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index f9c32ba..631b0e6 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -445,7 +445,7 @@ int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
 				  PCI_IO_VIRT_BASE + offset + SZ_64K,
 				  phys_addr,
-				  __pgprot(get_mem_type(MT_DEVICE)->prot_pte));
+				  __pgprot(get_mem_type(MT_UNCACHED)->prot_pte));
 }
 EXPORT_SYMBOL_GPL(pci_ioremap_io);
 #endif
-- 
1.9.3
