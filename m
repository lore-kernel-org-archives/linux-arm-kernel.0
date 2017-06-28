From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 28 Jun 2017 17:59:53 +0200
Subject: [PATCH] clocksource: timer-u300: Unmap region and unprepare clk
 obtained by of_iomap/clk_prepare_enable.
In-Reply-To: <4f413218d177cde9760f222329fde91b56797843.1498635400.git.arvind.yadav.cs@gmail.com>
References: <4f413218d177cde9760f222329fde91b56797843.1498635400.git.arvind.yadav.cs@gmail.com>
Message-ID: <20170628155953.GF2479@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 01:08:16PM +0530, arvind Yadav wrote:
> In case of error at init time, rollback iomapping and unprepare clk.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Hi Arvind,

thanks for the fixes. However, I would prefer you have a look at the timer-of
[1] code and convert the drivers to use it?[2], so the rollback and error catching
will be already handled properly.

Thanks

  -- Daniel

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=dc11bae78529526605c5c45c369c9512fd012093

[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=239751edad27d4fae964fb1f4ca1fedd742c8365

> ---
>  drivers/clocksource/timer-u300.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
> index 704e40c..e3b29ae 100644
> --- a/drivers/clocksource/timer-u300.c
> +++ b/drivers/clocksource/timer-u300.c
> @@ -376,19 +376,22 @@ static int __init u300_timer_init_of(struct device_node *np)
>  	irq = irq_of_parse_and_map(np, 2);
>  	if (!irq) {
>  		pr_err("no IRQ for system timer\n");
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto err_iounmap;
>  	}
>  
>  	pr_info("U300 GP1 timer @ base: %p, IRQ: %u\n", u300_timer_base, irq);
>  
>  	/* Clock the interrupt controller */
>  	clk = of_clk_get(np, 0);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto err_iounmap;
> +	}
>  
>  	ret = clk_prepare_enable(clk);
>  	if (ret)
> -		return ret;
> +		goto err_iounmap;
>  
>  	rate = clk_get_rate(clk);
>  
> @@ -422,7 +425,7 @@ static int __init u300_timer_init_of(struct device_node *np)
>  	/* Set up the IRQ handler */
>  	ret = setup_irq(irq, &u300_timer_irq);
>  	if (ret)
> -		return ret;
> +		goto err_unprepare;
>  
>  	/* Reset the General Purpose timer 2 */
>  	writel(U300_TIMER_APP_RGPT2_TIMER_RESET,
> @@ -444,7 +447,7 @@ static int __init u300_timer_init_of(struct device_node *np)
>  				    "GPT2", rate, 300, 32, clocksource_mmio_readl_up);
>  	if (ret) {
>  		pr_err("timer: failed to initialize U300 clock source\n");
> -		return ret;
> +		goto err_unprepare;
>  	}
>  
>  	/* Configure and register the clockevent */
> @@ -456,6 +459,12 @@ static int __init u300_timer_init_of(struct device_node *np)
>  	 * used by hrtimers!
>  	 */
>  	return 0;
> +
> +err_unprepare:
> +	clk_disable_unprepare(clk);
> +err_iounmap:
> +	iounmap(u300_timer_base);
> +	return ret;
>  }
>  
>  CLOCKSOURCE_OF_DECLARE(u300_timer, "stericsson,u300-apptimer",
> -- 
> 1.9.1
> 

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
