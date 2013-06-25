From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 25 Jun 2013 08:36:18 +0200
Subject: [alsa-devel] [PATCH] ASoC: Tegra and i.MX are mutually exclusive
In-Reply-To: <5967649.DUvDfofhX4@wuerfel>
References: <5967649.DUvDfofhX4@wuerfel>
Message-ID: <51C93A62.1050702@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2013 05:04 PM, Arnd Bergmann wrote:
> Both Tegra and i.MX provide ac97 operations, which can only
> exist once in the kernel. They can both be built as loadable
> modules (only one of them needs to be loaded anyway), but we
> have to disallow enabling them both as built-in.
> 

It's just the ac97 drivers that are mutually exclusive. I'm not sure whether
it makes sense to make the whole platforms mutually exclusive for this.

Also this is not limited to tegra and imx. As more platforms are converted
to multiplatform ARM the same issue will pop up for other platforms as well.
I don't think your solution will scale really well for multiple platforms.
The best solution would of course be to make AC97 work properly with
multiple AC97 drivers. But maybe we can get away with a 'choice' Kconfig
entry which allows you to select which platforms AC97 driver you want to build.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
> index 3843a18..5958948 100644
> --- a/sound/soc/fsl/Kconfig
> +++ b/sound/soc/fsl/Kconfig
> @@ -99,6 +99,7 @@ endif # SND_POWERPC_SOC
>  menuconfig SND_IMX_SOC
>  	tristate "SoC Audio for Freescale i.MX CPUs"
>  	depends on ARCH_MXC
> +	depends on SND_SOC_TEGRA=n || (SND_SOC_TEGRA=m && m)
>  	help
>  	  Say Y or M if you want to add support for codecs attached to
>  	  the i.MX CPUs.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
