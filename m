From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 16 Aug 2017 14:59:09 -0700
Subject: [PATCH v2 1/3] ASoC: rockchip: Parse dai links from dts
In-Reply-To: <1502340898-28403-2-git-send-email-jeffy.chen@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
 <1502340898-28403-2-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170816215909.GC109008@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Thu, Aug 10, 2017 at 12:54:56PM +0800 Jeffy Chen ha dit:

> Refactor rockchip_sound_probe, parse dai links from dts instead of
> hard coding them.

Mark doesn't seem to be overly convinced that 'rockchip,codec-names'
is a good idea (https://lkml.org/lkml/2017/8/10/511).

How about using something like this instead:

static const char *dailink_compat[] = {
	[DAILINK_MAX98357A] = "maxim,max98357a",
	[DAILINK_RT5514] = "realtek,rt5514",
	[DAILINK_DA7219] = "dlg,da7219",
};

...

static int rockchip_sound_probe(struct platform_device *pdev)
{
	...

	for (i = 0; ; i++) {
		struct device_node *codec_node;
		int j;

		codec_node = of_parse_phandle(pdev->dev.of_node, "rockchip,codec", i);
		if (!codec_node)
			break;

		for (j = 0; j < DAILINK_ENTITIES; j++) {
			if (of_device_is_compatible(codec_node, dailink_compat[j]))
				break;
		}

		if (j == DAILINK_ENTITIES) {
			dev_err(...);
			return -EINVAL;
		}

		rockchip_dailinks[j].codec_of_node = codec_node;
		rockchip_dailinks[j].platform_of_node = cpu_node;
		rockchip_dailinks[j].cpu_of_node = cpu_node;

		/* not strictly needed, could also check for
		   rockchip_dailinks[DAILINK_RT5514].cpu_of_node or so
		   */
		if (j == DAILINK_RT5514)
			has_rt5514 = true;
	}
	...
}

Matthias

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
> Changes in v2:
> Let rockchip,codec-names be a required property, because we plan to
> add more supported codecs to the fixed dai link list in the driver.
> 
>  sound/soc/rockchip/rk3399_gru_sound.c | 125 ++++++++++++++++++++++------------
>  1 file changed, 81 insertions(+), 44 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index 3475c61..03b7fae 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -247,9 +247,7 @@ enum {
>  	DAILINK_RT5514_DSP,
>  };
>  
> -#define DAILINK_ENTITIES	(DAILINK_DA7219 + 1)
> -
> -static struct snd_soc_dai_link rockchip_dailinks[] = {
> +static const struct snd_soc_dai_link rockchip_dais[] = {
>  	[DAILINK_MAX98357A] = {
>  		.name = "MAX98357A",
>  		.stream_name = "MAX98357A PCM",
> @@ -290,8 +288,6 @@ static struct snd_soc_dai_link rockchip_dailinks[] = {
>  static struct snd_soc_card rockchip_sound_card = {
>  	.name = "rk3399-gru-sound",
>  	.owner = THIS_MODULE,
> -	.dai_link = rockchip_dailinks,
> -	.num_links =  ARRAY_SIZE(rockchip_dailinks),
>  	.dapm_widgets = rockchip_dapm_widgets,
>  	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
>  	.dapm_routes = rockchip_dapm_routes,
> @@ -305,71 +301,112 @@ static int rockchip_sound_match_stub(struct device *dev, void *data)
>  	return 1;
>  }
>  
> -static int rockchip_sound_probe(struct platform_device *pdev)
> +static int rockchip_sound_of_parse_dais(struct device *dev,
> +					struct snd_soc_card *card)
>  {
> -	struct snd_soc_card *card = &rockchip_sound_card;
> +	struct device *rt5514_dev;
> +	struct device_driver *rt5514_drv;
>  	struct device_node *cpu_node;
> -	struct device *dev;
> -	struct device_driver *drv;
> -	int i, ret;
> -
> -	cpu_node = of_parse_phandle(pdev->dev.of_node, "rockchip,cpu", 0);
> -	if (!cpu_node) {
> -		dev_err(&pdev->dev, "Property 'rockchip,cpu' missing or invalid\n");
> -		return -EINVAL;
> -	}
> -
> -	for (i = 0; i < DAILINK_ENTITIES; i++) {
> -		rockchip_dailinks[i].platform_of_node = cpu_node;
> -		rockchip_dailinks[i].cpu_of_node = cpu_node;
> +	struct device_node *np_codec;
> +	struct snd_soc_dai_link *dai;
> +	bool has_rt5514 = false;
> +	int i, index, ret;
> +
> +	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
> +				      GFP_KERNEL);
> +	if (!card->dai_link)
> +		return -ENOMEM;
> +
> +	cpu_node = of_parse_phandle(dev->of_node, "rockchip,cpu", 0);
> +
> +	card->num_links = 0;
> +	for (i = 0; i < DAILINK_RT5514_DSP; i++) {
> +		index = of_property_match_string(dev->of_node,
> +				"rockchip,codec-names",
> +				rockchip_dais[i].name);
> +		if (index < 0)
> +			continue;
> +
> +		np_codec = of_parse_phandle(dev->of_node,
> +					    "rockchip,codec", index);
> +		if (!np_codec) {
> +			dev_err(dev, "Missing 'rockchip,codec' for %s\n",
> +				rockchip_dais[i].name);
> +			return -EINVAL;
> +		}
> +		if (!of_device_is_available(np_codec))
> +			continue;
>  
> -		rockchip_dailinks[i].codec_of_node =
> -			of_parse_phandle(pdev->dev.of_node, "rockchip,codec", i);
> -		if (!rockchip_dailinks[i].codec_of_node) {
> -			dev_err(&pdev->dev,
> -				"Property[%d] 'rockchip,codec' missing or invalid\n", i);
> +		if (!cpu_node) {
> +			dev_err(dev, "Missing 'rockchip,cpu' for %s\n",
> +				rockchip_dais[i].name);
>  			return -EINVAL;
>  		}
> +
> +		dai = &card->dai_link[card->num_links++];
> +		*dai = rockchip_dais[i];
> +
> +		dai->codec_of_node = np_codec;
> +		dai->platform_of_node = cpu_node;
> +		dai->cpu_of_node = cpu_node;
> +
> +		if (i == DAILINK_RT5514)
> +			has_rt5514 = true;
>  	}
>  
> +	if (!has_rt5514)
> +		return 0;
> +
>  	/**
>  	 * To acquire the spi driver of the rt5514 and set the dai-links names
>  	 * for soc_bind_dai_link
>  	 */
> -	drv = driver_find("rt5514", &spi_bus_type);
> -	if (!drv) {
> -		dev_err(&pdev->dev, "Can not find the rt5514 driver at the spi bus\n");
> +	rt5514_drv = driver_find("rt5514", &spi_bus_type);
> +	if (!rt5514_drv) {
> +		dev_err(dev, "Can not find the rt5514 driver at the spi bus\n");
>  		return -EINVAL;
>  	}
>  
> -	dev = driver_find_device(drv, NULL, NULL, rockchip_sound_match_stub);
> -	if (!dev) {
> -		dev_err(&pdev->dev, "Can not find the rt5514 device\n");
> +	rt5514_dev = driver_find_device(rt5514_drv, NULL, NULL,
> +					rockchip_sound_match_stub);
> +	if (!rt5514_dev) {
> +		dev_err(dev, "Can not find the rt5514 device\n");
>  		return -ENODEV;
>  	}
>  
>  	/* Set DMIC delay */
> -	ret = device_property_read_u32(&pdev->dev, "dmic-delay",
> -					&rt5514_dmic_delay);
> -	if (ret) {
> +	ret = device_property_read_u32(dev, "dmic-delay", &rt5514_dmic_delay);
> +	if (ret < 0) {
>  		rt5514_dmic_delay = 0;
> -		dev_dbg(&pdev->dev,
> +		dev_dbg(dev,
>  			"no optional property 'dmic-delay' found, default: no delay\n");
>  	}
>  
> -	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -	rockchip_dailinks[DAILINK_RT5514_DSP].cpu_dai_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> -	rockchip_dailinks[DAILINK_RT5514_DSP].platform_name = kstrdup_const(dev_name(dev), GFP_KERNEL);
> +	dai = &card->dai_link[card->num_links++];
> +	*dai = rockchip_dais[DAILINK_RT5514_DSP];
> +
> +	dai->cpu_name = devm_kstrdup(dev, dev_name(rt5514_dev), GFP_KERNEL);
> +	dai->cpu_dai_name = dai->cpu_name;
> +	dai->platform_name = dai->cpu_name;
> +
> +	return 0;
> +}
> +
> +static int rockchip_sound_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = &rockchip_sound_card;
> +	int ret;
> +
> +	ret = rockchip_sound_of_parse_dais(&pdev->dev, card);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to parse dais: %d\n", ret);
> +		return ret;
> +	}
>  
>  	card->dev = &pdev->dev;
>  	platform_set_drvdata(pdev, card);
>  
> -	ret = devm_snd_soc_register_card(&pdev->dev, card);
> -	if (ret)
> -		dev_err(&pdev->dev, "%s snd_soc_register_card fail %d\n",
> -			__func__, ret);
> -
> -	return ret;
> +	return devm_snd_soc_register_card(&pdev->dev, card);
>  }
>  
>  static const struct of_device_id rockchip_sound_of_match[] = {
