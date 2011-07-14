From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 14 Jul 2011 12:06:35 +0900
Subject: [alsa-devel] [PATCH V2 02/10] ASoc: mxs: add mxs-saif driver
In-Reply-To: <65EE16ACC360FA4D99C96DC085B3F7721CD902@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-3-git-send-email-b29396@freescale.com>
	<20110713010346.GA18959@opensource.wolfsonmicro.com>
	<65EE16ACC360FA4D99C96DC085B3F7721CD902@039-SN1MPN1-002.039d.mgd.msft.net>
Message-ID: <20110714030633.GA11559@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 08:14:09AM +0000, Dong Aisheng-B29396 wrote:

> > What if MCLK is not set corectly for some reason?  We'll just silently do
> > nothing.

> We will just return an error if MCLK is not correct (not 32x or 48x).
>         /* SAIF MCLK should be either 32*fs or 48*fs */
>         if (saif->mclk_in_use && (mclk % 32 != 0) && (mclk % 48 != 0))
>                 return -EINVAL;
> Machine driver should guarantee to set a correct value since it's HW limitation.
> Is that ok?

Please fix the code so you only check if the ratio is valid in one
place, the code currently is too hard to read.

> So it seems, as you said, we may need to set symmetric_rates in the DAI.

Not if there are two separate SAIFs used for each direction - this is
only relevant if one interface provides both playback and capture.

> > > +	stat = __raw_readl(saif->base + SAIF_STAT);
> > > +	if (stat & BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ)
> > > +		dev_dbg(saif->dev, "underrun!!! %d\n", ++saif->fifo_underrun);

> > > +	if (stat & BM_SAIF_STAT_FIFO_OVERFLOW_IRQ)
> > > +		dev_dbg(saif->dev, "overrun!!! %d\n", ++saif->fifo_overrun);

> > Probably dev_err()?
> I met an issue that during each playback when I pressed CTRL+C to stop,
> I would always see a line of "underrun!!!" message.
> This might because we actually do not stop SAIF (clear HW_SAIF_CTRL RUN bit)
> When SNDRV_PCM_TRIGGER_STOP due to codec still needs the clock.
> (clear HW_SAIF_CTRL RUN bit may cause mclk stop)
> So I observed that there was at least one underrun happened.
> It's limitation that sgtl5000 codec needs SAIF mclk.
> Bothered by this "underrun!!!", i use the dev_dbg only for debug purpose.

Hrm, OK.  I guess that's reasonable.

> > > +	__raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
> > > +			BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
> > > +			saif->base + SAIF_STAT + MXS_CLR_ADDR);

> > > +	return IRQ_HANDLED;

> > Should really check to see if underflow or overflow occurred and only
> > report handled if they did - otherwise we might have trouble with new
> > hardware blocks that have other interrupts.

> I may clear those two interrupts separately.
> But I'm not quite understand how it may cause trouble with new hardware
> Block that have other interrupts since it only clear underrun&overrun irq.

Because you return IRQ_HANDLED you're telling the IRQ infrastructure
that you handled the interrupt but you didn't.  If you didn't handle an
interrupt you should return IRQ_NONE instead.
