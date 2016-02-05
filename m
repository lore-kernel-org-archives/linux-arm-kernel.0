From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Feb 2016 17:20:49 +0100
Subject: [PATCH 2/3] ARM: ixp4xx: avoid warning about ioport_map() macro
 argument processing
In-Reply-To: <1454689262-613421-1-git-send-email-arnd@arndb.de>
References: <1454689262-613421-1-git-send-email-arnd@arndb.de>
Message-ID: <1454689262-613421-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get a harmless compiler warning when building the cs89x0 driver
for ixp4xx:

drivers/net/ethernet/cirrus/cs89x0.c: In function 'cs89x0_ioport_probe':
drivers/net/ethernet/cirrus/cs89x0.c:1602:28: warning: suggest parentheses around '+' in operand of '&' [-Wparentheses]
  io_mem = ioport_map(ioport & ~3, NETCARD_IO_EXTENT);

Simply adding parentheses in the macro avoids the warning

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index d04d3ec97ac0..d8c2a4dc54d7 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -534,7 +534,7 @@ static inline void iowrite32_rep(void __iomem *addr, const void *vaddr,
 #endif
 }
 
-#define	ioport_map(port, nr)		((void __iomem*)(port + PIO_OFFSET))
+#define	ioport_map(port, nr)		((void __iomem*)((port) + PIO_OFFSET))
 #define	ioport_unmap(addr)
 #endif /* CONFIG_PCI */
 
-- 
2.7.0
