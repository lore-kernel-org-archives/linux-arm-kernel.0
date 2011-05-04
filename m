From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 05 May 2011 08:42:57 +1200
Subject: AT91: Convert WDT driver to be independent of processor
	base-address
In-Reply-To: <1304110090.14210.2.camel@redbox>
References: <1304110090.14210.2.camel@redbox>
Message-ID: <4DC1BA51.9080304@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/30/2011 08:48 AM, Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> following changes to the WDT driver support:
>  * pass base addresses via platform resources
>  * replace calls to at91_sys_read() / at91_sys_write()
>  * rename AT91_WDT to AT91xxx_WDT to denote they are processor-specific
> definitions.
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>

Acked-by: Ryan Mallon <ryan@bluewatersys.com>

> diff --git a/arch/arm/mach-at91/at572d940hf_devices.c b/arch/arm/mach-at91/at572d940hf_devices.c
> index a3534e3..9e7e513 100644
> --- a/arch/arm/mach-at91/at572d940hf_devices.c
> +++ b/arch/arm/mach-at91/at572d940hf_devices.c
> @@ -628,10 +628,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT572D940HF_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT572D940HF_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at572d940hf_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/at91cap9_devices.c b/arch/arm/mach-at91/at91cap9_devices.c
> index f20a31d..d7ba0f2 100644
> --- a/arch/arm/mach-at91/at91cap9_devices.c
> +++ b/arch/arm/mach-at91/at91cap9_devices.c
> @@ -698,10 +698,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT91CAP9_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT91CAP9_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at91cap9_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index fa783c7..652a2f9 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -740,10 +740,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT91SAM9260_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT91SAM9260_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at91sam9260_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index f8a6bc9..c0bfcb6 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -622,10 +622,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT91SAM9261_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT91SAM9261_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at91sam9261_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
> index 5a8fb39..575b843 100644
> --- a/arch/arm/mach-at91/at91sam9263_devices.c
> +++ b/arch/arm/mach-at91/at91sam9263_devices.c
> @@ -996,10 +996,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT91SAM9263_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT91SAM9263_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at91sam9263_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 464d7ff..c8d9094 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -1120,10 +1120,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT91SAM9G45_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT91SAM9G45_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at91sam9g45_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
> index 72effd4..08bc4fa 100644
> --- a/arch/arm/mach-at91/at91sam9rl_devices.c
> +++ b/arch/arm/mach-at91/at91sam9rl_devices.c
> @@ -726,10 +726,20 @@ static void __init at91_add_device_rtt(void)
>   * -------------------------------------------------------------------- */
>  
>  #if defined(CONFIG_AT91SAM9X_WATCHDOG) || defined(CONFIG_AT91SAM9X_WATCHDOG_MODULE)
> +
> +static struct resource wdt_resources[] = {
> +	{
> +		.start	= AT91_VA_BASE_SYS + AT91SAM9RL_WDT,
> +		.end	= AT91_VA_BASE_SYS + AT91SAM9RL_WDT + SZ_16 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	}
> +};
> +
>  static struct platform_device at91sam9rl_wdt_device = {
>  	.name		= "at91_wdt",
>  	.id		= -1,
> -	.num_resources	= 0,
> +	.resource	= wdt_resources,
> +	.num_resources	= ARRAY_SIZE(wdt_resources),
>  };
>  
>  static void __init at91_add_device_watchdog(void)
> diff --git a/arch/arm/mach-at91/include/mach/at572d940hf.h b/arch/arm/mach-at91/include/mach/at572d940hf.h
> index b714a84..e5aba13 100644
> --- a/arch/arm/mach-at91/include/mach/at572d940hf.h
> +++ b/arch/arm/mach-at91/include/mach/at572d940hf.h
> @@ -101,7 +101,7 @@
>  #define AT91_RSTC	(0xfffffd00 - AT91_BASE_SYS)
>  #define AT572D940HF_RTT		(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT572D940HF_WDT		(0xfffffd40 - AT91_BASE_SYS)
>  
>  #define AT91_USART0	AT572D940HF_ID_US0
>  #define AT91_USART1	AT572D940HF_ID_US1
> diff --git a/arch/arm/mach-at91/include/mach/at91_wdt.h b/arch/arm/mach-at91/include/mach/at91_wdt.h
> index fecc2e9..d4ec83a 100644
> --- a/arch/arm/mach-at91/include/mach/at91_wdt.h
> +++ b/arch/arm/mach-at91/include/mach/at91_wdt.h
> @@ -16,11 +16,11 @@
>  #ifndef AT91_WDT_H
>  #define AT91_WDT_H
>  
> -#define AT91_WDT_CR		(AT91_WDT + 0x00)	/* Watchdog Control Register */
> +#define AT91_WDT_CR		0x00	/* Watchdog Control Register */
>  #define		AT91_WDT_WDRSTT		(1    << 0)		/* Restart */
>  #define		AT91_WDT_KEY		(0xa5 << 24)		/* KEY Password */
>  
> -#define AT91_WDT_MR		(AT91_WDT + 0x04)	/* Watchdog Mode Register */
> +#define AT91_WDT_MR		0x04	/* Watchdog Mode Register */
>  #define		AT91_WDT_WDV		(0xfff << 0)		/* Counter Value */
>  #define		AT91_WDT_WDFIEN		(1     << 12)		/* Fault Interrupt Enable */
>  #define		AT91_WDT_WDRSTEN	(1     << 13)		/* Reset Processor */
> @@ -30,7 +30,7 @@
>  #define		AT91_WDT_WDDBGHLT	(1     << 28)		/* Debug Halt */
>  #define		AT91_WDT_WDIDLEHLT	(1     << 29)		/* Idle Halt */
>  
> -#define AT91_WDT_SR		(AT91_WDT + 0x08)	/* Watchdog Status Register */
> +#define AT91_WDT_SR		0x08	/* Watchdog Status Register */
>  #define		AT91_WDT_WDUNF		(1 << 0)		/* Watchdog Underflow */
>  #define		AT91_WDT_WDERR		(1 << 1)		/* Watchdog Error */
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91cap9.h b/arch/arm/mach-at91/include/mach/at91cap9.h
> index a1776a0..95876d5 100644
> --- a/arch/arm/mach-at91/include/mach/at91cap9.h
> +++ b/arch/arm/mach-at91/include/mach/at91cap9.h
> @@ -100,7 +100,7 @@
>  #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91CAP9_RTT	(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT91CAP9_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(cpu_is_at91cap9_revB() ?	\
>  			(0xfffffd50 - AT91_BASE_SYS) :	\
>  			(0xfffffd60 - AT91_BASE_SYS))
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9260.h b/arch/arm/mach-at91/include/mach/at91sam9260.h
> index 53e715a..3e35785 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9260.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9260.h
> @@ -98,7 +98,7 @@
>  #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91SAM9260_RTT		(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT91SAM9260_WDT		(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
>  
>  #define AT91_USART0	AT91SAM9260_BASE_US0
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9261.h b/arch/arm/mach-at91/include/mach/at91sam9261.h
> index 5e633ae..5ff812f 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9261.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9261.h
> @@ -81,7 +81,7 @@
>  #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91SAM9261_RTT		(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT91SAM9261_WDT		(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd50 - AT91_BASE_SYS)
>  
>  #define AT91_USART0	AT91SAM9261_BASE_US0
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9263.h b/arch/arm/mach-at91/include/mach/at91sam9263.h
> index c12514f..88994a2 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9263.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9263.h
> @@ -97,7 +97,7 @@
>  #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91SAM9263_RTT0	(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT91SAM9263_WDT		(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91SAM9263_RTT1	(0xfffffd50 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9g45.h b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> index 6c42060..f1bb0a7 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9g45.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9g45.h
> @@ -107,7 +107,7 @@
>  #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91SAM9G45_RTT		(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT91SAM9G45_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
>  #define AT91SAM9G45_RTC		(0xfffffdb0 - AT91_BASE_SYS)
>  
> diff --git a/arch/arm/mach-at91/include/mach/at91sam9rl.h b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> index 003e0b5..f153a77 100644
> --- a/arch/arm/mach-at91/include/mach/at91sam9rl.h
> +++ b/arch/arm/mach-at91/include/mach/at91sam9rl.h
> @@ -89,7 +89,7 @@
>  #define AT91_SHDWC	(0xfffffd10 - AT91_BASE_SYS)
>  #define AT91SAM9RL_RTT	(0xfffffd20 - AT91_BASE_SYS)
>  #define AT91_PIT	(0xfffffd30 - AT91_BASE_SYS)
> -#define AT91_WDT	(0xfffffd40 - AT91_BASE_SYS)
> +#define AT91SAM9RL_WDT	(0xfffffd40 - AT91_BASE_SYS)
>  #define AT91_SCKCR	(0xfffffd50 - AT91_BASE_SYS)
>  #define AT91_GPBR	(0xfffffd60 - AT91_BASE_SYS)
>  #define AT91SAM9RL_RTC	(0xfffffe00 - AT91_BASE_SYS)
> diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> index eac2602..a7a63e9 100644
> --- a/drivers/watchdog/at91sam9_wdt.c
> +++ b/drivers/watchdog/at91sam9_wdt.c
> @@ -67,6 +67,7 @@ static struct {
>  	unsigned long open;
>  	char expect_close;
>  	struct timer_list timer;	/* The timer that pings the watchdog */
> +	void __iomem *regbase;		/* base address of WDT */
>  } at91wdt_private;
>  
>  /* ......................................................................... */
> @@ -77,7 +78,8 @@ static struct {
>   */
>  static inline void at91_wdt_reset(void)
>  {
> -	at91_sys_write(AT91_WDT_CR, AT91_WDT_KEY | AT91_WDT_WDRSTT);
> +	__raw_writel(AT91_WDT_KEY | AT91_WDT_WDRSTT,
> +		at91wdt_private.regbase + AT91_WDT_CR);
>  }
>  
>  /*
> @@ -132,7 +134,7 @@ static int at91_wdt_settimeout(unsigned int timeout)
>  	unsigned int mr;
>  
>  	/* Check if disabled */
> -	mr = at91_sys_read(AT91_WDT_MR);
> +	mr = __raw_readl(at91wdt_private.regbase + AT91_WDT_MR);
>  	if (mr & AT91_WDT_WDDIS) {
>  		printk(KERN_ERR DRV_NAME": sorry, watchdog is disabled\n");
>  		return -EIO;
> @@ -149,7 +151,7 @@ static int at91_wdt_settimeout(unsigned int timeout)
>  		| AT91_WDT_WDDBGHLT	/* disabled in debug mode */
>  		| AT91_WDT_WDD		/* restart at any time */
>  		| (timeout & AT91_WDT_WDV);  /* timer value */
> -	at91_sys_write(AT91_WDT_MR, reg);
> +	__raw_writel(reg, at91wdt_private.regbase + AT91_WDT_MR);
>  
>  	return 0;
>  }
> @@ -248,11 +250,17 @@ static struct miscdevice at91wdt_miscdev = {
>  
>  static int __init at91wdt_probe(struct platform_device *pdev)
>  {
> +	struct resource	*r;
>  	int res;
>  
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!r)
> +		return -ENODEV;
> +
>  	if (at91wdt_miscdev.parent)
>  		return -EBUSY;
>  	at91wdt_miscdev.parent = &pdev->dev;
> +	at91wdt_private.regbase = (void __force __iomem *) r->start;
>  
>  	/* Set watchdog */
>  	res = at91_wdt_settimeout(ms_to_ticks(WDT_HW_TIMEOUT * 1000));
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
