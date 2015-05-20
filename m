From: horms@verge.net.au (Simon Horman)
Date: Wed, 20 May 2015 11:18:07 +0900
Subject: [PATCH v2] ARM: shmobile: only select sound drivers that build
In-Reply-To: <2384220.GLN49TmlTT@wuerfel>
References: <2384220.GLN49TmlTT@wuerfel>
Message-ID: <20150520021807.GB31103@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 03:40:37PM +0200, Arnd Bergmann wrote:
> A couple of codec drivers are selected by shmobile platform code,
> but depend on I2C, which results in a build error:
> 
> sound/soc/codecs/ak4642.c:638:1: warning: data definition has no type or storage class
>  module_i2c_driver(ak4642_i2c_driver);
>  ^
> sound/soc/codecs/ak4642.c:638:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> sound/soc/codecs/ak4642.c:638:1: warning: parameter names (without types) in function declaration
> sound/soc/codecs/ak4642.c:627:26: warning: 'ak4642_i2c_driver' defined but not used [-Wunused-variable]
> 
> This ensures that we do not enable the respective drivers when I2C
> is disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Arnd,

I have queued this up as a fix for v4.1.

> ----
> v2: removed incorrect change for SND_SOC_AK4554, as pointed out by Geert
> 
> diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> index 679b866399f2..c4cb4b590d47 100644
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -150,7 +150,7 @@ config MACH_ARMADILLO800EVA
>  	select ARCH_REQUIRE_GPIOLIB
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select SMSC_PHY if SH_ETH
> -	select SND_SOC_WM8978 if SND_SIMPLE_CARD
> +	select SND_SOC_WM8978 if SND_SIMPLE_CARD && I2C
>  	select USE_OF
>  
>  config MACH_BOCKW
> @@ -159,7 +159,7 @@ config MACH_BOCKW
>  	select ARCH_REQUIRE_GPIOLIB
>  	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>  	select SND_SOC_AK4554 if SND_SIMPLE_CARD
> -	select SND_SOC_AK4642 if SND_SIMPLE_CARD
> +	select SND_SOC_AK4642 if SND_SIMPLE_CARD && I2C
>  	select USE_OF
>  
>  config MACH_BOCKW_REFERENCE
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
