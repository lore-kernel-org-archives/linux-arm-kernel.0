From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 18 Sep 2016 22:27:41 +0200
Subject: [PATCH v4 3/3] ASoC: sun4i-codec: Add custom regmap configs
In-Reply-To: <20160915163630.18026-4-dannym@scratchpost.org>
References: <20160915163630.18026-1-dannym@scratchpost.org>
 <20160915163630.18026-4-dannym@scratchpost.org>
Message-ID: <20160918202741.GM17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 06:36:30PM +0200, Danny Milosavljevic wrote:
> ASoC: sun4i-codec: The A20 has a few extra registers that the A10
> doesn't have.
> Therefore, use different regmaps for A10 as compared to A20.

Same comment with the commit log.

> 
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index 3b53b78..c5d6d84c 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -682,12 +682,37 @@ static const struct regmap_config sun4i_codec_regmap_config = {
>  	.reg_bits	= 32,
>  	.reg_stride	= 4,
>  	.val_bits	= 32,
> +	.max_register	= SUN4I_CODEC_ADC_RXCNT,
> +};
> +
> +static const struct regmap_config sun7i_codec_regmap_config = {
> +	.reg_bits	= 32,
> +	.reg_stride	= 4,
> +	.val_bits	= 32,
>  	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
>  };
>  
> +struct sun4i_codec_quirks {
> +	const struct regmap_config *regmap_config;
> +};
> +
> +static const struct sun4i_codec_quirks sun4i_codec_quirks = {
> +	.regmap_config = &sun4i_codec_regmap_config,
> +};
> +
> +static const struct sun4i_codec_quirks sun7i_codec_quirks = {
> +	.regmap_config = &sun7i_codec_regmap_config,
> +};
> +
>  static const struct of_device_id sun4i_codec_of_match[] = {
> -	{ .compatible = "allwinner,sun4i-a10-codec" },
> -	{ .compatible = "allwinner,sun7i-a20-codec" },
> +	{
> +		.compatible = "allwinner,sun4i-a10-codec",
> +		.data = &sun4i_codec_quirks,
> +	},
> +	{
> +		.compatible = "allwinner,sun7i-a20-codec",
> +		.data = &sun7i_codec_quirks,
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, sun4i_codec_of_match);
> @@ -760,6 +785,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_card *card;
>  	struct sun4i_codec *scodec;
> +	const struct sun4i_codec_quirks *quirks;
>  	struct resource *res;
>  	void __iomem *base;
>  	int ret;
> @@ -777,8 +803,9 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  		return PTR_ERR(base);
>  	}
>  
> +	quirks = of_device_get_match_data(&pdev->dev);

And you probably want to check that quirks isn't null there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160918/8e3456bf/attachment.sig>
