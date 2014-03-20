From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Mar 2014 11:10:17 +0000
Subject: [PATCH RESEND v2 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <m3eh20j6k2.fsf@t19.piap.pl>
References: <20140317144016.0508cc4d@marrow.netinsight.se>
 <20140317144244.6d2e09f9@marrow.netinsight.se> <m3eh20j6k2.fsf@t19.piap.pl>
Message-ID: <20140320111017.GO7528@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 08:43:09AM +0100, Krzysztof Ha?asa wrote:
> Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:
> 
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
> Yeah. One could also set both masks with the new single call. The driver
> uses both streaming and coherent mapping.

The other issue with this patch set is (from DMA-API-HOWTO.txt):

  The coherent coherent mask will always be able to set the same or a
  smaller mask as the streaming mask.

and code in places assumes that's true.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
