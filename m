From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 00:43:51 +0100
Subject: IXP4xx: Rename indirect MMIO primitives from __ixp4xx_* to
	__indirect_*. Re: nothing
In-Reply-To: <m3zl6owvvi.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Sun, 15 Nov 2009 00:05:05 +0100")
References: <m3zl6owvvi.fsf@intrepid.localdomain>
Message-ID: <m3bpj4wu2w.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to clean IXP4xx headers a bit, esp. IO at this time.
Comments?
(The VMALLOC_START issue is/will be addressed separately).

--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -55,8 +55,8 @@ extern int ixp4xx_pci_write(u32 addr, u32 cmd, u32 data);
  * access registers. If something outside of PCI is ioremap'd, we
  * fallback to the default.
  */
-static inline void __iomem *
-__ixp4xx_ioremap(unsigned long addr, size_t size, unsigned int mtype)
+static inline void __iomem * __indirect_ioremap(unsigned long addr, size_t size,
+						unsigned int mtype)
 {
 	if((addr < PCIBIOS_MIN_MEM) || (addr > 0x4fffffff))
 		return __arm_ioremap(addr, size, mtype);
@@ -64,34 +64,32 @@ __ixp4xx_ioremap(unsigned long addr, size_t size, unsigned int mtype)
 	return (void __iomem *)addr;
 }
 
-static inline void
-__ixp4xx_iounmap(void __iomem *addr)
+static inline void __indirect_iounmap(void __iomem *addr)
 {
 	if ((__force u32)addr >= VMALLOC_START)
 		__iounmap(addr);
 }
 
-#define __arch_ioremap(a, s, f)		__ixp4xx_ioremap(a, s, f)
-#define	__arch_iounmap(a)		__ixp4xx_iounmap(a)
+#define __arch_ioremap(a, s, f)		__indirect_ioremap(a, s, f)
+#define __arch_iounmap(a)		__indirect_iounmap(a)
 
-#define	writeb(v, p)			__ixp4xx_writeb(v, p)
-#define	writew(v, p)			__ixp4xx_writew(v, p)
-#define	writel(v, p)			__ixp4xx_writel(v, p)
+#define writeb(v, p)			__indirect_writeb(v, p)
+#define writew(v, p)			__indirect_writew(v, p)
+#define writel(v, p)			__indirect_writel(v, p)
 
-#define	writesb(p, v, l)		__ixp4xx_writesb(p, v, l)
-#define	writesw(p, v, l)		__ixp4xx_writesw(p, v, l)
-#define	writesl(p, v, l)		__ixp4xx_writesl(p, v, l)
-	
-#define	readb(p)			__ixp4xx_readb(p)
-#define	readw(p)			__ixp4xx_readw(p)
-#define	readl(p)			__ixp4xx_readl(p)
-	
-#define	readsb(p, v, l)			__ixp4xx_readsb(p, v, l)
-#define	readsw(p, v, l)			__ixp4xx_readsw(p, v, l)
-#define	readsl(p, v, l)			__ixp4xx_readsl(p, v, l)
+#define writesb(p, v, l)		__indirect_writesb(p, v, l)
+#define writesw(p, v, l)		__indirect_writesw(p, v, l)
+#define writesl(p, v, l)		__indirect_writesl(p, v, l)
 
-static inline void 
-__ixp4xx_writeb(u8 value, volatile void __iomem *p)
+#define readb(p)			__indirect_readb(p)
+#define readw(p)			__indirect_readw(p)
+#define readl(p)			__indirect_readl(p)
+
+#define readsb(p, v, l)			__indirect_readsb(p, v, l)
+#define readsw(p, v, l)			__indirect_readsw(p, v, l)
+#define readsl(p, v, l)			__indirect_readsl(p, v, l)
+
+static inline void __indirect_writeb(u8 value, volatile void __iomem *p)
 {
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
@@ -107,15 +105,14 @@ __ixp4xx_writeb(u8 value, volatile void __iomem *p)
 	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
 }
 
-static inline void
-__ixp4xx_writesb(volatile void __iomem *bus_addr, const u8 *vaddr, int count)
+static inline void __indirect_writesb(volatile void __iomem *bus_addr,
+				      const u8 *vaddr, int count)
 {
 	while (count--)
 		writeb(*vaddr++, bus_addr);
 }
 
-static inline void 
-__ixp4xx_writew(u16 value, volatile void __iomem *p)
+static inline void __indirect_writew(u16 value, volatile void __iomem *p)
 {
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
@@ -131,15 +128,14 @@ __ixp4xx_writew(u16 value, volatile void __iomem *p)
 	ixp4xx_pci_write(addr, byte_enables | NP_CMD_MEMWRITE, data);
 }
 
-static inline void
-__ixp4xx_writesw(volatile void __iomem *bus_addr, const u16 *vaddr, int count)
+static inline void __indirect_writesw(volatile void __iomem *bus_addr,
+				      const u16 *vaddr, int count)
 {
 	while (count--)
 		writew(*vaddr++, bus_addr);
 }
 
-static inline void 
-__ixp4xx_writel(u32 value, volatile void __iomem *p)
+static inline void __indirect_writel(u32 value, volatile void __iomem *p)
 {
 	u32 addr = (__force u32)p;
 	if (addr >= VMALLOC_START) {
@@ -150,15 +146,14 @@ __ixp4xx_writel(u32 value, volatile void __iomem *p)
 	ixp4xx_pci_write(addr, NP_CMD_MEMWRITE, value);
 }
 
-static inline void
-__ixp4xx_writesl(volatile void __iomem *bus_addr, const u32 *vaddr, int count)
+static inline void __indirect_writesl(volatile void __iomem *bus_addr,
+				      const u32 *vaddr, int count)
 {
 	while (count--)
 		writel(*vaddr++, bus_addr);
 }
 
-static inline unsigned char 
-__ixp4xx_readb(const volatile void __iomem *p)
+static inline unsigned char __indirect_readb(const volatile void __iomem *p)
 {
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
@@ -174,15 +169,14 @@ __ixp4xx_readb(const volatile void __iomem *p)
 	return data >> (8*n);
 }
 
-static inline void
-__ixp4xx_readsb(const volatile void __iomem *bus_addr, u8 *vaddr, u32 count)
+static inline void __indirect_readsb(const volatile void __iomem *bus_addr,
+				     u8 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = readb(bus_addr);
 }
 
-static inline unsigned short 
-__ixp4xx_readw(const volatile void __iomem *p)
+static inline unsigned short __indirect_readw(const volatile void __iomem *p)
 {
 	u32 addr = (u32)p;
 	u32 n, byte_enables, data;
@@ -198,15 +192,14 @@ __ixp4xx_readw(const volatile void __iomem *p)
 	return data>>(8*n);
 }
 
-static inline void 
-__ixp4xx_readsw(const volatile void __iomem *bus_addr, u16 *vaddr, u32 count)
+static inline void __indirect_readsw(const volatile void __iomem *bus_addr,
+				     u16 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = readw(bus_addr);
 }
 
-static inline unsigned long 
-__ixp4xx_readl(const volatile void __iomem *p)
+static inline unsigned long __indirect_readl(const volatile void __iomem *p)
 {
 	u32 addr = (__force u32)p;
 	u32 data;
@@ -220,8 +213,8 @@ __ixp4xx_readl(const volatile void __iomem *p)
 	return data;
 }
 
-static inline void 
-__ixp4xx_readsl(const volatile void __iomem *bus_addr, u32 *vaddr, u32 count)
+static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
+				     u32 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = readl(bus_addr);
@@ -235,7 +228,7 @@ __ixp4xx_readsl(const volatile void __iomem *bus_addr, u32 *vaddr, u32 count)
 #define memcpy_fromio(a,c,l)		_memcpy_fromio((a),(c),(l))
 #define memcpy_toio(c,a,l)		_memcpy_toio((c),(a),(l))
 
-#endif
+#endif /* CONFIG_IXP4XX_INDIRECT_PCI */
 
 #ifndef CONFIG_PCI
 
@@ -385,7 +378,7 @@ __ixp4xx_ioread8(const void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return (unsigned int)__raw_readb(port);
 #else
-		return (unsigned int)__ixp4xx_readb(addr);
+		return (unsigned int)__indirect_readb(addr);
 #endif
 }
 
@@ -399,7 +392,7 @@ __ixp4xx_ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsb(addr, vaddr, count);
 #else
-		__ixp4xx_readsb(addr, vaddr, count);
+		__indirect_readsb(addr, vaddr, count);
 #endif
 }
 
@@ -413,7 +406,7 @@ __ixp4xx_ioread16(const void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return le16_to_cpu(__raw_readw((u32)port));
 #else
-		return (unsigned int)__ixp4xx_readw(addr);
+		return (unsigned int)__indirect_readw(addr);
 #endif
 }
 
@@ -427,7 +420,7 @@ __ixp4xx_ioread16_rep(const void __iomem *addr, void *vaddr, u32 count)
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsw(addr, vaddr, count);
 #else
-		__ixp4xx_readsw(addr, vaddr, count);
+		__indirect_readsw(addr, vaddr, count);
 #endif
 }
 
@@ -441,7 +434,7 @@ __ixp4xx_ioread32(const void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return le32_to_cpu((__force __le32)__raw_readl(addr));
 #else
-		return (unsigned int)__ixp4xx_readl(addr);
+		return (unsigned int)__indirect_readl(addr);
 #endif
 	}
 }
@@ -456,7 +449,7 @@ __ixp4xx_ioread32_rep(const void __iomem *addr, void *vaddr, u32 count)
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsl(addr, vaddr, count);
 #else
-		__ixp4xx_readsl(addr, vaddr, count);
+		__indirect_readsl(addr, vaddr, count);
 #endif
 }
 
@@ -470,7 +463,7 @@ __ixp4xx_iowrite8(u8 value, void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writeb(value, port);
 #else
-		__ixp4xx_writeb(value, addr);
+		__indirect_writeb(value, addr);
 #endif
 }
 
@@ -484,7 +477,7 @@ __ixp4xx_iowrite8_rep(void __iomem *addr, const void *vaddr, u32 count)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesb(addr, vaddr, count);
 #else
-		__ixp4xx_writesb(addr, vaddr, count);
+		__indirect_writesb(addr, vaddr, count);
 #endif
 }
 
@@ -498,7 +491,7 @@ __ixp4xx_iowrite16(u16 value, void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writew(cpu_to_le16(value), addr);
 #else
-		__ixp4xx_writew(value, addr);
+		__indirect_writew(value, addr);
 #endif
 }
 
@@ -512,7 +505,7 @@ __ixp4xx_iowrite16_rep(void __iomem *addr, const void *vaddr, u32 count)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesw(addr, vaddr, count);
 #else
-		__ixp4xx_writesw(addr, vaddr, count);
+		__indirect_writesw(addr, vaddr, count);
 #endif
 }
 
@@ -526,7 +519,7 @@ __ixp4xx_iowrite32(u32 value, void __iomem *addr)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writel((u32 __force)cpu_to_le32(value), addr);
 #else
-		__ixp4xx_writel(value, addr);
+		__indirect_writel(value, addr);
 #endif
 }
 
@@ -540,7 +533,7 @@ __ixp4xx_iowrite32_rep(void __iomem *addr, const void *vaddr, u32 count)
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesl(addr, vaddr, count);
 #else
-		__ixp4xx_writesl(addr, vaddr, count);
+		__indirect_writesl(addr, vaddr, count);
 #endif
 }
 

-- 
Krzysztof Halasa
