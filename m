From: marex@denx.de (Marek Vasut)
Date: Fri, 29 Jun 2012 12:02:46 +0200
Subject: [PATCH 2/2] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120629093806.GL5844@shlinux2.ap.freescale.net>
References: <1340958243-2332-1-git-send-email-marex@denx.de>
 <201206291130.17060.marex@denx.de>
 <20120629093806.GL5844@shlinux2.ap.freescale.net>
Message-ID: <201206291202.46986.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Dong Aisheng,

> On Fri, Jun 29, 2012 at 05:30:16PM +0800, Marek Vasut wrote:
> > Dear Dong Aisheng,
> > 
> > > On Fri, Jun 29, 2012 at 04:24:03PM +0800, Marek Vasut wrote:
> > > > This patch implements DMA support into mxs-i2c. DMA transfers are now
> > > > enabled via DT. The DMA operation is enabled by default.
> > > > 
> > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > Cc: Detlev Zundel <dzu@denx.de>
> > > > CC: Dong Aisheng <b29396@freescale.com>
> > > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > > Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> > > > Cc: linux-i2c at vger.kernel.org
> > > > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > > > CC: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Stefano Babic <sbabic@denx.de>
> > > > CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > > Cc: Wolfgang Denk <wd@denx.de>
> > > > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > > > ---
> > > > 
> > > >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    4 +
> > > >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> > > >  drivers/i2c/busses/i2c-mxs.c                      |  267
> > > >  +++++++++++++++++++-- 3 files changed, 251 insertions(+), 22
> > > >  deletions(-)
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > > > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > > > d2bf750..9497ee0 100644
> > > > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > > > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > > > 
> > > > @@ -5,6 +5,10 @@ Required properties:
> > > >  - reg: Should contain registers location and length
> > > >  - interrupts: Should contain ERROR and DMA interrupts
> > > >  - clock-frequency: desired I2C bus clock frequency in Hz.
> > > > 
> > > > +- fsl,i2c-dma-channel: APBX DMA channel for the I2C
> > > 
> > > Shoundn't this be optional?
> > 
> > DMA channel? No, why?
> 
> User can use pio mode, so actually it's optional.
> Is it reasonable?

PIO mode is something that should not be used unless it's to be used for 
debugging purposes. The ultimate goal then is to use PIO for small transfers and 
DMA for large transfers. But that's not implemented yet and DMA is default.

> > > > +	/*
> > > > +	 * The last descriptor must have this callback,
> > > > +	 * to finish the DMA transaction.
> > > > +	 */
> > > > +	desc->callback = mxs_i2c_dma_irq_callback;
> > > > +	desc->callback_param = i2c;
> > > > +
> > > > +	/* Start the transfer. */
> > > > +	dmaengine_submit(desc);
> > > > +	dma_async_issue_pending(i2c->dmach);
> > > > +	return 0;
> > > > +
> > > > +/* Read failpath. */
> > > > +read_init_dma_fail:
> > > > +	dma_unmap_sg(i2c->dev, &i2c->sg_io[1], 1, DMA_FROM_DEVICE);
> > > > +select_init_dma_fail:
> > > > +	dma_unmap_sg(i2c->dev, &i2c->sg_io[0], 1, DMA_TO_DEVICE);
> > > > +select_init_pio_fail:
> > > > +	return 1;
> > > 
> > > look strange why return 1;
> > 
> > Because it failed. -Esomething might be better ?
> 
> i think yes.

And -Ewhat do you suggest ? :)

> Regards
> Dong Aisheng

Best regards,
Marek Vasut
