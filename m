From: broonie@kernel.org (Mark Brown)
Date: Thu, 18 Jul 2013 12:17:09 +0100
Subject: [PATCH] ASoC: atmel: add wm8904 based audio machine driver
In-Reply-To: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
References: <1374132483-25375-1-git-send-email-voice.shen@atmel.com>
Message-ID: <20130718111709.GL22506@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 03:28:03PM +0800, Bo Shen wrote:
> add wm8904 based audio machine driver
> 
> the following ek board based on it
>   - at91sam9n12ek
>   - sama5d3xek (d31, d33, d34, d35)
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Looks pretty good, a few fairly small issues below.

The binding document should be CCed to devicetree-discuss for review.

> +	atmel,audio-routing =
> +		"Headphone Jack", "HPOUTL",
> +		"Headphone Jack", "HPOUTR",
> +		"IN2L", "Line In Jack",
> +		"IN2R", "Line In Jack",
> +		"Mic", "MICBIAS",
> +		"IN1L", "Mic";

The widgets defined by the board should be documented in this binding.
Those from the CODEC should be documented in the CODEC binding.

> +#define MCLK_RATE 32768
> +
> +static struct clk *mclk;

This should be in driver data for the board.  Shouldn't the clock be
referenced using the clock bindings?

> +static int atmel_asoc_wm8904_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_sysclk(codec_dai, WM8904_CLK_FLL,
> +			12000000, SND_SOC_CLOCK_IN);
> +	if (ret < 0) {
> +		pr_err("%s -failed to set wm8904 SYSCLK\n", __func__);
> +		return ret;
> +	}

This is an odd thing to set the clock rate to and limits the sample
rates the board can play back.  It would be better to set the clock rate
based on the requested sample rate in hw_params - you're using the FLL
so may as well take advantage of the ability it offers to support all
sample rates.

> +static int atmel_asoc_wm8904_params(struct snd_pcm_substream *substream,
> +		struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_pll(codec_dai, WM8904_FLL_MCLK, WM8904_FLL_MCLK,
> +		32768, params_rate(params) * 256);

Ah, in fact you do actually do that - it'd be clearer to put the
set_sysclk() after this.

> +	switch (level) {
> +	case SND_SOC_BIAS_ON:
> +	case SND_SOC_BIAS_PREPARE:
> +		if (!mclk_on) {
> +			ret = clk_prepare_enable(mclk);
> +			if (ret == 0)
> +				mclk_on = 1;
> +		}
> +		break;
> +	case SND_SOC_BIAS_STANDBY:
> +	case SND_SOC_BIAS_OFF:
> +		if (mclk_on)
> +			clk_disable_unprepare(mclk);
> +		mclk_on = 0;
> +		break;
> +	}

It's better to write this using the previous state than to have the
mclk_on flag - you want to enable on the standby->prepare transition and
disable on the standby->off transition.

> +static int atmel_asoc_wm8904_dt_init(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *codec_np, *cpu_np;
> +	struct snd_soc_card *card = &atmel_asoc_wm8904_card;
> +	struct snd_soc_dai_link *dailink = &atmel_asoc_wm8904_dailink;
> +	int ret;
> +
> +	if (!np)
> +		return -1;

Return a real error code here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130718/3d976bad/attachment.sig>
