From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 29 Dec 2010 14:47:10 +0100
Subject: [PATCH 08/10] ARM: mxs: add ocotp read function
In-Reply-To: <20101229120822.GI19347@freescale.com>
References: <1293548155-16328-1-git-send-email-shawn.guo@freescale.com>
	<1293548155-16328-9-git-send-email-shawn.guo@freescale.com>
	<20101229104745.GV14221@pengutronix.de>
	<20101229120822.GI19347@freescale.com>
Message-ID: <20101229134710.GF14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

On Wed, Dec 29, 2010 at 08:08:23PM +0800, Shawn Guo wrote:
> On Wed, Dec 29, 2010 at 11:47:45AM +0100, Uwe Kleine-K?nig wrote:
> > On Tue, Dec 28, 2010 at 10:55:53PM +0800, Shawn Guo wrote:
> > > +{
> > > +	void __iomem *ocotp_base = MXS_IO_ADDRESS(MXS_OCOTP_BASE_ADDR);
> > > +	int i, timeout = 0x400;
> > > +
> > > +	/* open OCOTP banks for read */
> > > +	__mxs_setl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > > +
> > > +	/* approximately wait 32 hclk cycles */
> > > +	udelay(1);
> > > +
> > > +	/* poll BUSY bit becoming cleared */
> > > +	while ((__raw_readl(ocotp_base) & BM_OCOTP_CTRL_BUSY) && --timeout)
> > > +		/* nothing */;
> > > +
> > > +	if (unlikely(!timeout))
> > > +		goto error;
> > > +
> > > +	for (i = 0; i < count; i++, offset += 4)
> > > +		*values++ = __raw_readl(ocotp_base + offset);
> > > +
> > > +	/* close banks for power saving */
> > > +	__mxs_clrl(BM_OCOTP_CTRL_RD_BANK_OPEN, ocotp_base);
> > > +
> > > +	return 0;
> > > +
> > > +error:
> > > +	pr_err("%s: timeout in reading OCOTP\n", __func__);
> > > +	return -ETIMEDOUT;
> > > +}
> > does this need locking?
> > 
> You are suggesting mutex or spinlock?
This isn't time critical, so I'd advice to use a mutex.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
