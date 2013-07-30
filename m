From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 30 Jul 2013 14:21:00 -0700
Subject: [PATCH 08/11] clk: tegra114: add suspend/resume function for
 tegar_cpu_car_ops
In-Reply-To: <1372152475-18617-9-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-9-git-send-email-josephl@nvidia.com>
Message-ID: <20130730212100.5270.53947@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Joseph Lo (2013-06-25 02:27:52)
> Adding suspend/resume function for tegra_cpu_car_ops. We only save and
> restore the setting of the clock of CoreSight. Other clocks still need
> to be taken care by clock driver.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>

Change looks OK to me, besides Stephen's comments. I was waiting for a
V2 to hit the list but I never saw it. Any plans?

Regards,
Mike

> ---
>  drivers/clk/tegra/clk-tegra114.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
> index dbd0428..cd51d75 100644
> --- a/drivers/clk/tegra/clk-tegra114.c
> +++ b/drivers/clk/tegra/clk-tegra114.c
> @@ -258,6 +258,12 @@
>  #define PMC_PLLM_WB0_OVERRIDE 0x1dc
>  #define PMC_PLLM_WB0_OVERRIDE_2 0x2b0
>  
> +#ifdef CONFIG_PM_SLEEP
> +static struct cpu_clk_suspend_context {
> +       u32 clk_csite_src;
> +} tegra114_cpu_clk_sctx;
> +#endif
> +
>  static int periph_clk_enb_refcnt[CLK_OUT_ENB_NUM * 32];
>  
>  static void __iomem *clk_base;
> @@ -2107,9 +2113,29 @@ static void tegra114_disable_cpu_clock(u32 cpu)
>         /* flow controller would take care in the power sequence. */
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static void tegra114_cpu_clock_suspend(void)
> +{
> +       /* switch coresite to clk_m, save off original source */
> +       tegra114_cpu_clk_sctx.clk_csite_src =
> +                               readl(clk_base + CLK_SOURCE_CSITE);
> +       writel(3<<30, clk_base + CLK_SOURCE_CSITE);
> +}
> +
> +static void tegra114_cpu_clock_resume(void)
> +{
> +       writel(tegra114_cpu_clk_sctx.clk_csite_src,
> +                                       clk_base + CLK_SOURCE_CSITE);
> +}
> +#endif
> +
>  static struct tegra_cpu_car_ops tegra114_cpu_car_ops = {
>         .wait_for_reset = tegra114_wait_cpu_in_reset,
>         .disable_clock  = tegra114_disable_cpu_clock,
> +#ifdef CONFIG_PM_SLEEP
> +       .suspend        = tegra114_cpu_clock_suspend,
> +       .resume         = tegra114_cpu_clock_resume,
> +#endif
>  };
>  
>  static const struct of_device_id pmc_match[] __initconst = {
> -- 
> 1.8.3.1
