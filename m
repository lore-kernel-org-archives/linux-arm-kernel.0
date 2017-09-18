From: mka@chromium.org (Matthias Kaehlcke)
Date: Mon, 18 Sep 2017 12:15:24 -0700
Subject: [PATCH v11 2/2] ASoC: rockchip: Use bus_type to distinguish
 rt5514 dsp from rt5514 codec
In-Reply-To: <20170918111435.11411-2-jeffy.chen@rock-chips.com>
References: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
 <20170918111435.11411-2-jeffy.chen@rock-chips.com>
Message-ID: <20170918191524.GI173745@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Mon, Sep 18, 2017 at 07:14:35PM +0800 Jeffy Chen ha dit:

> Currently rt5514 dsp and rt5514 codec are sharing the same compatible.
> Use bus_type to distinguish rt5514 dsp from rt5514 codec.

This is a better solution than the compatible hack, thanks!

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v11: None
> Changes in v10: None
> Changes in v9: None
> 
>  sound/soc/rockchip/rk3399_gru_sound.c | 57 +++++++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index 0513fe480353..f8028f1f3266 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -23,6 +23,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/delay.h>
>  #include <linux/spi/spi.h>
> +#include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <sound/core.h>
>  #include <sound/jack.h>
> @@ -329,15 +330,6 @@ enum {
>  	DAILINK_RT5514_DSP,
>  };
>  
> -static const char * const dailink_compat[] = {
> -	[DAILINK_CDNDP] = "rockchip,rk3399-cdn-dp",
> -	[DAILINK_DA7219] = "dlg,da7219",
> -	[DAILINK_DMIC] = "dmic-codec",
> -	[DAILINK_MAX98357A] = "maxim,max98357a",
> -	[DAILINK_RT5514] = "realtek,rt5514-i2c",
> -	[DAILINK_RT5514_DSP] = "realtek,rt5514-spi",
> -};
> -
>  static const struct snd_soc_dai_link rockchip_dais[] = {
>  	[DAILINK_CDNDP] = {
>  		.name = "DP",
> @@ -391,13 +383,54 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
>  	},
>  };
>  
> +struct dailink_match_data {
> +	const char *compatible;
> +	struct bus_type *bus_type;
> +};
> +
> +static const struct dailink_match_data dailink_match[] = {
> +	[DAILINK_CDNDP] = {
> +		.compatible = "rockchip,rk3399-cdn-dp",
> +	},
> +	[DAILINK_DA7219] = {
> +		.compatible = "dlg,da7219",
> +	},
> +	[DAILINK_DMIC] = {
> +		.compatible = "dmic-codec",
> +	},
> +	[DAILINK_MAX98357A] = {
> +		.compatible = "maxim,max98357a",
> +	},
> +	[DAILINK_RT5514] = {
> +		.compatible = "realtek,rt5514",
> +		.bus_type = &i2c_bus_type,
> +	},
> +	[DAILINK_RT5514_DSP] = {
> +		.compatible = "realtek,rt5514",
> +		.bus_type = &spi_bus_type,
> +	},
> +};
> +
> +static int of_dev_node_match(struct device *dev, void *data)
> +{
> +	return dev->of_node == data;
> +}

The same is done in different places, even with the same function name
(drivers/i2c/i2c-core-of.c, drivers/mux/mux-core.c, ...), which
suggests that we might want to have this function in <linux/of.h>

>  static int rockchip_sound_codec_node_match(struct device_node *np_codec)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(dailink_compat); i++) {
> -		if (of_device_is_compatible(np_codec, dailink_compat[i]))
> -			return i;
> +	for (i = 0; i < ARRAY_SIZE(dailink_match); i++) {
> +		if (!of_device_is_compatible(np_codec,
> +					     dailink_match[i].compatible))
> +			continue;
> +
> +		if (dailink_match[i].bus_type
> +		    && !bus_find_device(dailink_match[i].bus_type,
> +					NULL, np_codec, of_dev_node_match))
> +			continue;
> +
> +		return i;
>  	}
>  	return -1;
>  }

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
