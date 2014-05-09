From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 09 May 2014 18:49:41 +0200
Subject: [PATCH v2.1 3/9] ARM: S3C24XX: enable usage of common dclk if
 common clock framework is enabled
In-Reply-To: <3835735.0k9HAgQHzN@phil>
References: <2104342.rkElQpXtvM@phil> <3888936.TSFL3ZW3mv@phil>
 <3835735.0k9HAgQHzN@phil>
Message-ID: <1399654181.19276.2.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-04-23 at 22:09 +0200, Heiko St?bner wrote:
> Add platform device and select the correct implementation automatically
> depending on wether the old samsung_clock or the common clock framework
> is enabled.
> 
> This is only done for machines already using the old dclk implementation,
> as everybody else should move to use dt anyway.
> 
> The machine-specific settings for the external clocks will have to be set
> by somebody with knowledge about the specific hardware.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

It seems this one just hit linux-next (in next-20140509).

> --- a/arch/arm/mach-s3c24xx/Kconfig
> +++ b/arch/arm/mach-s3c24xx/Kconfig
> @@ -18,6 +18,13 @@ config PLAT_S3C24XX
>  	help
>  	  Base platform code for any Samsung S3C24XX device
>  
> +config S3C2410_COMMON_DCLK
> +	bool
> +	select REGMAP_MMIO
> +	help
> +	  Temporary symbol to build the dclk driver based on the common clock
> +	  framework.
> +
>  menu "SAMSUNG S3C24XX SoCs Support"
>  
>  comment "S3C24XX SoCs"
> @@ -264,7 +271,8 @@ config ARCH_BAST
>  	select ISA
>  	select MACH_BAST_IDE
>  	select S3C2410_IOTIMING if ARM_S3C2410_CPUFREQ
> -	select S3C24XX_DCLK
> +	select S3C24XX_DCLK if SAMSUNG_CLOCK
> +	select S3C2410_COMMON_DCLK if COMMON_CLK
>  	select S3C24XX_SIMTEC_NOR
>  	select S3C24XX_SIMTEC_PM if PM
>  	select S3C24XX_SIMTEC_USB
> @@ -345,7 +353,8 @@ config MACH_TCT_HAMMER
>  config MACH_VR1000
>  	bool "Thorcom VR1000"
>  	select MACH_BAST_IDE
> -	select S3C24XX_DCLK
> +	select S3C24XX_DCLK if SAMSUNG_CLOCK
> +	select S3C2410_COMMON_DCLK if COMMON_CLK
>  	select S3C24XX_SIMTEC_NOR
>  	select S3C24XX_SIMTEC_PM if PM
>  	select S3C24XX_SIMTEC_USB
> @@ -530,7 +539,8 @@ config MACH_ANUBIS
>  	bool "Simtec Electronics ANUBIS"
>  	select HAVE_PATA_PLATFORM
>  	select S3C2440_XTAL_12000000
> -	select S3C24XX_DCLK
> +	select S3C24XX_DCLK if SAMSUNG_CLOCK
> +	select S3C2410_COMMON_DCLK if COMMON_CLK
>  	select S3C24XX_SIMTEC_PM if PM
>  	select S3C_DEV_USB_HOST
>  	help
> @@ -571,7 +581,8 @@ config MACH_OSIRIS
>  	bool "Simtec IM2440D20 (OSIRIS) module"
>  	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
>  	select S3C2440_XTAL_12000000
> -	select S3C24XX_DCLK
> +	select S3C24XX_DCLK if SAMSUNG_CLOCK
> +	select S3C2410_COMMON_DCLK if COMMON_CLK
>  	select S3C24XX_SIMTEC_PM if PM
>  	select S3C_DEV_NAND
>  	select S3C_DEV_USB_HOST
> @@ -643,7 +654,8 @@ config MACH_RX1950
>  	select PM_H1940 if PM
>  	select S3C2410_IOTIMING if ARM_S3C2440_CPUFREQ
>  	select S3C2440_XTAL_16934400
> -	select S3C24XX_DCLK
> +	select S3C24XX_DCLK if SAMSUNG_CLOCK
> +	select S3C24XX_COMMON_DCLK if COMMON_CLK

This looks like a typo. Did you mean S3C2410_COMMON_DCLK?

>  	select S3C24XX_PWM
>  	select S3C_DEV_NAND
>  	help


Paul Bolle
