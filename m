From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jul 2017 17:45:55 +0200
Subject: [PATCH 01/12] ARM: ixp4xx: fix ioport_unmap definition
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Message-ID: <20170720154616.3250481-2-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An empty macro definition can cause unexpected behavior, in
case of the ixp4xx ioport_unmap, we get two warnings:

drivers/net/wireless/marvell/libertas/if_cs.c: In function 'if_cs_release':
drivers/net/wireless/marvell/libertas/if_cs.c:826:3: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
   ioport_unmap(card->iobase);
drivers/vfio/pci/vfio_pci_rdwr.c: In function 'vfio_pci_vga_rw':
drivers/vfio/pci/vfio_pci_rdwr.c:230:15: error: the omitted middle operand in ?: will always be 'true', suggest explicit middle operand [-Werror=parentheses]
   is_ioport ? ioport_unmap(iomem) : iounmap(iomem);

This uses an inline function to define the macro in a safer way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 7a0c13bf4269..2f84c26a6758 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -523,8 +523,15 @@ static inline void iowrite32_rep(void __iomem *addr, const void *vaddr,
 #endif
 }
 
-#define	ioport_map(port, nr)		((void __iomem*)(port + PIO_OFFSET))
-#define	ioport_unmap(addr)
+#define ioport_map(port, nr) ioport_map(port, nr)
+static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
+{
+	return ((void __iomem*)((port) + PIO_OFFSET));
+}
+#define	ioport_unmap(addr) ioport_unmap(addr)
+static inline void ioport_unmap(void __iomem *addr)
+{
+}
 #endif /* CONFIG_PCI */
 
 #endif /* __ASM_ARM_ARCH_IO_H */
-- 
2.9.0
