From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 08 Jul 2013 16:39:17 +0200
Subject: [alsa-devel] [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver
 for at91sam9x5 wm8731 boards
In-Reply-To: <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <51DACF15.9080303@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/2013 03:29 PM, Richard Genoud wrote:
[...]
> +/*
> + * Logic for a wm8731 as connected on a at91sam9x5 based board.
> + */
> +static int at91sam9x5ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
> +{
[...]
> +	codec_dai->driver->playback.rates &= SNDRV_PCM_RATE_8000 |
> +		SNDRV_PCM_RATE_32000 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_96000;
> +	codec_dai->driver->capture.rates &= SNDRV_PCM_RATE_8000 |
> +		SNDRV_PCM_RATE_32000 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_96000;

That's not right. The driver structure is shared between all instances of
the codec, a single instance should not modify it. If you need to constrain
the list of supported rates use snd_pcm_hw_constraint_list().

> +
> +	/* set the codec system clock for DAC and ADC */
> +	ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
> +				     MCLK_RATE, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(dev, "ASoC: Failed to set WM8731 SYSCLK: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* signal a DAPM event */
> +	snd_soc_dapm_sync(dapm);

This should not be necessary.

> +	return 0;
> +}
