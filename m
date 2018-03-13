From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Mar 2018 09:20:07 +0100
Subject: [PATCH v2 3/6] ASoC: sun4i-i2s: Correct divider calculations
In-Reply-To: <20180312155753.9478-4-codekipper@gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-4-codekipper@gmail.com>
Message-ID: <20180313082007.bwqanceskmm2dq6f@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 04:57:50PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The clock division circuitry is different on the H3 and later SoCs.
> The division of bclk is now based on pll2.

You're doing too many things here.

> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 76 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 52 insertions(+), 24 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 396b11346361..2bd0befa02a8 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -129,10 +129,10 @@
>   * @has_chsel_offset: SoC uses offset for selecting dai operational mode.
>   * @reg_offset_txdata: offset of the tx fifo.
>   * @sun4i_i2s_regmap: regmap config to use.
> - * @mclk_offset: Value by which mclkdiv needs to be adjusted.
> - * @bclk_offset: Value by which bclkdiv needs to be adjusted.
>   * @fmt_offset: Value by which wss and sr needs to be adjusted.
>   * @field_clkdiv_mclk_en: regmap field to enable mclk output.
> + * @field_clkdiv_mclk: regmap field for mclkdiv.
> + * @field_clkdiv_bclk: regmap field for bclkdiv.
>   * @field_fmt_wss: regmap field to set word select size.
>   * @field_fmt_sr: regmap field to set sample resolution.
>   * @field_fmt_bclk: regmap field to set clk polarity.
> @@ -153,8 +153,6 @@ struct sun4i_i2s_quirks {
>  	bool				has_chsel_offset;
>  	unsigned int			reg_offset_txdata;	/* TX FIFO */
>  	const struct regmap_config	*sun4i_i2s_regmap;
> -	unsigned int			mclk_offset;
> -	unsigned int			bclk_offset;
>  	unsigned int			fmt_offset;
>  
>  	/* Register fields for i2s */
> @@ -212,7 +210,25 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_bclk_div[] = {
>  	{ .div = 8, .val = 3 },
>  	{ .div = 12, .val = 4 },
>  	{ .div = 16, .val = 5 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
> +};
> +
> +static const struct sun4i_i2s_clk_div sun8i_i2s_clk_div[] = {
> +	{ .div = 0, .val = 0 },
> +	{ .div = 1, .val = 1 },
> +	{ .div = 2, .val = 2 },
> +	{ .div = 4, .val = 3 },
> +	{ .div = 6, .val = 4 },
> +	{ .div = 8, .val = 5 },
> +	{ .div = 12, .val = 6 },
> +	{ .div = 16, .val = 7 },
> +	{ .div = 24, .val = 8 },
> +	{ .div = 32, .val = 9 },
> +	{ .div = 48, .val = 10 },
> +	{ .div = 64, .val = 11 },
> +	{ .div = 96, .val = 12 },
> +	{ .div = 128, .val = 13 },
> +	{ .div = 176, .val = 14 },
> +	{ .div = 192, .val = 15 },
>  };
>  
>  static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
> @@ -224,21 +240,21 @@ static const struct sun4i_i2s_clk_div sun4i_i2s_mclk_div[] = {
>  	{ .div = 12, .val = 5 },
>  	{ .div = 16, .val = 6 },
>  	{ .div = 24, .val = 7 },
> -	/* TODO - extend divide ratio supported by newer SoCs */
>  };
>  
>  static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>  				  unsigned int oversample_rate,
> -				  unsigned int word_size)
> +				  unsigned int word_size,
> +				  const struct sun4i_i2s_clk_div *bdiv,
> +				  unsigned int size)
>  {
>  	int div = oversample_rate / word_size / 2;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_bclk_div); i++) {
> -		const struct sun4i_i2s_clk_div *bdiv = &sun4i_i2s_bclk_div[i];
> -
> +	for (i = 0; i < size; i++) {
>  		if (bdiv->div == div)
>  			return bdiv->val;
> +		bdiv++;
>  	}
>  
>  	return -EINVAL;
> @@ -247,16 +263,17 @@ static int sun4i_i2s_get_bclk_div(struct sun4i_i2s *i2s,
>  static int sun4i_i2s_get_mclk_div(struct sun4i_i2s *i2s,
>  				  unsigned int oversample_rate,
>  				  unsigned int module_rate,
> -				  unsigned int sampling_rate)
> +				  unsigned int sampling_rate,
> +				  const struct sun4i_i2s_clk_div *mdiv,
> +				  unsigned int size)
>  {
>  	int div = module_rate / sampling_rate / oversample_rate;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(sun4i_i2s_mclk_div); i++) {
> -		const struct sun4i_i2s_clk_div *mdiv = &sun4i_i2s_mclk_div[i];
> -
> +	for (i = 0; i < size; i++) {
>  		if (mdiv->div == div)
>  			return mdiv->val;
> +		mdiv++;
>  	}
>  
>  	return -EINVAL;
> @@ -321,24 +338,37 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>  		return -EINVAL;
>  	}
>  
> -	bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> -					  word_size);
> +	if (i2s->variant->has_fmt_set_lrck_period)
> +		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
> +						  word_size,
> +						  sun8i_i2s_clk_div,
> +						  ARRAY_SIZE(sun8i_i2s_clk_div));

For example, you mention nowhere why here you would need clk_rate /
rate, instead of the previous oversample_rate.

> +	else
> +		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> +						  word_size,
> +						  sun4i_i2s_bclk_div,
> +						  ARRAY_SIZE(sun4i_i2s_bclk_div));


>  	if (bclk_div < 0) {
>  		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
>  		return -EINVAL;
>  	}
>  
> -	mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> -					  clk_rate, rate);
> +
> +	if (i2s->variant->has_fmt_set_lrck_period)
> +		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> +						  clk_rate, rate,
> +						  sun8i_i2s_clk_div,
> +						  ARRAY_SIZE(sun8i_i2s_clk_div));
> +	else
> +		mclk_div = sun4i_i2s_get_mclk_div(i2s, oversample_rate,
> +						  clk_rate, rate,
> +						  sun4i_i2s_mclk_div,
> +						  ARRAY_SIZE(sun4i_i2s_mclk_div));

While here it's ok to use oversample_rate.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180313/513f07c6/attachment.sig>
