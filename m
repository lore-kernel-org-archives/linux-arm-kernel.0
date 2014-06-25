From: trblinux@gmail.com (Tushar Behera)
Date: Wed, 25 Jun 2014 09:01:47 +0530
Subject: [alsa-devel] [PATCH V2 1/2] ASoC: samsung: Add machine driver
 for Odroid X2/U3
In-Reply-To: <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
Message-ID: <53AA42A3.7030004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2014 09:52 PM, Sylwester Nawrocki wrote:
> This patch adds the sound subsystem driver for Odroid-X2 and
> Odroid-U3 boards. The codec works in I2S master mode; there are
> 2 separate audio routing paths defined as there are differences
> in the signal routing between the X2 and U3 boards, i.e. U3 uses
> single jack for headphones and microphone.
> 
> Signed-off-by: Chen Zhen <zhen1.chen@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/Kconfig             |    8 ++
>  sound/soc/samsung/Makefile            |    2 +
>  sound/soc/samsung/odroidx2_max98090.c |  191 +++++++++++++++++++++++++++++++++
>  3 files changed, 201 insertions(+)
>  create mode 100644 sound/soc/samsung/odroidx2_max98090.c
> 

[ ... ]

> +static int odroidx2_hw_params(struct snd_pcm_substream *substream,
> +	struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, 0, MAX98090_MCLK,
> +						SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		dev_err(codec_dai->dev,
> +			"Unable to switch to FLL1: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Set the cpu DAI configuration in order to use CDCLK */
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, SAMSUNG_I2S_CDCLK,
> +					0, SND_SOC_CLOCK_OUT);
> +	if (ret < 0)
> +		return ret;
> +

While upstreaming sound-card driver for Snow board, I had a comment from
Mark to move this to probe, if possible. That way, the clock operations
would be done only once and this function and odroidx2_ops can be
removed altogether.

> +	dev_dbg(codec_dai->dev, "HiFi DAI %s params: channels: %d, rate: %d\n",
> +		snd_pcm_stream_str(substream), params_channels(params),
> +		params_rate(params));
> +
> +	return 0;
> +}
> +
> +static struct snd_soc_ops odroidx2_ops = {
> +	.hw_params	= odroidx2_hw_params,
> +};
> +

[ ... ]

> +
> +	ret = snd_soc_register_card(card);

devm_snd_soc_register_card ?

> +	if (ret) {
> +		dev_err(&pdev->dev, "snd_soc_register_card failed: %d\n", ret);
> +		goto err_put_cpu_n;
> +	}
> +
> +	return 0;
> +
> +err_put_cpu_n:
> +	of_node_put(odroidx2_dai[0].cpu_of_node);
> +err_put_cod_n:
> +	of_node_put(odroidx2_dai[0].codec_of_node);
> +	return ret;
> +}
> +
> +static int odroidx2_audio_remove(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +
> +	snd_soc_unregister_card(card);

This can be removed when devm_snd_soc_register_card is used.

-- 
Tushar Behera
