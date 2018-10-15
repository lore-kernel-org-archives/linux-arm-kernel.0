From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 15 Oct 2018 09:07:14 +0200
Subject: [PATCH v2 2/9] ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio
In-Reply-To: <20181013165329.13363-3-anarsoul@gmail.com>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-3-anarsoul@gmail.com>
Message-ID: <20181015070714.tglgw5dym6hraejz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2018 at 09:53:22AM -0700, Vasily Khoruzhick wrote:
> BCLK / LRCK ratio should be sample size * channels, but it was
> hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
> 
> Calculate it basing on sample size and number of channels.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index fb37dd927e33..e681e194ad4c 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -52,7 +52,6 @@
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
>  #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
> -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
> @@ -257,8 +256,8 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  }
>  
>  struct sun8i_codec_clk_div {
> -	u8	div;
> -	u8	val;
> +	unsigned int	div;
> +	u8		val;
>  };
>  
>  static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
> @@ -300,12 +299,33 @@ static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
>  	return best_val;
>  }
>  
> +static const struct sun8i_codec_clk_div sun8i_codec_lrck_div[] = {
> +	{ .div = 16,	.val = 0 },
> +	{ .div = 32,	.val = 1 },
> +	{ .div = 64,	.val = 2 },
> +	{ .div = 128,	.val = 3 },
> +	{ .div = 256,	.val = 4 },
> +};

That's log2(div) - 4, right? There's no need to store the table if so.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
