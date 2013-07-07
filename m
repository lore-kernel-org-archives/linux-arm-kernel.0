From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 7 Jul 2013 09:19:49 +0200
Subject: [PATCH v9 08/10] ASoC: Add phycore-ac97-dt driver
In-Reply-To: <20130703161727.GS27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-9-git-send-email-mpa@pengutronix.de>
 <20130703161727.GS27646@sirena.org.uk>
Message-ID: <20130707071949.GH16871@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 03, 2013 at 05:17:27PM +0100, Mark Brown wrote:
> On Thu, Jun 20, 2013 at 03:20:27PM +0200, Markus Pargmann wrote:
> 
> > Notes:
> >     Changes in v9:
> >      - Fix blank line at end of file.
> >     
> 
> Please don't include enormous changelogs like this, they're just noise.
> 
> > +config SND_SOC_PHYCORE_AC97_DT
> > +	bool "SoC Audio support for Phytec phyCORE (and phyCARD) boards (devicetree only)"
> > +	depends on MACH_PCA100 || MACH_PCM043
> 
> Is there an actual dependency on the machine type?  This seems wrong for
> a DT driver.

No, there is no dependency. Fixed.

> 
> > +static struct snd_soc_ops imx_phycore_hifi_ops = {
> > +};
> > +
> 
> You shouldn't have this if there's nothing in it.

Removed.

> 
> > +static struct platform_device *imx_phycore_snd_device;
> 
> This shouldn't be a global, it should be in driver data.

Moved to driver data.

> 
> > +/*
> > + * Pointer to AC97 reset functions for specific boards
> > + */
> > +#if IS_ENABLED(CONFIG_MACH_PCA100)
> > +extern void pca100_ac97_cold_reset(struct snd_ac97 *ac97);
> > +extern void pca100_ac97_warm_reset(struct snd_ac97 *ac97);
> > +#else
> > +static void pca100_ac97_cold_reset(struct snd_ac97 *ac97) { }
> > +static void pca100_ac97_warm_reset(struct snd_ac97 *ac97) { }
> > +#endif
> 
> > +	if (of_machine_is_compatible("phytec,imx27-pca100")) {
> > +		phycore_ac97_reset = pca100_ac97_cold_reset;
> > +		phycore_ac97_warm_reset = pca100_ac97_warm_reset;
> > +	} else if (of_machine_is_compatible("phytec,imx35-pcm043")) {
> > +		phycore_ac97_reset = pcm043_ac97_cold_reset;
> > +		phycore_ac97_warm_reset = pcm043_ac97_warm_reset;
> > +	} else {
> > +		dev_err(&pdev->dev, "Failed to set AC97 reset functions, unknown board.\n");
> > +		return -EINVAL;
> > +	}
> 
> These functions have no reason to be anywhere except in the driver and
> really you should just be specifying which pins to use there - ideally
> via pinctrl but I don't think i.MX has adopted that yet.

There are no pinctrl driver for imx27(pca100) or imx35(pcm043). The
iomux/pad configure functions are defined inside mach-imx/ including
their headers. Both reset functions have to configure iomux/pad before
and after using gpio. So I think it's not possible to make the reset
based on the gpio pins without the necessary iomux/pad configuration.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
