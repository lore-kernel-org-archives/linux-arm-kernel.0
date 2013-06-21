From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jun 2013 13:41:53 +0200
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <20130621104355.GG23141@intel.com>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306172258.08185.arnd@arndb.de> <20130621104355.GG23141@intel.com>
Message-ID: <201306211341.53928.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013, Vinod Koul wrote:
> On Mon, Jun 17, 2013 at 10:58:07PM +0200, Arnd Bergmann wrote:
> > On Monday 17 June 2013, Zhangfei Gao wrote:
> >
> > int dma_get_slave_channel(struct dma_chan *chan)
> > {
> >       /* lock against __dma_request_channel */
> >       mutex_lock(&dma_list_mutex);
> > 
> >       if (chan->client_count == 0)
> >               ret = dma_chan_get(chan);
> >       else    
> >               ret = -EBUSY;
> > 
> >       mutex_unlock(&dma_list_mutex);
> > 
> >       return ret;
> > }
> > EXPORT_SYMBOL_GPL(dma_get_slave_channel);
> and you add filter on top?

No, the idea is to no longer require a filter function when
we use dma_request_slave_channel with a DT specifier.

> This is getting you any channel and maynot work where we need to do some
> filtering. 

This function would be called only by the dmaengine driver's
xlate function. That driver obviously has to ensure that the
channel works for the specification from DT (or ACPI or
something else), but that part is easy, since that is
the same information that we currently pass into the filter
function.

	Arnd
