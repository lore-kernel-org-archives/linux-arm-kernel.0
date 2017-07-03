From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 3 Jul 2017 08:52:21 +0200
Subject: [PATCH 3/7] serial: imx: init dma_is_{rx|tx}ing variables
In-Reply-To: <20170630141329.6144cddd@karo-electronics.de>
References: <20170630120446.13994-1-romain.perier@collabora.com>
 <20170630120446.13994-4-romain.perier@collabora.com>
 <20170630141329.6144cddd@karo-electronics.de>
Message-ID: <20170703065221.imbpbybsrd3of4ec@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:13:29PM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Fri, 30 Jun 2017 14:04:42 +0200 Romain Perier wrote:
> > From: Nandor Han <nandor.han@ge.com>
> > 
> > Initialize both dma_is_{rx|tx}ing variables when DMA is enabled to avoid
> > checking uninitialized variables if port shutdown is requested before
> > DMA channels get a chance to start.
> > 
> > Signed-off-by: Nandor Han <nandor.han@ge.com>
> > Signed-off-by: Romain Perier <romain.perier@collabora.com>
> > ---
> >  drivers/tty/serial/imx.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index 188063d..81fb413 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -1225,6 +1225,9 @@ static void imx_enable_dma(struct imx_port *sport)
> >  
> >  	imx_setup_ufcr(sport, TXTL_DMA, RXTL_DMA);
> >  
> > +	sport->dma_is_rxing = 0;
> > +	sport->dma_is_txing = 0;
> > +
> >  	sport->dma_is_enabled = 1;
> >  }
> >  
> sport is devm_kzalloc()ed, so the variables are initialized to 0 anyway.

I'd agree to Lothar's statement. Did you find this issue by inspection,
or does it fix a compiler warning? Do you think there is an actual
problem?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
