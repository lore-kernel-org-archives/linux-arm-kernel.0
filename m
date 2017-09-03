From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Sun, 3 Sep 2017 19:58:56 +0200
Subject: [PATCH v2 3/4] ARM: ep93xx: tidy up TS-72xx Watchdog resources
In-Reply-To: <20170903174347.6148-4-f.fainelli@gmail.com>
References: <20170903174347.6148-1-f.fainelli@gmail.com>
 <20170903174347.6148-4-f.fainelli@gmail.com>
Message-ID: <9ad376d2-d7bf-d784-3a71-890d6803db06@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 03/09/17 19:43, Florian Fainelli wrote:
> From: H Hartley Sweeten <hsweeten@visionengravers.com>
> 
> The ts-72xx watchdog uses two byte sized registers. Tidy up the resource
> declaration so that the proper information is shown in /proc/iomem.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 20 +++++++++-----------
>  arch/arm/mach-ep93xx/ts72xx.h |  3 ---
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 55b186ef863a..55ca3b375952 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -186,24 +186,22 @@ static struct platform_device ts72xx_rtc_device = {
>  	.num_resources 	= ARRAY_SIZE(ts72xx_rtc_resources),
>  };
>  
> +/*************************************************************************
> + * Watchdog (in CPLD)
> + *************************************************************************/
> +#define TS72XX_WDT_CONTROL_PHYS_BASE	(EP93XX_CS2_PHYS_BASE + 0x03800000)
> +#define TS72XX_WDT_FEED_PHYS_BASE	(EP93XX_CS2_PHYS_BASE + 0x03c00000)
> +
>  static struct resource ts72xx_wdt_resources[] = {
> -	{
> -		.start	= TS72XX_WDT_CONTROL_PHYS_BASE,
> -		.end	= TS72XX_WDT_CONTROL_PHYS_BASE + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	{
> -		.start	= TS72XX_WDT_FEED_PHYS_BASE,
> -		.end	= TS72XX_WDT_FEED_PHYS_BASE + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> +	DEFINE_RES_MEM(TS72XX_WDT_CONTROL_PHYS_BASE, 0x01),
> +	DEFINE_RES_MEM(TS72XX_WDT_FEED_PHYS_BASE, 0x01),
>  };
>  
>  static struct platform_device ts72xx_wdt_device = {
>  	.name		= "ts72xx-wdt",
>  	.id		= -1,
> -	.num_resources 	= ARRAY_SIZE(ts72xx_wdt_resources),
>  	.resource	= ts72xx_wdt_resources,
> +	.num_resources	= ARRAY_SIZE(ts72xx_wdt_resources),
>  };
>  
>  static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
> diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
> index 2255ba29fdd6..4e6519b2a3c4 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.h
> +++ b/arch/arm/mach-ep93xx/ts72xx.h
> @@ -38,9 +38,6 @@
>  #define TS72XX_OPTIONS2_TS9420		0x04
>  #define TS72XX_OPTIONS2_TS9420_BOOT	0x02
>  
> -#define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
> -#define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
> -
>  #ifndef __ASSEMBLY__
>  
>  static inline int ts72xx_model(void)
