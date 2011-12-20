From: marek.vasut@gmail.com (Marek Vasut)
Date: Tue, 20 Dec 2011 14:44:40 +0100
Subject: [PATCH 02/12] arm/mxs: convert platform code to
 clk_prepare/clk_unprepare
In-Reply-To: <1324382443-4439-3-git-send-email-shawn.guo@linaro.org>
References: <1324382443-4439-1-git-send-email-shawn.guo@linaro.org>
 <1324382443-4439-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <201112201444.40509.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The patch converts mxs platform code to clk_prepare/clk_unprepare
> by using helper functions clk_prepare_enable/clk_disable_unprepare.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/mach-mxs/clock-mx23.c   |   10 +++++-----
>  arch/arm/mach-mxs/clock-mx28.c   |   10 +++++-----
>  arch/arm/mach-mxs/clock.c        |    2 +-
>  arch/arm/mach-mxs/mach-mx28evk.c |    2 +-
>  arch/arm/mach-mxs/system.c       |    2 +-
>  arch/arm/mach-mxs/timer.c        |    2 +-
>  6 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/clock-mx23.c
> b/arch/arm/mach-mxs/clock-mx23.c index 0163b6d..e12e112 100644
> --- a/arch/arm/mach-mxs/clock-mx23.c
> +++ b/arch/arm/mach-mxs/clock-mx23.c
> @@ -545,11 +545,11 @@ int __init mx23_clocks_init(void)
>  	 */
>  	clk_set_parent(&ssp_clk, &ref_io_clk);
> 
> -	clk_enable(&cpu_clk);
> -	clk_enable(&hbus_clk);
> -	clk_enable(&xbus_clk);
> -	clk_enable(&emi_clk);
> -	clk_enable(&uart_clk);
> +	clk_prepare_enable(&cpu_clk);
> +	clk_prepare_enable(&hbus_clk);
> +	clk_prepare_enable(&xbus_clk);
> +	clk_prepare_enable(&emi_clk);
> +	clk_prepare_enable(&uart_clk);
> 
>  	clkdev_add_table(lookups, ARRAY_SIZE(lookups));
> 
> diff --git a/arch/arm/mach-mxs/clock-mx28.c
> b/arch/arm/mach-mxs/clock-mx28.c index da6e4aa..f85f1f5 100644
> --- a/arch/arm/mach-mxs/clock-mx28.c
> +++ b/arch/arm/mach-mxs/clock-mx28.c
> @@ -775,11 +775,11 @@ int __init mx28_clocks_init(void)
>  	clk_set_parent(&ssp0_clk, &ref_io0_clk);
>  	clk_set_parent(&ssp1_clk, &ref_io0_clk);
> 
> -	clk_enable(&cpu_clk);
> -	clk_enable(&hbus_clk);
> -	clk_enable(&xbus_clk);
> -	clk_enable(&emi_clk);
> -	clk_enable(&uart_clk);
> +	clk_prepare_enable(&cpu_clk);
> +	clk_prepare_enable(&hbus_clk);
> +	clk_prepare_enable(&xbus_clk);
> +	clk_prepare_enable(&emi_clk);
> +	clk_prepare_enable(&uart_clk);
> 
>  	clk_set_parent(&lcdif_clk, &ref_pix_clk);
>  	clk_set_parent(&saif0_clk, &pll0_clk);
> diff --git a/arch/arm/mach-mxs/clock.c b/arch/arm/mach-mxs/clock.c
> index a7093c8..755eec0 100644
> --- a/arch/arm/mach-mxs/clock.c
> +++ b/arch/arm/mach-mxs/clock.c
> @@ -166,7 +166,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>  		return ret;
> 
>  	if (clk->usecount)
> -		clk_enable(parent);
> +		clk_prepare_enable(parent);
> 
>  	mutex_lock(&clocks_mutex);
>  	ret = clk->set_parent(clk, parent);
> diff --git a/arch/arm/mach-mxs/mach-mx28evk.c
> b/arch/arm/mach-mxs/mach-mx28evk.c index 064ec5a..6b9e83e 100644
> --- a/arch/arm/mach-mxs/mach-mx28evk.c
> +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> @@ -228,7 +228,7 @@ static void __init mx28evk_fec_reset(void)
>  	/* Enable fec phy clock */
>  	clk = clk_get_sys("pll2", NULL);
>  	if (!IS_ERR(clk))
> -		clk_enable(clk);
> +		clk_prepare_enable(clk);
> 
>  	/* Power up fec phy */
>  	ret = gpio_request(MX28EVK_FEC_PHY_POWER, "fec-phy-power");
> diff --git a/arch/arm/mach-mxs/system.c b/arch/arm/mach-mxs/system.c
> index 20ec3bd..9760a12 100644
> --- a/arch/arm/mach-mxs/system.c
> +++ b/arch/arm/mach-mxs/system.c
> @@ -66,7 +66,7 @@ static int __init mxs_arch_reset_init(void)
> 
>  	clk = clk_get_sys("rtc", NULL);
>  	if (!IS_ERR(clk))
> -		clk_enable(clk);
> +		clk_prepare_enable(clk);
> 

I still wonder how to handle the DUART -- amba-pl011 -- maybe we should toggle 
the clock here too ?

M

>  	return 0;
>  }
> diff --git a/arch/arm/mach-mxs/timer.c b/arch/arm/mach-mxs/timer.c
> index cace0d2..564a632 100644
> --- a/arch/arm/mach-mxs/timer.c
> +++ b/arch/arm/mach-mxs/timer.c
> @@ -245,7 +245,7 @@ static int __init mxs_clocksource_init(struct clk
> *timer_clk)
> 
>  void __init mxs_timer_init(struct clk *timer_clk, int irq)
>  {
> -	clk_enable(timer_clk);
> +	clk_prepare_enable(timer_clk);
> 
>  	/*
>  	 * Initialize timers to a known state
