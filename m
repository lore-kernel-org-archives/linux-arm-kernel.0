From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Jan 2015 10:53:22 +0000
Subject: [PATCH 1/2] arm64: Fix overlapping VA allocations
In-Reply-To: <20150114104256.GA12069@leverpostej>
References: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
 <1421091408-10660-2-git-send-email-mark.rutland@arm.com>
 <20150113153448.GE16524@e104818-lin.cambridge.arm.com>
 <20150114104256.GA12069@leverpostej>
Message-ID: <20150114105322.GE4050@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:42:56AM +0000, Mark Rutland wrote:
> On Tue, Jan 13, 2015 at 03:34:49PM +0000, Catalin Marinas wrote:
> > On Mon, Jan 12, 2015 at 07:36:47PM +0000, Mark Rutland wrote:
> > > --- a/arch/arm64/include/asm/io.h
> > > +++ b/arch/arm64/include/asm/io.h
> > > @@ -26,6 +26,7 @@
> > >  
> > >  #include <asm/byteorder.h>
> > >  #include <asm/barrier.h>
> > > +#include <asm/memory.h>
> > >  #include <asm/pgtable.h>
> > >  #include <asm/early_ioremap.h>
> > >  #include <asm/alternative.h>
> > > @@ -145,8 +146,8 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> > >   *  I/O port access primitives.
> > >   */
> > >  #define arch_has_dev_port()	(1)
> > > -#define IO_SPACE_LIMIT		(SZ_32M - 1)
> > > -#define PCI_IOBASE		((void __iomem *)(MODULES_VADDR - SZ_32M))
> > > +#define IO_SPACE_LIMIT		(PCI_IO_END - PCI_IO_START - 1)
> > > +#define PCI_IOBASE		((void __iomem *)PCI_IO_START)
> > 
> > I've seen at least couple of places where IO_SPACE_LIMIT is used as a
> > mark. So I would prefer it to be something like (power-of-two - 1)
> > rather than some random (size - 1).
> 
> I couldn't spot instances in core code (maybe I missed them), just
> arch/arm and arch/hexagon:

drivers/pci/probe.c: mask64 = PCI_BASE_ADDRESS_IO_MASK & (u32)IO_SPACE_LIMIT;
include/asm-generic/io.h: return PCI_IOBASE + (port & IO_SPACE_LIMIT);

Will
