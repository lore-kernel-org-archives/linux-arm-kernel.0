From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Thu, 13 Jul 2017 23:30:52 -0500
Subject: [PATCH] ARM: mm: iomap: use is_vmalloc_addr
Message-ID: <20170714043052.GA27345@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of manually checking the bounds of VMALLOC_START and VMALLOC_END,
use is_vmalloc_addr. Such function was specifically designed for that
purpose.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 arch/arm/mm/iomap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index 4614208..4bf5457 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -34,8 +34,7 @@ EXPORT_SYMBOL(pcibios_min_mem);
 
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-	if ((unsigned long)addr >= VMALLOC_START &&
-	    (unsigned long)addr < VMALLOC_END)
+	if (is_vmalloc_addr(addr))
 		iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
-- 
2.5.0
