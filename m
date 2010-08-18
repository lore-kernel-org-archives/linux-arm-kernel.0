From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 18 Aug 2010 21:23:25 +0200 (CEST)
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by "ARM:
	Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <20100810212638.GC7702@n2100.arm.linux.org.uk>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
	<20100810212638.GC7702@n2100.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.64.1008182107210.17895@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resuming the week-old thread, to try to get a solution for this problem 
for 2.6.36.

On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:

> On Tue, Aug 10, 2010 at 09:55:29PM +0200, Guennadi Liakhovetski wrote:
> > Hi Russell
> > 
> > On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:
> > 
> > > On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R?tornaz wrote:
> > > > Le dimanche, 8 ao?t 2010 17.45:26, Arnd Hannemann a ?crit :
> > > > > Hi Russell,
> > > > > 
> > > > > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > > > > ARM: Prohibit ioremap() on kernel managed RAM
> > > > > 
> > > > > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > > > > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > > > > I think, other configurations (i.MX31 users of the mx3_camera driver:
> > > > > pcm037 and mx31moboard) will have the same problem.
> > > > > 
> > > > > Since I have no idea how to fix this, I post this regression report here...
> > > > 
> > > > Have you found a solution to this problem ? As you said, the mx3_camera driver 
> > > > doesn't work anymore on mx31moboard.
> > > 
> > > MX3 is ARMv6 which has the architectural restriction as well I'm afraid.
> > 
> > So, if I understand this right, you cannot call 
> > dma_declare_coherent_memory() on already mapped RAM on ARM.
> 
> It would appear so - unfortunately this API was designed by ARM folk back
> in the VIVT cached days when this kind of restriction wasn't present.
> 
> > So, to use this on physical RAM we have to remove it from the kernel
> > mapping? Would using the "memmap=" kernel parameter suffice? Or is
> > there a better solution for this?
> 
> I don't know what "memmap=" is, which suggests that as we don't process
> it, it'll do nothing.  (This is one of the problems of
> kernel-parameters.txt - it doesn't tell you what are architecture
> specific parameters.)
> 
> You could instead use mem= or omit a chunk of memory from the ATAGs.
> However, as I've already covered, because of the brokenness of
> sparsemem not being able to handle sparse memory, its implementation
> of pfn_valid() will be over-happy to return 'true' even for memory
> you've omitted.  Flatmem doesn't suffer this problem.

Ok, so, this would work on flatmem (which is what platforms, that I know 
use this API for video buffer allocation), but is not very elegant.

> Or just make the DMA coherent region larger and use that instead (and
> the DMA coherent region I hope will be fixed to omit the dual-mapping
> for the next merge window.)

Sorry, don't quite understand. Currently what those platforms do is they 
allocate at platform init time a sufficient DMA doherent region per

	buf = dma_alloc_coherent(NULL, buf_size, &dma_handle, GFP_KERNEL);

and then "assign" it to the video platform device per

	dma = dma_declare_coherent_memory(&mx3_camera.dev,
					dma_handle, dma_handle, buf_size,
					DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE);

Now the driver will be able to use the videobuf-dma-contig video-buffer 
allocation, which does

	mem->vaddr = dma_alloc_coherent(q->dev, mem->size,
					&mem->dma_handle, GFP_KERNEL);

The sole purpose of the preallocation in the platform code is to avoid 
memory fragmentation. Sorry, if I'm repeating obvious things. So, we are 
already allocating DMA coherent memory. The ioremap() problem in this case 
is actually bogus - we do not need that ioremap(). The problem would be 
solved, if ioremap() would just not be called in these cases. This is what 
the drivers/staging/dt3155v4l/dt3155vfl.c driver is open-coding in its 
dt3155_alloc_coherent() function, as pointed out by Marin Mitov (CCed) in 
another thread. So, would it be acceptable to provide a second function, 
doing exactly the same as dma_declare_coherent_memory() but without an 
ioremap(), or add a new DMA_MEMORY_... flag to skip ioremap() in 
dma_declare_coherent_memory(), as suggested by Uwe (CCed too)?

> But as I've said, the whole "ioremap system RAM" idea has to die.  It's
> something that just isn't workable with later ARMs, and it's something
> that historically hasn't been supported on x86 either for very similar
> reasons (except for very exceptional corner cases.)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
