From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 25 Oct 2014 20:57:52 +0200
Subject: Unconditional registering EMDA platform devices
In-Reply-To: <20141025184854.GA10780@kleine-koenig.org>
References: <20141024142904.GC3142@lunn.ch> <2124815.5oBngWtcFV@wuerfel>
 <20141025184854.GA10780@kleine-koenig.org>
Message-ID: <2034542.1PWfBB7aBW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 25 October 2014 20:48:54 Uwe Kleine-K?nig wrote:
> On Fri, Oct 24, 2014 at 06:14:01PM +0200, Arnd Bergmann wrote:
> > On Friday 24 October 2014 16:29:04 Andrew Lunn wrote:
> > > giving warnings:
> > > 
> > > [    0.114771] edma-dma-engine edma-dma-engine.0: Can't allocate PaRAM dummy slot
> > > [    0.114794] edma-dma-engine: probe of edma-dma-engine.0 failed with error -5
> > >
> > > These seem to be coming from drivers/dma/emda.c
> > > 
> > > That driver has a subsys_initcall(edma_init);
> > > 
> > > and the edma_init function is unconditionally registering a driver and
> > > a platform device. For a multiarch kernel, this is not a good idea.
> > > 
> > > Please could you make this conditionally. Maybe look into the DT and
> > > see if the DMA is needed on the platform?
> >  
> > I just looked at that code an I'm completely confused about how that
> > even works today. I do see that the driver is used on ATAGS based
> > davinci machines, which means we can't just look into the DT.
> > 
> > The main problem seems to stem from arch/arm/common/edma.c being
> > half the driver that provides interfaces to both drivers/dma/edma.c
> > and to sound/soc/davinci/davinci-pcm.c, while drivers/dma/edma.c
> > is not really a driver by itself. My preferred solution to this would
> > be to move arch/arm/common/edma.c into drivers/dma/edma.c and still
> > have it export its private API, but I assume that the dmaengine
> > maintainers have already NAKed that approach.
> Isn't the preferred solution that sound/soc/davinci/davinci-pcm.c only
> uses dmaengine stuff and the private API goes away?

Absolutely, yes. I believe all other drivers have been converted
already, and it's on somebody's TODO list.

> > 8<-------
> > Subject: dma: edma: move device registration to platform code
> > 
> > The horrible split between the low-level part of the edma support
> > and the dmaengine front-end driver causes problems on multiplatform
> > kernels. This is an attempt to improve the situation slightly
> > by only registering the dmaengine devices that are actually
> > present.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > [...]
> > diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
> > index 123f578d6dd3..4cfaaa5a49be 100644
> > --- a/drivers/dma/edma.c
> > +++ b/drivers/dma/edma.c
> There is a comment in drivers/dma/edma.c reading:
> 
> /*
>  * This will go away when the private EDMA API is folded
>  * into this driver and the platform device(s) are
>  * instantiated in the arch code. We can only get away
>  * with this simplification because DA8XX may not be built
>  * in the same kernel image with other DaVinci parts. This
>  * avoids having to sprinkle dmaengine driver platform devices
>  * and data throughout all the existing board files.
>  */
> 
> Just looking into arch/arm/mach-davinci/Kconfig it seems wrong that
> DA8XX may not be enabled with other DaVinci parts. So probably there is
> really more broken here ...

Right, and it also seems that this would be fairly simple to fix
as a follow-up patch. I already eliminated the only use of EDMA_CTLRS,
and the da8xx type could be derived from the device identifier.

	Arnd
