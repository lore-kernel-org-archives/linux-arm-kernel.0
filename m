From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Sep 2014 14:52:47 +0100
Subject: [PATCH] ASoC: rockchip-max98090: add driver for rockchip board
 using a max98090
In-Reply-To: <1410507588-15719-1-git-send-email-jay.xu@rock-chips.com>
References: <1410506806-15327-1-git-send-email-jay.xu@rock-chips.com>
 <1410507588-15719-1-git-send-email-jay.xu@rock-chips.com>
Message-ID: <20140912135247.GU7960@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 03:39:48PM +0800, Jianqun wrote:

> +#define RK_PLAT_CLK_12M      12000000

I'm not sure a define is adding anything here...  it's just a define
saying 12MHz that has the value 12MHz.

> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +
> +/* Set max98090 as master, i2s clock output 12MHz for max98090 */
> +	ret = snd_soc_dai_set_sysclk(cpu_dai, 0,

Coding style, comments aren't aligned with the code.

> +	ret = snd_soc_add_card_controls(card, rk_mc_controls,
> +					ARRAY_SIZE(rk_mc_controls));
> +	if (ret) {
> +		pr_err("unable to add card controls\n");
> +		return ret;
> +	}

Use card->controls.

> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
> +	snd_soc_dapm_enable_pin(dapm, "Headphone");
> +	snd_soc_dapm_enable_pin(dapm, "Ext Spk");
> +	snd_soc_dapm_enable_pin(dapm, "Int Mic");
> +
> +	snd_soc_dapm_sync(dapm);

All pins are enabled by default and sync doesn't do anything during
init.

> +#ifdef CONFIG_PM_SLEEP
> +static int snd_rk_prepare(struct device *dev)
> +{
> +	struct snd_soc_card *card = dev_get_drvdata(dev);
> +	struct rk_mc_private *drv = snd_soc_card_get_drvdata(card);
> +
> +	snd_soc_jack_free_gpios(&drv->hp_jack, 1, &hp_jack_gpio);
> +	snd_soc_jack_free_gpios(&drv->mic_jack, 1, &mic_jack_gpio);
> +
> +	return snd_soc_suspend(dev);
> +}

Why are you freeing the GPIOs over suspend, that doesn't seem good?

> +	hp_jack_gpio.gpio = of_get_named_gpio(np, "rockchip,hp-det-gpios", 0);
> +	if (hp_jack_gpio.gpio == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
> +	mic_jack_gpio.gpio = of_get_named_gpio(np, "rockchip,mic-det-gpios", 0);
> +	if (mic_jack_gpio.gpio == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

This ignores errors other than probe deferral but the init code assumed
that these would've succeeded.  Either the init code should handle
failure or all errors should be treated as fatal.

> +	platform_set_drvdata(pdev, &card);
> +
> +	ret = snd_soc_of_parse_card_name(card, "rockchip,model");
> +	if (ret)
> +		return ret;

These need to happen before we register the card since they could be
used as soon as we probe.

> +	snd_soc_card_set_drvdata(soc_card, NULL);

No need to clear driver data, the core will do it anyway and anything
relying on pre-set driver data is broken.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140912/202287b7/attachment.sig>
