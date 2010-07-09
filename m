From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jul 2010 21:30:17 +0200
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <20100709182417.GL22845@n2100.arm.linux.org.uk>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<201007091808.01536.arnd@arndb.de>
	<20100709182417.GL22845@n2100.arm.linux.org.uk>
Message-ID: <201007092130.17504.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 July 2010 20:24:17 Russell King - ARM Linux wrote:
> On Fri, Jul 09, 2010 at 06:08:01PM +0200, Arnd Bergmann wrote:
> > On Friday 09 July 2010, Catalin Marinas wrote:
> > > This patch introduces readl*_relaxed()/write*_relaxed() as the main I/O
> > > accessors (when __mem_pci is defined). The standard read*()/write*()
> > > macros are now based on the relaxed accessors.
> > 
> > Are these new macros valid for both PCI and non-PCI mmio addresses?
> > The way I understand it, the regular readl/writel family is only
> > valid for __iomem addresses in PCI BARs, while anything else
> > has to go through either ioread32/iowrite32 or something arch
> > specific.
> > 
> > Does this mean we also need an ioread32_releaxed etc?
> 
> Only if you want to deal with PCI IO accesses as well.  The
> ioread*/iowrite* interfaces are more complex implementations than
> plain read/write[bwl], because they have to work out whether the
> void __iomem * cookie relates to an ioremapped cookie or a PCI IO
> cookie.  (That's the only reason to use the io* variants - if you
> want a driver which can portably access its registers via either
> PCI MEM or PCI IO access methods.)

Right. IMHO the PCI IO variants should get the same barriers that
Catalin is introducing in the PCI MEM variants. The ordering requirements
for IO accesses are stricter than those for MEM, the main difference
being that MEM writes are posted while IO writes are synchronizing.

Thinking about it from this angle, I'm not even sure that x86 compatibility
requires arm to add wmb() after writel(). IIRC, PCI memory space writes are
required to be ordered with regard to each other, but not necessarily
with regard to other CPU instructions or DMA transfers, unlike memory
space reads and IO space read/write accesses.

> Plain read/write[bwl] are much simpler, and on ARM are just pointer
> dereferences (and now with an additional barrier), so we allow their
> use in architecture specific drivers.

Yes, that makes sense.

	Arnd
