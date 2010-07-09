From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jul 2010 19:17:38 +0200
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <1278694392.28103.25.camel@e102109-lin.cambridge.arm.com>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<201007091808.01536.arnd@arndb.de>
	<1278694392.28103.25.camel@e102109-lin.cambridge.arm.com>
Message-ID: <201007091917.38298.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010, Catalin Marinas wrote: 
> On Fri, 2010-07-09 at 17:08 +0100, Arnd Bergmann wrote:
> > 
> > Are these new macros valid for both PCI and non-PCI mmio addresses?
> > The way I understand it, the regular readl/writel family is only
> > valid for __iomem addresses in PCI BARs, while anything else
> > has to go through either ioread32/iowrite32 or something arch
> > specific.
>
> On ARM we seem to use the readl/writel accessors for a lot more than the
> PCI (pretty much anything that is ioremap'ed). Not sure why but this has
> been the case for a long time.

Ok.

> > Does this mean we also need an ioread32_releaxed etc?
> 
> Most memory ordering problems that I've seen were with PCI devices and
> DMA coherent buffers. For other DMA engines used together with
> ioread*(), we could indeed introduce ioread32_relaxed(). But I'm not
> sure there are so many (a quick grep for dma_alloc_coherent and iowrite
> shows about 14 drivers).

Well, if only PCI devices really need the strict ordering, that may be
a good reason to use a less strict I/O accessor for non-PCI devices.

I think the 14 drivers you mentioned are mostly PCI driver as well.
dma_alloc_coherent and iowrite are both defined to do the right
thing for any possible bus, while pci_alloc_consistent and writel
are doing the same thing on PCI but are undefined (or arch specific
if you want) for other kinds of devices.

It would probably be reasonable to define iowrite as writel for PCI
and as write_relaxed for other buses, requiring manual synchronization
for other kinds of DMA. You could detect this at ioremap time and then
use one of the bits in the __iomem token to decide if the strict ordering
is necessary.

	Arnd
