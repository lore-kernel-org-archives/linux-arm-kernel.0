From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Jul 2012 14:10:29 +0200
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120713082249.GF32184@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
Message-ID: <201207131410.29469.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Hi,
> 
> On Mon, Jul 09, 2012 at 06:22:54PM +0200, Marek Vasut wrote:
> > This patch implements DMA support into mxs-i2c. DMA transfers are now
> > enabled via DT. The DMA operation is enabled by default.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Detlev Zundel <dzu@denx.de>
> > CC: Dong Aisheng <b29396@freescale.com>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> > Cc: linux-i2c at vger.kernel.org
> > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > CC: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Stefano Babic <sbabic@denx.de>
> > CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > Cc: Wolfgang Denk <wd@denx.de>
> > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > ---
> > 
> >  Documentation/devicetree/bindings/i2c/i2c-mxs.txt |    5 +
> >  arch/arm/boot/dts/imx28.dtsi                      |    2 +
> >  drivers/i2c/busses/i2c-mxs.c                      |  267
> >  +++++++++++++++++++-- 3 files changed, 252 insertions(+), 22
> >  deletions(-)
> > 
> > V2: Fixed return value from mxs_i2c_dma_setup_xfer().
> > 
> >     Fixed coding style nitpicks
> >     Call mxs_i2c_dma_finish() in failpath only if DMA is active
> > 
> > V3: Align with changes in previous patch
> > 
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt index
> > 30ac3a0..45b6307 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mxs.txt
> > 
> > @@ -6,6 +6,10 @@ Required properties:
> >  - interrupts: Should contain ERROR and DMA interrupts
> >  - clock-frequency: Desired I2C bus clock frequency in Hz.
> >  
> >                     Only 100000Hz and 400000Hz modes are supported.
> > 
> > +- fsl,i2c-dma-channel: APBX DMA channel for the I2C
> > +
> > +Optional properties:
> > +- fsl,use-pio: Use PIO transfers instead of DMA, useful for debug
> 
> Having PIOQUEUE (not PIO) as a fallback is good. I'd rather like to see
> this as a module parameter, though.

It'd be cool if someone complained earlier and the responses to new patches 
would be faster. This series has been going on for more than two months and 
noone complained about this part until now. Instead I was made to document this 
and now I have to do it in completely different way? Decide already ...

> For one reason, this is not a
> hardware property or board specific, so not a good device tree property.

Actually, there're still people who might benefit of doing PIOq only, since they 
do small (eg. one byte) transfers. And this is good to have configurable per 
bus.

> Also, it is implicitly deprecated somehow since either we want DMA to
> fully work

And the DMA doesn't fully work?

> or, even better, somewhen be able to automatically switch
> between PIOQUEUE and DMA depending on the i2c_msg size.

That'd be cool. Some months ago, you promised to take a look. I tried it 
recently again with not much luck.

> Deprecated
> properties are also troublesome. Third, we don't really need this per
> instance, if somebody really has problems with DMA, it will apply to all
> i2c busses. Makes sense?

No, it doesn't. See above about small transfers. Consider the easy situation 
where you have sensor on one bus (so you do PIO because you transfer small data) 
and you have EEPROM on other bus, where you use DMA because you transfer large 
data. And the mixed mode isn't there yet.

> >  Examples:
> > @@ -16,4 +20,5 @@ i2c0: i2c at 80058000 {
> > 
> >  	reg = <0x80058000 2000>;
> >  	interrupts = <111 68>;
> >  	clock-frequency = <100000>;
> > 
> > +	fsl,i2c-dma-channel = <6>;
> > 
> >  };
> > 
> > +	/*
> > +	 * The MXS I2C DMA mode is prefered and enabled by default.
> > +	 * The PIO mode is still supported, but should be used only
> 
> PIOQUEUE
> 
> > +	 * for debuging purposes etc.
> > +	 */
> > +	i2c->dma_mode = 1;
> > +	if (of_find_property(node, "fsl,use-pio", NULL)) {
> > +		i2c->dma_mode = 0;
> > +		dev_info(dev, "Using PIO mode for I2C transfers!\n");
> > +	}
> > +
> > +	/*
> > +	 * TODO: This is a temporary solution and should be changed
> > +	 * to use generic DMA binding later when the helpers get in.
> > +	 */
> 
> @Shawn: Any idea when this is going to happen? And why do we need this?
> AFAICT it will be always channel 6/7 on mx28?
> 
> > +	ret = of_property_read_u32(node, "fsl,i2c-dma-channel",
> > +				   &i2c->dma_channel);
> > +	if (ret) {
> > +		dev_warn(dev, "Failed to get DMA channel!\n");
> > +		i2c->dma_mode = 0;
> > +	}
> > +
> 
> Rest looks good, thanks!
> 
>    Wolfram

Best regards,
Marek Vasut
