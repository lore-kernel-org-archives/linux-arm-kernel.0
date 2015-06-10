From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jun 2015 13:30:40 +0100
Subject: Moan: usage of __iormb() and __iowmb() outside of asm/io.h
In-Reply-To: <20150610112433.GM7557@n2100.arm.linux.org.uk>
References: <20150608184701.GA7557@n2100.arm.linux.org.uk>
 <20150610111819.GC22973@arm.com>
 <20150610112433.GM7557@n2100.arm.linux.org.uk>
Message-ID: <20150610123040.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 12:24:34PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 10, 2015 at 12:18:20PM +0100, Will Deacon wrote:
> > I agree to removing these from view; we already have plenty of barrier
> > macros and we don't want these to proliferate outside of the arch code.
> > 
> > Any chance you could do a similar change for arm64, please (we have the
> > same macros there)?
> 
> Yes - as you're aware, removing them from sight does cause us to decend
> into macro-hell in asm/io.h, but I think that's better than having people
> get their grubby fingers on arch internal stuff they shouldn't be touching.

Here's what I'm proposing for ARM.  As I say, it's macro-hell...  It's
also not perfect yet (since the __LINUX_ARM_ARCH__ < 6 case isn't
properly handled yet.)

The down-side is that we end up with a load of __arm_(read|write)*
functions, which people could start using.

I _guess_ a solution to that would be to have these macros be used to
generate inline functions with the correct accessor name as required.

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index addfb3dd095f..6566ef9f69f8 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -31,6 +31,16 @@
 #include <asm-generic/pci_iomap.h>
 #include <xen/xen.h>
 
+/* IO barriers */
+#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
+#include <asm/barrier.h>
+#define __iormb()		rmb()
+#define __iowmb()		wmb()
+#else
+#define __iormb()		do { } while (0)
+#define __iowmb()		do { } while (0)
+#endif
+
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
@@ -56,6 +66,61 @@ void __raw_readsb(const volatile void __iomem *addr, void *data, int bytelen);
 void __raw_readsw(const volatile void __iomem *addr, void *data, int wordlen);
 void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
 
+/*
+ * Macros used to define the raw IO accessors.
+ * This generates:
+ *  __arm_read[bwl]()
+ *  __arm_read[bwl]_rmb()
+ *  __arm_read[bwl]_le()
+ *  __arm_read[bwl]_be()
+ *  __arm_read[bwl]_le_rmb()
+ *  __arm_read[bwl]_be_rmb()
+ *  __arm_write[bwl]()
+ *  __arm_write[bwl]_rmb()
+ *  __arm_write[bwl]_le()
+ *  __arm_write[bwl]_be()
+ *  __arm_write[bwl]_le_rmb()
+ *  __arm_write[bwl]_be_rmb()
+ */
+#define DEFINE_IOR_OP(size, suffix, endian, instr, constraint, conv, barrier) \
+static inline u##size __arm_read##suffix(const volatile avoid __iomem *addr) \
+{									\
+	endian##size val;						\
+	asm volatile(instr						\
+		     : "=r" (val)					\
+		     : constraint (*(volatile endian##size __force *)addr)); \
+	barrier;							\
+	return conv(val);						\
+}
+
+#define DEFINE_IOW_OP(size, suffix, endian, instr, constraint, conv, barrier) \
+static inline void __arm_write##suffix(u##size val, volatile void __iomem *addr) \
+{									\
+	barrier;							\
+	asm volatile(instr						\
+		     : : "r" (conv(val)),				\
+			 constraint (*(volatile endian##size __force *)addr)); \
+}
+
+#define DEFINE_IOR_OP_B(size, suffix, endian, instr, constraint, conv)	\
+DEFINE_IOR_OP(size, suffix, endian, instr, constraint, conv, )		\
+DEFINE_IOR_OP(size, suffix##_rmb, endian, instr, constraint, conv, __iormb())
+
+#define DEFINE_IOW_OP_B(size, suffix, endian, instr, constraint, conv)	\
+DEFINE_IOW_OP(size, suffix, endian, instr, constraint, conv, )		\
+DEFINE_IOW_OP(size, suffix##_wmb, endian, instr, constraint, conv, __iowmb())
+
+#define DEFINE_IO_OP(size, suffix, rinstr, winstr, constraint)		\
+DEFINE_IOR_OP_B(size, suffix, u, rinstr, constraint,)			\
+DEFINE_IOW_OP_B(size, suffix, u, winstr, constraint,)
+
+#define DEFINE_IO_LE_OP(size, suffix, rinstr, winstr, constraint)	\
+DEFINE_IO_OP(size, suffix, rinstr, winstr, constraint)		\
+DEFINE_IOR_OP_B(size, suffix##_le, le, rinstr, constraint, cpu_to_le##size) \
+DEFINE_IOW_OP_B(size, suffix##_le, le, winstr, constraint, le##size##_to_cpu) \
+DEFINE_IOR_OP_B(size, suffix##_be, be, rinstr, constraint, cpu_to_be##size) \
+DEFINE_IOW_OP_B(size, suffix##_be, be, winstr, constraint, be##size##_to_cpu)
+
 #if __LINUX_ARM_ARCH__ < 6
 /*
  * Half-word accesses are problematic with RiscPC due to limitations of
@@ -70,57 +135,30 @@ void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
  * writeback addressing modes as these incur a significant performance
  * overhead (the address generation must be emulated in software).
  */
-#define __raw_writew __raw_writew
-static inline void __raw_writew(u16 val, volatile void __iomem *addr)
-{
-	asm volatile("strh %1, %0"
-		     : : "Q" (*(volatile u16 __force *)addr), "r" (val));
-}
+#define __raw_writew __arm_writew
+#define __raw_readw __arm_readw
+DEFINE_IO_LE_OP(16, w, "ldrh %0, %1", "strh %0, %1", "Q")
 
-#define __raw_readw __raw_readw
-static inline u16 __raw_readw(const volatile void __iomem *addr)
-{
-	u16 val;
-	asm volatile("ldrh %0, %1"
-		     : "=r" (val)
-		     : "Q" (*(volatile u16 __force *)addr));
-	return val;
-}
 #endif
 
-#define __raw_writeb __raw_writeb
-static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
-{
-	asm volatile("strb %1, %0"
-		     : : "Qo" (*(volatile u8 __force *)addr), "r" (val));
-}
+#define __raw_writeb __arm_writeb
+#define __raw_readb __arm_readb
+DEFINE_IO_OP(8, b, "ldrb %0, %1", "strb %0, %1", "Qo")
 
-#define __raw_writel __raw_writel
-static inline void __raw_writel(u32 val, volatile void __iomem *addr)
-{
-	asm volatile("str %1, %0"
-		     : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
-}
+#define __raw_writel __arm_writel
+#define __raw_readl __arm_readl
+DEFINE_IO_LE_OP(32, l, "ldr %0, %1", "str %0, %1", "Qo")
 
-#define __raw_readb __raw_readb
-static inline u8 __raw_readb(const volatile void __iomem *addr)
-{
-	u8 val;
-	asm volatile("ldrb %0, %1"
-		     : "=r" (val)
-		     : "Qo" (*(volatile u8 __force *)addr));
-	return val;
-}
+#undef DEFINE_IO_OP
+#undef DEFINE_IOW_OP
+#undef DEFINE_IOW_OP_B
+#undef DEFINE_IOR_OP
+#undef DEFINE_IOR_OP_B
+#undef DEFINE_IO_LE_OP
 
-#define __raw_readl __raw_readl
-static inline u32 __raw_readl(const volatile void __iomem *addr)
-{
-	u32 val;
-	asm volatile("ldr %0, %1"
-		     : "=r" (val)
-		     : "Qo" (*(volatile u32 __force *)addr));
-	return val;
-}
+/* Don't let people use these as another barrier in their code. */
+#undef __iowmb
+#undef __iormb
 
 /*
  * Architecture ioremap implementation.
@@ -170,16 +208,6 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 
 #define IOMEM(x)	((void __force __iomem *)(x))
 
-/* IO barriers */
-#ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
-#include <asm/barrier.h>
-#define __iormb()		rmb()
-#define __iowmb()		wmb()
-#else
-#define __iormb()		do { } while (0)
-#define __iowmb()		do { } while (0)
-#endif
-
 /* PCI fixed i/o mapping */
 #define PCI_IO_VIRT_BASE	0xfee00000
 #define PCI_IOBASE		((void __iomem *)PCI_IO_VIRT_BASE)
@@ -250,17 +278,13 @@ extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
  * The {in,out}[bwl] macros are for emulating x86-style PCI/ISA IO space.
  */
 #ifdef __io
-#define outb(v,p)	({ __iowmb(); __raw_writeb(v,__io(p)); })
-#define outw(v,p)	({ __iowmb(); __raw_writew((__force __u16) \
-					cpu_to_le16(v),__io(p)); })
-#define outl(v,p)	({ __iowmb(); __raw_writel((__force __u32) \
-					cpu_to_le32(v),__io(p)); })
-
-#define inb(p)	({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
-#define inw(p)	({ __u16 __v = le16_to_cpu((__force __le16) \
-			__raw_readw(__io(p))); __iormb(); __v; })
-#define inl(p)	({ __u32 __v = le32_to_cpu((__force __le32) \
-			__raw_readl(__io(p))); __iormb(); __v; })
+#define outb(v,p)		__arm_writeb_wmb(v,__io(p))
+#define outw(v,p)		__arm_writew_le_wmb(v,__io(p))
+#define outl(v,p)		__arm_writel_le_wmb(v,__io(p))
+
+#define inb(p)			__arm_readb_rmb(__io(p))
+#define inw(p)			__arm_readw_le_rmb(__io(p))
+#define inl(p)			__arm_readl_le_rmb(__io(p))
 
 #define outsb(p,d,l)		__raw_writesb(__io(p),d,l)
 #define outsw(p,d,l)		__raw_writesw(__io(p),d,l)
@@ -291,23 +315,21 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * IO port primitives for more information.
  */
 #ifndef readl
-#define readb_relaxed(c) ({ u8  __r = __raw_readb(c); __r; })
-#define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
-					__raw_readw(c)); __r; })
-#define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
-					__raw_readl(c)); __r; })
+#define readb_relaxed(c)	__arm_readb(c)
+#define readw_relaxed(c)	__arm_readw_le(c)
+#define readl_relaxed(c)	__arm_readl_le(c)
 
-#define writeb_relaxed(v,c)	__raw_writeb(v,c)
-#define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
-#define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
+#define writeb_relaxed(v,c)	__arm_writeb(v,c)
+#define writew_relaxed(v,c)	__arm_writew_le(v,c)
+#define writel_relaxed(v,c)	__arm_writel_le(v,c)
 
-#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
-#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
-#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+#define readb(c)		__arm_readb_rmb(c)
+#define readw(c)		__arm_readw_le_rmb(c)
+#define readl(c)		__arm_readl_le_rmb(c)
 
-#define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
-#define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
-#define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
+#define writeb(v,c)		__arm_writeb_wmb(v,c)
+#define writew(v,c)		__arm_writew_le_wmb(v,c)
+#define writel(v,c)		__arm_writel_le_wmb(v,c)
 
 #define readsb(p,d,l)		__raw_readsb(p,d,l)
 #define readsw(p,d,l)		__raw_readsw(p,d,l)
@@ -363,11 +385,11 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
 /*
  * io{read,write}{16,32}be() macros
  */
-#define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
-#define ioread32be(p)		({ __u32 __v = be32_to_cpu((__force __be32)__raw_readl(p)); __iormb(); __v; })
+#define ioread16be(p)			__arm_readw_be_rmb(p)
+#define ioread32be(p)			__arm_readl_be_rmb(p)
 
-#define iowrite16be(v,p)	({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
-#define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
+#define iowrite16be(v,p)		__arm_writew_be_wmb(v,p)
+#define iowrite32be(v,p)		__arm_writel_be_wmb(v,p)
 
 #ifndef ioport_map
 #define ioport_map ioport_map


-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
