From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Jul 2012 17:31:19 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <Pine.LNX.4.64.1207061737410.29809@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207061528.58291.arnd@arndb.de>
 <Pine.LNX.4.64.1207061737410.29809@axis700.grange>
Message-ID: <201207061731.20271.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012, Guennadi Liakhovetski wrote:
> > > <dmaengine_core>
> > >     for_each_channel() {
> > >             ret = chan->device->device_alloc_chan_resources(chan, filter_arg);
> > >             if (!ret)
> > >                     return chan;
> > >             else if (ret != -ENODEV)
> > >                     return ret;
> > >             /* -ENODEV - try the next channel */
> > >     }
> > > 
> > > Which is quite similar to my above mentioned proposal. Wouldn't this both 
> > > improve the present API and prepare it for DT?
> > 
> > How would the individual driver know the size of the filter_arg?
> 
> In exactly the same way as most dmaengine drivers do it today: they don't 
> touch filter_arg until they're sure this is one of their channels. And 
> this they typically do by comparing the driver pointer, e.g.:
> 
> bool sa11x0_dma_filter_fn(struct dma_chan *chan, void *param)
> {
>         if (chan->device->dev->driver == &sa11x0_dma_driver.driver) {

I don't understand. This already matches because we're calling the
device_alloc_chan_resources() function of the specific device that
matches the channel. However, we do the same for each channel, with the
same data, but different controllers, each of which will think they match
the channel.

	Arnd
