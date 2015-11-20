From: robh@kernel.org (Rob Herring)
Date: Fri, 20 Nov 2015 09:23:36 -0600
Subject: [PATCH 1/4] ASoC: sun4i-codec: Add support for PA gpio pin
In-Reply-To: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20151120152336.GA1670@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 02:47:10PM +0100, Hans de Goede wrote:
> Add support for PA gpio pin for controlling an external amplifier as used
> on some Allwinner boards.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/sound/sun4i-codec.txt      |  3 +++
>  sound/soc/sunxi/sun4i-codec.c                      | 25 ++++++++++++++--------
>  2 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-codec.txt b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
> index c92966b..974babe 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-codec.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-codec.txt
> @@ -14,6 +14,9 @@ Required properties:
>     - "apb": the parent APB clock for this controller
>     - "codec": the parent module clock
>  
> +Optional properties:
> +- pa-gpios: gpio to enable external amplifier
> +
>  Example:
>  codec: codec at 01c22c00 {
>  	#sound-dai-cells = <0>;
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index bcbf4da..2aca9cd 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -27,6 +27,7 @@
>  #include <linux/of_address.h>
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include <sound/core.h>
>  #include <sound/pcm.h>
> @@ -101,16 +102,15 @@ struct sun4i_codec {
>  	struct regmap	*regmap;
>  	struct clk	*clk_apb;
>  	struct clk	*clk_module;
> +	struct gpio_desc *gpio_pa;
>  
>  	struct snd_dmaengine_dai_dma_data	playback_dma_data;
>  };
>  
>  static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
>  {
> -	/*
> -	 * FIXME: according to the BSP, we might need to drive a PA
> -	 *        GPIO high here on some boards
> -	 */
> +	if (scodec->gpio_pa)
> +		gpiod_set_value_cansleep(scodec->gpio_pa, 1);
>  
>  	/* Flush TX FIFO */
>  	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
> @@ -125,15 +125,13 @@ static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
>  
>  static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
>  {
> -	/*
> -	 * FIXME: according to the BSP, we might need to drive a PA
> -	 *        GPIO low here on some boards
> -	 */
> -
>  	/* Disable DAC DRQ */
>  	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
>  			   BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
>  			   0);
> +
> +	if (scodec->gpio_pa)
> +		gpiod_set_value_cansleep(scodec->gpio_pa, 0);
>  }
>  
>  static int sun4i_codec_trigger(struct snd_pcm_substream *substream, int cmd,
> @@ -633,6 +631,15 @@ static int sun4i_codec_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	scodec->gpio_pa = devm_gpiod_get_optional(&pdev->dev, "pa",
> +						  GPIOD_OUT_HIGH);
> +	if (IS_ERR(scodec->gpio_pa)) {
> +		ret = PTR_ERR(scodec->gpio_pa);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "Failed to get pa gpio: %d\n", ret);
> +		return ret;
> +	}
> +
>  	/* DMA configuration for TX FIFO */
>  	scodec->playback_dma_data.addr = res->start + SUN4I_CODEC_DAC_TXDATA;
>  	scodec->playback_dma_data.maxburst = 4;
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
