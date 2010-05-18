From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 08:25:19 +0100
Subject: [PATCH 6/8] ARM: S3C64XX: Add RTC Driver support
In-Reply-To: <1274162378-1981-1-git-send-email-kgene.kim@samsung.com>
References: <1274162378-1981-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100518072519.GE26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, May 18, 2010 at 02:59:38PM +0900, Kukjin Kim wrote:
> From: Atul Dahiya <atul.dahiya@samsung.com>
> 
> This patch adds RTC driver support for S3C64XX.
> 
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c64xx/Kconfig         |    1 +
>  arch/arm/mach-s3c64xx/mach-smdk6410.c |    1 +
>  drivers/rtc/Kconfig                   |    8 ++++----
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
> index 959df38..1207c8b 100644
> --- a/arch/arm/mach-s3c64xx/Kconfig
> +++ b/arch/arm/mach-s3c64xx/Kconfig
> @@ -91,6 +91,7 @@ config MACH_SMDK6410
>  	select S3C_DEV_FB
>  	select S3C_DEV_USB_HOST
>  	select S3C_DEV_USB_HSOTG
> +	select S3C_DEV_RTC
>  	select S3C64XX_SETUP_SDHCI
>  	select S3C64XX_SETUP_I2C1
>  	select S3C64XX_SETUP_FB_24BPP
> diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> index 10cf64a..866026a 100644
> --- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
> +++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
> @@ -255,6 +255,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
>  	&s3c_device_fb,
>  	&s3c_device_ohci,
>  	&s3c_device_usb_hsotg,
> +	&s3c_device_rtc,
>  	&s3c64xx_device_ac97,
>  	&s3c64xx_device_iisv4,
>  
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 6a13037..8cabeeb 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -630,16 +630,16 @@ config RTC_DRV_OMAP
>  
>  config RTC_DRV_S3C
>  	tristate "Samsung S3C series SoC RTC"
> -	depends on ARCH_S3C2410
> +	depends on ARCH_S3C2410 || ARCH_S3C64XX

I wonder whether just making this depend on either S3C_DEV_RTC, or simply
PLAT_SAMSUNG would just be a better choice.

The S3C_DEV_RTC would mean that the drivers the core of the kernel
would be built, but means that we can't speculatively build drivers
if the kernel hasn't any machines using them.

Making it depend on PLAT_SAMSUNG would mean it is available to all,
but would be selectable even if there isn't a machine supporting it
being built.

The current situation would mean that we have to update driver Kconfig
entries each time a new SoC turns up...

We could also have a HAVE_RTC_DRV_S3C so that all SoCs supporting this
coudl select it independant of whether there is machine support.

Anyone else got any comments?

>  	help
>  	  RTC (Realtime Clock) driver for the clock inbuilt into the
> -	  Samsung S3C24XX series of SoCs. This can provide periodic
> +	  Samsung S3C series of SoCs. This can provide periodic
>  	  interrupt rates from 1Hz to 64Hz for user programs, and
>  	  wakeup from Alarm.
>  
>  	  The driver currently supports the common features on all the
> -	  S3C24XX range, such as the S3C2410, S3C2412, S3C2413, S3C2440
> -	  and S3C2442.
> +	  S3C range, such as the S3C2410, S3C2412, S3C2413, S3C2440,
> +	  S3C2442 and S3C64XX.
>  
>  	  This driver can also be build as a module. If so, the module
>  	  will be called rtc-s3c.
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
