From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Jan 2011 11:27:01 +0100
Subject: [PATCH 6/6] dmaengine: imx-sdma: avoid stopping channel in the
	middle of a BD transfer
In-Reply-To: <20110120104312.GA18834@S2101-09.ap.freescale.net>
References: <1295473840-17295-1-git-send-email-shawn.guo@freescale.com>
	<1295473840-17295-7-git-send-email-shawn.guo@freescale.com>
	<20110120104312.GA18834@S2101-09.ap.freescale.net>
Message-ID: <20110120102701.GW9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 06:43:13PM +0800, Shawn Guo wrote:
> On Thu, Jan 20, 2011 at 05:50:40AM +0800, Shawn Guo wrote:
> > When STOP register bit gets set, SDMA hardware will immediately stop
> > the channel once the current burst other than buffer descriptor
> > transfer is done.
> > 
> > * Change sdma_disable_channel() to only set STOP register bit after
> >   polling the current BD done, so that the current BD transfer
> >   corruption could be avoided.
> > 
> > * Increment buf_tail in mxc_sdma_handle_channel_normal() as well as
> >   sdma_handle_channel_loop(), since buf_tail now is used in
> >   sdma_disable_channel() which could be called in both sg and cyclic
> >   cases.
> > 
> > * Return DMA_SUCCESS other than DMA_ERROR in sdma_disable_channel().
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > ---
> >  drivers/dma/imx-sdma.c |    9 ++++++++-
> >  1 files changed, 8 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> > index fa63ace..ae87287 100644
> > --- a/drivers/dma/imx-sdma.c
> > +++ b/drivers/dma/imx-sdma.c
> > @@ -481,6 +481,8 @@ static void mxc_sdma_handle_channel_normal(struct sdma_channel *sdmac)
> >  	else
> >  		sdmac->status = DMA_SUCCESS;
> >  
> > +	sdmac->buf_tail++;
> > +
> >  	if (sdmac->desc.callback)
> >  		sdmac->desc.callback(sdmac->desc.callback_param);
> >  	sdmac->last_completed = sdmac->desc.cookie;
> > @@ -655,9 +657,14 @@ static void sdma_disable_channel(struct sdma_channel *sdmac)
> >  {
> >  	struct sdma_engine *sdma = sdmac->sdma;
> >  	int channel = sdmac->channel;
> > +	struct sdma_buffer_descriptor *bd = &sdmac->bd[sdmac->buf_tail];
> > +
> > +	while (bd->mode.status & BD_DONE)
> > +		cpu_relax();
> >  
> >  	__raw_writel(1 << channel, sdma->regs + SDMA_H_STATSTOP);
> > -	sdmac->status = DMA_ERROR;
> > +
> > +	sdmac->status = DMA_SUCCESS;
> >  }
> 
> Sorry. The patch lost the change as below.  Will pick it up in v2.
> 
> @@ -658,11 +658,15 @@ static void sdma_disable_channel(struct sdma_channel *sdmac)
>         struct sdma_engine *sdma = sdmac->sdma;
>         int channel = sdmac->channel;
>         struct sdma_buffer_descriptor *bd = &sdmac->bd[sdmac->buf_tail];
> +       u32 stat = __raw_readl(sdma->regs + SDMA_H_STATSTOP);
> 
> -       while (bd->mode.status & BD_DONE)
> -               cpu_relax();
> +       /* stop the channel if it's running */
> +       if (stat & (1 << channel)) {
> +               while (bd->mode.status & BD_DONE)
> +                       cpu_relax();
> 
> -       __raw_writel(1 << channel, sdma->regs + SDMA_H_STATSTOP);
> +               __raw_writel(1 << channel, sdma->regs + SDMA_H_STATSTOP);
> +       }
> 
>         sdmac->status = DMA_SUCCESS;

NAK.

The patches has several problems.

- buf_tail is only used for cyclic transfers, so in case of non cyclic
  transfers you poll for an arbitrary descriptor being ready.

- Even in cyclic transfers when buf_tail points to the correct
  descriptor the hardware will immediatly start the next descriptor
  before you have a chance to set the STATSTOP bit. So you probably
  will corrupt the next descriptor instead of the current one
  which makes this patch useless.

- buf_tail is increased in the interrupt handler, so if you
  happen to disable the channel after the bd is done but before
  the interrupt handler has increased buf_tail you poll for the
  wrong bd being ready which again makes this patch useless.

If in non cyclic transfers we want to disable a channel we have our
reasons (device error or timeout) and then the data is corrupted anyway,
so no reason to poll for a descriptor getting done. Even worse, in case
of an device error the descriptor might not get ready at all and
we will poll for ever in the loop above.
Cyclic transfers are designed for audio and disabling a channel
basically means pausing the stream. When the SDMA engine does not
support pausing the stream in hardware, we have to live with the
fact that we pick up the stream on the next descriptor resulting
in some bytes missing in the resulting audio stream.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
