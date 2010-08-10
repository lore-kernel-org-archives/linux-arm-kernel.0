From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Aug 2010 22:26:38 +0100
Subject: [regression] in linux-next: sh_mobile_ceu_camera broken by
	"ARM: Prohibit ioremap() on kernel managed RAM"
In-Reply-To: <Pine.LNX.4.64.1008102117000.18934@axis700.grange>
References: <4C5ED116.5000002@arndnet.de>
	<201008101045.03547.philippe.retornaz@epfl.ch>
	<20100810092759.GB31759@n2100.arm.linux.org.uk>
	<Pine.LNX.4.64.1008102117000.18934@axis700.grange>
Message-ID: <20100810212638.GC7702@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 09:55:29PM +0200, Guennadi Liakhovetski wrote:
> Hi Russell
> 
> On Tue, 10 Aug 2010, Russell King - ARM Linux wrote:
> 
> > On Tue, Aug 10, 2010 at 10:45:03AM +0200, Philippe R?tornaz wrote:
> > > Le dimanche, 8 ao?t 2010 17.45:26, Arnd Hannemann a ?crit :
> > > > Hi Russell,
> > > > 
> > > > your commit 309caa9cc6ff39d261264ec4ff10e29489afc8f8
> > > > ARM: Prohibit ioremap() on kernel managed RAM
> > > > 
> > > > lets drivers/base/dma-coherent.c::dma_declare_coherent_memory()
> > > > fail for the sh_mobile_ceu_camera driver (see backtrace below).
> > > > I think, other configurations (i.MX31 users of the mx3_camera driver:
> > > > pcm037 and mx31moboard) will have the same problem.
> > > > 
> > > > Since I have no idea how to fix this, I post this regression report here...
> > > 
> > > Have you found a solution to this problem ? As you said, the mx3_camera driver 
> > > doesn't work anymore on mx31moboard.
> > 
> > MX3 is ARMv6 which has the architectural restriction as well I'm afraid.
> 
> So, if I understand this right, you cannot call 
> dma_declare_coherent_memory() on already mapped RAM on ARM.

It would appear so - unfortunately this API was designed by ARM folk back
in the VIVT cached days when this kind of restriction wasn't present.

> So, to use this on physical RAM we have to remove it from the kernel
> mapping? Would using the "memmap=" kernel parameter suffice? Or is
> there a better solution for this?

I don't know what "memmap=" is, which suggests that as we don't process
it, it'll do nothing.  (This is one of the problems of
kernel-parameters.txt - it doesn't tell you what are architecture
specific parameters.)

You could instead use mem= or omit a chunk of memory from the ATAGs.
However, as I've already covered, because of the brokenness of
sparsemem not being able to handle sparse memory, its implementation
of pfn_valid() will be over-happy to return 'true' even for memory
you've omitted.  Flatmem doesn't suffer this problem.

Or just make the DMA coherent region larger and use that instead (and
the DMA coherent region I hope will be fixed to omit the dual-mapping
for the next merge window.)

But as I've said, the whole "ioremap system RAM" idea has to die.  It's
something that just isn't workable with later ARMs, and it's something
that historically hasn't been supported on x86 either for very similar
reasons (except for very exceptional corner cases.)
