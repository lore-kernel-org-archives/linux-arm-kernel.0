From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 21:01:39 +0100
Subject: [PATCH 3/3] cpufreq: exynos: allow modular build
In-Reply-To: <20150128172209.GF29600@developer.hsd1.ca.comcast.net>
References: <1422451015-390439-1-git-send-email-arnd@arndb.de>
 <1422451015-390439-4-git-send-email-arnd@arndb.de>
 <20150128172209.GF29600@developer.hsd1.ca.comcast.net>
Message-ID: <1799972.nQ2Axu0CEJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 13:22:11 Eduardo Valentin wrote:
> >  
> >  config ARM_EXYNOS5440_CPUFREQ
> > -	bool "SAMSUNG EXYNOS5440"
> > +	tristate "SAMSUNG EXYNOS5440"
> >  	depends on SOC_EXYNOS5440
> >  	depends on HAVE_CLK && OF
> > +	depends on THERMAL
> >  	select PM_OPP
> >  	default y
> >  	help
> 
> Reading the code briefly, looks like the intention is to separate soc
> specific code into different files, but they all compose one single
> driver. Translating into module, I believe it makes sense to build them
> into a single module, instead of having all of them as separate module.
> 
> Meaning, only ARM_EXYNOS_CPUFREQ becomes tristate, all the remaining
> continues bool. And we add the following Makefile change to your patch

That was my initial thought as well, but the devil is in the details:

> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 0f9a2c3..c3c3cf5 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -26,13 +26,19 @@ config ARM_VEXPRESS_SPC_CPUFREQ
>  
>  
>  config ARM_EXYNOS_CPUFREQ
> -	bool
> +	tristate "SAMSUNG EXYNOS CPUfreq Driver"
> +	depends on THERMAL
> +	default y
> +	help
> +	  This adds the CPUFreq driver for Samsung EXYNOS platforms
> +
> +	  If in doubt, say N.

Now the option shows up on all systems that include Kconfig.arm,
in particular non-exynos machines that might not even be able
to build this.

It's also enabled by default, but if you change the default to 'n',
the entire drivers will be disabled for users with an existing
configuration file.

We could work around these issues by adding extra (silent) Kconfig
symbols that automatically do the right thing, but that would not
be any less ugly than my first patch.

Another possible might be to change the drivers to use the normal
probe ordering and move the module_platform_driver() statement
into the individual drivers, so that e.g. exynos4210_cpufreq_init()
gets turned into exynos4210_cpufreq_probe() and calls the generic
exynos_cpufreq_probe() function. This would let us express the
dependencies more naturally and just export one symbol from the
main module.

	Arnd
