From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 13 Jul 2011 08:14:09 +0000
Subject: [alsa-devel] [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <20110713010346.GA18959@opensource.wolfsonmicro.com>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-3-git-send-email-b29396@freescale.com>
	<20110713010346.GA18959@opensource.wolfsonmicro.com>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721CD902@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: alsa-devel-bounces at alsa-project.org [mailto:alsa-devel-
> bounces at alsa-project.org] On Behalf Of Mark Brown
> Sent: Wednesday, July 13, 2011 9:04 AM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; s.hauer at pengutronix.de; lrg at ti.com;
> linux-arm-kernel at lists.infradead.org; u.kleine-koenig at pengutronix.de
> Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
> 
> On Tue, Jul 12, 2011 at 11:04:37PM +0800, Dong Aisheng wrote:
> 
> Looks pretty good, a few small issues below.
> 
> > +	/* The SAIF clock should be either 384*fs or 512*fs */
> > +	if (saif->mclk_in_use) {
> > +		if (mclk % 32 == 0) {
> > +			scr &= ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
> > +			ret = clk_set_rate(saif->clk, 512 * rate);
> > +		} else if (mclk % 48 == 0) {
> > +			scr |= BM_SAIF_CTRL_BITCLK_BASE_RATE;
> > +			ret = clk_set_rate(saif->clk, 384 * rate);
> > +		}
> 
> What if MCLK is not set corectly for some reason?  We'll just silently do
> nothing.
We will just return an error if MCLK is not correct (not 32x or 48x).
        /* SAIF MCLK should be either 32*fs or 48*fs */
        if (saif->mclk_in_use && (mclk % 32 != 0) && (mclk % 48 != 0))
                return -EINVAL;
Machine driver should guarantee to set a correct value since it's HW limitation.
Is that ok?

> > +	if (ret)
> > +		return  -EINVAL;
> 
> Should pass through any error codes we get.
> 
> In hw_params()...
OK, I will change it.

> > +	stat = __raw_readl(saif->base + SAIF_STAT);
> > +	if (stat & BM_SAIF_STAT_BUSY) {
> > +		dev_err(cpu_dai->dev, "error: busy\n");
> > +		return -EBUSY;
> > +	}
> 
> Does this work for simultaneous playback and record?  Perhaps you need to
> set symmetric_rates in the DAI (if the hardware needs the same sample
> rate for playback and record) and have a check here to see if we're
> trying to apply the same configuration as we already have.
The SAIF does not support full-duplex (simultaneous playback & record).
However, it allows to use two saif instances to implement it (one playback
While another capture).
For the two SAIFs, one can master or driver the clock pins while the other
SAIF, in slave mode, receives clock from the master.
This also means that both SAIFs must operate at the same sample rate.

So it seems, as you said, we may need to set symmetric_rates in the DAI.

> > +	struct mxs_saif *saif = dev_id;
> > +	unsigned int stat;
> > +
> > +	stat = __raw_readl(saif->base + SAIF_STAT);
> > +	if (stat & BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ)
> > +		dev_dbg(saif->dev, "underrun!!! %d\n", ++saif->fifo_underrun);
> > +
> > +	if (stat & BM_SAIF_STAT_FIFO_OVERFLOW_IRQ)
> > +		dev_dbg(saif->dev, "overrun!!! %d\n", ++saif->fifo_overrun);
> 
> Probably dev_err()?
I met an issue that during each playback when I pressed CTRL+C to stop,
I would always see a line of "underrun!!!" message.
This might because we actually do not stop SAIF (clear HW_SAIF_CTRL RUN bit)
When SNDRV_PCM_TRIGGER_STOP due to codec still needs the clock.
(clear HW_SAIF_CTRL RUN bit may cause mclk stop)
So I observed that there was at least one underrun happened.
It's limitation that sgtl5000 codec needs SAIF mclk.
Bothered by this "underrun!!!", i use the dev_dbg only for debug purpose.

> > +	__raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
> > +			BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
> > +			saif->base + SAIF_STAT + MXS_CLR_ADDR);
> > +
> > +	return IRQ_HANDLED;
> 
> Should really check to see if underflow or overflow occurred and only
> report handled if they did - otherwise we might have trouble with new
> hardware blocks that have other interrupts.
I may clear those two interrupts separately.
But I'm not quite understand how it may cause trouble with new hardware
Block that have other interrupts since it only clear underrun&overrun irq.

> > +	if (pdev->id >= 2)
> > +		return -EINVAL;
> > +	mxs_saif[pdev->id] = saif;
> 
> The id check should check for ARRAY_SIZE() mxs_saif[] to make updates
> easier if a new chip has more ports.
Yes, got it.
 
> > +	saif->dma_param.chan_irq = platform_get_irq(pdev, 1);
> > +	if (saif->dma_param.chan_irq < 0) {
> 
> Does the IRQ requesting need to happen after you've set the base address?
> Otherwise there's a potential race if for some reason the IRQ fires
> before we've got the data structures set up.
Yes, neglect it. Thanks for reminder. :)

Regards
Dong Aisheng
