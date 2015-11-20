From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Nov 2015 23:20:28 +0100
Subject: [PATCH] ARM: ixp4xx: fix read{b,w,l} return types
Message-ID: <4577677.sEiIMqkHSM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ixp4xx, the readl() function returns an 'unsigned long' output
when indirect I/O is used. This is unlike any other platform, and
it causes lots of harmless compiler warnings, such as:

drivers/ata/libahci.c: In function 'ahci_show_host_version':
drivers/ata/libahci.c:254:22: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
drivers/block/mtip32xx/mtip32xx.c: In function 'mtip_hw_read_registers':
drivers/block/mtip32xx/mtip32xx.c:2602:31: warning: format '%X' expects argument of type 'unsigned int', but argument 3 has type 'long unsigned int' [-Wformat=]
drivers/block/cciss.c: In function 'print_cfg_table':
drivers/block/cciss.c:3845:25: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long unsigned int' [-Wformat=]

This changes all six of the ixp4xx specific I/O read functions
to return the same types that we have in the normal asm/io.h,
to avoid the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index b02439019963..7a0c13bf4269 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -143,7 +143,7 @@ static inline void __indirect_writesl(volatile void __iomem *bus_addr,
 		writel(*vaddr++, bus_addr);
 }
 
-static inline unsigned char __indirect_readb(const volatile void __iomem *p)
+static inline u8 __indirect_readb(const volatile void __iomem *p)
 {
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
@@ -166,7 +166,7 @@ static inline void __indirect_readsb(const volatile void __iomem *bus_addr,
 		*vaddr++ = readb(bus_addr);
 }
 
-static inline unsigned short __indirect_readw(const volatile void __iomem *p)
+static inline u16 __indirect_readw(const volatile void __iomem *p)
 {
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
@@ -189,7 +189,7 @@ static inline void __indirect_readsw(const volatile void __iomem *bus_addr,
 		*vaddr++ = readw(bus_addr);
 }
 
-static inline unsigned long __indirect_readl(const volatile void __iomem *p)
+static inline u32 __indirect_readl(const volatile void __iomem *p)
 {
 	u32 addr = (__force u32)p;
 	u32 data;
@@ -350,7 +350,7 @@ static inline void insl(u32 io_addr, void *p, u32 count)
 					((unsigned long)p <= (PIO_MASK + PIO_OFFSET)))
 
 #define	ioread8(p)			ioread8(p)
-static inline unsigned int ioread8(const void __iomem *addr)
+static inline u8 ioread8(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -378,7 +378,7 @@ static inline void ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
 }
 
 #define	ioread16(p)			ioread16(p)
-static inline unsigned int ioread16(const void __iomem *addr)
+static inline u16 ioread16(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
@@ -407,7 +407,7 @@ static inline void ioread16_rep(const void __iomem *addr, void *vaddr,
 }
 
 #define	ioread32(p)			ioread32(p)
-static inline unsigned int ioread32(const void __iomem *addr)
+static inline u32 ioread32(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
