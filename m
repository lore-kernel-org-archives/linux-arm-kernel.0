From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Aug 2010 20:41:09 +0100
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by
	"ARM: Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <Pine.LNX.4.64.1008182107210.17895@axis700.grange>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
	<20100810212638.GC7702@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008182107210.17895@axis700.grange>
Message-ID: <20100818194109.GA19126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 18, 2010 at 09:23:25PM +0200, Guennadi Liakhovetski wrote:
> Resuming the week-old thread, to try to get a solution for this problem 
> for 2.6.36.
> 
> On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:
> > Or just make the DMA coherent region larger and use that instead (and
> > the DMA coherent region I hope will be fixed to omit the dual-mapping
> > for the next merge window.)
> 
> Sorry, don't quite understand. Currently what those platforms do is they 
> allocate at platform init time a sufficient DMA doherent region per
> 
> 	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);
> 
> and then "assign" it to the video platform device per
> 
> 	dma = dma_declare_coherent_memory(&mx3_camera.dev,
> 					dma_handle, dma_handle, buf_size,
> 					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);

So, why have the DMA memory mapped in _correctly_ by dma_alloc_coherent(),
and then have dma_declare_coherent_memory() map it in using ioremap(),
thereby creating an incompatible DEVICE aliasing mapping of the already
existing memory mapping.

This definitely falls outside of predicatible behaviour on ARMv6 and
ARMv7, and doesn't even fall within the limits of the mitigated
conditions for existing CPUs.

The above will _not_ work reliably.  Good, my patch has identified
something that's definitely broken.

> Now the driver will be able to use the videobuf-dma-contig video-buffer 
> allocation, which does
> 
> 	mem->vaddr = dma_alloc_coherent(q->dev, mem->size,
> 					&mem->dma_handle, GFP_KERNEL);
> 
> The sole purpose of the preallocation in the platform code is to avoid 
> memory fragmentation. Sorry, if I'm repeating obvious things. So, we are 
> already allocating DMA coherent memory. The ioremap() problem in this case 
> is actually bogus - we do not need that ioremap(). The problem would be 
> solved, if ioremap() would just not be called in these cases. This is what 
> the drivers/staging/dt3155v4l/dt3155vfl.c driver is open-coding in its 
> dt3155_alloc_coherent() function, as pointed out by Marin Mitov (CCed) in 
> another thread. So, would it be acceptable to provide a second function, 
> doing exactly the same as dma_declare_coherent_memory() but without an 
> ioremap(), or add a new DMA_MEMORY_... flag to skip ioremap() in 
> dma_declare_coherent_memory(), as suggested by Uwe (CCed too)?

Sounds like a sane approach to fixing this to me.
