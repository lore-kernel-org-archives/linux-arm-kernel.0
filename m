From: stefan.bruens@rwth-aachen.de (Stefan Bruens)
Date: Thu, 28 Sep 2017 01:10:46 +0200
Subject: [PATCH v2 07/10] dmaengine: sun6i: Retrieve channel count/max
 request from devicetree
In-Reply-To: <20170927090922.u2hnvgz7yi55sjl3@flea>
References: <20170917031956.28010-1-stefan.bruens@rwth-aachen.de>
 <3154933.I7MMVk5mkV@sbruens-linux> <20170927090922.u2hnvgz7yi55sjl3@flea>
Message-ID: <9434998.NR9mI8DG1i@pebbles.site>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mittwoch, 27. September 2017 11:09:22 CEST Maxime Ripard wrote:
> On Sat, Sep 23, 2017 at 12:00:15AM +0000, Br?ns, Stefan wrote:
> > On Freitag, 22. September 2017 23:30:27 CEST Maxime Ripard wrote:
> > > On Tue, Sep 19, 2017 at 04:17:59PM +0000, Br?ns, Stefan wrote:
> > > > On Dienstag, 19. September 2017 16:25:08 CEST Maxime Ripard wrote:
> > > > > On Mon, Sep 18, 2017 at 02:09:43PM +0000, Br?ns, Stefan wrote:
> > > > > > On Montag, 18. September 2017 10:18:24 CEST you wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Sun, Sep 17, 2017 at 05:19:53AM +0200, Stefan Br?ns wrote:
> > > > > > > > +	ret = of_property_read_u32(np, "dma-channels",
> > > > > > > > &sdc->num_pchans);
> > > > > > > > +	if (ret && !sdc->num_pchans) {
> > > > > > > > +		dev_err(&pdev->dev, "Can't get dma-channels.\n");
> > > > > > > > +		return ret;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (sdc->num_pchans > DMA_MAX_CHANNELS) {
> > > > > > > > +		dev_err(&pdev->dev, "Number of dma-channels out of range.
> > 
> > \n");
> > 
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	ret = of_property_read_u32(np, "dma-requests",
> > > > > > > > &sdc->max_request);
> > > > > > > > +	if (ret && !sdc->max_request) {
> > > > > > > > +		dev_info(&pdev->dev, "Missing dma-requests, using %u.\n",
> > > > > > > > +			 DMA_CHAN_MAX_DRQ);
> > > > > > > > +		sdc->max_request = DMA_CHAN_MAX_DRQ;
> > > > > > > > +	}
> > > > > > > > +
> > > > > > > > +	if (sdc->max_request > DMA_CHAN_MAX_DRQ) {
> > > > > > > > +		dev_err(&pdev->dev, "Value of dma-requests out of
> > > > > > > > range.\n");
> > > > > > > > +		return -EINVAL;
> > > > > > > > +	}
> > > > > > > 
> > > > > > > I'm not really convinced about these two checks. They don't
> > > > > > > catch
> > > > > > > all
> > > > > > > errors (the range between the actual number of channels / DRQ
> > > > > > > and
> > > > > > > the
> > > > > > > maximum allowed per the registers), they might increase in the
> > > > > > > future
> > > > > > > too, and if we want to make that check actually working, we
> > > > > > > would
> > > > > > > have
> > > > > > > to duplicate the number of requests and channels into the
> > > > > > > driver.
> > > > > > 
> > > > > > 1. If these values increase, we have a new register layout and and
> > > > > > need a new compatible anyway.
> > > > > 
> > > > > And you want to store a new maximum attached to the compatible?
> > > > > Isn't
> > > > > that exactly the situation you're trying to get away from?
> > > > 
> > > > Yes, and no. H3, H5, A64 and R40 have the exact same register layout,
> > > > but
> > > > different number of channels and ports. They could share a compatible
> > > > (if
> > > > DMA channels were generalized), and we already have several register
> > > > offsets/ widths (implicitly via the callbacks) attached to the
> > > > compatible
> > > > (so these don't need generalization via DT).
> > > > 
> > > > Now, we could also move everything that is currently attached to the
> > > > compatible, i.e. clock gate register offset, burst widths/lengths etc.
> > > > into
> > > > the devicetree binding, but that would just be too much.
> > > > 
> > > > The idea is to find a middle ground here, using common patterns in the
> > > > existing SoCs. The register layout has hardly changed, while the
> > > > number of
> > > > DMA channels and ports changes all the time. Moving the number of DMA
> > > > channels and ports to the DT is trivial, and a pattern also found in
> > > > other DMA controller drivers.
> > > 
> > > I'm sorry, but the code is inconsistent here. You basically have two
> > > variables from one SoC to the other, the number of channels and
> > > requests.
> > > 
> > > In one case (channels), it mandates that the property is provided in
> > > the device tree, and doesn't default to anything.
> > > 
> > > In the other case (requests), the property is optional and it will
> > > provide a default. All that in 20 lines.
> > 
> > The channel number is a hardware property. Using more channels than the
> > hardware provides is a bug. There is no default.
> > 
> > The port/request is just some lax property to limit the resource
> > allocation
> > upfront. As long as the bindings of the different IP blocks (SPI, audio,
> > ...) provide the correct port numbers, all required information is
> > available.
> Using an improper request ID or out of bounds will be just as much as
> a bug. You will not get your DMA transfer to the proper device you
> were trying to, the data will not reach the device or memory, your
> driver will not work => a bug.
> 
> It will not be for the same reasons, you will not overwrite other
> registers, but the end result is just the same: your transfer will not
> work.

Writing adjacent registers breaks other users of the DMA controller. 
"Everytime I play a sound, my MMC breaks" - oh, what fun.

> > > I guess we already reached that middle ground by providing them
> > > through the DT, we just have to make sure we remain consistent.
> > > 
> > > > *If* the number of dma channels and ports is ever increased,
> > > > exceeding the current maximum, this would amount to major changes in
> > > > the driver and maybe even warrant a completely new driver.
> > > > 
> > > > > > 2. As long as the the limits are adhered to, no other
> > > > > > registers/register
> > > > > > fields are overwritten. As the channel number and port are used to
> > > > > > calculate memory offsets bounds checking is IMHO a good idea.
> > > > > 
> > > > > And this is true for many other resources, starting with the one
> > > > > defined in reg. We don't error check every register range, clock
> > > > > index, reset line, interrupt, DMA channel, the memory size, etc. yet
> > > > > you could make the same argument.
> > > > > 
> > > > > The DT has to be right, and we have to trust it. Otherwise we can
> > > > > just
> > > > > throw it away.
> > > > 
> > > > So your argument here basically is - don't do any checks on DT
> > > > provided
> > > > values, these are always correct. So, following this argument, not
> > > > only
> > > > the
> > > > range check, but also the of_property_read return values should be
> > > > ignored, as the DT is correct, thus of_property_read will never return
> > > > an
> > > > error.
> > > 
> > > No, my argument is don't do a check if you can catch only half of the
> > > errors, and with no hope of fixing it.
> > > 
> > > The functions you mentionned have a 100% error catch rate. This is the
> > > difference.
> > > 
> > > > That clearly does not match the implementation of drivers throughout
> > > > the
> > > > various subsystems for DT properties, which is in general - do all the
> > > > checks that can be done, trust everything you can not verify.
> > > 
> > > And my point is that we're falling into the latter here. You cannot
> > > verify it properly.
> > 
> > Please check the following line:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dr
> > ivers/dma/sun6i-dma.c#n951
> > 
> > Thats far from 100% - the highest allowed port for each SoC differs
> > between RX and TX, and port allocation is sparse.
> 
> But until your patches, you *could* fix it and reach that 100%.

1. You had 3 years to do that, but you never cared.
2. Its still possible to do, just add a property to the devicetree.

> And I guess now we could indeed remove it.
> 
> Look, this discussion is going nowhere. I told you what the condition
> for my Acked-by was already.

Yeah, and its your power as a so called maintainer to force your opinion on 
anyone crossing your way. Fine, go for it ...

Stefan

-- 
Stefan Br?ns  /  Bergstra?e 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
