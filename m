From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 01:21:34 +0100
Subject: IXP4xx: Indirect PCI MMIO compile failure and fix
In-Reply-To: <20091114231854.GB30027@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat, 14 Nov 2009 23:18:54 +0000")
References: <m3pr7kyi9x.fsf@intrepid.localdomain>
	<20091114210533.GA30027@n2100.arm.linux.org.uk>
	<m34oowyako.fsf@intrepid.localdomain>
	<20091114231854.GB30027@n2100.arm.linux.org.uk>
Message-ID: <m37htswsc1.fsf_-_@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm attaching the complete patch, it seems to work on my IXP425 with
indirect PCI, the only PCI device is SIL3512 SATA mini-PCI card.

That #include <linux/mm.h> wasn't a bright idea :-(

Comments?

--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -55,10 +55,16 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
  * access registers. If something outside of PCI is ioremap'd, we
  * fallback to the default.
  */
+
+static inline int is_pci_memory(u32 addr)
+{
+	return (addr >= PCIBIOS_MIN_MEM) && (addr <= 0x4FFFFFFF);
+}
+
 static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
 						unsigned int mtype)
 {
-	if((addr < PCIBIOS_MIN_MEM) || (addr > 0x4fffffff))
+	if (!is_pci_memory(addr))
 		return __arm_ioremap(addr, size, mtype);
 
 	return (void __iomem *)addr;
@@ -66,7 +72,7 @@ static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
 
 static inline void __indirect_iounmap(void __iomem *addr)
 {
-	if ((__force u32)addr >= VMALLOC_START)
+	if (!is_pci_memory((__force u32)addr))
 		__iounmap(addr);
 }
 
@@ -94,7 +100,7 @@ static inline void __indirect_writeb(u8 value, volatile void __iomem *p)
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
-	if (addr >= VMALLOC_START) {
+	if (!is_pci_memory(addr)) {
 		__raw_writeb(value, addr);
 		return;
 	}
@@ -117,7 +123,7 @@ static inline void __indirect_writew(u16 value, volatile void __iomem *p)
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
-	if (addr >= VMALLOC_START) {
+	if (!is_pci_memory(addr)) {
 		__raw_writew(value, addr);
 		return;
 	}
@@ -138,7 +144,8 @@ static inline void __indirect_writesw(volatile void __iomem *bus_addr,
 static inline void __indirect_writel(u32 value, volatile void __iomem *p)
 {
 	u32 addr = (__force u32)p;
-	if (addr >= VMALLOC_START) {
+
+	if (!is_pci_memory(addr)) {
 		__raw_writel(value, p);
 		return;
 	}
@@ -158,7 +165,7 @@ static inline unsigned char __indirect_readb(const volatile void __iomem *p)
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
-	if (addr >= VMALLOC_START)
+	if (!is_pci_memory(addr))
 		return __raw_readb(addr);
 
 	n = addr % 4;
@@ -181,7 +188,7 @@ static inline unsigned short __indirect_readw(const volatile void __iomem *p)
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
 
-	if (addr >= VMALLOC_START)
+	if (!is_pci_memory(addr))
 		return __raw_readw(addr);
 
 	n = addr % 4;
@@ -204,7 +211,7 @@ static inline unsigned long __indirect_readl(const volatile void __iomem *p)
 	u32 addr = (__force u32)p;
 	u32 data;
 
-	if (addr >= VMALLOC_START)
+	if (!is_pci_memory(addr))
 		return __raw_readl(p);
 
 	if (ixp4xx_pci_read(addr, NP_CMD_MEMREAD, &data))

-- 
Krzysztof Halasa
