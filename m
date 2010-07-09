From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 15:21:23 +0100
Subject: [PATCH v2 3/3] ARM: Add barriers to the I/O
	accessorsifARM_DMA_MEM_BUFFERABLE
In-Reply-To: <1278680538.11895.49.camel@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110814.11333.83771.stgit@e102109-lin.cambridge.arm.com>
	<1278675696.11895.37.camel@e102109-lin.cambridge.arm.com>
	<20100709121629.GE22845@n2100.arm.linux.org.uk>
	<1278680538.11895.49.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1278685283.11895.52.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 14:02 +0100, Catalin Marinas wrote:
> On Fri, 2010-07-09 at 13:16 +0100, Russell King - ARM Linux wrote:
> > On Fri, Jul 09, 2010 at 12:41:36PM +0100, Catalin Marinas wrote:
> > > This part requires a small change. It looks like the e1000e driver
> > > doesn't like the do {...} while (0) constructs in the write*() accessors
> > > (the E1000_WRITE_REG_ARRAY macro). Thanks to Giuseppe for finding this.
> >
> > Hmm.  I think those additional parens in drivers/net/e1000e/hw.h should
> > be killed off instead.  They aren't serving any useful purpose.
> >
> > In fact, this is potentially dangerous - it causes write[bwl]() not to
> > be 'void' - in that if you do use write[bwl]() in an expression that
> > wants its return value, write[bwl]() will generate a read.  (While you
> > might not use the value, you're relying on the compiler being able to
> > spot that you're not using the value.)
> >
> > Keeping the do { } while() there prevents write[bwl]() being used as
> > an expression, and therefore avoids nasty surprises when the compiler
> > decides to read the register after writing.
> 
> I haven't thought of that but yes, it could cause problems. An better
> solution may be to use a "static inline void writel()" function. If you
> are ok with this, I'll post a new set of patches.

The patch below changes the __raw_* accessors to inline functions. Do
you see any problem with this? This would be needed even without the I/O
ordering patches.


ARM: Convert the read[bwl]/write[bwl] I/O accessors to inline functions

From: Catalin Marinas <catalin.marinas@arm.com>

The write* accessors conversion from macros ensures that the return type
is always void. For completeness, the read* macros are also converted to
inline functions.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/include/asm/io.h |   34 ++++++++++++++++++++++++++++------
 1 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index c980156..b5be0ec 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -46,13 +46,35 @@ extern void __raw_readsb(const void __iomem *addr, void *data, int bytelen);
 extern void __raw_readsw(const void __iomem *addr, void *data, int wordlen);
 extern void __raw_readsl(const void __iomem *addr, void *data, int longlen);
 
-#define __raw_writeb(v,a)	(__chk_io_ptr(a), *(volatile unsigned char __force  *)(a) = (v))
-#define __raw_writew(v,a)	(__chk_io_ptr(a), *(volatile unsigned short __force *)(a) = (v))
-#define __raw_writel(v,a)	(__chk_io_ptr(a), *(volatile unsigned int __force   *)(a) = (v))
+static inline void __raw_writeb(u8 val, volatile void __iomem *addr)
+{
+	*(volatile u8 __force *)addr = val;
+}
+
+static inline void __raw_writew(u16 val, volatile void __iomem *addr)
+{
+	*(volatile u16 __force *)addr = val;
+}
+
+static inline void __raw_writel(u32 val, volatile void __iomem *addr)
+{
+	*(volatile u32 __force *)addr = val;
+}
 
-#define __raw_readb(a)		(__chk_io_ptr(a), *(volatile unsigned char __force  *)(a))
-#define __raw_readw(a)		(__chk_io_ptr(a), *(volatile unsigned short __force *)(a))
-#define __raw_readl(a)		(__chk_io_ptr(a), *(volatile unsigned int __force   *)(a))
+static inline u8 __raw_readb(const volatile void __iomem *addr)
+{
+	return *(const volatile u8 __force *)addr;
+}
+
+static inline u16 __raw_readw(const volatile void __iomem *addr)
+{
+	return *(const volatile u16 __force *)addr;
+}
+
+static inline u32 __raw_readl(const volatile void __iomem *addr)
+{
+	return *(const volatile u32 __force *)addr;
+}
 
 /*
  * Architecture ioremap implementation.



-- 
Catalin
