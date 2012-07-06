From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 6 Jul 2012 17:43:38 +0200 (CEST)
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201207061528.58291.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206252030.56025.arnd@arndb.de>
 <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
 <201207061528.58291.arnd@arndb.de>
Message-ID: <Pine.LNX.4.64.1207061737410.29809@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd

On Fri, 6 Jul 2012, Arnd Bergmann wrote:

> On Friday 06 July 2012, Guennadi Liakhovetski wrote:
> > On Mon, 25 Jun 2012, Arnd Bergmann wrote:
> > 
> > [snip]
> > 
> > > The channel data in the device tree is still in a format
> > > that is specific to that dmaengine driver and interpreted
> > > by it. Using the regular dma_filter_fn prototype is not
> > > necessary, but it would be convenient because the dmaengine
> > > code already knows how to deal with it. If we don't use this
> > > method, how about adding another callback to struct dma_device
> > > like
> > > 
> > > bool (*device_match)(struct dma_chan *chan, struct property *req);
> > 
> > I like this idea, but why don't we extend it to also cover the non-DT 
> > case? I.e., why don't we add the above callback (call it "match" or 
> > "filter" or anything else) to dmaengine operations and inside (the 
> > extended) dma_request_channel(), instead of calling the filter function, 
> > passed as a parameter, we loop over all registered DMAC devices and call 
> > their filter callbacks, until one of them returns true? In fact, it goes 
> > back to my earlier proposal from 
> > http://thread.gmane.org/gmane.linux.kernel/1246957
> > which I, possibly, failed to explain properly. So, the transformation 
> > chain from today's API would be (all code is approximate):
> > 
> > ...
> > <dmaengine_core>
> > 	for_each_channel() {
> > 		ret = chan->device->device_alloc_chan_resources(chan, filter_arg);
> > 		if (!ret)
> > 			return chan;
> > 		else if (ret != -ENODEV)
> > 			return ret;
> > 		/* -ENODEV - try the next channel */
> > 	}
> > 
> > Which is quite similar to my above mentioned proposal. Wouldn't this both 
> > improve the present API and prepare it for DT?
> 
> How would the individual driver know the size of the filter_arg?

In exactly the same way as most dmaengine drivers do it today: they don't 
touch filter_arg until they're sure this is one of their channels. And 
this they typically do by comparing the driver pointer, e.g.:

bool sa11x0_dma_filter_fn(struct dma_chan *chan, void *param)
{
	if (chan->device->dev->driver == &sa11x0_dma_driver.driver) {

Thanks
Guennadi

> In the
> device tree code, we would know if from #dma-cells of the engine node,
> and that gets checked when reading the property, but when you have
> a free-form data structure, it's much less clear.
> 
> Also, you could easily have an argument that looks valid for more than one
> dmaengine, but really isn't.
> 
> I think for your proposal to work, we would need something like the
> phandle for the dmaengine device that is at the start of the property
> in the DT case.
> 
> 	Arnd
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
