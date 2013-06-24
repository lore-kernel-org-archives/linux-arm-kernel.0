From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 18:00:13 +0200
Subject: [PATCH] ASoC: Tegra and i.MX are mutually exclusive
In-Reply-To: <51C86588.5020606@wwwdotorg.org>
References: <5967649.DUvDfofhX4@wuerfel> <51C86588.5020606@wwwdotorg.org>
Message-ID: <2742661.EnTVWyoBzK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013 09:28:08 Stephen Warren wrote:
> On 06/24/2013 09:04 AM, Arnd Bergmann wrote:
> > Both Tegra and i.MX provide ac97 operations, which can only
> > exist once in the kernel. They can both be built as loadable
> > modules (only one of them needs to be loaded anyway), but we
> > have to disallow enabling them both as built-in.
> 
> > diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> 
> >  menuconfig SND_IMX_SOC
> >       tristate "SoC Audio for Freescale i.MX CPUs"
> >       depends on ARCH_MXC
> > +     depends on SND_SOC_TEGRA=n || (SND_SOC_TEGRA=m && m)
> 
> I can easily see how this prevents adding SND_IMX_SOC to a config if
> SND_SOC_TEGRA is enabled, but I'm not sure about the other way around;
> does Kconfig check that adding a new SND_SOC_TEGRA wouldn't invalidate
> any of the depends of any already-selected options?

If you start out with a config that has SND_IMX_SOC and select
SND_SOC_TEGRA, SND_IMX_SOC gets turned off.

> In other words, do you need to make the "same" change to Tegra?

No, that would create a circular dependency that is not allowed
in Kconfig.

	Arnd
