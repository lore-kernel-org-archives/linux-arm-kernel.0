From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Apr 2012 21:59:31 +0800
Subject: Using GPMI-NAND driver on iMX28 using 3.4-rc1?
In-Reply-To: <CAOdLEaoD2sezmXbOoBdZ4h4E+A2rqf-2K9P-Y6aUt+zeASZQrw@mail.gmail.com>
References: <CAOdLEaoboQowyx3T9ONjv-Y3q1JfFRb4ahS8CNrzeJi3N8Dczg@mail.gmail.com>
 <CAOMZO5AsbFDXHs3JRLC5=1MjZ7QrxciqV25xpZQL1Yvk3boQmw@mail.gmail.com>
 <CAOdLEaoEDr7fnswwV-Gs8tZF9Zj-RFnRa9Z=eqRFd0==OgV10Q@mail.gmail.com>
 <CAOMZO5AoFnM=cCR-kS4A1k2xY_bRd9+gN1p9bFxdyPS2-UdbkQ@mail.gmail.com>
 <4F7D3DB8.6080009@freescale.com>
 <CAOdLEaoy8ARS=awimR6fN8EcX+FrqxaSr3VUG3rP3zrNLOf+Gw@mail.gmail.com>
 <1333628861.31825.22.camel@vkoul-udesk3>
 <20120406022305.GJ7264@S2101-09.ap.freescale.net>
 <4F7EC6AF.6000603@freescale.com>
 <CAOdLEaoD2sezmXbOoBdZ4h4E+A2rqf-2K9P-Y6aUt+zeASZQrw@mail.gmail.com>
Message-ID: <20120406135929.GR7264@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 06:49:05AM -0700, Sam Gandhi wrote:
> >
> >
> > It's maybe too late to assign the DMA cookie after mxs_dma_enable_chan() in
> > mxs_dma_tx_submit().
> > The interrupt may arise before the dma_cookie_assign() finishes.
> >
> > Why mmc/audio do not have this bug? their interrupt arise too slow.
> >
> > I tested the following code :
> > ==============================================================
> >
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> > index 5978113..0f5b09a 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -202,10 +202,12 @@ static struct mxs_dma_chan *to_mxs_dma_chan(struct
> > dma_cha
> > static dma_cookie_t mxs_dma_tx_submit(struct dma_async_tx_descriptor *tx)
> > {
> > struct mxs_dma_chan *mxs_chan = to_mxs_dma_chan(tx->chan);
> > + dma_cookie_t c;
> >
> > + c = dma_cookie_assign(tx);
> > mxs_dma_enable_chan(mxs_chan);
> >
> > - return dma_cookie_assign(tx);
> > + return c;
> > }
> >
> If this is the issue, then why not have mxs_dma_enable_chan itself
> call dma_cookie_assign() and return that cookie.
> 
As the function name tells, mxs_dma_enable_chan is to only operate dma
hardware to enable the channel but nothing else.

> That way mxs_dma_enable_chan() is self contained function that assign
> the cookie, enables channel and returns assigned cookie. And nobody
> will make mistake of calling just mxs_dma_enable_chan without first
> calling dma_cookie_assign?
> 
mxs_dma_enable_chan() is a mxs-dma private call.  Nobody but only
mxs-dma driver itself can call it.

-- 
Regards,
Shawn
