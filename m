From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Tue, 5 Dec 2017 13:48:39 +0900
Subject: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
In-Reply-To: <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
Message-ID: <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Thanks a lot for your review.

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Tuesday, December 5, 2017 3:40 AM
> To: Suzuki, Katsuhiro/?? ?? <suzuki.katsuhiro@socionext.com>
> Cc: alsa-devel at alsa-project.org; Rob Herring <robh+dt@kernel.org>; devicetree at vger.kernel.org; Yamada, Masahiro/?
> ? ?? <yamada.masahiro@socionext.com>; Masami Hiramatsu <masami.hiramatsu@linaro.org>; Jassi Brar
> <jaswinder.singh@linaro.org>; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: Re: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
> 
> On Wed, Nov 22, 2017 at 08:43:18PM +0900, Katsuhiro Suzuki wrote:
> 
> >  sound/soc/uniphier/Makefile      |   4 +
> >  sound/soc/uniphier/aio-core.c    | 368 +++++++++++++++++++++
> >  sound/soc/uniphier/aio-dma.c     | 266 +++++++++++++++
> >  sound/soc/uniphier/aio-regctrl.c | 699 +++++++++++++++++++++++++++++++++++++++
> >  sound/soc/uniphier/aio-regctrl.h | 495 +++++++++++++++++++++++++++
> >  sound/soc/uniphier/aio.h         | 261 +++++++++++++++
> 
> Please split this up more, it looks like there's at least two or three
> drivers in here and it winds up being quite large.  There's at least a
> DMA and a DAI driver.  Looking through this my overall impression is
> that this is a fairly large and complex audio subsystem with some DSP
> and routing capacity which is being handled in a board specific fashion
> rather than generically but it's kind of hard to tell as there's not
> much description of what's going on so I'm needing to reverse engineer
> things from the driver.
> 
> The code itself looks fairly clean, it's mainly a case of trying to
> figure out if it's doing what it's supposed to with the limited
> documentation.
> 
> > +int uniphier_aio_hw_params(struct snd_pcm_substream *substream,
> > +			   struct snd_pcm_hw_params *params,
> > +			   struct snd_soc_dai *dai)
> > +{
> > +	struct uniphier_aio *aio = uniphier_priv(dai);
> > +	struct uniphier_aio_sub *sub = &aio->sub[substream->stream];
> > +
> > +	sub->params = *params;
> > +	sub->setting = 1;
> 
> So we don't validate the params at all?
> 
> > +	uniphier_aio_port_reset(sub);
> > +	uniphier_aio_srcport_reset(sub);
> 
> Is there a mux in the SoC here?
> 

Sorry for confusing, It's not mux.

uniphier_srcport_reset() resets HW SRC (sampling rate converter) block.
Audio data out ports of UniPhier audio system have HW SRC.


> > +static const struct of_device_id uniphier_aio_of_match[] = {
> > +#ifdef CONFIG_SND_SOC_UNIPHIER_LD11
> > +	{
> > +		.compatible = "socionext,uniphier-ld11-aio",
> > +		.data = &uniphier_aio_ld11_spec,
> > +	},
> > +	{
> > +		.compatible = "socionext,uniphier-ld20-aio",
> > +		.data = &uniphier_aio_ld20_spec,
> > +	},
> > +#endif /* CONFIG_SND_SOC_UNIPHIER_LD11 */
> 
> Why is there an ifdef here?  There's no other conditional code in here,
> it seems pointless.
> 

This config is used to support or not LD11 SoC.
aio-ld11.c is not build and 'uniphier_aio_ldxx_spec' is undefined if this config is disabled.

aio-ld11.c defines SoC dependent resources (port, HW ring buffer, DMA ch, etc.)
and fixed settings.
I know it's better to move such information into device-tree, but register areas of
UniPhier's audio system is very strange and interleaved. It's hard to split each nodes...


> > +		for (j = 0; j < ARRAY_SIZE(aio->sub); j++) {
> > +			struct uniphier_aio_sub *sub = &aio->sub[j];
> > +
> > +			if (!sub->running)
> > +				continue;
> > +
> > +			spin_lock(&sub->spin);
> > +			uniphier_aio_rb_sync(sub);
> > +			uniphier_aio_rb_clear_int(sub);
> > +			spin_unlock(&sub->spin);
> 
> It's not 100% obvious what this does...  a comment might help.
> 
> > +int uniphier_aio_chip_init(struct uniphier_aio_chip *chip)
> > +{
> > +	struct regmap *r = chip->regmap;
> > +
> > +	regmap_update_bits(r, A2APLLCTR0,
> > +			   A2APLLCTR0_APLLXPOW_MASK,
> > +			   A2APLLCTR0_APLLXPOW_PWON);
> > +
> > +	regmap_update_bits(r, A2APLLCTR1, A2APLLCTR1_APLL_MASK,
> > +			   A2APLLCTR1_APLLF2_33MHZ | A2APLLCTR1_APLLA2_33MHZ |
> > +			   A2APLLCTR1_APLLF1_36MHZ | A2APLLCTR1_APLLA1_36MHZ);
> > +
> > +	regmap_update_bits(r, A2EXMCLKSEL0,
> > +			   A2EXMCLKSEL0_EXMCLK_MASK,
> > +			   A2EXMCLKSEL0_EXMCLK_OUTPUT);
> > +
> > +	regmap_update_bits(r, A2AIOINPUTSEL, A2AIOINPUTSEL_RXSEL_MASK,
> > +			   A2AIOINPUTSEL_RXSEL_PCMI1_HDMIRX1 |
> > +			   A2AIOINPUTSEL_RXSEL_PCMI2_SIF |
> > +			   A2AIOINPUTSEL_RXSEL_PCMI3_EVEA |
> > +			   A2AIOINPUTSEL_RXSEL_IECI1_HDMIRX1);
> 
> This definitely looks like there's some clocking and audio routing
> within the SoC which should be exposed to userspace, or at the very
> least machine driver configuration rather than being hard coded.
> 
> > +	switch (pc) {
> > +	case IEC61937_PC_AC3:
> > +		repet = OPORTMXREPET_STRLENGTH_AC3 |
> > +			OPORTMXREPET_PMLENGTH_AC3;
> > +		pause |= OPORTMXPAUDAT_PAUSEPD_AC3;
> > +		break;
> > +	case IEC61937_PC_MPA:
> > +		repet = OPORTMXREPET_STRLENGTH_MPA |
> > +			OPORTMXREPET_PMLENGTH_MPA;
> > +		pause |= OPORTMXPAUDAT_PAUSEPD_MPA;
> > +		break;
> > +	case IEC61937_PC_MP3:
> > +		repet = OPORTMXREPET_STRLENGTH_MP3 |
> > +			OPORTMXREPET_PMLENGTH_MP3;
> > +		pause |= OPORTMXPAUDAT_PAUSEPD_MP3;
> > +		break;
> 
> This looks awfully like compressed audio support...  should there be
> integration with the compressed audio API/

Thanks, I'll try it. Is there Documentation in sound/designes/compress-offload.rst?
And best sample is... Intel's driver?


(Summary)
I think I should fix as follows:

  - Split DMA, DAI patches from large one
  - Validate parameters in hw_params
  - Add description about HW SRC (or fix bad name 'srcport')
  - Add comments about uniphier_aiodma_irq()
  - Expose clocking and audio routing to userspace, or at the very
    least machine driver configuration
  - Support compress-audio API for S/PDIF

and post V2.


Regards,
--
Katsuhiro Suzuki
