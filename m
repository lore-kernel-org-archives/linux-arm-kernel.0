From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 27 Jan 2015 18:09:39 +0100
Subject: [alsa-devel] [PATCH v4 1/3] ASoC: samsung: Add machine driver for
 Trats2
In-Reply-To: <1421989410-12490-2-git-send-email-ideal.song@samsung.com>
References: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
 <1421989410-12490-2-git-send-email-ideal.song@samsung.com>
Message-ID: <54C7C653.6080904@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/15 06:03, Inha Song wrote:
> +static int trats2_aif1_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct trats2_machine_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +	int ret;
> +
> +	ret = clk_prepare_enable(priv->clk_mclk);
> +	if (ret) {
> +		dev_err(rtd->card->dev, "Failed to enable mclk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void trats2_aif1_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct trats2_machine_priv *priv = snd_soc_card_get_drvdata(rtd->card);
> +
> +	clk_disable_unprepare(priv->clk_mclk);
> +}
> +
> +static const struct snd_soc_ops trats2_aif1_ops = {
> +	.startup = trats2_aif1_startup,
> +	.shutdown = trats2_aif1_shutdown,
> +	.hw_params = trats2_aif1_hw_params,
> +};

> +static int trats2_audio_probe(struct platform_device *pdev)
> +{

> +	priv->clk_mclk =  of_clk_get_by_name(codec_node, "MCLK1");
> +	if (IS_ERR(priv->clk_mclk)) {
> +		dev_err(&pdev->dev, "Failed to get mclk clock\n");
> +		of_node_put(codec_node);
> +		return PTR_ERR(priv->clk_mclk);
> +	}

Wouldn't it also work if we added clock handling into the wm8994 codec
driver instead? Not sure if it is correct to retrieve the codec's clock
in the machine driver like this. Or perhaps the MCLK1 (SoC CLKOUT) clock
should be added to the sound DT node and handled only by the machine
driver, together with the other (MCLK2) clock?

> +	of_node_put(codec_node);

--
Regards,
Sylwester
