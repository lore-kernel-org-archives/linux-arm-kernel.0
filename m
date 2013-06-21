From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 21 Jun 2013 16:13:55 +0530
Subject: [PATCH] dmaengine: Add hisilicon k3 DMA engine driver
In-Reply-To: <201306172258.08185.arnd@arndb.de>
References: <1371444872-26994-1-git-send-email-zhangfei.gao@linaro.org>
 <201306172258.08185.arnd@arndb.de>
Message-ID: <20130621104355.GG23141@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:58:07PM +0200, Arnd Bergmann wrote:
> On Monday 17 June 2013, Zhangfei Gao wrote:
> > Add dmaengine driver for hisilicon k3 platform based on virt_dma
> > 
> > Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > Tested-by: Kai Yang <jean.yangkai@huawei.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> This filter function works only as long as there is no more than
> one DMA engine in the system, which is something that needs to
> be documented better. Unfortunately, providing a filter
> function to be called by .xlate is currently the only way that
> the dma-engine API supports, but we should really get over that.
> 
> Vinod: I think we need to add a way for a dmaengine driver to
> just return one of its channels to the xlate function. The
> current method is getting very silly, and it adds run-time and
> code complexity without any need.
> 
> How about something like
> 
> int dma_get_slave_channel(struct dma_chan *chan)
> {
> 	/* lock against __dma_request_channel */
> 	mutex_lock(&dma_list_mutex);
> 
> 	if (chan->client_count == 0)
> 		ret = dma_chan_get(chan);
> 	else	
> 		ret = -EBUSY;
> 
> 	mutex_unlock(&dma_list_mutex);
> 
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(dma_get_slave_channel);
and you add filter on top?

This is getting you any channel and maynot work where we need to do some
filtering. 

--
~vinod
-- 
