From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 26 Nov 2015 13:38:25 +0100
Subject: [PATCH v3] clk: rockchip: switch PLLs to slow mode before reboot
 for rk3288
In-Reply-To: <1447225799-23996-1-git-send-email-zyw@rock-chips.com>
References: <1447225799-23996-1-git-send-email-zyw@rock-chips.com>
Message-ID: <24978828.KbpsHhykTc@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Mittwoch, 11. November 2015, 15:09:59 schrieb Chris Zhong:
> We've been seeing some crashes at reboot test on rk3288-based systems,
> which boards have not reset pin connected to NPOR, they reboot by
> setting 0xfdb9 to RK3288_GLB_SRST_FST register. If the APLL works in
> a high frequency mode, some IPs might hang during soft reset.
> It appears that we can fix the problem by switching to slow mode before
> reboot, just like what we did before suspend.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> ---
> 
> Changes in v3:
> remove include reboot.h
> 
> Changes in v2:
> replace restart_handlers with the shutdown callback of syscore
> 
>  drivers/clk/rockchip/clk-rk3288.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c
> b/drivers/clk/rockchip/clk-rk3288.c index 9040878..3002d7d 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -783,9 +783,9 @@ static const char *const rk3288_critical_clocks[]
> __initconst = { "pclk_pd_pmu",
>  };
> 
> -#ifdef CONFIG_PM_SLEEP
>  static void __iomem *rk3288_cru_base;
> 
> +#ifdef CONFIG_PM_SLEEP
>  /* Some CRU registers will be reset in maskrom when the system
>   * wakes up from fastboot.
>   * So save them before suspend, restore them after resume.
> @@ -839,34 +839,32 @@ static void rk3288_clk_resume(void)
>  			       rk3288_cru_base + reg_id);
>  	}
>  }
> +#endif
> 
> -static struct syscore_ops rk3288_clk_syscore_ops = {
> -	.suspend = rk3288_clk_suspend,
> -	.resume = rk3288_clk_resume,
> -};
> -
> -static void rk3288_clk_sleep_init(void __iomem *reg_base)
> +static void rk3288_clk_shutdown(void)
>  {
> -	rk3288_cru_base = reg_base;
> -	register_syscore_ops(&rk3288_clk_syscore_ops);
> +	writel_relaxed(0xf3030000, rk3288_cru_base + RK3288_MODE_CON);
>  }
> 
> -#else /* CONFIG_PM_SLEEP */
> -static void rk3288_clk_sleep_init(void __iomem *reg_base) {}
> +static struct syscore_ops rk3288_clk_syscore_ops = {
> +#ifdef CONFIG_PM_SLEEP

I think we can get rid of these CONFIG_PM_SLEEP conditionals completely.
It protected against registering the syscore_ops if sleep is disabled, as we 
were only using these. But now the sleep-related functions will simply not be 
called, but it doesn't hurt to register the syscore_ops with them included.

And it makes the code look cleaner I think :-)


Heiko

> +	.suspend = rk3288_clk_suspend,
> +	.resume = rk3288_clk_resume,
>  #endif
> +	.shutdown = rk3288_clk_shutdown,
> +};
> 
>  static void __init rk3288_clk_init(struct device_node *np)
>  {
> -	void __iomem *reg_base;
>  	struct clk *clk;
> 
> -	reg_base = of_iomap(np, 0);
> -	if (!reg_base) {
> +	rk3288_cru_base = of_iomap(np, 0);
> +	if (!rk3288_cru_base) {
>  		pr_err("%s: could not map cru region\n", __func__);
>  		return;
>  	}
> 
> -	rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
> +	rockchip_clk_init(np, rk3288_cru_base, CLK_NR_CLKS);
> 
>  	/* xin12m is created by an cru-internal divider */
>  	clk = clk_register_fixed_factor(NULL, "xin12m", "xin24m", 0, 1, 2);
> @@ -907,10 +905,13 @@ static void __init rk3288_clk_init(struct device_node
> *np) &rk3288_cpuclk_data, rk3288_cpuclk_rates,
>  			ARRAY_SIZE(rk3288_cpuclk_rates));
> 
> -	rockchip_register_softrst(np, 12, reg_base + RK3288_SOFTRST_CON(0),
> +	rockchip_register_softrst(np, 12,
> +				  rk3288_cru_base + RK3288_SOFTRST_CON(0),
>  				  ROCKCHIP_SOFTRST_HIWORD_MASK);
> 
>  	rockchip_register_restart_notifier(RK3288_GLB_SRST_FST);
> -	rk3288_clk_sleep_init(reg_base);
> +
> +	register_syscore_ops(&rk3288_clk_syscore_ops);
> +;
>  }
>  CLK_OF_DECLARE(rk3288_cru, "rockchip,rk3288-cru", rk3288_clk_init);
