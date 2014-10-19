From: stefan.hengelein@fau.de (Stefan Hengelein)
Date: Sun, 19 Oct 2014 19:49:45 +0200
Subject: [PATCH] ARM: ixp4xx: remove compilation warnings in io.h
Message-ID: <1413740985-20365-1-git-send-email-stefan.hengelein@fau.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When arch/arm/mach-ixp4xx/common-pci.c is compiled, two warnings
occur:

arch/arm/mach-ixp4xx/include/mach/io.h:144: warning: passing argument 1 of '__raw_readb' makes pointer from integer without a cast
arch/arm/mach-ixp4xx/include/mach/io.h:79: warning: passing argument 2 of '__raw_writeb' makes pointer from integer without a cast

Both functions expect an 'volatile void __iomem *' but get an u32.
The 'u32 addr' variable is initialized with the address of an
'volatile void __iomem *' pointer. Passing the pointer
directly, avoids the warning and semantics are preserved.

This warning was found with vampyr.

Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 559c69a..7d11979 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -76,7 +76,7 @@ static inline void __indirect_writeb(u8 value, volatile void __iomem *p)
 	u32 n, byte_enables, data;
 
 	if (!is_pci_memory(addr)) {
-		__raw_writeb(value, addr);
+		__raw_writeb(value, p);
 		return;
 	}
 
@@ -141,7 +141,7 @@ static inline unsigned char __indirect_readb(const volatile void __iomem *p)
 	u32 n, byte_enables, data;
 
 	if (!is_pci_memory(addr))
-		return __raw_readb(addr);
+		return __raw_readb(p);
 
 	n = addr % 4;
 	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
-- 
1.9.1
