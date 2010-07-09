From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Jul 2010 19:24:17 +0100
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <201007091808.01536.arnd@arndb.de>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110801.11333.22995.stgit@e102109-lin.cambridge.arm.com>
	<201007091808.01536.arnd@arndb.de>
Message-ID: <20100709182417.GL22845@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 09, 2010 at 06:08:01PM +0200, Arnd Bergmann wrote:
> On Friday 09 July 2010, Catalin Marinas wrote:
> > This patch introduces readl*_relaxed()/write*_relaxed() as the main I/O
> > accessors (when __mem_pci is defined). The standard read*()/write*()
> > macros are now based on the relaxed accessors.
> 
> Are these new macros valid for both PCI and non-PCI mmio addresses?
> The way I understand it, the regular readl/writel family is only
> valid for __iomem addresses in PCI BARs, while anything else
> has to go through either ioread32/iowrite32 or something arch
> specific.
> 
> Does this mean we also need an ioread32_releaxed etc?

Only if you want to deal with PCI IO accesses as well.  The
ioread*/iowrite* interfaces are more complex implementations than
plain read/write[bwl], because they have to work out whether the
void __iomem * cookie relates to an ioremapped cookie or a PCI IO
cookie.  (That's the only reason to use the io* variants - if you
want a driver which can portably access its registers via either
PCI MEM or PCI IO access methods.)

Plain read/write[bwl] are much simpler, and on ARM are just pointer
dereferences (and now with an additional barrier), so we allow their
use in architecture specific drivers.
