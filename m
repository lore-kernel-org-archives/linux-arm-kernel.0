From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Thu, 15 Sep 2011 13:06:12 +0000
Subject: [PATCH v3 1/1] ASoC: mxs-saif: add record function
In-Reply-To: <20110909133051.GS1912@pengutronix.de>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<20110909133051.GS1912@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77225DB00@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Friday, September 09, 2011 9:31 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel at alsa-project.org; linux-arm-kernel at lists.infradead.org;
> broonie at opensource.wolfsonmicro.com; lrg at ti.com; s.hauer at pengutronix.de
> Subject: Re: [PATCH v3 1/1] ASoC: mxs-saif: add record function
> 
> On Wed, Sep 07, 2011 at 08:51:50PM +0800, Dong Aisheng wrote:
> > 1. add different clkmux mode handling
> > SAIF can use two instances to implement full duplex (playback &
> > recording) and record saif may work on EXTMASTER mode which is using
> > other saif's BITCLK&LRCLK.
> >
> > The clkmux mode could be set in pdata->init() in mach-specific code.
> > For generic saif driver, it only needs to know who is his master and
> > the master id is also provided in mach-specific code.
> >
> > 2. support playback and capture simutaneously however the sample rates
> > can not be different due to hw limitation.
> >
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> 
> One thing I see...
> 
> > @@ -422,20 +503,39 @@ static int mxs_saif_trigger(struct
> snd_pcm_substream *substream, int cmd,
> >  			__raw_readl(saif->base + SAIF_DATA);
> >  		}
> >
> > -		dev_dbg(cpu_dai->dev, "CTRL 0x%x STAT 0x%x\n",
> > +		master_saif->ongoing = 1;
> > +
> > +		dev_dbg(saif->dev, "CTRL 0x%x STAT 0x%x\n",
> >  			__raw_readl(saif->base + SAIF_CTRL),
> >  			__raw_readl(saif->base + SAIF_STAT));
> >
> > +		dev_dbg(master_saif->dev, "CTRL 0x%x STAT 0x%x\n",
> > +			__raw_readl(master_saif->base + SAIF_CTRL),
> > +			__raw_readl(master_saif->base + SAIF_STAT));
> >  		break;
> >  	case SNDRV_PCM_TRIGGER_SUSPEND:
> >  	case SNDRV_PCM_TRIGGER_STOP:
> >  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> >  		dev_dbg(cpu_dai->dev, "stop\n");
> >
> > -		clk_disable(saif->clk);
> > -		if (!saif->mclk_in_use)
> > +		/* wait a while for the current sample to complete */
> > +		delay = USEC_PER_SEC / master_saif->cur_rate;
> > +
> > +		if (!master_saif->mclk_in_use) {
> > +			__raw_writel(BM_SAIF_CTRL_RUN,
> > +				master_saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> > +			udelay(delay);
> > +		}
> > +		clk_disable(master_saif->clk);
> > +
> > +		if (saif != master_saif) {
> >  			__raw_writel(BM_SAIF_CTRL_RUN,
> >  				saif->base + SAIF_CTRL + MXS_CLR_ADDR);
> > +			udelay(delay);
> 
> I think we should use usleep_range for both udelays here? Having a rate
> of 8000, we'd burn 250us here.
>
Yes, I agree that it's a bit long for 8000.
I tried sleep way but I found the trigger function is called with
spin_lock held, so it seems we may not be able to sleep here.

I think the way of dynamically calculate delay suggested by Liam has
Already minimize the affection, especially for high sample rate, it
may work more efficiency than sleep (context switch cost).

Do you think if it's reasonable to accept it?

Regards
Dong Aisheng
