From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 07 Oct 2011 12:09:55 +0200
Subject: [PATCH 1/2] sam9g45: add trng clock and platform device
In-Reply-To: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
References: <1317915694-27564-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <4E8ECFF3.7010305@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2011 05:41 PM, Peter Korsgaard :
> For the new hw_random driver.
> 
> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I add it to at91-l2 and at91-next branches of:
git://github.com/at91linux/linux-at91.git

Thanks,

> ---
>  arch/arm/mach-at91/at91sam9g45.c         |    7 +++++++
>  arch/arm/mach-at91/at91sam9g45_devices.c |   29 +++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index 6da8ace..6850f1d 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -54,6 +54,11 @@ static struct clk pioDE_clk = {
>  	.pmc_mask	= 1 << AT91SAM9G45_ID_PIODE,
>  	.type		= CLK_TYPE_PERIPHERAL,
>  };
> +static struct clk trng_clk = {
> +	.name		= "trng_clk",
> +	.pmc_mask	= 1 << AT91SAM9G45_ID_TRNG,
> +	.type		= CLK_TYPE_PERIPHERAL,
> +};
>  static struct clk usart0_clk = {
>  	.name		= "usart0_clk",
>  	.pmc_mask	= 1 << AT91SAM9G45_ID_US0,
> @@ -177,6 +182,7 @@ static struct clk *periph_clocks[] __initdata = {
>  	&pioB_clk,
>  	&pioC_clk,
>  	&pioDE_clk,
> +	&trng_clk,
>  	&usart0_clk,
>  	&usart1_clk,
>  	&usart2_clk,
> @@ -216,6 +222,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.1", &tcb0_clk),
>  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
>  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "atmel-trng", &trng_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
>  };
> diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
> index 2ee20bd..1ca6c62 100644
> --- a/arch/arm/mach-at91/at91sam9g45_devices.c
> +++ b/arch/arm/mach-at91/at91sam9g45_devices.c
> @@ -1101,6 +1101,34 @@ static void __init at91_add_device_rtt(void)
>  
>  
>  /* --------------------------------------------------------------------
> + *  TRNG
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_HW_RANDOM_ATMEL) || defined(CONFIG_HW_RANDOM_ATMEL_MODULE)
> +static struct resource trng_resources[] = {
> +	{
> +		.start	= AT91SAM9G45_BASE_TRNG,
> +		.end	= AT91SAM9G45_BASE_TRNG + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device at91sam9g45_trng_device = {
> +	.name		= "atmel-trng",
> +	.id		= -1,
> +	.resource	= trng_resources,
> +	.num_resources	= ARRAY_SIZE(trng_resources),
> +};
> +
> +static void __init at91_add_device_trng(void)
> +{
> +	platform_device_register(&at91sam9g45_trng_device);
> +}
> +#else
> +static void __init at91_add_device_trng(void) {}
> +#endif
> +
> +/* --------------------------------------------------------------------
>   *  Watchdog
>   * -------------------------------------------------------------------- */
>  
> @@ -1589,6 +1617,7 @@ static int __init at91_add_standard_devices(void)
>  	at91_add_device_hdmac();
>  	at91_add_device_rtc();
>  	at91_add_device_rtt();
> +	at91_add_device_trng();
>  	at91_add_device_watchdog();
>  	at91_add_device_tc();
>  	return 0;


-- 
Nicolas Ferre
