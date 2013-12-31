From: broonie@kernel.org (Mark Brown)
Date: Tue, 31 Dec 2013 13:25:55 +0000
Subject: [PATCH RFC v2 REPOST 3/8] ASoC: davinci-evm: HDMI audio support
 for TDA998x trough McASP I2S bus
In-Reply-To: <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
References: <cover.1387535299.git.jsarha@ti.com>
 <d3c3f645d39338df0ee9686cb030255ce36a249d.1387535302.git.jsarha@ti.com>
Message-ID: <20131231132555.GA31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 12:39:38PM +0200, Jyri Sarha wrote:

> Add machine driver support for BeagleBone-Black and other boards with
> tilcdc support and NXP TDA998X HDMI transmitter connected to McASP
> port in I2S mode. The 44100 Hz sample-rate and it's multiples can not
> be supported on Beaglebone-Black because of limited clock-rate

Can the drivers infer this from the clocks?

> support. The only supported sample format is SNDRV_PCM_FORMAT_S32_LE.
> The 8 least significant bits are ignored.

Where does this constraint come from?

> +	struct snd_soc_card_drvdata_davinci *drvdata =
> +		(struct snd_soc_card_drvdata_davinci *)
> +		snd_soc_card_get_drvdata(soc_card);

Again with the casting.

> +	runtime->hw.rate_min = drvdata->rate_constraint->list[0];
> +	runtime->hw.rate_max = drvdata->rate_constraint->list[
> +		drvdata->rate_constraint->count - 1];
> +	runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
> +
> +	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +				   drvdata->rate_constraint);
> +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_CHANNELS,
> +				     2, 2);

Why not just set all this statically when registering the DAI?

> +static unsigned int evm_get_bclk(struct snd_pcm_hw_params *params)
> +{
> +	int sample_size = snd_pcm_format_width(params_format(params));
> +	int rate = params_rate(params);
> +	int channels = params_channels(params);
> +
> +	return sample_size * channels * rate;
> +}

snd_soc_params_to_frame_size().

> +static int evm_tda998x_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_card *soc_card = codec->card;
> +	struct platform_device *pdev = to_platform_device(soc_card->dev);
> +	unsigned int bclk_freq = evm_get_bclk(params);
> +	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
> +			   snd_soc_card_get_drvdata(soc_card))->sysclk;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_clkdiv(cpu_dai, 1, sysclk / bclk_freq);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "can't set CPU DAI clock divider %d\n",
> +			ret);
> +		return ret;
> +	}

This looks like something the DAI driver ought to be able to work out
for itself based on the clock rate and sample format.

> +static unsigned int tda998x_hdmi_rates[] = {
> +	32000,
> +	44100,
> +	48000,
> +	88200,
> +	96000,
> +};

The changelog said that 44.1kHz and its multiples couldn't be supported
- is that just the multiples?

> +static struct snd_pcm_hw_constraint_list *evm_tda998x_rate_constraint(
> +	struct snd_soc_card *soc_card)
> +{
> +	struct platform_device *pdev = to_platform_device(soc_card->dev);
> +	unsigned sysclk = ((struct snd_soc_card_drvdata_davinci *)
> +			   snd_soc_card_get_drvdata(soc_card))->sysclk;
> +	struct snd_pcm_hw_constraint_list *ret;
> +	unsigned int *rates;
> +	int i = 0, j = 0;
> +
> +	ret = devm_kzalloc(soc_card->dev, sizeof(*ret) +
> +			   sizeof(tda998x_hdmi_rates), GFP_KERNEL);
> +	if (!ret) {
> +		dev_err(&pdev->dev, "Unable to allocate rate constraint!\n");

OOM is already very verbose, don't bother.

> +		return NULL;
> +	}
> +
> +	rates = (unsigned int *)&ret[1];
> +	ret->list = rates;
> +	ret->mask = 0;
> +	for (; i < ARRAY_SIZE(tda998x_hdmi_rates); i++) {

This is all very hard to read.  Why has the assignment of i been moved
up to the declaration rather than put here as is idiomatic, what's all
the casting going on with ret and in general?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131231/d502c2f2/attachment.sig>
