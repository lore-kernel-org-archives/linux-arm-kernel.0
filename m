From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Jul 2013 17:17:27 +0100
Subject: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
In-Reply-To: <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
Message-ID: <20130703161727.GS27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 03:20:27PM +0200, Markus Pargmann wrote:

> Notes:
>     Changes in v9:
>      - Fix blank line at end of file.
>     

Please don't include enormous changelogs like this, they're just noise.

> +config SND_SOC_PHYCORE_AC97_DT
> +	bool "SoC Audio support for Phytec phyCORE (and phyCARD) boards (devicetree only)"
> +	depends on MACH_PCA100 || MACH_PCM043

Is there an actual dependency on the machine type?  This seems wrong for
a DT driver.

> +static struct snd_soc_ops imx_phycore_hifi_ops = {
> +};
> +

You shouldn't have this if there's nothing in it.

> +static struct platform_device *imx_phycore_snd_device;

This shouldn't be a global, it should be in driver data.

> +/*
> + * Pointer to AC97 reset functions for specific boards
> + */
> +#if IS_ENABLED(CONFIG_MACH_PCA100)
> +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> +#else
> +static void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> +static void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
> +#endif

> +	if (of_machine_is_compatible("phytec,imx27-pca100")) {
> +		phycore_ac97_reset = pca100_ac97_cold_reset;
> +		phycore_ac97_warm_reset = pca100_ac97_warm_reset;
> +	} else if (of_machine_is_compatible("phytec,imx35-pcm043")) {
> +		phycore_ac97_reset = pcm043_ac97_cold_reset;
> +		phycore_ac97_warm_reset = pcm043_ac97_warm_reset;
> +	} else {
> +		dev_err(&pdev->dev, "Failed to set AC97 reset functions, unknown board.\n");
> +		return -EINVAL;
> +	}

These functions have no reason to be anywhere except in the driver and
really you should just be specifying which pins to use there - ideally
via pinctrl but I don't think i.MX has adopted that yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130703/97fef7f1/attachment.sig>
