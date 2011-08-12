From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Aug 2011 16:40:21 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <4E44EAAD.1030805@ti.com>
References: <4E40FC88.5090403@ti.com>
	<20110812041016.GA6618@S2100-06.ap.freescale.net>
	<4E44EAAD.1030805@ti.com>
Message-ID: <201108121640.22199.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 August 2011, Cousson, Benoit wrote:
> > Arnd Bergmann:
> > But I really don't think there is value in using IORESOURCE_DMA for this.
> > We don't have the code to manage DMA resources for more than one DMA
> > controller AFAICT, and I think we should not add it. Globally
> > unique interrupt numbers cause us a lot of trouble and we go to great
> > lengths to fake them on modern devices.
> 
> Yeah, that totally makes sense. We do have several DMA engines in OMAP 
> anyway, so unique number is clearly not the best approach.
> But in that case, it means adding a new kernel API for that and not only 
> an of_XXX one. Because driver should then rely on it with or without DT.
> 
> > It would be much better
> > not to have them visible in the OS, and I don't want to add them to
> > a modern API like the dmaengine.
> 
> That part is less clear to me, what does it means?
> 

I mean you can have DMA channel numbers visible in the device
tree, relative to a 'parent' dma controller, but I would not
expose them as numbers on a device driver interface. Instead,
I think the interface we provide to the device driver is one
where we pass the device using the DMA channel into a generic
dmaengine API and let that figure out where it's connected
in order to return a struct dma_chan pointer.

	ARnd
