From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 8 Nov 2012 16:24:31 +0100
Subject: [RFC PATCH v4 2/2] ASoC: sam9g20-wm8731: convert to dt support
In-Reply-To: <1352361422-13265-2-git-send-email-voice.shen@atmel.com>
References: <1352361422-13265-1-git-send-email-voice.shen@atmel.com>
 <1352361422-13265-2-git-send-email-voice.shen@atmel.com>
Message-ID: <20121108152431.GJ4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:57 Thu 08 Nov     , Bo Shen wrote:
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
> ---
> Change since v3 RFC:
>   Remove dai node, remap ssc in place
>   without pinctrl added, so don't modify the dtsi file, will be added
>   soon
until I see the pinctrl to test this no
This code is untested
> Change since v2:
>   No change
> Change since v1:
>   Add sam9g20-wm8731 binding document
> ---
>  .../bindings/sound/atmel-sam9g20-wm8731-audio.txt  |   21 ++++++
>  sound/soc/atmel/Kconfig                            |    3 +-
>  sound/soc/atmel/sam9g20_wm8731.c                   |   71 ++++++++++++++++++--
>  3 files changed, 88 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/atmel-sam9g20-wm8731-audio.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/atmel-sam9g20-wm8731-audio.txt b/Documentation/devicetree/bindings/sound/atmel-sam9g20-wm8731-audio.txt
> new file mode 100644
> index 0000000..adf7e7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/atmel-sam9g20-wm8731-audio.txt
> @@ -0,0 +1,21 @@
> +* Atmel sam9g20ek audio complex
this is board file or soc?


and use the full soc sor board ame in the documentation

Best Regards,
J.
> +
> +Required properties:
> +  - compatible: "atmel,at91sam9g20-audio"
> +  - atmel,model: The user-visible name of this sound complex.
> +  - atmel,audio-routing: A list of the connections between audio components.
> +  - atmel,ssc-controller: The phandle of the SSC controller
> +  - atmel,audio-codec: The phandle of the WM8731 audio codec
> +
> +Example:
> +sound {
> +	compatible = "atmel,at91sam9g20-audio";
> +	atmel,model = "wm8731 @ AT91SAMG20EK";
> +
> +	atmel,audio-routing =
> +		"Ext Spk", "LHPOUT",
> +		"Int MIC", "MICIN";
> +
> +	atmel,ssc-controller = <&ssc0>;
> +	atmel,audio-codec = <&wm8731>;
> +};
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 72b09cf..397ec75 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -16,8 +16,7 @@ config SND_ATMEL_SOC_SSC
>  
>  config SND_AT91_SOC_SAM9G20_WM8731
>  	tristate "SoC Audio support for WM8731-based At91sam9g20 evaluation board"
> -	depends on ATMEL_SSC && ARCH_AT91SAM9G20 && SND_ATMEL_SOC && \
> -                   AT91_PROGRAMMABLE_CLOCKS
> +	depends on ATMEL_SSC && SND_ATMEL_SOC && AT91_PROGRAMMABLE_CLOCKS
>  	select SND_ATMEL_SOC_SSC
>  	select SND_SOC_WM8731
>  	help
> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_wm8731.c
> index eef6eed..62c3a3d 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -197,14 +197,30 @@ static struct snd_soc_card snd_soc_at91sam9g20ek = {
>  
>  static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *codec_np, *cpu_np;
>  	struct clk *pllb;
>  	struct snd_soc_card *card = &snd_soc_at91sam9g20ek;
> -	int ret;
> -
> -	if (!(machine_is_at91sam9g20ek() || machine_is_at91sam9g20ek_2mmc()))
> -		return -ENODEV;
> +	int ret, id;
> +
> +	if (np) {
> +		cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
> +		if (!cpu_np) {
> +			dev_err(&pdev->dev, "codec info missing\n");
> +			return -EINVAL;
> +		}
> +
> +		id = of_alias_get_id(cpu_np, "ssc");
> +		of_node_put(cpu_np);
> +	} else {
> +		if (!(machine_is_at91sam9g20ek() ||
> +			machine_is_at91sam9g20ek_2mmc()))
> +			return -ENODEV;
> +
> +		id = pdev->id;
> +	}
>  
> -	ret = atmel_ssc_set_audio(pdev->id);
> +	ret = atmel_ssc_set_audio(id);
>  	if (ret)
>  		goto err;
>  
> @@ -234,6 +250,42 @@ static int __devinit at91sam9g20ek_audio_probe(struct platform_device *pdev)
>  	clk_set_rate(mclk, MCLK_RATE);
>  
>  	card->dev = &pdev->dev;
> +
> +	/* Parse device node info */
> +	if (np) {
> +		ret = snd_soc_of_parse_card_name(card, "atmel,model");
> +		if (ret)
> +			goto err;
> +
> +		ret = snd_soc_of_parse_audio_routing(card,
> +			"atmel,audio-routing");
> +		if (ret)
> +			goto err;
> +
> +		/* Parse codec info */
> +		at91sam9g20ek_dai.codec_name = NULL;
> +		codec_np = of_parse_phandle(np, "atmel,audio-codec", 0);
> +		if (!codec_np) {
> +			dev_err(&pdev->dev, "codec info missing\n");
> +			return -EINVAL;
> +		}
> +		at91sam9g20ek_dai.codec_of_node = codec_np;
> +
> +		/* Parse dai and platform info */
> +		at91sam9g20ek_dai.cpu_dai_name = NULL;
> +		at91sam9g20ek_dai.platform_name = NULL;
> +		cpu_np = of_parse_phandle(np, "atmel,ssc-controller", 0);
> +		if (!cpu_np) {
> +			dev_err(&pdev->dev, "dai and pcm info missing\n");
> +			return -EINVAL;
> +		}
> +		at91sam9g20ek_dai.cpu_of_node = cpu_np;
> +		at91sam9g20ek_dai.platform_of_node = cpu_np;
> +
> +		of_node_put(codec_np);
> +		of_node_put(cpu_np);
> +	}
> +
>  	ret = snd_soc_register_card(card);
>  	if (ret) {
>  		printk(KERN_ERR "ASoC: snd_soc_register_card() failed\n");
> @@ -262,10 +314,19 @@ static int __devexit at91sam9g20ek_audio_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id sam9g20ek_wm8731_dt_ids[] = {
> +	{ .compatible = "atmel,at91sam9g20-audio", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sam9g20ek_wm8731_dt_ids);
> +#endif
> +
>  static struct platform_driver at91sam9g20ek_audio_driver = {
>  	.driver = {
>  		.name	= "at91sam9g20ek-audio",
>  		.owner	= THIS_MODULE,
> +		.of_match_table = of_match_ptr(sam9g20ek_wm8731_dt_ids),
>  	},
>  	.probe	= at91sam9g20ek_audio_probe,
>  	.remove	= __devexit_p(at91sam9g20ek_audio_remove),
> -- 
> 1.7.9.5
> 
