From: mka@chromium.org (Matthias Kaehlcke)
Date: Fri, 15 Sep 2017 17:54:07 -0700
Subject: [PATCH] Asoc: rockchip: Init dapm routes dynamically
In-Reply-To: <20170905041401.23866-1-jeffy.chen@rock-chips.com>
References: <20170905041401.23866-1-jeffy.chen@rock-chips.com>
Message-ID: <20170916005407.GH173745@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

El Tue, Sep 05, 2017 at 12:14:01PM +0800 Jeffy Chen ha dit:

> Currently we are using a fixed list of dapm routes.
> 
> Init dapm routes dynamically when parsing dailinks, since we are
> supporting optional codecs.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
> 
>  sound/soc/rockchip/rk3399_gru_sound.c | 88 +++++++++++++++++++++++++++++------
>  1 file changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
> index 0513fe480353..c537781f8054 100644
> --- a/sound/soc/rockchip/rk3399_gru_sound.c
> +++ b/sound/soc/rockchip/rk3399_gru_sound.c
> @@ -47,18 +47,7 @@ static const struct snd_soc_dapm_widget rockchip_dapm_widgets[] = {
>  	SND_SOC_DAPM_SPK("Speakers", NULL),
>  	SND_SOC_DAPM_MIC("Headset Mic", NULL),
>  	SND_SOC_DAPM_MIC("Int Mic", NULL),
> -};
> -
> -static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
> -	/* Input Lines */
> -	{"MIC", NULL, "Headset Mic"},
> -	{"DMIC1L", NULL, "Int Mic"},
> -	{"DMIC1R", NULL, "Int Mic"},
> -
> -	/* Output Lines */
> -	{"Headphones", NULL, "HPL"},
> -	{"Headphones", NULL, "HPR"},
> -	{"Speakers", NULL, "Speaker"},
> +	SND_SOC_DAPM_LINE("HDMI", NULL),

The HDMI items are newly added, I think a separate patch would be
preferable.

>  };
>  
>  static const struct snd_kcontrol_new rockchip_controls[] = {
> @@ -66,6 +55,7 @@ static const struct snd_kcontrol_new rockchip_controls[] = {
>  	SOC_DAPM_PIN_SWITCH("Speakers"),
>  	SOC_DAPM_PIN_SWITCH("Headset Mic"),
>  	SOC_DAPM_PIN_SWITCH("Int Mic"),
> +	SOC_DAPM_PIN_SWITCH("HDMI"),
>  };
>  
>  static int rockchip_sound_max98357a_hw_params(struct snd_pcm_substream *substream,
> @@ -314,8 +304,6 @@ static struct snd_soc_card rockchip_sound_card = {
>  	.owner = THIS_MODULE,
>  	.dapm_widgets = rockchip_dapm_widgets,
>  	.num_dapm_widgets = ARRAY_SIZE(rockchip_dapm_widgets),
> -	.dapm_routes = rockchip_dapm_routes,
> -	.num_dapm_routes = ARRAY_SIZE(rockchip_dapm_routes),
>  	.controls = rockchip_controls,
>  	.num_controls = ARRAY_SIZE(rockchip_controls),
>  };
> @@ -391,6 +379,65 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
>  	},
>  };
>  
> +static const struct snd_soc_dapm_route rockchip_sound_cdndp_routes[] = {
> +	/* Output */
> +	{"HDMI", NULL, "TX"},
> +};
> +
> +static const struct snd_soc_dapm_route rockchip_sound_da7219_routes[] = {
> +	/* Output */
> +	{"Headphones", NULL, "HPL"},
> +	{"Headphones", NULL, "HPR"},
> +
> +	/* Input */
> +	{"MIC", NULL, "Headset Mic"},
> +};
> +
> +static const struct snd_soc_dapm_route rockchip_sound_dmic_routes[] = {
> +	/* Input */
> +	{"Dmic", NULL, "Int Mic"},

Should be "DMic" as in dmic_dapm_widgets of the dmic codec driver.

This route is also new and would probably be better added in a
separate patch.

> +};
> +
> +static const struct snd_soc_dapm_route rockchip_sound_max98357a_routes[] = {
> +	/* Output */
> +	{"Speakers", NULL, "Speaker"},
> +};
> +
> +static const struct snd_soc_dapm_route rockchip_sound_rt5514_routes[] = {
> +	/* Input */
> +	{"DMIC1L", NULL, "Int Mic"},
> +	{"DMIC1R", NULL, "Int Mic"},
> +};
> +
> +struct rockchip_sound_route {
> +	const struct snd_soc_dapm_route *routes;
> +	int num_routes;
> +};
> +
> +static const struct rockchip_sound_route rockchip_routes[] = {
> +	[DAILINK_CDNDP] = {
> +		.routes = rockchip_sound_cdndp_routes,
> +		.num_routes = ARRAY_SIZE(rockchip_sound_cdndp_routes),
> +	},
> +	[DAILINK_DA7219] = {
> +		.routes = rockchip_sound_da7219_routes,
> +		.num_routes = ARRAY_SIZE(rockchip_sound_da7219_routes),
> +	},
> +	[DAILINK_DMIC] = {
> +		.routes = rockchip_sound_dmic_routes,
> +		.num_routes = ARRAY_SIZE(rockchip_sound_dmic_routes),
> +	},
> +	[DAILINK_MAX98357A] = {
> +		.routes = rockchip_sound_max98357a_routes,
> +		.num_routes = ARRAY_SIZE(rockchip_sound_max98357a_routes),
> +	},
> +	[DAILINK_RT5514] = {
> +		.routes = rockchip_sound_rt5514_routes,
> +		.num_routes = ARRAY_SIZE(rockchip_sound_rt5514_routes),
> +	},
> +	[DAILINK_RT5514_DSP] = {},
> +};
> +
>  static int rockchip_sound_codec_node_match(struct device_node *np_codec)
>  {
>  	int i;
> @@ -408,6 +455,7 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
>  	struct device_node *np_cpu, *np_cpu0, *np_cpu1;
>  	struct device_node *np_codec;
>  	struct snd_soc_dai_link *dai;
> +	struct snd_soc_dapm_route *routes;
>  	int i, index;
>  
>  	card->dai_link = devm_kzalloc(dev, sizeof(rockchip_dais),
> @@ -415,9 +463,16 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
>  	if (!card->dai_link)
>  		return -ENOMEM;
>  
> +	routes = devm_kzalloc(dev, sizeof(rockchip_routes),
> +			      GFP_KERNEL);
> +	if (!routes)
> +		return -ENOMEM;
> +	card->dapm_routes = routes;
> +
>  	np_cpu0 = of_parse_phandle(dev->of_node, "rockchip,cpu", 0);
>  	np_cpu1 = of_parse_phandle(dev->of_node, "rockchip,cpu", 1);
>  
> +	card->num_dapm_routes = 0;
>  	card->num_links = 0;
>  	for (i = 0; i < ARRAY_SIZE(rockchip_dais); i++) {
>  		np_codec = of_parse_phandle(dev->of_node,
> @@ -445,6 +500,11 @@ static int rockchip_sound_of_parse_dais(struct device *dev,
>  		dai->codec_of_node = np_codec;
>  		dai->platform_of_node = np_cpu;
>  		dai->cpu_of_node = np_cpu;
> +
> +		memcpy(routes + card->num_dapm_routes,
> +		       rockchip_routes[index].routes,
> +		       rockchip_routes[index].num_routes * sizeof(*routes));
> +		card->num_dapm_routes += rockchip_routes[index].num_routes;
>  	}
>  
>  	return 0;

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
