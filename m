From: Guangyu.Chen@freescale.com (Nicolin Chen)
Date: Wed, 16 Apr 2014 16:08:29 +0800
Subject: [PATCH v3 09/18] ASoC: fsl-ssi: Only enable baudclk when used
In-Reply-To: <20140416072738.GC6159@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <1397482548-28463-10-git-send-email-mpa@pengutronix.de>
 <20140414152850.GB7197@MrMyself>
 <20140416072738.GC6159@pengutronix.de>
Message-ID: <20140416080826.GA13449@MrMyself>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

Please allow me to drop some content.

On Wed, Apr 16, 2014 at 09:27:38AM +0200, Markus Pargmann wrote:
> On Mon, Apr 14, 2014 at 11:28:51PM +0800, Nicolin Chen wrote:
> > On Mon, Apr 14, 2014 at 03:35:39PM +0200, Markus Pargmann wrote:
> > > +static bool fsl_ssi_is_i2s_master(struct fsl_ssi_private *ssi_private)
> > > +{
> > > +	return (ssi_private->dai_fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
> > > +		SND_SOC_DAIFMT_CBS_CFS;
> > > +}

> > > @@ -496,6 +503,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
> > >  		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
> > >  	}
> > >  
> > > +	if (fsl_ssi_is_i2s_master(ssi_private)) {
> > > +		ret = clk_prepare_enable(ssi_private->baudclk);
> > > +		if (ret)
> > > +			return ret;
> > > +	}

> > > +static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
> > > +		struct snd_soc_dai *dai)
> > > +{
> > > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > > +	struct fsl_ssi_private *ssi_private =
> > > +		snd_soc_dai_get_drvdata(rtd->cpu_dai);
> > > +
> > > +	if (fsl_ssi_is_i2s_master(ssi_private))
> > > +		clk_disable_unprepare(ssi_private->baudclk);
> > > +}

> > > @@ -576,6 +600,11 @@ static int fsl_ssi_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> > >  
> > >  	ssi_private->dai_fmt = fmt;
> > >  
> > > +	if (fsl_ssi_is_i2s_master(ssi_private) && IS_ERR(ssi_private->baudclk)) {
> > > +		dev_err(cpu_dai->dev, "no baudclk needed for master mode\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > I was wondering what if machine driver doesn't set fmt to master during
> > its probe(), in another word -- before fsl_ssi_startup(), but leave that
> > into its hw_params() via snd_soc_dai_set_fmt() which then would run after
> > fsl_ssi_startup() while having no baud clock enabled in this case.
> > 
> > A better solution may be to wrap clk_prepare_enable() and master mode
> > clock dividing code into fsl_ssi_hw_params(), a bit like the ESAI driver
> > even though it doesn't contain the clk_prepare_enable() part currently,
> > and then to put clk_disable_unprepare() into hw_free() for symmetry.
> > 
> > Any suggestion?
> 
> Yes this is a problem. Although I am not really convinced of the concept
> of setting up the DAIs in hw_params, we should support it as there are
> some users.

I think it might be an old fashion way. I saw quite a lot machine drivers
doing the DAI format setting in its hw_params(). Even in the current tree
we can also grep some out by using:

find ./sound/soc/ -name "*.c" |xargs grep "snd_soc_dai_set_fmt"

So it should be plausible considering there might be some special cases,
using CBS_CFS for 44.1KHz groups and CBM_CFM for 48KHz groups for example.

> Is there always exactly one hw_free call for one hw_params call? There
> is a comment above the function:
> "Frees resources allocated by hw_params, can be called multiple times",

That's a good question. IIRC, snd_pcm_release_substream() would call its
hw_free() right before calling snd_pcm_close(). So there would be at least
twice for hw_free()'s execution.

> so I am not sure if we can directly use clk_prepare_enable or if we need
> to remember the clock state?

We need to if applying that. Or put them into trigger() as an alternative
approach even if it sounds weird to me.

Thanks,
Nicolin
