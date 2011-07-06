From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Jul 2011 16:59:45 +0200
Subject: [Linaro-mm-sig] [PATCH 6/8] drivers: add Contiguous Memory
	Allocator
In-Reply-To: <alpine.LFD.2.00.1107061034200.14596@xanadu.home>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<20110706142345.GC8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107061034200.14596@xanadu.home>
Message-ID: <201107061659.45253.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 July 2011, Nicolas Pitre wrote:
> On Wed, 6 Jul 2011, Russell King - ARM Linux wrote:
> 
> > Another issue is that when a platform has restricted DMA regions,
> > they typically don't fall into the highmem zone.  As the dmabounce
> > code allocates from the DMA coherent allocator to provide it with
> > guaranteed DMA-able memory, that would be rather inconvenient.
> 
> Do we encounter this in practice i.e. do those platforms requiring large 
> contiguous allocations motivating this work have such DMA restrictions?

You can probably find one or two of those, but we don't have to optimize
for that case. I would at least expect the maximum size of the allocation
to be smaller than the DMA limit for these, and consequently mandate that
they define a sufficiently large CONSISTENT_DMA_SIZE for the crazy devices,
or possibly add a hack to unmap some low memory and call
dma_declare_coherent_memory() for the device.

	Arnd
