From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Apr 2012 21:52:21 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <201204301410.14393.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <1335738969-27445-2-git-send-email-marex@denx.de>
 <20120430060554.GB7926@pengutronix.de>
 <201204301410.14393.marex@denx.de>
Message-ID: <20120430195221.GB28226@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > >  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int
> > >  len) {
> > > 
> > > -	u32 data;
> > > +	u32 data = 0;
> > 
> > Unrelated, useless change.
> 
> Have you tried compiling the code with gcc 4.7?

What has the compiler version to do with the relevance? :) This has
nothing to do with adding DMA support. Plus, nobody so far could tell me
what path gcc is seeing there.

> > > +	i2c->dma_mode = 1;
> > 
> > Have you measured the overhead of DMA? I'd still think that
> > 
> > 	if (MX23 || msg->len > 24)
> > 		do_dma
> > 	else
> > 		do_pioqueue
> > 
> > might be worth considered.
> 
> It might, but in the 2.6.35.3 I have from FSL, it only does:
> 
> WARN_ONCE(len > 24, "choose DMA mode if xfer len > 24 bytes\n");

Well, we are back to the "FSL code is just a reference" topic. I truly
hope that part was implemented because of laziness and not because of
hardware limitations.

> Also, I tried switching PIOQUEUE/DMA, but didn't get it working. We might as 
> well make this dma/pioqueue mode configurable as well as speed via platform data 
> until someone comes up with a patch that can mix pioqueue and dma?

User configuration is not an option here IMO, because PIOQUEUE would still
fail for bigger transfers. "Always DMA" might be better then. But I will
try to switch modes this week, that's just too tempting.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120430/b81d51a3/attachment.sig>
