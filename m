From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Feb 2016 17:20:50 +0100
Subject: [PATCH 3/3] ARM: ixp4xx: move indirect I/O into common-pci.c
In-Reply-To: <1454689262-613421-1-git-send-email-arnd@arndb.de>
References: <1454689262-613421-1-git-send-email-arnd@arndb.de>
Message-ID: <1454689262-613421-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pointer comparison in is_pci_memory() confuses gcc, so it
starts throwing bogus warnings about the use of possibly uninitialized
variables:

drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
arch/arm/include/asm/io.h:101:2: error: 'px_is' may be used uninitialized in this function [-Werror=maybe-uninitialized]
drivers/crypto/ixp4xx_crypto.c: In function 'aead_perform':
drivers/crypto/ixp4xx_crypto.c:1072:5: error: 'lastlen' may be used uninitialized in this function [-Werror=maybe-uninitialized]

The code is that gets warned about is correct, and we should not warn
about this. Moving the code into a .c file makes the object files
smaller and avoids the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-ixp4xx/common-pci.c      | 98 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-ixp4xx/include/mach/io.h | 95 +++-----------------------------
 2 files changed, 104 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-ixp4xx/common-pci.c b/arch/arm/mach-ixp4xx/common-pci.c
index 4977296f0c78..6f5d92f88062 100644
--- a/arch/arm/mach-ixp4xx/common-pci.c
+++ b/arch/arm/mach-ixp4xx/common-pci.c
@@ -166,6 +166,104 @@ int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data)
 	return retval;
 }
 
+#ifdef CONFIG_IXP4XX_INDIRECT_PCI
+void __indirect_writeb(u8 value, volatile void __iomem *p)
+{
+	u32 addr = (u32)p;
+	u32 n, byte_enables, data;
+
+	if (!is_pci_memory(addr)) {
+		__raw_writeb(value, p);
+		return;
+	}
+
+	n = addr % 4;
+	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
+	data = value << (8*n);
+	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
+}
+EXPORT_SYMBOL(__indirect_writeb);
+
+void __indirect_writew(u16 value, volatile void __iomem *p)
+{
+	u32 addr = (u32)p;
+	u32 n, byte_enables, data;
+
+	if (!is_pci_memory(addr)) {
+		__raw_writew(value, p);
+		return;
+	}
+
+	n = addr % 4;
+	byte_enables = (0xf & ~(BIT(n) | BIT(n+1))) << IXP4XX_PCI_NP_CBE_BESL;
+	data = value << (8*n);
+	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
+}
+EXPORT_SYMBOL(__indirect_writew);
+
+void __indirect_writel(u32 value, volatile void __iomem *p)
+{
+	u32 addr = (__force u32)p;
+
+	if (!is_pci_memory(addr)) {
+		__raw_writel(value, p);
+		return;
+	}
+
+	ixp4xx_pci_write(addr, NP_CMD_MEMWRITE, value);
+}
+EXPORT_SYMBOL(__indirect_writel);
+
+u8 __indirect_readb(const volatile void __iomem *p)
+{
+	u32 addr = (u32)p;
+	u32 n, byte_enables, data;
+
+	if (!is_pci_memory(addr))
+		return __raw_readb(p);
+
+	n = addr % 4;
+	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
+	if (ixp4xx_pci_read(addr, byte_enables | NP_CMD_MEMREAD, &data))
+		return 0xff;
+
+	return data >> (8*n);
+}
+EXPORT_SYMBOL(__indirect_readb);
+
+u16 __indirect_readw(const volatile void __iomem *p)
+{
+	u32 addr = (u32)p;
+	u32 n, byte_enables, data;
+
+	if (!is_pci_memory(addr))
+		return __raw_readw(p);
+
+	n = addr % 4;
+	byte_enables = (0xf & ~(BIT(n) | BIT(n+1))) << IXP4XX_PCI_NP_CBE_BESL;
+	if (ixp4xx_pci_read(addr, byte_enables | NP_CMD_MEMREAD, &data))
+		return 0xffff;
+
+	return data>>(8*n);
+}
+EXPORT_SYMBOL(__indirect_readw);
+
+u32 __indirect_readl(const volatile void __iomem *p)
+{
+	u32 addr = (__force u32)p;
+	u32 data;
+
+	if (!is_pci_memory(addr))
+		return __raw_readl(p);
+
+	if (ixp4xx_pci_read(addr, NP_CMD_MEMREAD, &data))
+		return 0xffffffff;
+
+	return data;
+}
+EXPORT_SYMBOL(__indirect_readl);
+#endif
+
 static u32 ixp4xx_config_addr(u8 bus_num, u16 devfn, int where)
 {
 	u32 addr;
diff --git a/arch/arm/mach-ixp4xx/include/mach/io.h b/arch/arm/mach-ixp4xx/include/mach/io.h
index d8c2a4dc54d7..e770858b490a 100644
--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -78,21 +78,12 @@ static inline int is_pci_memory(u32 addr)
 #define readsw(p, v, l)			__indirect_readsw(p, v, l)
 #define readsl(p, v, l)			__indirect_readsl(p, v, l)
 
-static inline void __indirect_writeb(u8 value, volatile void __iomem *p)
-{
-	u32 addr = (u32)p;
-	u32 n, byte_enables, data;
-
-	if (!is_pci_memory(addr)) {
-		__raw_writeb(value, p);
-		return;
-	}
-
-	n = addr % 4;
-	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
-	data = value << (8*n);
-	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
-}
+void __indirect_writeb(u8 value, volatile void __iomem *p);
+void __indirect_writew(u16 value, volatile void __iomem *p);
+void __indirect_writel(u32 value, volatile void __iomem *p);
+u8 __indirect_readb(const volatile void __iomem *p);
+u16 __indirect_readw(const volatile void __iomem *p);
+u32 __indirect_readl(const volatile void __iomem *p);
 
 static inline void __indirect_writesb(volatile void __iomem *bus_addr,
 				      const void *p, int count)
@@ -103,22 +94,6 @@ static inline void __indirect_writesb(volatile void __iomem *bus_addr,
 		writeb(*vaddr++, bus_addr);
 }
 
-static inline void __indirect_writew(u16 value, volatile void __iomem *p)
-{
-	u32 addr = (u32)p;
-	u32 n, byte_enables, data;
-
-	if (!is_pci_memory(addr)) {
-		__raw_writew(value, p);
-		return;
-	}
-
-	n = addr % 4;
-	byte_enables = (0xf & ~(BIT(n) | BIT(n+1))) << IXP4XX_PCI_NP_CBE_BESL;
-	data = value << (8*n);
-	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
-}
-
 static inline void __indirect_writesw(volatile void __iomem *bus_addr,
 				      const void *p, int count)
 {
@@ -128,18 +103,6 @@ static inline void __indirect_writesw(volatile void __iomem *bus_addr,
 		writew(*vaddr++, bus_addr);
 }
 
-static inline void __indirect_writel(u32 value, volatile void __iomem *p)
-{
-	u32 addr = (__force u32)p;
-
-	if (!is_pci_memory(addr)) {
-		__raw_writel(value, p);
-		return;
-	}
-
-	ixp4xx_pci_write(addr, NP_CMD_MEMWRITE, value);
-}
-
 static inline void __indirect_writesl(volatile void __iomem *bus_addr,
 				      const void *p, int count)
 {
@@ -148,22 +111,6 @@ static inline void __indirect_writesl(volatile void __iomem *bus_addr,
 		writel(*vaddr++, bus_addr);
 }
 
-static inline u8 __indirect_readb(const volatile void __iomem *p)
-{
-	u32 addr = (u32)p;
-	u32 n, byte_enables, data;
-
-	if (!is_pci_memory(addr))
-		return __raw_readb(p);
-
-	n = addr % 4;
-	byte_enables = (0xf & ~BIT(n)) << IXP4XX_PCI_NP_CBE_BESL;
-	if (ixp4xx_pci_read(addr, byte_enables | NP_CMD_MEMREAD, &data))
-		return 0xff;
-
-	return data >> (8*n);
-}
-
 static inline void __indirect_readsb(const volatile void __iomem *bus_addr,
 				     void *p, u32 count)
 {
@@ -173,22 +120,6 @@ static inline void __indirect_readsb(const volatile void __iomem *bus_addr,
 		*vaddr++ = readb(bus_addr);
 }
 
-static inline u16 __indirect_readw(const volatile void __iomem *p)
-{
-	u32 addr = (u32)p;
-	u32 n, byte_enables, data;
-
-	if (!is_pci_memory(addr))
-		return __raw_readw(p);
-
-	n = addr % 4;
-	byte_enables = (0xf & ~(BIT(n) | BIT(n+1))) << IXP4XX_PCI_NP_CBE_BESL;
-	if (ixp4xx_pci_read(addr, byte_enables | NP_CMD_MEMREAD, &data))
-		return 0xffff;
-
-	return data>>(8*n);
-}
-
 static inline void __indirect_readsw(const volatile void __iomem *bus_addr,
 				     void *p, u32 count)
 {
@@ -198,20 +129,6 @@ static inline void __indirect_readsw(const volatile void __iomem *bus_addr,
 		*vaddr++ = readw(bus_addr);
 }
 
-static inline u32 __indirect_readl(const volatile void __iomem *p)
-{
-	u32 addr = (__force u32)p;
-	u32 data;
-
-	if (!is_pci_memory(addr))
-		return __raw_readl(p);
-
-	if (ixp4xx_pci_read(addr, NP_CMD_MEMREAD, &data))
-		return 0xffffffff;
-
-	return data;
-}
-
 static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
 				     void *p, u32 count)
 {
-- 
2.7.0
