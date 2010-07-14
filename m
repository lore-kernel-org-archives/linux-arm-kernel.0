From: rabin@rab.in (Rabin Vincent)
Date: Thu, 15 Jul 2010 00:33:11 +0530
Subject: [PATCH] RFC: U300 clock updates to match PrimeCell clocking
In-Reply-To: <1279065807-22238-1-git-send-email-linus.walleij@stericsson.com>
References: <1279065807-22238-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100714190311.GA18649@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(corrected lakml address)

On Wed, Jul 14, 2010 at 02:03:27AM +0200, Linus Walleij wrote:
> This makes the U300 architecture use the PrimeCell (AMBA) bus
> clocking method suggested by Russell King. Since the bus will
> now clock itself, we can remove the special PrimeCell clocking
> hooks in the clock file.

In order to be able to remove your clock enabling around the
amba_device_register() calls, the busclk get/enabling would need to be
also added around the peripheral ID read in amba_device_register(), not
just before the probe call, where Russell's patch added it.

Rabin

> ---
>  arch/arm/mach-u300/clock.c |   56 +++++++++++---------------------------------
>  arch/arm/mach-u300/clock.h |    2 -
>  arch/arm/mach-u300/core.c  |    2 -
>  3 files changed, 14 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
> index 5af71d5..5c7c90e 100644
> --- a/arch/arm/mach-u300/clock.c
> +++ b/arch/arm/mach-u300/clock.c
> @@ -1218,6 +1218,13 @@ static struct clk ppm_clk = {
>  	.clk = clkref,				\
>  	}
>  
> +#define DEF_LOOKUP_PRECISE(devid, conid, clkref) \
> +	{					\
> +	.dev_id = devid,			\
> +	.con_id = conid,			\
> +	.clk = clkref,				\
> +	}
> +
>  /*
>   * Here we only define clocks that are meaningful to
>   * look up through clockdevice.
> @@ -1240,12 +1247,14 @@ static struct clk_lookup lookups[] = {
>  	DEF_LOOKUP("ahb",       &ahb_clk),
>  	/* AHB bridge clocks */
>  	DEF_LOOKUP("ahb_subsys", &ahb_subsys_clk),
> -	DEF_LOOKUP("intcon",    &intcon_clk),
> +	DEF_LOOKUP_PRECISE("intcon", "ahb_pclk", &intcon_clk),
>  	DEF_LOOKUP("mspro",     &mspro_clk),
> -	DEF_LOOKUP("pl172",     &emif_clk),
> +	DEF_LOOKUP_PRECISE("mspro", "ahb_pclk", &mspro_clk),
> +	DEF_LOOKUP_PRECISE("pl172", "ahb_pclk", &emif_clk),
>  	/* FAST bridge clocks */
>  	DEF_LOOKUP("fast",      &fast_clk),
>  	DEF_LOOKUP("mmci",      &mmcsd_clk),
> +	DEF_LOOKUP_PRECISE("mmci", "ahb_pclk", &mmcsd_clk),
>  	/*
>  	 * The .0 and .1 identifiers on these comes from the platform device
>  	 * .id field and are assigned when the platform devices are registered.
> @@ -1255,13 +1264,16 @@ static struct clk_lookup lookups[] = {
>  	DEF_LOOKUP("stu300.0",  &i2c0_clk),
>  	DEF_LOOKUP("stu300.1",  &i2c1_clk),
>  	DEF_LOOKUP("pl022",     &spi_clk),
> +	DEF_LOOKUP_PRECISE("pl022", "ahb_pclk", &spi_clk),
>  #ifdef CONFIG_MACH_U300_BS335
>  	DEF_LOOKUP("uart1",     &uart1_clk),
> +	DEF_LOOKUP_PRECISE("uart1", "ahb_pclk", &uart1_clk),
>  #endif
>  	/* SLOW bridge clocks */
>  	DEF_LOOKUP("slow",      &slow_clk),
>  	DEF_LOOKUP("coh901327_wdog",      &wdog_clk),
>  	DEF_LOOKUP("uart0",     &uart_clk),
> +	DEF_LOOKUP_PRECISE("uart0", "ahb_pclk", &uart_clk),
>  	DEF_LOOKUP("apptimer",  &app_timer_clk),
>  	DEF_LOOKUP("coh901461-keypad",    &keypad_clk),
>  	DEF_LOOKUP("u300-gpio", &gpio_clk),
> @@ -1281,46 +1293,6 @@ static void __init clk_register(void)
>  }
>  
>  /*
> - * These are the clocks for cells registered as primecell drivers
> - * on the AMBA bus. These must be on during AMBA device registration
> - * since the bus probe will attempt to read magic configuration
> - * registers for these devices. If they are deactivated these probes
> - * will fail.
> - *
> - *
> - * Please note that on emif, both RAM and NAND is connected in dual
> - * RAM phones. On single RAM phones, ram is on semi and NAND on emif.
> - *
> - */
> -void u300_clock_primecells(void)
> -{
> -	clk_enable(&intcon_clk);
> -	clk_enable(&uart_clk);
> -#ifdef CONFIG_MACH_U300_BS335
> -	clk_enable(&uart1_clk);
> -#endif
> -	clk_enable(&spi_clk);
> -
> -	clk_enable(&mmcsd_clk);
> -
> -}
> -EXPORT_SYMBOL(u300_clock_primecells);
> -
> -void u300_unclock_primecells(void)
> -{
> -
> -	clk_disable(&intcon_clk);
> -	clk_disable(&uart_clk);
> -#ifdef CONFIG_MACH_U300_BS335
> -	clk_disable(&uart1_clk);
> -#endif
> -	clk_disable(&spi_clk);
> -	clk_disable(&mmcsd_clk);
> -
> -}
> -EXPORT_SYMBOL(u300_unclock_primecells);
> -
> -/*
>   * The interrupt controller is enabled before the clock API is registered.
>   */
>  void u300_enable_intcon_clock(void)
> diff --git a/arch/arm/mach-u300/clock.h b/arch/arm/mach-u300/clock.h
> index fc6d9cc..e5e096b 100644
> --- a/arch/arm/mach-u300/clock.h
> +++ b/arch/arm/mach-u300/clock.h
> @@ -45,8 +45,6 @@ struct clk {
>  	void (*disable) (struct clk *);
>  };
>  
> -void u300_clock_primecells(void);
> -void u300_unclock_primecells(void);
>  void u300_enable_intcon_clock(void);
>  void u300_enable_timer_clock(void);
>  
> diff --git a/arch/arm/mach-u300/core.c b/arch/arm/mach-u300/core.c
> index 5f34eb6..98e4639 100644
> --- a/arch/arm/mach-u300/core.c
> +++ b/arch/arm/mach-u300/core.c
> @@ -1642,12 +1642,10 @@ void __init u300_init_devices(void)
>  	u300_spi_init(&pl022_device);
>  
>  	/* Register the AMBA devices in the AMBA bus abstraction layer */
> -	u300_clock_primecells();
>  	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
>  		struct amba_device *d = amba_devs[i];
>  		amba_device_register(d, &iomem_resource);
>  	}
> -	u300_unclock_primecells();
>  
>  	u300_assign_physmem();
>  
> -- 
> 1.7.1
> 
