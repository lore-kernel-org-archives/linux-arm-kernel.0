From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 18 Aug 2010 22:31:10 +0200 (CEST)
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
	Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <20100818194109.GA19126@n2100.arm.linux.org.uk>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
	<20100810212638.GC7702@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008182107210.17895@axis700.grange>
	<20100818194109.GA19126@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.1008182218150.17895@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Aug 2010, Russell King - ARM Linux wrote:

> On Wed, Aug 18, 2010 at 09:23:25PM +0200, Guennadi Liakhovetski wrote:

[snip]

> > The sole purpose of the preallocation in the platform code is to avoid 
> > memory fragmentation. Sorry, if I'm repeating obvious things. So, we are 
> > already allocating DMA coherent memory. The ioremap() problem in this case 
> > is actually bogus - we do not need that ioremap(). The problem would be 
> > solved, if ioremap() would just not be called in these cases. This is what 
> > the drivers/staging/dt3155v4l/dt3155vfl.c driver is open-coding in its 
> > dt3155_alloc_coherent() function, as pointed out by Marin Mitov (CCed) in 
> > another thread. So, would it be acceptable to provide a second function, 
> > doing exactly the same as dma_declare_coherent_memory() but without an 
> > ioremap(), or add a new DMA_MEMORY_... flag to skip ioremap() in 
> > dma_declare_coherent_memory(), as suggested by Uwe (CCed too)?
> 
> Sounds like a sane approach to fixing this to me.

I assume, you mean adding a new flag to skip ioremap(). But then we have 
to pass the virtual address to the function. Its prototype is

int dma_declare_coherent_memory(struct device *dev, dma_addr_t bus_addr,
				dma_addr_t device_addr, size_t size, int flags);

bus_addr is unused in this case, but I don't think abusing it to pass a 
"void *" would be an acceptable solution - apart from all the ugly 
type-casting, if we ever get 64-bit virtual addresses on ARM with 32-bit 
DMA addresses, we've got a problem. Or is this never going to happen? Or 
whould I rather add a new function?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
