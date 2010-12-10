From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Fri, 10 Dec 2010 22:03:52 +0100
Subject: [RESEND] [PATCH 1/2] OMAP1: allow reserving memory for camera
In-Reply-To: <20101210170356.GA28472@n2100.arm.linux.org.uk>
References: <201012051929.07220.jkrzyszt@tis.icnet.pl>
	<201012101203.09441.jkrzyszt@tis.icnet.pl>
	<20101210170356.GA28472@n2100.arm.linux.org.uk>
Message-ID: <201012102203.54413.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Friday 10 December 2010 18:03:56 Russell King - ARM Linux napisa?(a):
> On Fri, Dec 10, 2010 at 12:03:07PM +0100, Janusz Krzysztofik wrote:
> >  void __init omap1_camera_init(void *info)
> >  {
> >  	struct platform_device *dev = &omap1_camera_device;
> > +	dma_addr_t paddr = omap1_camera_phys_mempool_base;
> > +	dma_addr_t size = omap1_camera_phys_mempool_size;
> >  	int ret;
> >
> >  	dev->dev.platform_data = info;
> >
> > +	if (paddr) {
> > +		if (dma_declare_coherent_memory(&dev->dev, paddr, paddr, size,
> > +				DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE))
>
> Although this works, you're ending up with SDRAM being mapped via
> ioremap, which uses MT_DEVICE - so what is SDRAM ends up being
> mapped as if it were a device.
>
> For OMAP1, which is ARMv5 or lower, device memory becomes 'uncacheable,
> unbufferable' which is luckily what is used for the DMA coherent
> memory on those platforms - so no technical problem here.
>
> However, on ARMv6 and later, ioremapped memory is device memory, which
> has different ordering wrt normal memory mappings, and may appear on
> different busses on the CPU's interface.  So, this is something I don't
> encourage as it's unclear that the hardware will work.
>
> Essentially, dma_declare_coherent_memory() on ARM with main SDRAM should
> be viewed as a 'it might work, it might not, and it might stop working
> in the future' kind of interface.  In other words, there is no guarantee
> that this kind of thing will be supported in the future.

I was affraid of an unswer of this kind. I'm not capable of comming out with 
any better, alternative solutions. Any hints other than giving up with that 
old videobuf-contig, coherent memory based interface? Or can we agree on 
that 'luckily uncacheable, unbufferable, SDRAM based DMA coherent memory' 
solution for now?

Thanks,
Janusz
