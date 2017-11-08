From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 9 Nov 2017 00:25:22 +0800
Subject: [PATCH 3/3] ASoC: sun8i-codec: Fix left and right channels
 inversion
In-Reply-To: <20171108154710.16407-4-maxime.ripard@free-electrons.com>
References: <20171108154710.16407-1-maxime.ripard@free-electrons.com>
 <20171108154710.16407-4-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v678wHyfCm1HzdmGT8f7qcv7VGkAZprMuK5rwqfT7BTvQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 8, 2017 at 11:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Since its introduction, the codec had an inversion of the left and right
> channels. It turned out to be pretty simple as it appears that the codec
> doesn't have the same polarity on the LRCK signal than the I2S block.
>
> Fix this by inverting our bit value for the LRCK inversion.
>
> Fixes: 36c684936fae ("ASoC: Add sun8i digital audio codec")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I suggest adding a comment in case anyone stumbles across it.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  sound/soc/sunxi/sun8i-codec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index 522546e6b153..c8dcb1502d74 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -200,7 +200,7 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>                            value << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_INV);
>         regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
>                            BIT(SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV),
> -                          value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
> +                          !value << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV);
>
>         /* DAI format */
>         switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> --
> 2.14.3
>
