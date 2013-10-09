From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 9 Oct 2013 17:26:22 +0800
Subject: [PATCH 1/7] clk: tegra124: add suspend/resume function for
 tegra_cpu_car_ops
In-Reply-To: <1381310411-11391-2-git-send-email-josephl@nvidia.com>
References: <1381310411-11391-1-git-send-email-josephl@nvidia.com>
 <1381310411-11391-2-git-send-email-josephl@nvidia.com>
Message-ID: <1381310782.2200.6.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-10-09 at 17:20 +0800, Joseph Lo wrote:
> Adding suspend/resume function for tegra_cpu_car_ops. We only save and
> restore the setting of the clock of CoreSight. Other clocks still need
> to be taken care by clock driver.
> 
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
Sorry.
I forgot to mention this series depends on the patch series below.
[PATCH 0/5] Tegra124 clock support
[PATCH 1/4] clk: tegra124: add wait_for_reset and disable_clock for
tegra_cpu_car_ops

>  drivers/clk/tegra/clk-tegra124.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-tegra124.c b/drivers/clk/tegra/clk-tegra124.c
> index c1c9330..66eb1f8a 100644
> --- a/drivers/clk/tegra/clk-tegra124.c
> +++ b/drivers/clk/tegra/clk-tegra124.c
> @@ -28,6 +28,7 @@
>  #include "clk.h"
>  #include "clk-id.h"
>  
> +#define CLK_SOURCE_CSITE 0x1d4
>  #define CLK_SOURCE_EMC 0x19c
>  #define CLK_SOURCE_XUSB_SS_SRC 0x610
>  
> @@ -109,6 +110,12 @@
>  /* Tegra CPU clock and reset control regs */
>  #define CLK_RST_CONTROLLER_CPU_CMPLX_STATUS	0x470
>  
> +#ifdef CONFIG_PM_SLEEP
> +static struct cpu_clk_suspend_context {
> +	u32 clk_csite_src;
> +} tegra124_cpu_clk_sctx;
> +#endif
> +
>  static void __iomem *clk_base;
>  static void __iomem *pmc_base;
>  
> @@ -1139,9 +1146,29 @@ static void tegra124_disable_cpu_clock(u32 cpu)
>  	/* flow controller would take care in the power sequence. */
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static void tegra124_cpu_clock_suspend(void)
> +{
> +	/* switch coresite to clk_m, save off original source */
> +	tegra124_cpu_clk_sctx.clk_csite_src =
> +				readl(clk_base + CLK_SOURCE_CSITE);
> +	writel(3 << 30, clk_base + CLK_SOURCE_CSITE);
> +}
> +
> +static void tegra124_cpu_clock_resume(void)
> +{
> +	writel(tegra124_cpu_clk_sctx.clk_csite_src,
> +				clk_base + CLK_SOURCE_CSITE);
> +}
> +#endif
> +
>  static struct tegra_cpu_car_ops tegra124_cpu_car_ops = {
>  	.wait_for_reset	= tegra124_wait_cpu_in_reset,
>  	.disable_clock	= tegra124_disable_cpu_clock,
> +#ifdef CONFIG_PM_SLEEP
> +	.suspend	= tegra124_cpu_clock_suspend,
> +	.resume		= tegra124_cpu_clock_resume,
> +#endif
>  };
>  
>  static const struct of_device_id pmc_match[] __initconst = {
