From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 May 2011 22:01:17 -0700
Subject: [RFC 3/3] ARM:Tegra: Device Tree Support: Initialize from
	wm8903 the	device tree
In-Reply-To: <20110511232711.10362.53256.stgit@riker>
References: <20110511231905.10362.12844.stgit@riker>
	<20110511232711.10362.53256.stgit@riker>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AA2C8@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

John Bonesio wrote at Wednesday, May 11, 2011 5:27 PM:
> This patch makes it so the wm8903 is initialized from it's device tree
> node.

> diff --git a/arch/arm/boot/dts/tegra-harmony.dts
> b/arch/arm/boot/dts/tegra-harmony.dts
> index af169aa..05521a5 100644
> --- a/arch/arm/boot/dts/tegra-harmony.dts
> +++ b/arch/arm/boot/dts/tegra-harmony.dts
> @@ -19,6 +19,23 @@
>  	i2c at 7000c000 {
>  		status = "ok";
>  		clock-frequency = <400000>;
> +
> +		codec: wm8903 at 1a {
> +			compatible = "wlf,wm8903";
> +			reg = <0x1a>;
> +			interrupts = < 347 >;
> +			irq-active-low = <0>;
> +			micdet-cfg = <0>;
> +			micdet-delay = <100>;

Nit: Maybe group all the WM8903-specific fields together, rather than
spacing them out and interleaving the gpio-controller/gpio-cells in the
middle of them?

> +
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +
> +			gpio-base = < 224 >;
> +			gpio-num-cfg = < 5 >;

I don't think gpio-num-cfg is required; the codec always exports 5 GPIOs.

> +			/* #define WM8903_GPIO_NO_CONFIG 0x8000 */
> +			gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;
> +		};
>  	};
> 
>  	i2c at 7000c400 {
> diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
> index f52b623..2347201 100644
> --- a/sound/soc/codecs/wm8903.c
> +++ b/sound/soc/codecs/wm8903.c
> @@ -1865,10 +1865,14 @@ static void wm8903_init_gpio(struct snd_soc_codec *codec)
>  	wm8903->gpio_chip.ngpio = WM8903_NUM_GPIO;
>  	wm8903->gpio_chip.dev = codec->dev;
> 
> -	if (pdata && pdata->gpio_base)
> +	wm8903->gpio_chip.base = -1;
> +	if (pdata && pdata->gpio_base) {
>  		wm8903->gpio_chip.base = pdata->gpio_base;
> -	else
> -		wm8903->gpio_chip.base = -1;
> +	} else if (codec->dev->of_node) {
> +		prop = of_get_property(codec->dev->of_node, "gpio-base", NULL);
> +		if (prop)
> +			wm8903->gpio_chip.base = be32_to_cpup(prop);
> +	}

The above checks for pdata first, then falls back to of_node. However,
The previous i2c-tegra.c patch checks of_node first then falls back to
pdata. It seems like the ordering should be consistent (although
changing the I2C patch might be best, since I imagine checking pdata
first would lead to least compatibility issues)

> @@ -1964,10 +1973,76 @@ static int wm8903_probe(struct snd_soc_codec
> *codec)
>  		WARN_ON(!mic_gpio && (pdata->micdet_cfg & WM8903_MICDET_ENA));
> 
>  		wm8903->mic_delay = pdata->micdet_delay;
> +	} else if (codec->dev->of_node) {
> +		bool mic_gpio = false;
> +
> +		prop = of_get_property(codec->dev->of_node, "gpio-num-cfg", NULL);
> +		if (prop)
> +			num_gpios = be32_to_cpup(prop);

Again, I'd just hard-code num_gpios==WM8903_NUM_GPIO in the
loop below, instead of making it configurable, since the HW is fixed.

> +		prop = of_get_property(codec->dev->of_node, "gpio-cfg", NULL);
> +		if (num_gpios && prop) {
> +			for (i = 0; i < num_gpios; i++) {
> +				gpio_cfg = be32_to_cpu(prop[i]);
> +
> +				if (gpio_cfg == WM8903_GPIO_NO_CONFIG)
> +					continue;
> +
> +				snd_soc_write(codec, WM8903_GPIO_CONTROL_1 + i,
> +					      gpio_cfg & 0xffff);
> +
> +				val = (gpio_cfg & WM8903_GP1_FN_MASK)
> +					>> WM8903_GP1_FN_SHIFT;
> +
> +				switch (val) {
> +				case WM8903_GPn_FN_MICBIAS_CURRENT_DETECT:
> +				case WM8903_GPn_FN_MICBIAS_SHORT_DETECT:
> +					mic_gpio = true;
> +					break;
> +				default:
> +					break;
> +				}
> +			}
> +		}
> +
> +		prop = of_get_property(codec->dev->of_node, "interrupts", NULL);
> +		if (prop)
> +			wm8903->irq = be32_to_cpup(prop);
> +
> +		prop = of_get_property(codec->dev->of_node, "micdet-cfg", NULL);
> +		if (prop)
> +			micdet_cfg = be32_to_cpup(prop);
> +
> +		snd_soc_write(codec, WM8903_MIC_BIAS_CONTROL_0, micdet_cfg);
> +
> +		if (micdet_cfg)
> +			snd_soc_update_bits(codec, WM8903_WRITE_SEQUENCER_0,
> +					    WM8903_WSEQ_ENA, WM8903_WSEQ_ENA);
> +
> +		/* If microphone detection is enabled in device tree but
> +		 * detected via IRQ then interrupts can be lost before
> +		 * the machine driver has set up microphone detection
> +		 * IRQs as the IRQs are clear on read.  The detection
> +		 * will be enabled when the machine driver configures.
> +		 */
> +		WARN_ON(!mic_gpio && (micdet_cfg & WM8903_MICDET_ENA));
> +
> +		prop = of_get_property(codec->dev->of_node, "micdet-delay", NULL);
> +		if (prop)
> +			wm8903->mic_delay = be32_to_cpup(prop);
> +

The above chunk duplicates a lot of code in the pdata and of_node paths.

Instead, perhaps it'd be better to do something more like:

if (!pdata && of_node) {
    pdata = kalloc()
    read of_node, convert & write to pdata
}
if (pdata) {
    // existing code to handle pdata
}

That way, the code to handle the pdata is re-used and not duplicated.

> diff --git a/sound/soc/tegra/harmony.c b/sound/soc/tegra/harmony.c
>...
> +#ifdef CONFIG_OF
> +	if ((!of_machine_is_compatible("nvidia,harmony")) &&
> (!machine_is_harmony())) {
> +		dev_err(&pdev->dev, "Not running on Tegra Harmony!\n");
> +		return -ENODEV;
> +	}
> +#else
>  	if (!machine_is_harmony()) {
>  		dev_err(&pdev->dev, "Not running on Tegra Harmony!\n");
>  		return -ENODEV;
>  	}
> +#endif

Is that backwards-compatible if CONFIG_OF is enabled, but a devicetree
wasn't provided, but instead the old-style Harmony machine ID was used?
I note that the board-harmony.c machine description doesn't include a
DT_MACHINE_START listing that compatible value; only board-dt.c does
this, and that has a different ARM machine ID.

-- 
nvpublic
