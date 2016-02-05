From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Feb 2016 17:20:48 +0100
Subject: [PATCH 1/3] ARM: ixp4xx: use normal prototype for {read, write}s{b, w,
 l}
Message-ID: <1454689262-613421-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ixp4xx defines the arguments to its __indirect_writesb() and other
functions as pointers to fixed-size data. This is not necessarily
wrong, and it works most of the time, but it causes warnings in
at least one driver:

drivers/net/ethernet/smsc/smc91x.c: In function 'smc_rcv':
drivers/net/ethernet/smsc/smc91x.c:495:21: error: passing argument 2 of '__indirect_readsw' from incompatible pointer type [-Werror=incompatible-pointer-types]
   SMC_PULL_DATA(lp, data, packet_len - 4);

All other definitions of the same functions pass void pointers,
so doing the same here avoids the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 7a0c13bf4269..d04d3ec97ac0 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -95,8 +95,10 @@ static inline void __indirect_writeb(u8 value, volatile void __iomem *p)
 }
 
 static inline void __indirect_writesb(volatile void __iomem *bus_addr,
-				      const u8 *vaddr, int count)
+				      const void *p, int count)
 {
+	const u8 *vaddr = p;
+
 	while (count--)
 		writeb(*vaddr++, bus_addr);
 }
@@ -118,8 +120,10 @@ static inline void __indirect_writew(u16 value, volatile void __iomem *p)
 }
 
 static inline void __indirect_writesw(volatile void __iomem *bus_addr,
-				      const u16 *vaddr, int count)
+				      const void *p, int count)
 {
+	const u16 *vaddr = p;
+
 	while (count--)
 		writew(*vaddr++, bus_addr);
 }
@@ -137,8 +141,9 @@ static inline void __indirect_writel(u32 value, volatile void __iomem *p)
 }
 
 static inline void __indirect_writesl(volatile void __iomem *bus_addr,
-				      const u32 *vaddr, int count)
+				      const void *p, int count)
 {
+	const u32 *vaddr = p;
 	while (count--)
 		writel(*vaddr++, bus_addr);
 }
@@ -160,8 +165,10 @@ static inline u8 __indirect_readb(const volatile void __iomem *p)
 }
 
 static inline void __indirect_readsb(const volatile void __iomem *bus_addr,
-				     u8 *vaddr, u32 count)
+				     void *p, u32 count)
 {
+	u8 *vaddr = p;
+
 	while (count--)
 		*vaddr++ = readb(bus_addr);
 }
@@ -183,8 +190,10 @@ static inline u16 __indirect_readw(const volatile void __iomem *p)
 }
 
 static inline void __indirect_readsw(const volatile void __iomem *bus_addr,
-				     u16 *vaddr, u32 count)
+				     void *p, u32 count)
 {
+	u16 *vaddr = p;
+
 	while (count--)
 		*vaddr++ = readw(bus_addr);
 }
@@ -204,8 +213,10 @@ static inline u32 __indirect_readl(const volatile void __iomem *p)
 }
 
 static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
-				     u32 *vaddr, u32 count)
+				     void *p, u32 count)
 {
+	u32 *vaddr = p;
+
 	while (count--)
 		*vaddr++ = readl(bus_addr);
 }
-- 
2.7.0
