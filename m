From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 16 Apr 2014 09:27:38 +0200
Subject: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable baudclk when used
In-Reply-To: <20140414152850.GB7197@MrMyself>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself>
Message-ID: <20140416072738.GC6159@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Apr 14, 2014 at 11:28:51PM +0800, Nicolin Chen wrote:
> On Mon, Apr 14, 2014 at 03:35:39PM +0200, Markus Pargmann wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > 
> > Enable baudclk only when it is used. The baudclock is only needed in master
> > mode and only when thr driver is active, so move enabling to fsl_ssi_startup
> > and disabling to fsl_ssi_shutdown.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  sound/soc/fsl/fsl_ssi.c | 37 ++++++++++++++++++++++++++++++-------
> >  1 file changed, 30 insertions(+), 7 deletions(-)
> > 
> > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > index f2255cb..d6d3f0a3 100644
> > --- a/sound/soc/fsl/fsl_ssi.c
> > +++ b/sound/soc/fsl/fsl_ssi.c
> > @@ -236,6 +236,12 @@ static bool fsl_ssi_is_ac97(struct fsl_ssi_private *ssi_private)
> >  	return !!(ssi_private->dai_fmt & SND_SOC_DAIFMT_AC97);
> >  }
> >  
> > +static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
> > +{
> > +	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
> > +		SND_SOC_DAIFMT_CBS_CFS;
> > +}
> > +
> >  /**
> >   * fsl_ssi_isr: SSI interrupt handler
> >   *
> > @@ -489,6 +495,7 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
> >  	struct fsl_ssi_private *ssi_private =
> >  		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> >  	unsigned long flags;
> > +	int ret;
> >  
> >  	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
> >  		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
> > @@ -496,6 +503,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
> >  		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
> >  	}
> >  
> > +	if (fsl_ssi_is_i2s_master(ssi_private)) {
> > +		ret = clk_prepare_enable(ssi_private->baudclk);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	/* When using dual fifo mode, it is safer to ensure an even period
> >  	 * size. If appearing to an odd number while DMA always starts its
> >  	 * task from fifo0, fifo1 would be neglected at the end of each
> > @@ -508,6 +521,17 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
> >  	return 0;
> >  }
> >  
> > +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct fsl_ssi_private *ssi_private =
> > +		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> > +
> > +	if (fsl_ssi_is_i2s_master(ssi_private))
> > +		clk_disable_unprepare(ssi_private->baudclk);
> > +}
> > +
> >  /**
> >   * fsl_ssi_hw_params - program the sample size
> >   *
> > @@ -576,6 +600,11 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> >  
> >  	ssi_private->dai_fmt = fmt;
> >  
> > +	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
> > +		dev_err(cpu_dai->dev, "no baudclk needed for master mode\n");
> > +		return -EINVAL;
> > +	}
> > +
> 
> I was wondering what if machine driver doesn't set fmt to master during
> its probe(), in another word -- before fsl_ssi_startup(), but leave that
> into its hw_params() via snd_soc_dai_set_fmt() which then would run after
> fsl_ssi_startup() while having no baud clock enabled in this case.
> 
> A better solution may be to wrap clk_prepare_enable() and master mode
> clock dividing code into fsl_ssi_hw_params(), a bit like the ESAI driver
> even though it doesn't contain the clk_prepare_enable() part currently,
> and then to put clk_disable_unprepare() into hw_free() for symmetry.
> 
> Any suggestion?

Yes this is a problem. Although I am not really convinced of the concept
of setting up the DAIs in hw_params, we should support it as there are
some users.

Is there always exactly one hw_free call for one hw_params call? There
is a comment above the function:
"Frees resources allocated by hw_params, can be called multiple times",
so I am not sure if we can directly use clk_prepare_enable or if we need
to remember the clock state?

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140416/e9b7b118/attachment.sig>
