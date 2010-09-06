From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 7 Sep 2010 00:55:36 +0200
Subject: [PATCH 03/74] ST SPEAr: Formalized timer support
In-Reply-To: <eed779f7085ed5686aceb61b48a2c2a7d6af5953.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<eed779f7085ed5686aceb61b48a2c2a7d6af5953.1283161023.git.viresh.kumar@st.com>
Message-ID: <20100906225536.GD8153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>  
> -#endif
> +static void __init spear3xx_timer_init(void)
> +{
> +	spear_setup_timer();
why not call it directly?


> +}
> +
> +struct sys_timer spear3xx_timer = {
> +	.init = spear3xx_timer_init,
> +};
> diff --git a/arch/arm/mach-spear6xx/include/mach/generic.h b/arch/arm/mach-spear6xx/include/mach/generic.h
> index 16205a5..e5967ed 100644
> --- a/arch/arm/mach-spear6xx/include/mach/generic.h
> +++ b/arch/arm/mach-spear6xx/include/mach/generic.h
> @@ -31,9 +31,10 @@
>  /* Add spear6xx family device structure declarations here */
>  extern struct amba_device gpio_device[];
>  extern struct amba_device uart_device[];
> -extern struct sys_timer spear_sys_timer;
> +extern struct sys_timer spear6xx_timer;
>  
>  /* Add spear6xx family function declarations here */
> +void __init spear_setup_timer(void);
>  void __init spear6xx_map_io(void);
>  void __init spear6xx_init_irq(void);
>  void __init spear6xx_init(void);
> diff --git a/arch/arm/mach-spear6xx/spear600_evb.c b/arch/arm/mach-spear6xx/spear600_evb.c
> index daff8d0..bdd5b76 100644
> --- a/arch/arm/mach-spear6xx/spear600_evb.c
> +++ b/arch/arm/mach-spear6xx/spear600_evb.c
> @@ -42,10 +42,11 @@ static void __init spear600_evb_init(void)
>  		amba_device_register(amba_devs[i], &iomem_resource);
>  }
>  
> +
please remove
>  MACHINE_START(SPEAR600, "ST-SPEAR600-EVB")
>  	.boot_params	=	0x00000100,
>  	.map_io		=	spear6xx_map_io,
>  	.init_irq	=	spear6xx_init_irq,
> -	.timer		=	&spear_sys_timer,
> +	.timer		=	&spear6xx_timer,
>  	.init_machine	=	spear600_evb_init,
>  MACHINE_END
> diff --git a/arch/arm/mach-spear6xx/spear6xx.c b/arch/arm/mach-spear6xx/spear6xx.c
> index baf6bcc..88a82ca 100644
> --- a/arch/arm/mach-spear6xx/spear6xx.c
> +++ b/arch/arm/mach-spear6xx/spear6xx.c
> @@ -155,3 +155,12 @@ void __init spear6xx_map_io(void)
>  	/* This will initialize clock framework */
>  	clk_init();
>  }
> +
> +static void __init spear6xx_timer_init(void)
> +{
> +	spear_setup_timer();
> +}
> +
> +struct sys_timer spear6xx_timer = {
> +	.init = spear6xx_timer_init,
> +};
> diff --git a/arch/arm/plat-spear/time.c b/arch/arm/plat-spear/time.c
> index ab21165..850d0cf 100644
> --- a/arch/arm/plat-spear/time.c
> +++ b/arch/arm/plat-spear/time.c
> @@ -66,6 +66,13 @@
>  static __iomem void *gpt_base;
>  static struct clk *gpt_clk;
>  
> +/* following defines the parent clock to be used */
> +#ifdef CONFIG_ARCH_SPEAR13XX
> +static char pclk_name[] = "osc1_24m_clk";
> +#else
> +static char pclk_name[] = "pll3_48m_clk";
> +#endif
why 2 name?
it will be better to use clkdev and create an alias
btw how about move the timer to drivers/clocksource?
> +
>  static void clockevent_set_mode(enum clock_event_mode mode,
>  				struct clock_event_device *clk_event_dev);
>  static int clockevent_next_event(unsigned long evt,
> @@ -215,7 +222,8 @@ static void __init spear_clockevent_init(void)
>  
>  void __init spear_setup_timer(void)
>  {
> -	struct clk *pll3_clk;
> +	struct clk *clk;
> +	int ret;
>  
>  	if (!request_mem_region(SPEAR_GPT0_BASE, SZ_1K, "gpt0")) {
>  		pr_err("%s:cannot get IO addr\n", __func__);
> @@ -234,26 +242,32 @@ void __init spear_setup_timer(void)
>  		goto err_iomap;
>  	}
>  
> -	pll3_clk = clk_get(NULL, "pll3_48m_clk");
> -	if (!pll3_clk) {
> -		pr_err("%s:couldn't get PLL3 as parent for gpt\n", __func__);
> +	/* get the parent clock */
> +	clk = clk_get(NULL, pclk_name);
> +
> +	if (!clk) {
> +		pr_err("%s:couldn't get %s as parent for gpt\n",
> +				__func__, pclk_name);
>  		goto err_iomap;
>  	}
>  
> -	clk_set_parent(gpt_clk, pll3_clk);
> +	clk_set_parent(gpt_clk, clk);
??
why not do this in the clock file?

Best Regards,
J.
