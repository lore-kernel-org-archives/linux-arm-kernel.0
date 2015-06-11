From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Jun 2015 15:16:18 +0100
Subject: Moan: usage of __iormb() and __iowmb() outside of asm/io.h
In-Reply-To: <20150610165904.GB6612@arm.com>
References: <20150608184701.GA7557@n2100.arm.linux.org.uk>
 <20150610111819.GC22973@arm.com>
 <20150610112433.GM7557@n2100.arm.linux.org.uk>
 <20150610123040.GN7557@n2100.arm.linux.org.uk>
 <20150610165323.GE22844@e104818-lin.cambridge.arm.com>
 <20150610165904.GB6612@arm.com>
Message-ID: <20150611141618.GY7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 05:59:04PM +0100, Will Deacon wrote:
> Or generate static line functions from the macros, as Russell suggested
> previously. Then we can #undef the macros at the end of the file (I have
> patches doing this for our cmpxchg implementation).

Or something like this, which probably improves the ctags stuff - but
at the expense if not using macros, so the chances of there being
something wrong is _considerably_ greater.

Macros have their place: when there's lots of repetitive code with only
a few changes between, which is very much the case with these IO accessor
macros.  Also look at what happens to the line count when we have an
inline function for every damn accessor which has to exist in its own
individual right just for ctags.

IMHO, this is not "better" in any regard - it's just a different trade-off
between ctags-compatibility, and making sure the code is correct.

 arch/arm/include/asm/io.h | 248 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 195 insertions(+), 53 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index addfb3dd095f..9b1f89918bf0 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -56,70 +56,90 @@ void __raw_readsb(const volatile void __iomem *addr, void *data, int bytelen);
 void __raw_readsw(const volatile void __iomem *addr, void *data, int wordlen);
 void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
 
+/*
+ * Macros used to define the raw assembly IO accessors.
+ */
+#define __IOR_OP(type, instr, constraint, addr)				\
+	({								\
+		type ior_val;						\
+		asm volatile(instr					\
+			     : "=r" (ior_val)				\
+			     : constraint (*(volatile type __force *)addr)); \
+		ior_val;						\
+	})
+
+#define __IOW_OP(type, instr, constraint, addr, val)			\
+	({								\
+		asm volatile(instr					\
+			     : : "r" (val),				\
+				 constraint (*(volatile type __force *)addr)); \
+	})
+
 #if __LINUX_ARM_ARCH__ < 6
 /*
  * Half-word accesses are problematic with RiscPC due to limitations of
  * the bus. Rather than special-case the machine, just let the compiler
  * generate the access for CPUs prior to ARMv6.
  */
-#define __raw_readw(a)         (__chk_io_ptr(a), *(volatile unsigned short __force *)(a))
-#define __raw_writew(v,a)      ((void)(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v)))
+#define __IOR16(endian, addr)		\
+	*(volatile unsigned short __force *)(addr))
+#define __IOW16(endian, addr, val)	\
+	((void)*(volatile unsigned short __force *)(addr) = (val))
 #else
 /*
  * When running under a hypervisor, we want to avoid I/O accesses with
  * writeback addressing modes as these incur a significant performance
  * overhead (the address generation must be emulated in software).
  */
+#define __IOR16(endian, addr) \
+	__IOR_OP(endian##16, "ldrh %0, %1", "Q", addr)
+#define __IOW16(endian, addr, val) \
+	__IOW_OP(endian##16, "strh %0, %1", "Q", addr, val)
+#endif
+
+#define __IOR8(endian, addr) \
+	__IOR_OP(u8, "ldrb %0, %1", "Qo", addr)
+#define __IOR32(endian, addr) \
+	__IOR_OP(endian##32, "ldr %0, %1", "Qo", addr)
+#define __IOW8(endian, addr, val) \
+	__IOW_OP(u8, "strb %0, %1", "Qo", addr, val)
+#define __IOW32(endian, addr, val) \
+	__IOW_OP(endian##32, "str %0, %1", "Qo", addr, val)
+
 #define __raw_writew __raw_writew
 static inline void __raw_writew(u16 val, volatile void __iomem *addr)
 {
-	asm volatile("strh %1, %0"
-		     : : "Q" (*(volatile u16 __force *)addr), "r" (val));
+	__IOW16(u, addr, val);
 }
 
 #define __raw_readw __raw_readw
 static inline u16 __raw_readw(const volatile void __iomem *addr)
 {
-	u16 val;
-	asm volatile("ldrh %0, %1"
-		     : "=r" (val)
-		     : "Q" (*(volatile u16 __force *)addr));
-	return val;
+	return __IOR16(u, addr);
 }
-#endif
 
 #define __raw_writeb __raw_writeb
 static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
 {
-	asm volatile("strb %1, %0"
-		     : : "Qo" (*(volatile u8 __force *)addr), "r" (val));
+	__IOW8(u, addr, val);
 }
 
 #define __raw_writel __raw_writel
 static inline void __raw_writel(u32 val, volatile void __iomem *addr)
 {
-	asm volatile("str %1, %0"
-		     : : "Qo" (*(volatile u32 __force *)addr), "r" (val));
+	__IOW32(u, addr, val);
 }
 
 #define __raw_readb __raw_readb
 static inline u8 __raw_readb(const volatile void __iomem *addr)
 {
-	u8 val;
-	asm volatile("ldrb %0, %1"
-		     : "=r" (val)
-		     : "Qo" (*(volatile u8 __force *)addr));
-	return val;
+	return __IOR8(u, addr);
 }
 
 #define __raw_readl __raw_readl
 static inline u32 __raw_readl(const volatile void __iomem *addr)
 {
-	u32 val;
-	asm volatile("ldr %0, %1"
-		     : "=r" (val)
-		     : "Qo" (*(volatile u32 __force *)addr));
-	return val;
+	return __IOR32(u, addr);
 }
 
 /*
@@ -250,17 +270,53 @@ extern int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr);
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
+static inline void outb(u8 val, unsigned int port)
+{
+	void __iomem *addr = __io(port);
+
+	__iowmb();
+	__IOW8(u, addr, val);
+}
+
+static inline void outw(u16 val, unsigned int port)
+{
+	void __iomem *addr = __io(port);
+
+	__iowmb();
+	__IOW16(le, addr, cpu_to_le16(val));
+}
+
+static inline void outl(u32 val, unsigned int port)
+{
+	void __iomem *addr = __io(port);
+
+	__iowmb();
+	__IOW32(le, addr, cpu_to_le32(val));
+}
+
+static inline u8 inb(unsigned int port)
+{
+	void __iomem *addr = __io(port);
+	u8 val = __IOR8(u, addr);
+	__iormb();
+	return val;
+}
+
+static inline u16 inw(unsigned int port)
+{
+	void __iomem *addr = __io(port);
+	le16 val = __IOR16(le, addr);
+	__iormb();
+	return le16_to_cpu(val);
+}
+
+static inline u32 inl(unsigned int port)
+{
+	void __iomem *addr = __io(port);
+	le32 val = __IOR32(le, addr);
+	__iormb();
+	return le32_to_cpu(val);
+}
 
 #define outsb(p,d,l)		__raw_writesb(__io(p),d,l)
 #define outsw(p,d,l)		__raw_writesw(__io(p),d,l)
@@ -291,23 +347,74 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
  * IO port primitives for more information.
  */
 #ifndef readl
-#define readb_relaxed(c) ({ u8  __r = __raw_readb(c); __r; })
-#define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
-					__raw_readw(c)); __r; })
-#define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
-					__raw_readl(c)); __r; })
+static inline u8 readb_relaxed(const volatile void __iomem *c)
+{
+	return __IOR8(u, c);
+}
 
-#define writeb_relaxed(v,c)	__raw_writeb(v,c)
-#define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
-#define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
+static inline u16 readw_relaxed(const volatile void __iomem *c)
+{
+	return le16_to_cpu(__IOR16(le, c));
+}
 
-#define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
-#define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
-#define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
+static inline u32 readl_relaxed(const volatile void __iomem *c)
+{
+	return le32_to_cpu(__IOR32(le, c));
+}
 
-#define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
-#define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
-#define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
+static inline void writeb_relaxed(u8 val, volatile void __iomem *c)
+{
+	__IOW8(u, c, val);
+}
+
+static inline void writew_relaxed(u16 val, volatile void __iomem *c)
+{
+	__IOW16(le, c, cpu_to_le16(val));
+}
+
+static inline void writel_relaxed(u32 val, volatile void __iomem *c)
+{
+	__IOW32(le, c, cpu_to_le32(val));
+}
+
+static inline u8 readb(const volatile void __iomem *c)
+{
+	u8 val = __IOR8(u, c);
+	__iormb();
+	return val;
+}
+
+static inline u16 readw(const volatile void __iomem *c)
+{
+	le16 val = __IOR16(le, c);
+	__iormb();
+	return le16_to_cpu(val);
+}
+
+static inline u32 readl(const volatile void __iomem *c)
+{
+	le32 val = __IOR32(le, c);
+	__iormb();
+	return le32_to_cpu(val);
+}
+
+static inline void writeb(u8 val, volatile void __iomem *c)
+{
+	__iowmb();
+	__IOW8(u, c, val);
+}
+
+static inline void writew(u16 val, volatile void __iomem *c)
+{
+	__iowmb();
+	__IOW16(le, c, cpu_to_le16(val));
+}
+
+static inline void writel(u32 val, volatile void __iomem *c)
+{
+	__iowmb();
+	__IOW32(le, c, cpu_to_le32(val));
+}
 
 #define readsb(p,d,l)		__raw_readsb(p,d,l)
 #define readsw(p,d,l)		__raw_readsw(p,d,l)
@@ -363,11 +470,46 @@ static inline void memcpy_toio(volatile void __iomem *to, const void *from,
 /*
  * io{read,write}{16,32}be() macros
  */
-#define ioread16be(p)		({ __u16 __v = be16_to_cpu((__force __be16)__raw_readw(p)); __iormb(); __v; })
-#define ioread32be(p)		({ __u32 __v = be32_to_cpu((__force __be32)__raw_readl(p)); __iormb(); __v; })
+static inline u16 ioread16be(const volatile void __iomem *c)
+{
+	be16 val = __IOR16(be, c);
+	__iormb();
+	return be16_to_cpu(val);
+}
 
-#define iowrite16be(v,p)	({ __iowmb(); __raw_writew((__force __u16)cpu_to_be16(v), p); })
-#define iowrite32be(v,p)	({ __iowmb(); __raw_writel((__force __u32)cpu_to_be32(v), p); })
+static inline u32 ioread32be(const volatile void __iomem *c)
+{
+	be32 val = __IOR32(be, c);
+	__iormb();
+	return be32_to_cpu(val);
+}
+
+static void iowrite16be(u16 val, volatile void __iomem *c)
+{
+	__iowmb();
+	__IOW16(be, c, cpu_to_be16(val));
+}
+
+static void iowrite32be(u32 val, volatile void __iomem *c)
+{
+	__iowmb();
+	__IOW32(be, c, cpu_to_be32(val));
+}
+
+/*
+ * Don't let people use these macros in their code - they're an arch
+ * implementation detail.
+ */
+#undef __iowmb
+#undef __iormb
+#undef __IOW8
+#undef __IOW16
+#undef __IOW32
+#undef __IOW_OP
+#undef __IOR8
+#undef __IOR16
+#undef __IOR32
+#undef __IOR_OP
 
 #ifndef ioport_map
 #define ioport_map ioport_map


-- 
FTTC broadband for 0.8mile line: currently@10.5Mbps down 400kbps up
according to speedtest.net.
