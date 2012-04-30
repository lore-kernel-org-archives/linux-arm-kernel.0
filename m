From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 22:07:38 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <20120430195221.GB28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204301410.14393.marex@denx.de> <20120430195221.GB28226@pengutronix.de>
Message-ID: <201204302207.39112.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int
> > > >  len) {
> > > > 
> > > > -	u32 data;
> > > > +	u32 data = 0;
> > > 
> > > Unrelated, useless change.
> > 
> > Have you tried compiling the code with gcc 4.7?
> 
> What has the compiler version to do with the relevance? :) This has
> nothing to do with adding DMA support. Plus, nobody so far could tell me
> what path gcc is seeing there.

It complains that data might be undefined, do you want it in a separate patch 
then ?

> 
> > > > +	i2c->dma_mode = 1;
> > > 
> > > Have you measured the overhead of DMA? I'd still think that
> > > 
> > > 	if (MX23 || msg->len > 24)
> > > 	
> > > 		do_dma
> > > 	
> > > 	else
> > > 	
> > > 		do_pioqueue
> > > 
> > > might be worth considered.
> > 
> > It might, but in the 2.6.35.3 I have from FSL, it only does:
> > 
> > WARN_ONCE(len > 24, "choose DMA mode if xfer len > 24 bytes\n");
> 
> Well, we are back to the "FSL code is just a reference" topic.

Obviously.

> I truly
> hope that part was implemented because of laziness and not because of
> hardware limitations.

I still havent figured out how to flip between pioqueue mode and dma mode 
without the controller getting confused, so I prefer to postpone it into 
subsequent patch. Eventually, I agree it'd be cool to be able to do this 
switching.

> > Also, I tried switching PIOQUEUE/DMA, but didn't get it working. We might
> > as well make this dma/pioqueue mode configurable as well as speed via
> > platform data until someone comes up with a patch that can mix pioqueue
> > and dma?
> 
> User configuration is not an option here IMO, because PIOQUEUE would still
> fail for bigger transfers. "Always DMA" might be better then.

Yes, that's what I have in V2.

> But I will
> try to switch modes this week, that's just too tempting.

I'll have a V2 patch for you by ... in a bit ;-) Also, you can grab latest 
version here (will be updated before I submit V2): 
http://git.kernel.org/?p=linux/kernel/git/marex/linux-2.6.git;a=shortlog;h=refs/heads/mxs-
i2c

> 
> Regards,
> 
>    Wolfram

Best regards,
Marek Vasut
