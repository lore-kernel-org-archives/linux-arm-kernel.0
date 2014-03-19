From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:13 +0100
Subject: [PATCH 16/62] ARM: ixp4xx: avoid use of PCIBIOS_MIN_MEM in io.h
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-17-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When using CONFIG_IXP4XX_INDIRECT_PCI, we run into a recursive
header file dependency between mach/io.h and asm/pci.h, resulting
in a build failure:

mach-ixp4xx/include/mach/io.h: In function 'is_pci_memory':
mach-ixp4xx/include/mach/io.h:53:18: error: 'PCIBIOS_MIN_MEM' undeclared (first use in this function)
  return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
                  ^
mach-ixp4xx/include/mach/io.h:53:18: note: each undeclared identifier is reported only once for each function it appears in

We can work around this by referencing the pcibios_min_mem variable
directly through an extern declaration, rather than using the macro.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Imre Kaloz <kaloz@openwrt.org>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 5cf30d1..559c69a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -48,9 +48,10 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
  * fallback to the default.
  */
 
+extern unsigned long pcibios_min_mem;
 static inline int is_pci_memory(u32 addr)
 {
-	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
+	return (addr >= pcibios_min_mem) && (addr <= 0x4FFFFFFF);
 }
 
 #define writeb(v, p)			__indirect_writeb(v, p)
-- 
1.8.3.2
