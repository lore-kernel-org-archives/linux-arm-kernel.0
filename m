From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jul 2017 17:51:47 +0200
Subject: [PATCH 09/12] ARM: ixp4xx: use normal prototype for {read, write}s{b,
 w, l}
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Message-ID: <20170720155209.3250880-6-arnd@arndb.de>
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
Acked-by: Krzysztof Halasa <khalasa@piap.pl>
---
Originally sent on Feb 2016, but it got lost
---
 arch/arm/mach-ixp4xx/include/mach/io.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index 2f84c26a6758..844e8ac593e2 100644
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
2.9.0
