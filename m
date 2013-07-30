From: rizhao@nvidia.com (Richard Zhao)
Date: Tue, 30 Jul 2013 11:06:46 +0800
Subject: [PATCH 2/9] dma: tegra20-apbdma: move to generic device tree
 bindings
In-Reply-To: <51F2CDBE.40802@wwwdotorg.org>
References: <1374639002-16753-1-git-send-email-rizhao@nvidia.com>
 <1374639002-16753-3-git-send-email-rizhao@nvidia.com>
 <51F2CDBE.40802@wwwdotorg.org>
Message-ID: <20130730030644.GJ15855@rizhao-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 03:27:58AM +0800, Stephen Warren wrote:
> (Stripping the Cc list a lot)
> 
> On 07/23/2013 10:09 PM, Richard Zhao wrote:
> > Update tegra20-apbdma driver to adopt generic DMA device tree bindings.
> > It calls of_dma_controller_register() with of_dma_simple_xlate to get
> > the generic DMA device tree helper support. The #dma-cells for apbdma
> > must be 1, which is slave ID.
> > 
> > The existing nvidia,dma-request-selector still works there, and the
> > support will be removed after all clients get converted to generic DMA
> > device tree helper.
> 
> (BTW, I would like to take this series through the Tegra tree to
> simplify dependencies. So, I'm looking for ack's on the drivers rather
> than for them to be applied. I had hoped Richard would point this out
> when posting the patches)
Sorry I forgot to add maintainr-pick-up suggestions.
> 
> > diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
> 
> > +static bool tegra_dma_filter_fn(struct dma_chan *dc, void *param)
> > +{
> > +	if (dc->device->dev->driver == &tegra_dmac_driver.driver) {
> > +		struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
> > +		unsigned req = *(unsigned *)param;
> > +
> > +		tdc->slave_id = req;
> > +
> > +		return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +static struct of_dma_filter_info tegra_dma_info = {
> > +	.filter_fn = tegra_dma_filter_fn,
> > +};
> 
> Why does this driver need to define a filter function? I thought the
> dmaengine's DT support would already match DMA clients/engines based on
> the phandle in DT? Isn't the need to pass the slave channel ID into
> drivers something pretty fundamental to dmaengine, and hence something
> it already supports?
of_dma_simple_xlate only pass slave id to filter function. It needs
change to pass dt node too. I didn't start work on the common code
change yet. Do you think we need to hold it until common code change?

Thanks
Richard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
