From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Nov 2011 14:13:49 +0000
Subject: [PATCH] ARM: pxa: add support for Raumfeld DDX
In-Reply-To: <1320661562-422-1-git-send-email-zonque@gmail.com>
References: <1320661562-422-1-git-send-email-zonque@gmail.com>
Message-ID: <20111115141348.GG3077@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 11:26:02AM +0100, Daniel Mack wrote:

>  arch/arm/mach-pxa/raumfeld.c |  119 +++++++++++++++++---
>  sound/soc/pxa/Kconfig        |    2 +
>  sound/soc/pxa/raumfeld.c     |  249 +++++++++++++++++++++++++++++++++++++++---

Is there any cross dependency between these bits?  I honestly didn't
notice the ASoC bit in here...

> index 33ebc46..e6db56a 100644
> --- a/sound/soc/pxa/Kconfig
> +++ b/sound/soc/pxa/Kconfig
> @@ -152,6 +152,8 @@ config SND_SOC_RAUMFELD
>  	select SND_PXA_SOC_SSP
>  	select SND_SOC_CS4270
>  	select SND_SOC_AK4104
> +	select SND_SOC_STA32X
> +	select SND_SOC_WM8782

Is this really a single driver?  Looking at the code it looks like
there's little if any code sharing between the different machines, it'd
help with maintainability to have multiple simple drivers.

> +	/* PXA DMA cannot do zero extend for 24bit samples,
> +	* thus only 16bit (two samples packet into 32bit word)
> +	* or 32bit samples are possible
> +	*/
> +	snd_pcm_hw_constraint_mask64(substream->runtime,
> +				    SNDRV_PCM_HW_PARAM_FORMAT,
> +				    SNDRV_PCM_FMTBIT_S16_LE  | SNDRV_PCM_FMTBIT_S16_BE |
> +				    SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE);

If the PXA DMA controller can't do 24 bit audio it should be imposing
this constraint.

> +static void raumfeld_sta32x_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
> +	/* set freq to 0 to enable all possible codec sample rates */
> +	snd_soc_dai_set_sysclk(codec_dai, 0, 0, 0);
> +}

Are you sure this does the right thing with simultaneous playback and
record?

> +	fmt = SND_SOC_DAIFMT_I2S |
> +	      SND_SOC_DAIFMT_NB_NF |
> +	      SND_SOC_DAIFMT_CBS_CFS;

Set this using dai_fmt in hte machine driver.
