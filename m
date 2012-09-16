From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 16 Sep 2012 13:12:23 +0200
Subject: [PATCH V4] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <201209161251.41895.marex@denx.de>
References: <1345779871-7677-1-git-send-email-marex@denx.de>
 <20120916102342.GA933@pengutronix.de>
 <201209161251.41895.marex@denx.de>
Message-ID: <20120916111223.GD933@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Unsurprisingly, I also couldn't get the mode switching between DMA and
> > PIOQUEUE to work :(
> 
> I'd say more work should be invested into this.

I ran out of ideas. Next thing I'd do is to ask FSL if this is possible
at all. Yet, I'd like to have some solution for 3.7.

> Besides, what about rather > trying PIO + DMA instead of PIOQ + DMA?

That could also be a solution.

> > However, I did come up with an idea how to select DMA or PIOQUEUE per
> > bus via devicetree. If we change the view from "I want PIOQUEUE" to "I
> > don't want DMA", we could simply override the default DMA configuration
> > in the devicetree with, e.g.:
> > 
> > 			i2c0: i2c at 80058000 {
> > 				...
> > 				fsl,i2c-dma-channel = <>;
> > 			};
> > 
> > So, no DMA channel set up will fall back to PIOQUEUE. This is more
> > generic than a custom binding, because if one doesn't want DMA, don't
> > configure it. That should also work with other devices which can fall
> > back to something. I think this is worth trying, another advantage is
> > that it doesn't expose something new to the user. So, there is no legacy
> > support needed in case there will be a better way of configuration.
> 
> Ewww ... that's such an ad-hoc hack.

Please give reasons.

> Besides, someone might simply forget to add the binding, you'd need to
> print a warning.

? It is "on" by default because of the entry in the dtsi. And the status
of DMA will be printed.

> > +	dev_info(dev, "registered. DMA: %s\n", i2c->dma_mode ? "on" : "off");
> 
> dev_debug() ?

Yup.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120916/992906f8/attachment-0001.sig>
