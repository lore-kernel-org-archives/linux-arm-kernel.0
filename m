From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 May 2010 14:44:10 +0100
Subject: arm926_dma_flush_range undefined!
In-Reply-To: <4BE95C54.5070008@atmel.com>
References: <4BE2C013.4040009@atmel.com>
	<1273154831.2094.11.camel@e102109-lin.cambridge.arm.com>
	<20100506175907.GA15797@n2100.arm.linux.org.uk>
	<4BE926B5.7090602@atmel.com>
	<20100511094448.GB18828@n2100.arm.linux.org.uk>
	<4BE95C54.5070008@atmel.com>
Message-ID: <20100511134409.GB27201@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 03:32:04PM +0200, Nicolas Ferre wrote:
> After a read with DMA from sd/mmc interface, a DMA buffer allocated by
> dma_alloc_coherent() is filled.
> This buffer is then copied to the scatterlist provided by the mmc
> request (from drivers/mmc/card/block.c it seems that sg buffers are
> alocacted via kmalloc()).

I assume that this means you can't handle scatterlists with your DMA
engine?

> For each buffer of the scatterlist, I do this dmac_flush_rage()...

I think you need to look at how mmci.c does its flushing, and do something
along those lines.  You could use flush_kernel_dcache_page() instead of
flush_dcache_page(), which would be slightly cheaper.

> As copy is done between a coherent and a kernel memory buffers, I guess
> that the flushing routine is not needed?

The issue of coherency with "PIO" writes to block IO pages is going
around the same old loops of discussion yet again at the moment; it's
been a problem for ARM for about the last 10 years or so, and I'm not
expecting there to suddenly be a major change of heart or political
will to fix the issue.

So I think we're stuck with having to have the drivers we really care
about and have our own control over do the flushing themselves.
