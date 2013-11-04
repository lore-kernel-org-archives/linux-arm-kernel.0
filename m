From: B47053@freescale.com (Li Xiubo)
Date: Mon, 4 Nov 2013 07:35:12 +0000
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131101182514.GE2493@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > +static int fsl_sai_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
> > +		int div_id, int div)
> > +{
> > +	struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> > +	u32 tcr2, rcr2;
> > +
> > +	if (div_id == FSL_SAI_TX_DIV) {
> > +		tcr2 = readl(sai->base + FSL_SAI_TCR2);
> > +		tcr2 &= ~FSL_SAI_CR2_DIV_MASK;
> > +		tcr2 |= FSL_SAI_CR2_DIV(div);
> > +		writel(tcr2, sai->base + FSL_SAI_TCR2);
> 
> What is this divider and why does the user have to set it manually?
> 

This is the bit clock divider. I'll add some comments or rename them to be more readable.
>From the IP spec:
++++++
Bit Clock Divide
Divides down the audio master clock to generate the bit clock when configured for an internal bit clock.
------

>From the ASoC subsystem comments we can see that:
++++++
Configures the clock dividers. This is used to derive the best DAI bit and
frame clocks from the system or master clock. It's best to set the DAI bit
and frame clocks as low as possible to save system power.
------


> > +static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
> > +	int ret;
> > +	struct fsl_sai *sai = dev_get_drvdata(dai->dev);
> > +
> > +	ret = clk_prepare_enable(sai->clk);
> > +	if (ret)
> > +		return ret;
> 
> It'd be nicer to only enable the clock while the device is in active use.
> 

While if the module clock is not enabled here, the followed registers cannot read/write in the same function.
And this _probe function is the _dai_probe not the driver's module _probe.

If the clk_prepare_enable(sai->clk) is not here, where should it be will be nicer ?
One of the following functions ?
        .set_sysclk     = fsl_sai_set_dai_sysclk,
        .set_clkdiv     = fsl_sai_set_dai_clkdiv,
        .set_fmt        = fsl_sai_set_dai_fmt,
        .set_tdm_slot   = fsl_sai_set_dai_tdm_slot,
        .hw_params      = fsl_sai_hw_params,
        .trigger        = fsl_sai_trigger,


> > +	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL,
> > +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> > +	if (ret)
> > +		return ret;
> 
> We should have a devm_ version of this.

Sorry, is there one patch for adding the devm_ version of snd_dmaengine_pcm_register() already ?
In the -next and other topics branches I could not find it.



Best Regards,
Xiubo
