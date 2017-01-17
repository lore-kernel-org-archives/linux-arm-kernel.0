From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Tue, 17 Jan 2017 17:20:29 +0100
Subject: [PATCH v2 05/10] ASoC: Add sun8i digital audio codec
In-Reply-To: <20170117140230.23142-6-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-6-mylene.josserand@free-electrons.com>
Message-ID: <c1800916-5373-50a8-1b36-0ba5bb69641a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

On 17/01/2017 15:02, Myl?ne Josserand wrote:
> Add the sun8i audio codec which handles the digital register of
> A33 codec.
> The driver handles only the basic playback from the DAC to headphones.
> All other features (microphone, capture, etc) will be added later.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>

[...]

> +static int sun8i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
> +{
> +	unsigned int rate = params_rate(params);
> +
> +	switch (rate) {
> +	case 8000:
> +	case 7350:
> +		return 0x0;
> +	case 11025:
> +		return 0x1;
> +	case 12000:
> +		return 0x2;
> +	case 16000:
> +		return 0x3;
> +	case 22050:
> +		return 0x4;
> +	case 24000:
> +		return 0x5;
> +	case 32000:
> +		return 0x6;
> +	case 44100:
> +		return 0x7;
> +	case 48000:
> +		return 0x8;
> +	case 96000:
> +		return 0x9;
> +	case 192000:
> +		return 0xa;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static u32 sun8i_codec_get_mod_freq(struct snd_pcm_hw_params *params)
> +{
> +	unsigned int rate = params_rate(params);
> +
> +	switch (rate) {
> +	case 176400:
> +	case 88200:
> +	case 44100:
> +	case 22050:
> +	case 11025:
> +		return 22579200;
> +
> +	case 192000:
> +	case 128000:
> +	case 96000:
> +	case 64000:
> +	case 48000:
> +	case 32000:
> +	case 24000:
> +	case 16000:
> +	case 12000:
> +	case 8000:
> +		return 24576000;
> +
> +	default:
> +		return 0;
> +	}
> +}

This function is not used anymore, I will remove it in v3 (once I will 
get some reviews).

> +
> +static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
> +{
> +	struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
> +	u32 value;
> +
> +	/* clock masters */
> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS: /* DAI Slave */
> +		value = 0x0; /* Codec Master */
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM: /* DAI Master */
> +		value = 0x1; /* Codec Slave */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> +			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD),
> +			   value << SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD);
> +
> +	/* clock inversion */
> +	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +	case SND_SOC_DAIFMT_NB_NF: /* Normal */
> +		value = 0x0;
> +		break;
> +	case SND_SOC_DAIFMT_IB_IF: /* Inversion */
> +		value = 0x1;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> +			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV),
> +			   value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
> +	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> +			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
> +			   value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
> +
> +	/* DAI format */
> +	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +	case SND_SOC_DAIFMT_I2S:
> +		value = 0x0;
> +		break;
> +	case SND_SOC_DAIFMT_LEFT_J:
> +		value = 0x1;
> +		break;
> +	case SND_SOC_DAIFMT_RIGHT_J:
> +		value = 0x2;
> +		break;
> +	case SND_SOC_DAIFMT_DSP_A:
> +	case SND_SOC_DAIFMT_DSP_B:
> +		value = 0x3;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> +			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT),
> +			   value << SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT);
> +
> +	return 0;
> +}
> +
> +static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;

Same things for these variables.

> +	struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
> +	u32 clk_freq;
> +	int sample_rate, err;

ditto for "clk_freq" and "err" ones.

Sorry about that.

Best regards,

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
