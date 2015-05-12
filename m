From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 20:26:36 +0100
Subject: [PATCH 2/4] ASoC: rockchip: add rockchip machine driver for
 max98090
In-Reply-To: <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
References: <1431422797-31903-1-git-send-email-zhengxing@rock-chips.com>
 <1431422797-31903-3-git-send-email-zhengxing@rock-chips.com>
Message-ID: <20150512192636.GA3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 05:26:35PM +0800, Xing Zheng wrote:

>  sound/soc/rockchip/Kconfig                   |   10 ++
>  sound/soc/rockchip/Makefile                  |    2 +
>  sound/soc/rockchip/rockchip_machine_driver.c |    6 +
>  sound/soc/rockchip/rockchip_machine_driver.h |    6 +
>  sound/soc/rockchip/rockchip_max98090.c       |  185 ++++++++++++++++++++++++++

This looks more like a normal and reasonable machine driver but then why
have you created the generic rockchip machine driver?  It seems like
this should just be a regular machine driver like other platforms have,
were it not for that this would be mostly fine apart from a couple of
nitpicks below.

> +config SND_SOC_ROCKCHIP_MAX98090
> +	tristate "ASoC support for Rockchip boards using a MAX98090 codec"
> +	depends on SND_SOC_ROCKCHIP && I2C && GPIOLIB
> +	select SND_SOC_ROCKCHIP_I2S
> +	select SND_SOC_MAX98090
> +	select SND_SOC_TS3A227E

This looks like it's a driver specific to Chromebooks (possibly even
specific Chromeooks) and so should be named as such.

> +	card->dapm.idle_bias_off = true;

Just set this when declaring the card, don't do it at runtime.

> +	snd_soc_dapm_enable_pin(dapm, "Headset Mic");
> +	snd_soc_dapm_enable_pin(dapm, "Headphone");
> +	snd_soc_dapm_enable_pin(dapm, "Speaker");
> +	snd_soc_dapm_enable_pin(dapm, "Int Mic");

No need to do this, all pins are enabled by default.

> +	snd_soc_dapm_sync(dapm);

This has no effect during initialization.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/6ac3446f/attachment.sig>
