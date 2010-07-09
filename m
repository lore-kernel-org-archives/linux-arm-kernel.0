From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 23:31:54 +0100
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <201007092130.17504.arnd@arndb.de>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<201007091808.01536.arnd@arndb.de>
	<20100709182417.GL22845@n2100.arm.linux.org.uk>
	<201007092130.17504.arnd@arndb.de>
Message-ID: <1278714714.30012.14.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 20:30 +0100, Arnd Bergmann wrote:
> On Friday 09 July 2010 20:24:17 Russell King - ARM Linux wrote:
> > On Fri, Jul 09, 2010 at 06:08:01PM +0200, Arnd Bergmann wrote:
> > > On Friday 09 July 2010, Catalin Marinas wrote:
> > > > This patch introduces readl*_relaxed()/write*_relaxed() as the main I/O
> > > > accessors (when __mem_pci is defined). The standard read*()/write*()
> > > > macros are now based on the relaxed accessors.
> > >
> > > Are these new macros valid for both PCI and non-PCI mmio addresses?
> > > The way I understand it, the regular readl/writel family is only
> > > valid for __iomem addresses in PCI BARs, while anything else
> > > has to go through either ioread32/iowrite32 or something arch
> > > specific.
> > >
> > > Does this mean we also need an ioread32_releaxed etc?
> >
> > Only if you want to deal with PCI IO accesses as well.  The
> > ioread*/iowrite* interfaces are more complex implementations than
> > plain read/write[bwl], because they have to work out whether the
> > void __iomem * cookie relates to an ioremapped cookie or a PCI IO
> > cookie.  (That's the only reason to use the io* variants - if you
> > want a driver which can portably access its registers via either
> > PCI MEM or PCI IO access methods.)
> 
> Right. IMHO the PCI IO variants should get the same barriers that
> Catalin is introducing in the PCI MEM variants. The ordering requirements
> for IO accesses are stricter than those for MEM, the main difference
> being that MEM writes are posted while IO writes are synchronizing.

Linux docs don't clearly define the ordering requirements. There are
various e-mail threads but not a finalised document. In principle,
trying to be as close to x86 as possible, in which case we probably need
barriers here as well.

> Thinking about it from this angle, I'm not even sure that x86 compatibility
> requires arm to add wmb() after writel(). IIRC, PCI memory space writes are
> required to be ordered with regard to each other, but not necessarily
> with regard to other CPU instructions or DMA transfers, unlike memory
> space reads and IO space read/write accesses.

We don't need a wmb() after writel(), my patch only adds wmb() before
writel(). We need previous DMA buffer writes to be visible before
writel(), otherwise we get corrupted DMA transfers.

There were past discussions about writel() and spin_unlock() ordering.
For PCI, people introduced mmiowb(). In general, that's not needed on
ARM as the DMB in spin_unlock() should in general suffice (but it may
depend on whether the bus gets notified about the DMB).

-- 
Catalin
