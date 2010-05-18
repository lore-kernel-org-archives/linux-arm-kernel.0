From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 08:12:57 +0100
Subject: [PATCH 1/8] ARM: SAMSUNG: Move RTC device definitions in
	plat-samsung
In-Reply-To: <1274162336-32667-1-git-send-email-kgene.kim@samsung.com>
References: <1274162336-32667-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100518071257.GD26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 18, 2010 at 02:58:56PM +0900, Kukjin Kim wrote:
> From: Atul Dahiya <atul.dahiya@samsung.com>
> 
> This patch moves RTC device definitions from mach-s3c64xx
> to plat-samsung, to enable the other SoCs to use same device
> definition.
> 
> Signed-off-by: Atul Dahiya <atul.dahiya@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

ok, will apply to a branch.

> ---
>  arch/arm/mach-s3c64xx/Makefile                    |    1 -
>  arch/arm/mach-s3c64xx/include/mach/map.h          |    1 +
>  arch/arm/plat-samsung/Kconfig                     |    5 +++
>  arch/arm/plat-samsung/Makefile                    |    1 +
>  arch/arm/{mach-s3c64xx => plat-samsung}/dev-rtc.c |   28 ++++++++++----------
>  5 files changed, 21 insertions(+), 15 deletions(-)
>  rename arch/arm/{mach-s3c64xx => plat-samsung}/dev-rtc.c (58%)
> 
> diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
> index a690a9d..e7ac812 100644
> --- a/arch/arm/mach-s3c64xx/Makefile
> +++ b/arch/arm/mach-s3c64xx/Makefile
> @@ -56,7 +56,6 @@ obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
>  # device support
>  
>  obj-y				+= dev-uart.o
> -obj-y				+= dev-rtc.o
>  obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C_ADC)		+= dev-adc.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
> index 801c1c0..cce28a9 100644
> --- a/arch/arm/mach-s3c64xx/include/mach/map.h
> +++ b/arch/arm/mach-s3c64xx/include/mach/map.h
> @@ -103,5 +103,6 @@
>  #define S3C_PA_USBHOST		S3C64XX_PA_USBHOST
>  #define S3C_PA_USB_HSOTG	S3C64XX_PA_USB_HSOTG
>  #define S3C_VA_USB_HSPHY	S3C64XX_VA_USB_HSPHY
> +#define S3C_PA_RTC		S3C64XX_PA_RTC
>  
>  #endif /* __ASM_ARCH_6400_MAP_H */
> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
> index 287e6f7..29e2800 100644
> --- a/arch/arm/plat-samsung/Kconfig
> +++ b/arch/arm/plat-samsung/Kconfig
> @@ -190,6 +190,11 @@ config S3C_DEV_NAND
>  	help
>  	  Compile in platform device definition for NAND controller
>  
> +config S3C_DEV_RTC
> +	bool
> +	help
> +	  Complie in platform device definition for RTC
> +
>  config S3C64XX_DEV_SPI
>  	bool
>  	help
> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
> index 0ad820a..af17434 100644
> --- a/arch/arm/plat-samsung/Makefile
> +++ b/arch/arm/plat-samsung/Makefile
> @@ -41,6 +41,7 @@ obj-y				+= dev-uart.o
>  obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
>  obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
>  obj-$(CONFIG_S3C_DEV_NAND)	+= dev-nand.o
> +obj-$(CONFIG_S3C_DEV_RTC)	+= dev-rtc.o
>  
>  # DMA support
>  
> diff --git a/arch/arm/mach-s3c64xx/dev-rtc.c b/arch/arm/plat-samsung/dev-rtc.c
> similarity index 58%
> rename from arch/arm/mach-s3c64xx/dev-rtc.c
> rename to arch/arm/plat-samsung/dev-rtc.c
> index b9e7a05..bf4e226 100644
> --- a/arch/arm/mach-s3c64xx/dev-rtc.c
> +++ b/arch/arm/plat-samsung/dev-rtc.c
> @@ -1,4 +1,4 @@
> -/* linux/arch/arm/plat-s3c64xx/dev-rtc.c
> +/* linux/arch/arm/plat-samsung/dev-rtc.c
>   *
>   * Copyright 2009 by Maurus Cuelenaere <mcuelenaere@gmail.com>
>   *
> @@ -18,26 +18,26 @@
>  
>  static struct resource s3c_rtc_resource[] = {
>  	[0] = {
> -		.start = S3C64XX_PA_RTC,
> -		.end   = S3C64XX_PA_RTC + 0xff,
> -		.flags = IORESOURCE_MEM,
> +		.start	= S3C_PA_RTC,
> +		.end	= S3C_PA_RTC + 0xff,
> +		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -		.start = IRQ_RTC_ALARM,
> -		.end   = IRQ_RTC_ALARM,
> -		.flags = IORESOURCE_IRQ,
> +		.start	= IRQ_RTC_ALARM,
> +		.end	= IRQ_RTC_ALARM,
> +		.flags	= IORESOURCE_IRQ,
>  	},
>  	[2] = {
> -		.start = IRQ_RTC_TIC,
> -		.end   = IRQ_RTC_TIC,
> -		.flags = IORESOURCE_IRQ
> +		.start	= IRQ_RTC_TIC,
> +		.end	= IRQ_RTC_TIC,
> +		.flags	= IORESOURCE_IRQ
>  	}
>  };
>  
>  struct platform_device s3c_device_rtc = {
> -	.name		  = "s3c64xx-rtc",
> -	.id		  = -1,
> -	.num_resources	  = ARRAY_SIZE(s3c_rtc_resource),
> -	.resource	  = s3c_rtc_resource,
> +	.name		= "s3c64xx-rtc",
> +	.id		= -1,
> +	.num_resources	= ARRAY_SIZE(s3c_rtc_resource),
> +	.resource	= s3c_rtc_resource,
>  };
>  EXPORT_SYMBOL(s3c_device_rtc);
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
