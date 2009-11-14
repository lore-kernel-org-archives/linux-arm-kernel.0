From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 15 Nov 2009 00:33:23 +0100
Subject: IXP4xx: Drop "__ixp4xx_" prefix from in/out/ioread/iowrite functions
	for clarity. Re: (to fool the list server)
In-Reply-To: <m3zl6owvvi.fsf@intrepid.localdomain> (Krzysztof Halasa's message
	of "Sun, 15 Nov 2009 00:05:05 +0100")
References: <m3zl6owvvi.fsf@intrepid.localdomain>
Message-ID: <m3k4xswukc.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HAVE_IOREAD_AND_IOWRITE patch and the one which changes indirect
MMIO names __ixp4xx_* -> __indirect_* (on hold by the list server)
enables us to remove all those meaningless __ixp4xx_ prefixes.

This way we have (on IXP4xx):
- __indirect_* for indirect MMIO (only enabled if CONFIG_IXP4XX_INDIRECT_PCI)
- outX/inX/ioreadX/iowriteX() etc.
- readX/writeX which is implemented in assembler and swaps the bytes
  in u16/u32 (on IXP4xx we could eventually use value-preserving mapping)
- __raw_readX/__raw_writeX which simply does *(volatile*)ptr, thus
  preserving order of bytes (not value - ARM requires at least
  order-preserving connection to PCI).

Comments?

--- a/arch/arm/mach-ixp4xx/include/mach/io.h
+++ b/arch/arm/mach-ixp4xx/include/mach/io.h
@@ -243,25 +243,8 @@ static inline void __indirect_readsl(const volatile void __iomem *bus_addr,
  * transaction.  This means that we need to override the default
  * I/O functions.
  */
-#define	outb(p, v)			__ixp4xx_outb(p, v)
-#define	outw(p, v)			__ixp4xx_outw(p, v)
-#define	outl(p, v)			__ixp4xx_outl(p, v)
-	
-#define	outsb(p, v, l)			__ixp4xx_outsb(p, v, l)
-#define	outsw(p, v, l)			__ixp4xx_outsw(p, v, l)
-#define	outsl(p, v, l)			__ixp4xx_outsl(p, v, l)
 
-#define	inb(p)				__ixp4xx_inb(p)
-#define	inw(p)				__ixp4xx_inw(p)
-#define	inl(p)				__ixp4xx_inl(p)
-
-#define	insb(p, v, l)			__ixp4xx_insb(p, v, l)
-#define	insw(p, v, l)			__ixp4xx_insw(p, v, l)
-#define	insl(p, v, l)			__ixp4xx_insl(p, v, l)
-
-
-static inline void 
-__ixp4xx_outb(u8 value, u32 addr)
+static inline void outb(u8 value, u32 addr)
 {
 	u32 n, byte_enables, data;
 	n = addr % 4;
@@ -270,15 +253,13 @@ __ixp4xx_outb(u8 value, u32 addr)
 	ixp4xx_pci_write(addr, byte_enables | NP_CMD_IOWRITE, data);
 }
 
-static inline void 
-__ixp4xx_outsb(u32 io_addr, const u8 *vaddr, u32 count)
+static inline void outsb(u32 io_addr, const u8 *vaddr, u32 count)
 {
 	while (count--)
 		outb(*vaddr++, io_addr);
 }
 
-static inline void 
-__ixp4xx_outw(u16 value, u32 addr)
+static inline void outw(u16 value, u32 addr)
 {
 	u32 n, byte_enables, data;
 	n = addr % 4;
@@ -287,28 +268,24 @@ __ixp4xx_outw(u16 value, u32 addr)
 	ixp4xx_pci_write(addr, byte_enables | NP_CMD_IOWRITE, data);
 }
 
-static inline void 
-__ixp4xx_outsw(u32 io_addr, const u16 *vaddr, u32 count)
+static inline void outsw(u32 io_addr, const u16 *vaddr, u32 count)
 {
 	while (count--)
 		outw(cpu_to_le16(*vaddr++), io_addr);
 }
 
-static inline void 
-__ixp4xx_outl(u32 value, u32 addr)
+static inline void outl(u32 value, u32 addr)
 {
 	ixp4xx_pci_write(addr, NP_CMD_IOWRITE, value);
 }
 
-static inline void 
-__ixp4xx_outsl(u32 io_addr, const u32 *vaddr, u32 count)
+static inline void outsl(u32 io_addr, const u32 *vaddr, u32 count)
 {
 	while (count--)
 		outl(cpu_to_le32(*vaddr++), io_addr);
 }
 
-static inline u8 
-__ixp4xx_inb(u32 addr)
+static inline u8 inb(u32 addr)
 {
 	u32 n, byte_enables, data;
 	n = addr % 4;
@@ -319,15 +296,13 @@ __ixp4xx_inb(u32 addr)
 	return data >> (8*n);
 }
 
-static inline void 
-__ixp4xx_insb(u32 io_addr, u8 *vaddr, u32 count)
+static inline void insb(u32 io_addr, u8 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = inb(io_addr);
 }
 
-static inline u16 
-__ixp4xx_inw(u32 addr)
+static inline u16 inw(u32 addr)
 {
 	u32 n, byte_enables, data;
 	n = addr % 4;
@@ -338,15 +313,13 @@ __ixp4xx_inw(u32 addr)
 	return data>>(8*n);
 }
 
-static inline void 
-__ixp4xx_insw(u32 io_addr, u16 *vaddr, u32 count)
+static inline void insw(u32 io_addr, u16 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = le16_to_cpu(inw(io_addr));
 }
 
-static inline u32 
-__ixp4xx_inl(u32 addr)
+static inline u32 inl(u32 addr)
 {
 	u32 data;
 	if (ixp4xx_pci_read(addr, NP_CMD_IOREAD, &data))
@@ -355,8 +328,7 @@ __ixp4xx_inl(u32 addr)
 	return data;
 }
 
-static inline void 
-__ixp4xx_insl(u32 io_addr, u32 *vaddr, u32 count)
+static inline void insl(u32 io_addr, u32 *vaddr, u32 count)
 {
 	while (count--)
 		*vaddr++ = le32_to_cpu(inl(io_addr));
@@ -368,12 +340,11 @@ __ixp4xx_insl(u32 io_addr, u32 *vaddr, u32 count)
 #define	__is_io_address(p)	(((unsigned long)p >= PIO_OFFSET) && \
 					((unsigned long)p <= (PIO_MASK + PIO_OFFSET)))
 
-static inline unsigned int
-__ixp4xx_ioread8(const void __iomem *addr)
+static inline unsigned int ioread8(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		return (unsigned int)__ixp4xx_inb(port & PIO_MASK);
+		return (unsigned int)inb(port & PIO_MASK);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return (unsigned int)__raw_readb(port);
@@ -382,12 +353,11 @@ __ixp4xx_ioread8(const void __iomem *addr)
 #endif
 }
 
-static inline void
-__ixp4xx_ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
+static inline void ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_insb(port & PIO_MASK, vaddr, count);
+		insb(port & PIO_MASK, vaddr, count);
 	else
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsb(addr, vaddr, count);
@@ -396,12 +366,11 @@ __ixp4xx_ioread8_rep(const void __iomem *addr, void *vaddr, u32 count)
 #endif
 }
 
-static inline unsigned int
-__ixp4xx_ioread16(const void __iomem *addr)
+static inline unsigned int ioread16(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		return	(unsigned int)__ixp4xx_inw(port & PIO_MASK);
+		return	(unsigned int)inw(port & PIO_MASK);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return le16_to_cpu(__raw_readw((u32)port));
@@ -410,12 +379,12 @@ __ixp4xx_ioread16(const void __iomem *addr)
 #endif
 }
 
-static inline void
-__ixp4xx_ioread16_rep(const void __iomem *addr, void *vaddr, u32 count)
+static inline void ioread16_rep(const void __iomem *addr, void *vaddr,
+				u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_insw(port & PIO_MASK, vaddr, count);
+		insw(port & PIO_MASK, vaddr, count);
 	else
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsw(addr, vaddr, count);
@@ -424,12 +393,11 @@ __ixp4xx_ioread16_rep(const void __iomem *addr, void *vaddr, u32 count)
 #endif
 }
 
-static inline unsigned int
-__ixp4xx_ioread32(const void __iomem *addr)
+static inline unsigned int ioread32(const void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		return	(unsigned int)__ixp4xx_inl(port & PIO_MASK);
+		return	(unsigned int)inl(port & PIO_MASK);
 	else {
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		return le32_to_cpu((__force __le32)__raw_readl(addr));
@@ -439,12 +407,12 @@ __ixp4xx_ioread32(const void __iomem *addr)
 	}
 }
 
-static inline void
-__ixp4xx_ioread32_rep(const void __iomem *addr, void *vaddr, u32 count)
+static inline void ioread32_rep(const void __iomem *addr, void *vaddr,
+				u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_insl(port & PIO_MASK, vaddr, count);
+		insl(port & PIO_MASK, vaddr, count);
 	else
 #ifndef	CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_readsl(addr, vaddr, count);
@@ -453,12 +421,11 @@ __ixp4xx_ioread32_rep(const void __iomem *addr, void *vaddr, u32 count)
 #endif
 }
 
-static inline void
-__ixp4xx_iowrite8(u8 value, void __iomem *addr)
+static inline void iowrite8(u8 value, void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_outb(value, port & PIO_MASK);
+		outb(value, port & PIO_MASK);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writeb(value, port);
@@ -467,12 +434,12 @@ __ixp4xx_iowrite8(u8 value, void __iomem *addr)
 #endif
 }
 
-static inline void
-__ixp4xx_iowrite8_rep(void __iomem *addr, const void *vaddr, u32 count)
+static inline void iowrite8_rep(void __iomem *addr, const void *vaddr,
+				u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_outsb(port & PIO_MASK, vaddr, count);
+		outsb(port & PIO_MASK, vaddr, count);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesb(addr, vaddr, count);
@@ -481,12 +448,11 @@ __ixp4xx_iowrite8_rep(void __iomem *addr, const void *vaddr, u32 count)
 #endif
 }
 
-static inline void
-__ixp4xx_iowrite16(u16 value, void __iomem *addr)
+static inline void iowrite16(u16 value, void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_outw(value, port & PIO_MASK);
+		outw(value, port & PIO_MASK);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writew(cpu_to_le16(value), addr);
@@ -495,12 +461,12 @@ __ixp4xx_iowrite16(u16 value, void __iomem *addr)
 #endif
 }
 
-static inline void
-__ixp4xx_iowrite16_rep(void __iomem *addr, const void *vaddr, u32 count)
+static inline void iowrite16_rep(void __iomem *addr, const void *vaddr,
+				 u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_outsw(port & PIO_MASK, vaddr, count);
+		outsw(port & PIO_MASK, vaddr, count);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesw(addr, vaddr, count);
@@ -509,12 +475,11 @@ __ixp4xx_iowrite16_rep(void __iomem *addr, const void *vaddr, u32 count)
 #endif
 }
 
-static inline void
-__ixp4xx_iowrite32(u32 value, void __iomem *addr)
+static inline void iowrite32(u32 value, void __iomem *addr)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_outl(value, port & PIO_MASK);
+		outl(value, port & PIO_MASK);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writel((u32 __force)cpu_to_le32(value), addr);
@@ -523,12 +488,12 @@ __ixp4xx_iowrite32(u32 value, void __iomem *addr)
 #endif
 }
 
-static inline void
-__ixp4xx_iowrite32_rep(void __iomem *addr, const void *vaddr, u32 count)
+static inline void iowrite32_rep(void __iomem *addr, const void *vaddr,
+				 u32 count)
 {
 	unsigned long port = (unsigned long __force)addr;
 	if (__is_io_address(port))
-		__ixp4xx_outsl(port & PIO_MASK, vaddr, count);
+		outsl(port & PIO_MASK, vaddr, count);
 	else
 #ifndef CONFIG_IXP4XX_INDIRECT_PCI
 		__raw_writesl(addr, vaddr, count);
@@ -537,27 +502,11 @@ __ixp4xx_iowrite32_rep(void __iomem *addr, const void *vaddr, u32 count)
 #endif
 }
 
-#define	ioread8(p)			__ixp4xx_ioread8(p)
-#define	ioread16(p)			__ixp4xx_ioread16(p)
-#define	ioread32(p)			__ixp4xx_ioread32(p)
-
-#define	ioread8_rep(p, v, c)		__ixp4xx_ioread8_rep(p, v, c)
-#define	ioread16_rep(p, v, c)		__ixp4xx_ioread16_rep(p, v, c)
-#define	ioread32_rep(p, v, c)		__ixp4xx_ioread32_rep(p, v, c)
-
-#define	iowrite8(v,p)			__ixp4xx_iowrite8(v,p)
-#define	iowrite16(v,p)			__ixp4xx_iowrite16(v,p)
-#define	iowrite32(v,p)			__ixp4xx_iowrite32(v,p)
-
-#define	iowrite8_rep(p, v, c)		__ixp4xx_iowrite8_rep(p, v, c)
-#define	iowrite16_rep(p, v, c)		__ixp4xx_iowrite16_rep(p, v, c)
-#define	iowrite32_rep(p, v, c)		__ixp4xx_iowrite32_rep(p, v, c)
-
 #define HAVE_IOREAD_AND_IOWRITE
 
 #define	ioport_map(port, nr)		((void __iomem*)(port + PIO_OFFSET))
 #define	ioport_unmap(addr)
-#endif	// !CONFIG_PCI
+#endif	// CONFIG_PCI
 
 #endif	//  __ASM_ARM_ARCH_IO_H
 

-- 
Krzysztof Halasa
