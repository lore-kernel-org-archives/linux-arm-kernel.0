From: Stefan.Bruens@rwth-aachen.de (=?iso-8859-1?Q?Br=FCns=2C_Stefan?=)
Date: Tue, 19 Sep 2017 16:17:59 +0000
Subject: [PATCH v2 07/10] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <20170919142508.woslovwjtecgygpo@flea.lan>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <2791817.czGZyN6WKS@sbruens-linux> <20170919142508.woslovwjtecgygpo@flea.lan>
Message-ID: <6028407.VKu5LCmQv0@sbruens-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Dienstag, 19. September 2017 16:25:08 CEST Maxime Ripard wrote:
> On Mon, Sep 18, 2017 at 02:09:43PM +0000, Br?ns, Stefan wrote:
> > On Montag, 18. September 2017 10:18:24 CEST you wrote:
> > > Hi,
> > > 
> > > On Sun, Sep 17, 2017 at 05:19:53AM +0200, Stefan Br?ns wrote:
> > > > +	ret = of_property_read_u32(np, "dma-channels", &sdc->num_pchans);
> > > > +	if (ret && !sdc->num_pchans) {
> > > > +		dev_err(&pdev->dev, "Can't get dma-channels.\n");
> > > > +		return ret;
> > > > +	}
> > > > +
> > > > +	if (sdc->num_pchans > DMA_MAX_CHANNELS) {
> > > > +		dev_err(&pdev->dev, "Number of dma-channels out of range.\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	ret = of_property_read_u32(np, "dma-requests", &sdc->max_request);
> > > > +	if (ret && !sdc->max_request) {
> > > > +		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> > > > +			 DMA_CHAN_MAX_DRQ);
> > > > +		sdc->max_request = DMA_CHAN_MAX_DRQ;
> > > > +	}
> > > > +
> > > > +	if (sdc->max_request > DMA_CHAN_MAX_DRQ) {
> > > > +		dev_err(&pdev->dev, "Value of dma-requests out of range.\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > 
> > > I'm not really convinced about these two checks. They don't catch all
> > > errors (the range between the actual number of channels / DRQ and the
> > > maximum allowed per the registers), they might increase in the future
> > > too, and if we want to make that check actually working, we would have
> > > to duplicate the number of requests and channels into the driver.
> > 
> > 1. If these values increase, we have a new register layout and and
> > need a new compatible anyway.
> 
> And you want to store a new maximum attached to the compatible? Isn't
> that exactly the situation you're trying to get away from?

Yes, and no. H3, H5, A64 and R40 have the exact same register layout, but 
different number of channels and ports. They could share a compatible (if DMA 
channels were generalized), and we already have several register offsets/
widths (implicitly via the callbacks) attached to the compatible (so these 
don't need generalization via DT).

Now, we could also move everything that is currently attached to the 
compatible, i.e. clock gate register offset, burst widths/lengths etc. into 
the devicetree binding, but that would just be too much.

The idea is to find a middle ground here, using common patterns in the 
existing SoCs. The register layout has hardly changed, while the number of DMA 
channels and ports changes all the time. Moving the number of DMA channels and 
ports to the DT is trivial, and a pattern also found in other DMA controller 
drivers. *If* the number of dma channels and ports is ever increased, 
exceeding the current maximum, this would amount to major changes in the 
driver and maybe even warrant a completely new driver.

> > 2. As long as the the limits are adhered to, no other registers/register
> > fields are overwritten. As the channel number and port are used to
> > calculate memory offsets bounds checking is IMHO a good idea.
> 
> And this is true for many other resources, starting with the one
> defined in reg. We don't error check every register range, clock
> index, reset line, interrupt, DMA channel, the memory size, etc. yet
> you could make the same argument.
> 
> The DT has to be right, and we have to trust it. Otherwise we can just
> throw it away.

So your argument here basically is - don't do any checks on DT provided 
values, these are always correct. So, following this argument, not only the 
range check, but also the of_property_read return values should be ignored, as 
the DT is correct, thus of_property_read will never return an error.

That clearly does not match the implementation of drivers throughout the 
various subsystems for DT properties, which is in general - do all the checks 
that can be done, trust everything you can not verify.

Kind regards,

Stefan
