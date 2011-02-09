From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 Feb 2011 09:34:00 +0100
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110208232833.GC6963@S2100-06.ap.freescale.net>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<20110207082521.GI9041@pengutronix.de>
	<20110208232833.GC6963@S2100-06.ap.freescale.net>
Message-ID: <20110209083400.GK9041@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Wed, Feb 09, 2011 at 07:28:34AM +0800, Shawn Guo wrote:
> > > +
> > > +     if (direction == DMA_NONE) {
> > > +             ccw = &mxs_chan->ccw[0];
> > > +             pio = (u32 *) sgl;
> > > +
> > > +             for (j = 0; j < sg_len;)
> > > +                     ccw->pio_words[j++] = *pio++;
> > > +
> > > +             ccw->next = 0;
> > > +             ccw->bits.chain = 0;
> > > +             ccw->bits.irq = 1;
> > > +             ccw->bits.dec_sem = 1;
> > > +             ccw->bits.wait4end = flags;
> > > +             ccw->bits.halt_on_terminate = 1;
> > > +             ccw->bits.terminate_flush = 1;
> > > +             ccw->bits.pio_num = sg_len;
> > > +             ccw->bits.command = MXS_DMA_NO_XFER;
> > 
> > Does this have a valid usecase? I would just return some error code
> > here. pio_num and pio_words are unused in the driver and I don't think
> > a dmaengine driver should have some kind of PIO fallback.
> > 
> If you happen to have a look at mxs-mmc patch set, you could find it.

As Russell already pointed out, the (mmc-) driver should handle this.

> > > +
> > > +     /*
> > > +      * dmaengine clients have to use dma_device.dev_id to filter
> > > +      * dma device between apbh and apbx, so need to ensure it is
> > > +      * identical to mxs_dma_engine.dev_id.
> > > +      */
> > > +     if (mxs_dma->dma_device.dev_id != mxs_dma->dev_id) {
> > > +             dev_err(&pdev->dev, "dev_id of dma_device %d differs from mxs_dma_engine %d\n",
> > > +                             mxs_dma->dma_device.dev_id, mxs_dma->dev_id);
> > > +             goto err_init;
> > > +     }
> > 
> > I think it makes more sense to match against device names (apbh vs.
> > apbx) in the client's filter function than to rely on exact numbering.
> > 
> I agree, if there is already a member like dev_name in dma_device.
> There is dev_id but no dev_name.  Suggestion on how to use device
> name for matching?

Have a look at the implementation of imx_dma_is_general_purpose() and
imx_dma_is_ipu().

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
