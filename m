From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Nov 2013 08:15:37 -0800
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101182514.GE2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F8287439D@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131104161537.GI2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 07:35:12AM +0000, Li Xiubo wrote:

> From the ASoC subsystem comments we can see that:
> ++++++
> Configures the clock dividers. This is used to derive the best DAI bit and
> frame clocks from the system or master clock. It's best to set the DAI bit
> and frame clocks as low as possible to save system power.
> ------

You should never use this unless you have to, there is no point in every
single machine driver using your driver having to duplicate the same
calculations.

> 
> > > +static int fsl_sai_dai_probe(struct snd_soc_dai *dai) {
> > > +	int ret;
> > > +	struct fsl_sai *sai = dev_get_drvdata(dai->dev);
> > > +
> > > +	ret = clk_prepare_enable(sai->clk);
> > > +	if (ret)
> > > +		return ret;

> > It'd be nicer to only enable the clock while the device is in active use.

> While if the module clock is not enabled here, the followed registers cannot read/write in the same function.
> And this _probe function is the _dai_probe not the driver's module _probe.

So you can enable the clock when you explicitly need to write to the
registers...

> If the clk_prepare_enable(sai->clk) is not here, where should it be will be nicer ?
> One of the following functions ?
>         .set_sysclk     = fsl_sai_set_dai_sysclk,
>         .set_clkdiv     = fsl_sai_set_dai_clkdiv,
>         .set_fmt        = fsl_sai_set_dai_fmt,
>         .set_tdm_slot   = fsl_sai_set_dai_tdm_slot,
>         .hw_params      = fsl_sai_hw_params,
>         .trigger        = fsl_sai_trigger,

It could be in any or all of them except trigger (where the core should
hold a runtime PM reference anyway).  You can always take a reference
for the duration of the function if you're concerned it may be called
when the referent isn't otherwise held.

> > > +	ret = snd_dmaengine_pcm_register(&pdev->dev, NULL,
> > > +			SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
> > > +	if (ret)
> > > +		return ret;

> > We should have a devm_ version of this.

> Sorry, is there one patch for adding the devm_ version of snd_dmaengine_pcm_register() already ?
> In the -next and other topics branches I could not find it.

No, there isn't one but there should be one.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131104/ae3affc4/attachment.sig>
