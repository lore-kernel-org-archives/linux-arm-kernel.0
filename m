From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Wed, 5 Oct 2016 13:54:57 +0200
Subject: [PATCH 06/14] ASoC: Add sun8i digital audio codec
In-Reply-To: <20161004144008.0d07d18c@free-electrons.com>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <85cbd9926e52d0aa03f6bbfd8794373d8db491e0.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004144008.0d07d18c@free-electrons.com>
Message-ID: <b8c11edf-bdba-f9ce-08a9-d777961b535e@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On 04/10/2016 14:40, Thomas Petazzoni wrote:
> Hello,
>
> On Tue,  4 Oct 2016 11:46:19 +0200, Myl?ne Josserand wrote:
>> Add the digital sun8i audio codec which handles the base register
>> (without DAI).
>
> I'm not sure what you mean by "which handles the base register".

I wanted to explain that it is registers for audio codec and not PRCM 
ones. This is, maybe, unclear (and useless ?).

>
>> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
>> index 7aee95a..9e287b0 100644
>> --- a/sound/soc/sunxi/Kconfig
>> +++ b/sound/soc/sunxi/Kconfig
>> @@ -27,6 +27,15 @@ config SND_SUN4I_SPDIF
>>  	  Say Y or M to add support for the S/PDIF audio block in the Allwinner
>>  	  A10 and affiliated SoCs.
>>
>> +config SND_SUN8I_CODEC
>> +	tristate "Allwinner SUN8I audio codec"
>> +	select REGMAP_MMIO
>> +        help
>
> Indentation issue here, it should be intended with one tab, not spaces.
>
> You probably also want a "depends on OF" here.

Yes, thanks !

>
>> +/* CODEC_OFFSET represents the offset of the codec registers
>> + * and not all the DAI registers
>> + */
>
> This is not the proper comment style I believe for audio code, it
> should be:
>
> /*
>  * ...
>  */
>
>> +#define CODEC_OFFSET				0x200
>
> Do you really need this CODEC_OFFSET macro? Why not simply use directly
> the right offsets? I.e instead of:
>
>   #define SUN8I_SYSCLK_CTL			(0x20c - CODEC_OFFSET)
>
> use:
>
>   #define SUN8I_SYSCLK_CTL			0xc

I thought it could be easier to find registers using offset but I guess 
that register's names are enough.

>
>> +#define CODEC_BASSADDRESS			0x01c22c00
>
> This define is not used anywhere.

Yes, sorry, I forgot to remove it.

>
>> +#define SUN8I_SYSCLK_CTL			(0x20c - CODEC_OFFSET)
>> +#define SUN8I_SYSCLK_CTL_AIF1CLK_ENA		(11)
>> +#define SUN8I_SYSCLK_CTL_SYSCLK_ENA		(3)
>> +#define SUN8I_SYSCLK_CTL_SYSCLK_SRC		(0)
>
> Parenthesis around single values are not really useful.
>
>> +#define SUN8I_MOD_CLK_ENA			(0x210 - CODEC_OFFSET)
>> +#define SUN8I_MOD_CLK_ENA_AIF1			(15)
>> +#define SUN8I_MOD_CLK_ENA_DAC			(2)
>> +#define SUN8I_MOD_RST_CTL			(0x214 - CODEC_OFFSET)
>> +#define SUN8I_MOD_RST_CTL_AIF1			(15)
>> +#define SUN8I_MOD_RST_CTL_DAC			(2)
>> +#define SUN8I_SYS_SR_CTRL			(0x218 - CODEC_OFFSET)
>> +#define SUN8I_SYS_SR_CTRL_AIF1_FS		(12)
>> +#define SUN8I_SYS_SR_CTRL_AIF2_FS		(8)
>> +#define SUN8I_AIF1CLK_CTRL			(0x240 - CODEC_OFFSET)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD	(15)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV	(14)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV	(13)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV	(9)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV	(6)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ	(4)
>> +#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT	(2)
>> +#define SUN8I_AIF1_DACDAT_CTRL			(0x248 - CODEC_OFFSET)
>> +#define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA	(15)
>> +#define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA	(14)
>> +#define SUN8I_DAC_DIG_CTRL			(0x320 - CODEC_OFFSET)
>> +#define SUN8I_DAC_DIG_CTRL_ENDA		(15)
>> +#define SUN8I_DAC_MXR_SRC			(0x330 - CODEC_OFFSET)
>> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA0L (15)
>> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF1DA1L (14)
>> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_AIF2DACL (13)
>> +#define SUN8I_DAC_MXR_SRC_DACL_MXR_SRC_ADCL	(12)
>> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA0R (11)
>> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R (10)
>> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR (9)
>> +#define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR	(8)
>
> Indentation of the value is not very clean for those last defines.
>
>> +static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>> +{
>> +	struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
>> +	unsigned long value;
>
> I'm not sure "unsigned long" is a very good choice here, it's going to
> be a 64 bits integer on 64 bits platform. I'd suggest to use "u32",
> which also seems to be what's used in _set_fmt() function of the
> sun4i-i2s.c driver.

Agreed, thanks !

>
>
>> +static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
>> +				 struct snd_pcm_hw_params *params,
>> +				 struct snd_soc_dai *dai)
>> +{
>> +	int rs_value  = 0;
>
> Two spaces before the = sign, not needed. Is the initialization to 0
> really needed? Also, this should be a u32.

ditto

>
>> +	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>> +			   0x3 << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ,
>
> Maybe a #define value to replace the hardcoded 0x3 ?
>
>> +			   rs_value << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ);
>> +
>> +	/* calculate bclk_lrck_div Ratio */
>> +	bclk_lrck_div = sample_resolution * 2;
>> +	switch (bclk_lrck_div) {
>> +	case 16:
>> +		bclk_lrck_div = 0;
>> +		break;
>> +	case 32:
>> +		bclk_lrck_div = 1;
>> +		break;
>> +	case 64:
>> +		bclk_lrck_div = 2;
>> +		break;
>> +	case 128:
>> +		bclk_lrck_div = 3;
>> +		break;
>> +	case 256:
>> +		bclk_lrck_div = 4;
>> +		break;
>
> This could quite easily be replaced by a formula, if you don't care
> about error checking:
>
> 	bclk_lrck_div = log2(bclk_lrck_div) - 4;
>
> Of course, if you care about error checking, this switch is nicer.
>
>> +	default:
>
> So there's no error checking if the value is not supported?

You are right. I guess it should return -EINVAL.

[snip]

>
>
>> +static struct snd_soc_dai_driver sun8i_codec_dai = {
>> +	.name = "sun8i",
>> +	/* playback capabilities */
>> +	.playback = {
>> +		.stream_name = "Playback",
>> +		.channels_min = 1,
>> +		.channels_max = 2,
>> +		.rates = SNDRV_PCM_RATE_8000_192000 |
>> +			SNDRV_PCM_RATE_KNOT,
>> +		.formats = SNDRV_PCM_FMTBIT_S8 |
>> +			SNDRV_PCM_FMTBIT_S16_LE |
>> +			SNDRV_PCM_FMTBIT_S18_3LE |
>> +			SNDRV_PCM_FMTBIT_S20_3LE |
>> +			SNDRV_PCM_FMTBIT_S24_LE |
>> +			SNDRV_PCM_FMTBIT_S32_LE,
>> +	},
>> +	/* pcm operations */
>> +	.ops = &sun8i_codec_dai_ops,
>> +};
>> +EXPORT_SYMBOL(sun8i_codec_dai);
>
> This EXPORT_SYMBOL looks wrong. First because it doesn't seem to be
> used outside of this module. And second because using EXPORT_SYMBOL on
> a function defined as static doesn't make much sense, as the "static"
> qualifier limits the visibility of the symbol to the current
> compilation unit.
>

Yes, sorry, I missed it from the clean-up of the original driver.

[snip]

>> +static int sun8i_codec_probe(struct platform_device *pdev)
>> +{
>> +	struct resource *res_base;
>> +	struct sun8i_codec *scodec;
>> +	void __iomem *base;
>> +
>> +	scodec = devm_kzalloc(&pdev->dev, sizeof(*scodec), GFP_KERNEL);
>> +	if (!scodec)
>> +		return -ENOMEM;
>> +
>> +	scodec->dev = &pdev->dev;
>> +
>> +	/* Get the clocks from the DT */
>> +	scodec->clk_module = devm_clk_get(&pdev->dev, "codec");
>> +	if (IS_ERR(scodec->clk_module)) {
>> +		dev_err(&pdev->dev, "Failed to get the module clock\n");
>> +		return PTR_ERR(scodec->clk_module);
>> +	}
>> +	if (clk_prepare_enable(scodec->clk_module))
>> +		pr_err("err:open failed;\n");
>
> Grr, pr_err, not good. Plus you want to return with an error from the
> probe() function.

Oh, sorry for that ugly use :(

>
>> +
>> +	scodec->clk_apb = devm_clk_get(&pdev->dev, "apb");
>> +	if (IS_ERR(scodec->clk_apb)) {
>> +		dev_err(&pdev->dev, "Failed to get the apb clock\n");
>> +		return PTR_ERR(scodec->clk_apb);
>> +	}
>> +	if (clk_prepare_enable(scodec->clk_apb))
>> +		pr_err("err:open failed;\n");
>
> Ditto. + unprepare/disable the previous clock.

[snip]

ack, thank you for the review!


-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
