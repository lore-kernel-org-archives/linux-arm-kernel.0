From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 17 Dec 2014 02:19:45 +0200
Subject: [PATCH v6 6/8] dma-mapping: detect and configure IOMMU in
 of_dma_configure
In-Reply-To: <20141215113252.GH20738@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <6311849.8NniZ58Jf1@avalon> <20141215113252.GH20738@arm.com>
Message-ID: <35498434.EVQZ75aAeX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Monday 15 December 2014 11:32:52 Will Deacon wrote:
> On Sun, Dec 14, 2014 at 03:51:13PM +0000, Laurent Pinchart wrote:
> > On Monday 01 December 2014 16:57:12 Will Deacon wrote:
> > > This patch extends of_dma_configure so that it sets up the IOMMU for a
> > > device, as well as the coherent/non-coherent DMA mapping ops.
> > > 
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Tested-by: Robin Murphy <robin.murphy@arm.com>
> > > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> [...]
> 
> > > +static void of_dma_deconfigure(struct device *dev)
> > > +{
> > > +	arch_teardown_dma_ops(dev);
> > >  }
> > >  
> > >  /**
> > > @@ -223,16 +234,12 @@ static struct platform_device
> > > *of_platform_device_create_pdata( if (!dev)
> > > 
> > >  		goto err_clear_flag;
> > > 
> > > -	of_dma_configure(&dev->dev);
> > >  	dev->dev.bus = &platform_bus_type;
> > >  	dev->dev.platform_data = platform_data;
 > > -
> > > -	/* We do not fill the DMA ops for platform devices by default.
> > > -	 * This is currently the responsibility of the platform code
> > > -	 * to do such, possibly using a device notifier
> > > -	 */
> > > +	of_dma_configure(&dev->dev);
> > >  	if (of_device_add(dev) != 0) {
> > > +		of_dma_deconfigure(&dev->dev);
> > 
> > Don't you also need to call of_dma_deconfigure() when the device is
> > destroyed ? Otherwise the default domain created by arch_setup_dma_ops()
> > will be leaked.
>
> Something like below?

Yes, something like that. This will however cause a dev_warn("Not attached") 
message to be printed for devices that have no IOMMU, that should be fixed in 
the arch code.

> --->8
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b89caf8c7586..ec29c25b4fce 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -525,6 +525,7 @@ static int of_platform_device_destroy(struct device
> *dev, void *data) amba_device_unregister(to_amba_device(dev));
>  #endif
> 
> +       of_dma_deconfigure(dev);
>         of_node_clear_flag(dev->of_node, OF_POPULATED);
>         of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>         return 0;

-- 
Regards,

Laurent Pinchart
