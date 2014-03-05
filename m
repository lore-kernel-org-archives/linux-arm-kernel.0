From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Mar 2014 09:43:30 +0000
Subject: [PATCH 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <m3d2i1atmq.fsf@t19.piap.pl>
References: <20140305085311.07b3922a@marrow.netinsight.se>
 <20140305085549.3eb22236@marrow.netinsight.se> <m3d2i1atmq.fsf@t19.piap.pl>
Message-ID: <20140305094330.GU21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 05, 2014 at 10:21:01AM +0100, Krzysztof Ha?asa wrote:
> Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:
> 
> > --- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
> > +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
> > @@ -1426,6 +1426,10 @@ static int eth_init_one(struct platform_device *pdev)
> >  	port->netdev = dev;
> >  	port->id = pdev->id;
> >  
> > +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
> > +	if (err < 0)
> > +		goto err_free;
> > +
> 
> Both David and the DMA API say 32 bits must be the default. OTOH there
> is other code like this in the kernel, guess IXP4xx is not alone with
> such constrains.

If you have drivers missing this call, that's part of the problem:

| For correct operation, you must interrogate the kernel in your device
| probe routine to see if the DMA controller on the machine can properly
| support the DMA addressing limitation your device has.  It is good
| style to do this even if your device holds the default setting,
| because this shows that you did think about these issues wrt. your
| device.
| 
| The query is performed via a call to dma_set_mask_and_coherent():
| 
|         int dma_set_mask_and_coherent(struct device *dev, u64 mask);
| 
| which will query the mask for both streaming and coherent APIs together.
| If you have some special requirements, then the following two separate
| queries can be used instead:
| 
|         The query for streaming mappings is performed via a call to
|         dma_set_mask():
| 
|                 int dma_set_mask(struct device *dev, u64 mask);
| 
|         The query for consistent allocations is performed via a call
|         to dma_set_coherent_mask():
| 
|                 int dma_set_coherent_mask(struct device *dev, u64 mask);
| 
| Here, dev is a pointer to the device struct of your device, and mask
| is a bit mask describing which bits of an address your device
| supports.  It returns zero if your card can perform DMA properly on
| the machine given the address mask you provided.  In general, the
| device struct of your device is embedded in the bus specific device
| struct of your device.  For example, a pointer to the device struct of
| your PCI device is pdev->dev (pdev is a pointer to the PCI device
| struct of your device).
| 
| If it returns non-zero, your device cannot perform DMA properly on
| this platform, and attempting to do so will result in undefined
| behavior.  You must either use a different mask, or not use DMA.
| 
| ...

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
