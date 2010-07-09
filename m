From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 09 Jul 2010 17:53:12 +0100
Subject: [PATCH v2 1/3] ARM: Introduce *_relaxed() I/O accessors
In-Reply-To: <201007091808.01536.arnd@arndb.de>
References: <20100709110350.11333.34303.stgit@e102109-lin.cambridge.arm.com>
	<20100709110801.11333.22995.stgit@e102109-lin.cambridge.arm.com>
	<201007091808.01536.arnd@arndb.de>
Message-ID: <1278694392.28103.25.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-07-09 at 17:08 +0100, Arnd Bergmann wrote:
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

On ARM we seem to use the readl/writel accessors for a lot more than the
PCI (pretty much anything that is ioremap'ed). Not sure why but this has
been the case for a long time.

> Does this mean we also need an ioread32_releaxed etc?

Most memory ordering problems that I've seen were with PCI devices and
DMA coherent buffers. For other DMA engines used together with
ioread*(), we could indeed introduce ioread32_relaxed(). But I'm not
sure there are so many (a quick grep for dma_alloc_coherent and iowrite
shows about 14 drivers).

Thanks.

-- 
Catalin
