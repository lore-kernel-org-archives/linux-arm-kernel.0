From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 17 Oct 2018 09:12:48 +0200
Subject: [PATCH v4 2/9] ASoC: sun8i-codec: Don't hardcode BCLK / LRCK ratio
In-Reply-To: <20181016030239.15449-3-anarsoul@gmail.com>
References: <20181016030239.15449-1-anarsoul@gmail.com>
 <20181016030239.15449-3-anarsoul@gmail.com>
Message-ID: <20181017071248.65g7m6ih2swazjh4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Mon, Oct 15, 2018 at 08:02:32PM -0700, Vasily Khoruzhick wrote:
> BCLK / LRCK ratio should be sample size * channels, but it was
> hardcoded to 32 (0x1 is 32 as per A33 and A64 datasheets).
> 
> Calculate it basing on sample size and number of channels.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
> index fb37dd927e33..2467fab94a19 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -24,6 +24,7 @@
>  #include <linux/io.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
> +#include <linux/log2.h>
>  
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
> @@ -52,7 +53,6 @@
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_INV		13
>  #define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
>  #define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
> -#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_16		(1 << 6)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
>  #define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_16		(1 << 4)
>  #define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
> @@ -257,8 +257,8 @@ static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>  }
>  
>  struct sun8i_codec_clk_div {
> -	u8	div;
> -	u8	val;
> +	unsigned int	div;
> +	u8		val;
>  };

Do we still need that type change? It looks like you're not using it
anywhere in that patch.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181017/c6577c26/attachment.sig>
