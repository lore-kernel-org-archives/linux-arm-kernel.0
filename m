From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Nov 2017 00:22:23 +0800
Subject: [PATCH 2/3] ASoC: sun8i-codec: Set the BCLK divider
In-Reply-To: <20171108154710.16407-3-maxime.ripard@free-electrons.com>
References: <20171108154710.16407-1-maxime.ripard@free-electrons.com>
 <20171108154710.16407-3-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64taPeDRQUhh9pZMQ=UdNsZE9xSfiDF2pVRs1wvz8pubw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 8, 2017 at 11:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> While the current code was reporting to be able to work in master mode, it
> failed to do so because the BCLK divider wasn't programmed, meaning that
> the BCLK would run at the PLL's frequency no matter the sample rate.
>
> It was obviously a bit too fast.
>
> Add support to retrieve the divider to use, and set it. Since our PLL is
> not always able to generate a perfect multiple of the sample rate, we'll
> have to choose the closest divider that matches our setup.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index 038107baf414..522546e6b153 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -73,6 +73,7 @@
>  #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK         GENMASK(11, 8)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK  GENMASK(5, 4)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK  GENMASK(8, 6)
> +#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK  GENMASK(12, 9)
>
>  struct sun8i_codec {
>         struct device   *dev;
> @@ -226,12 +227,57 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>         return 0;
>  }
>
> +struct sun8i_codec_clk_div {
> +       u8      div;
> +       u8      val;
> +};
> +
> +static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
> +       { .div = 1,     .val = 0 },
> +       { .div = 2,     .val = 1 },
> +       { .div = 4,     .val = 2 },
> +       { .div = 6,     .val = 3 },
> +       { .div = 8,     .val = 4 },
> +       { .div = 12,    .val = 5 },
> +       { .div = 16,    .val = 6 },
> +       { .div = 24,    .val = 7 },
> +       { .div = 32,    .val = 8 },
> +       { .div = 48,    .val = 9 },
> +       { .div = 64,    .val = 10 },
> +       { .div = 96,    .val = 11 },
> +       { .div = 128,   .val = 12 },
> +       { .div = 192,   .val = 13 },
> +};
> +
> +static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
> +                                  unsigned int rate,
> +                                  unsigned int word_size)
> +{
> +       unsigned long clk_rate = clk_get_rate(scodec->clk_module);
> +       unsigned int div = clk_rate / rate / word_size / 2;
> +       unsigned int best_val = 0, best_diff = ~0;
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(sun8i_codec_bclk_div); i++) {
> +               const struct sun8i_codec_clk_div *bdiv = &sun8i_codec_bclk_div[i];
> +               unsigned int diff = abs(bdiv->div - div);
> +
> +               if (diff < best_diff) {
> +                       best_diff = diff;
> +                       best_val = bdiv->val;
> +               }
> +       }
> +
> +       return best_val;
> +}
> +
>  static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
>                                  struct snd_pcm_hw_params *params,
>                                  struct snd_soc_dai *dai)
>  {
>         struct sun8i_codec *scodec = snd_soc_codec_get_drvdata(dai->codec);
>         int sample_rate;
> +       u8 bclk_div;
>
>         /*
>          * The CPU DAI handles only a sample of 16 bits. Configure the
> @@ -241,6 +287,13 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
>                            SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
>                            SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16);

This looks like it's using 16 bit words regardless of the settings in params.

>
> +       bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params),
> +                                           params_width(params));

But here you pass params_width(params). Seems a bit error prone.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +
> +       regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
> +                          SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
> +                          bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
> +
>         regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>                            SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
>                            SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16);
> --
> 2.14.3
>
