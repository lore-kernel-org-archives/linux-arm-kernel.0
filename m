From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 15 Sep 2012 09:57:34 +0100
Subject: [PATCH 22/24] scsi: eesox: use __iomem pointers for MMIO
In-Reply-To: <201209150800.35605.arnd@arndb.de>
References: <201209150800.35605.arnd@arndb.de>
Message-ID: <20120915085734.GG12245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 08:00:35AM +0000, Arnd Bergmann wrote:
> On Friday 14 September 2012, Russell King - ARM Linux wrote:
> > On Fri, Sep 14, 2012 at 11:34:50PM +0200, Arnd Bergmann wrote:
> > > ARM is moving to stricter checks on readl/write functions,
> > > so we need to use the correct types everywhere.
> > 
> > There's nothing wrong with const iomem pointers.  If you think
> > otherwise, patch x86 not to use const in its accessor implementation
> > and watch the reaction:
> > 
> > #define build_mmio_read(name, size, type, reg, barrier) \
> > static inline type name(const volatile void __iomem *addr) \
> > { type ret; asm volatile("mov" size " %1,%0":reg (ret) \
> > :"m" (*(volatile type __force *)addr) barrier); return ret; }
> > 
> > build_mmio_read(readb, "b", unsigned char, "=q", :"memory")
> > build_mmio_read(readw, "w", unsigned short, "=r", :"memory")
> > build_mmio_read(readl, "l", unsigned int, "=r", :"memory")
> 
> Ok, fair enough. Can you fold the patch below into 
> "ARM: 7500/1: io: avoid writeback addressing modes for __raw_
> accessors", or apply on top then?

No - const is not appropriate for the write accessors.  Again, this puts
us at odds with x86:

#define build_mmio_write(name, size, type, reg, barrier) \
static inline void name(type val, volatile void __iomem *addr) \
{ asm volatile("mov" size " %0,%1": :reg (val), \
"m" (*(volatile type __force *)addr) barrier); }

build_mmio_write(writeb, "b", unsigned char, "q", :"memory")
build_mmio_write(writew, "w", unsigned short, "r", :"memory")
build_mmio_write(writel, "l", unsigned int, "r", :"memory")

So, readl etc are all const volatile void __iomem *, but writel etc are
all volatile void __iomem *.

How they're defined on ARM after 7500/1 copies how they're defined on
x86.
