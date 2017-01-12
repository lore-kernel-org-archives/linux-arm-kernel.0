From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 Jan 2017 14:07:52 +0100
Subject: NVMe vs DMA addressing limitations
In-Reply-To: <3306663.hKmLLq1hhl@wuerfel>
References: <1483044304-2085-1-git-send-email-nikita.yoush@cogentembedded.com>
 <20170110144839.GB27156@lst.de>
 <80676b35-121b-0462-23fc-ed5608e1e671@grimberg.me>
 <3306663.hKmLLq1hhl@wuerfel>
Message-ID: <20170112130752.GA14465@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 12:56:07PM +0100, Arnd Bergmann wrote:
> That is an interesting question: We actually have the
> "DMA_ATTR_NO_KERNEL_MAPPING" for this case, and ARM implements
> it in the coherent interface, so that might be a good fit.

Yes. my WIP HMB patch uses DMA_ATTR_NO_KERNEL_MAPPING, although I'm
workin on x86 at the moment where it's a no-op.

> Implementing it in the streaming API makes no sense since we
> already have a kernel mapping here, but using a normal allocation
> (possibly with DMA_ATTR_NON_CONSISTENT or DMA_ATTR_SKIP_CPU_SYNC,
> need to check) might help on other architectures that have
> limited amounts of coherent memory and no CMA.

Though about that - but in the end DMA_ATTR_NO_KERNEL_MAPPING implies
those, so instead of using lots of flags in driver I'd rather fix
up more dma_ops implementations to take advantage of
DMA_ATTR_NO_KERNEL_MAPPING.
