From: mka@chromium.org (Matthias Kaehlcke)
Date: Thu, 24 Aug 2017 14:19:51 -0700
Subject: [RESENT PATCH v7 1/7] ASoC: rockchip: Use codec of_node and
 dai_name for rt5514 dsp
In-Reply-To: <20170824045227.15504-2-jeffy.chen@rock-chips.com>
References: <20170824045227.15504-1-jeffy.chen@rock-chips.com>
 <20170824045227.15504-2-jeffy.chen@rock-chips.com>
Message-ID: <20170824211951.GG173745@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Aug 24, 2017 at 12:52:21PM +0800 Jeffy Chen ha dit:

> Currently we are using codec name for rt5514 dsp dai link, use codec
> of_node instead.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
(The codec is still 'detected' on kevin, with the name spi32765.0)

> Changes in v7:
> Rebase on the newest for-next
> 
> Changes in v6: None
> Changes in v3: None
> Changes in v2: None
> 
>  sound/soc/rockchip/rk3399_gru_sound.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index 566ccb39fb31..cd2fdba922f1 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -247,8 +247,6 @@ enum {
>  	DAILINK_RT5514_DSP,
>  };
>  
> -#define DAILINK_ENTITIES	(DAILINK_DA7219 + 1)
> -
>  static struct snd_soc_dai_link rockchip_dailinks[] = {
>  	[DAILINK_MAX98357A] = {
>  		.name = "MAX98357A",
> @@ -282,8 +280,7 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
>  	[DAILINK_RT5514_DSP] = {
>  		.name = "RT5514 DSP",
>  		.stream_name = "Wake on Voice",
> -		.codec_name = "snd-soc-dummy",
> -		.codec_dai_name = "snd-soc-dummy-dai",
> +		.codec_dai_name = "rt5514-dsp-cpu-dai",
>  	},
>  };
>  
> @@ -300,17 +297,10 @@ static struct snd_soc_card rockchip_sound_card = {
>  	.num_controls = ARRAY_SIZE(rockchip_controls),
>  };
>  
> -static int rockchip_sound_match_stub(struct device *dev, void *data)
> -{
> -	return 1;
> -}
> -
>  static int rockchip_sound_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_card *card = &rockchip_sound_card;
>  	struct device_node *cpu_node;
> -	struct device *dev;
> -	struct device_driver *drv;
>  	int i, ret;
>  
>  	cpu_node = of_parse_phandle(pdev->dev.of_node, "rockchip,cpu", 0);
> @@ -319,7 +309,7 @@ static int rockchip_sound_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < DAILINK_ENTITIES; i++) {
> +	for (i = 0; i < ARRAY_SIZE(rockchip_dailinks); i++) {
>  		rockchip_dailinks[i].platform_of_node = cpu_node;
>  		rockchip_dailinks[i].cpu_of_node = cpu_node;
>  
> @@ -332,22 +322,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	/**
> -	 * To acquire the spi driver of the rt5514 and set the dai-links names
> -	 * for soc_bind_dai_link
> -	 */
> -	drv = driver_find("rt5514", &spi_bus_type);
> -	if (!drv) {
> -		dev_err(&pdev->dev, "Can not find the rt5514 driver at the spi bus\n");
> -		return -EINVAL;
> -	}
> -
> -	dev = driver_find_device(drv, NULL, NULL, rockchip_sound_match_stub);
> -	if (!dev) {
> -		dev_err(&pdev->dev, "Can not find the rt5514 device\n");
> -		return -ENODEV;
> -	}
> -
>  	/* Set DMIC wakeup delay */
>  	ret = device_property_read_u32(&pdev->dev, "dmic-wakeup-delay-ms",
>  					&dmic_wakeup_delay);
> @@ -357,10 +331,6 @@ static int rockchip_sound_probe(struct platform_device *pdev)
>  			"no optional property 'dmic-wakeup-delay-ms' found, default: no delay\n");
>  	}
>  
> -	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -
>  	card->dev = &pdev->dev;
>  
>  	ret = devm_snd_soc_register_card(&pdev->dev, card);
