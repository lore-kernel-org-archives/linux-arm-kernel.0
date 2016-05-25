From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 May 2016 10:31:54 +0200
Subject: [PATCH 2/3] clk: samsung: cpu: prepare for adding Exynos5433 CPU
 clocks
In-Reply-To: <1464095957-25851-3-git-send-email-b.zolnierkie@samsung.com>
References: <1464095957-25851-1-git-send-email-b.zolnierkie@samsung.com>
 <1464095957-25851-3-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <574562FA.1050103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 03:19 PM, Bartlomiej Zolnierkiewicz wrote:
> Exynos5433 uses different register layout for CPU clock registers
> than earlier SoCs so add new code for handling this layout.  Also
> add new CLK_CPU_HAS_E5433_REGS_LAYOUT flag to request using it.
> 
> There should be no functional change resulting from this patch.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/clk/samsung/clk-cpu.c | 131 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/clk/samsung/clk-cpu.h |   4 +-
>  2 files changed, 133 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
> index 813003d..8bf7e80 100644
> --- a/drivers/clk/samsung/clk-cpu.c
> +++ b/drivers/clk/samsung/clk-cpu.c
> @@ -45,6 +45,13 @@
>  #define E4210_DIV_STAT_CPU0	0x400
>  #define E4210_DIV_STAT_CPU1	0x404
>  
> +#define E5433_MUX_SEL2		0x008
> +#define E5433_MUX_STAT2		0x208
> +#define E5433_DIV_CPU0		0x400
> +#define E5433_DIV_CPU1		0x404
> +#define E5433_DIV_STAT_CPU0	0x500
> +#define E5433_DIV_STAT_CPU1	0x504

I got a problem matching it with datasheed. The base is 0x200?

> +
>  #define E4210_DIV0_RATIO0_MASK	0x7
>  #define E4210_DIV1_HPM_MASK	(0x7 << 4)
>  #define E4210_DIV1_COPY_MASK	(0x7 << 0)
> @@ -253,6 +260,102 @@ static int exynos_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
>  }
>  
>  /*
> + * Helper function to set the 'safe' dividers for the CPU clock. The parameters
> + * div and mask contain the divider value and the register bit mask of the
> + * dividers to be programmed.
> + */
> +static void exynos5433_set_safe_div(void __iomem *base, unsigned long div,
> +					unsigned long mask)

Please align the argument.

> +{
> +	unsigned long div0;
> +
> +	div0 = readl(base + E5433_DIV_CPU0);
> +	div0 = (div0 & ~mask) | (div & mask);
> +	writel(div0, base + E5433_DIV_CPU0);
> +	wait_until_divider_stable(base + E5433_DIV_STAT_CPU0, mask);
> +}
> +
> +/* handler for pre-rate change notification from parent clock */
> +static int exynos5433_cpuclk_pre_rate_change(struct clk_notifier_data *ndata,
> +			struct exynos_cpuclk *cpuclk, void __iomem *base)
> +{
> +	const struct exynos_cpuclk_cfg_data *cfg_data = cpuclk->cfg;
> +	unsigned long alt_prate = clk_get_rate(cpuclk->alt_parent);
> +	unsigned long alt_div = 0, alt_div_mask = DIV_MASK;
> +	unsigned long div0, div1 = 0, mux_reg;
> +	unsigned long flags;
> +
> +	/* find out the divider values to use for clock data */
> +	while ((cfg_data->prate * 1000) != ndata->new_rate) {
> +		if (cfg_data->prate == 0)
> +			return -EINVAL;
> +		cfg_data++;
> +	}
> +
> +	spin_lock_irqsave(cpuclk->lock, flags);
> +
> +	/*
> +	 * For the selected PLL clock frequency, get the pre-defined divider
> +	 * values.
> +	 */
> +	div0 = cfg_data->div0;
> +	div1 = cfg_data->div1;
> +
> +	/*
> +	 * If the old parent clock speed is less than the clock speed of
> +	 * the alternate parent, then it should be ensured that at no point
> +	 * the armclk speed is more than the old_prate until the dividers are
> +	 * set.  Also workaround the issue of the dividers being set to lower
> +	 * values before the parent clock speed is set to new lower speed
> +	 * (this can result in too high speed of armclk output clocks).

In entire sentence: s/speed/rate/

> +	 */
> +	if (alt_prate > ndata->old_rate || ndata->old_rate > ndata->new_rate) {
> +		unsigned long tmp_rate = min(ndata->old_rate, ndata->new_rate);
> +
> +		alt_div = DIV_ROUND_UP(alt_prate, tmp_rate) - 1;
> +		WARN_ON(alt_div >= MAX_DIV);
> +
> +		exynos5433_set_safe_div(base, alt_div, alt_div_mask);
> +		div0 |= alt_div;
> +	}
> +
> +	/* select the alternate parent */
> +	mux_reg = readl(base + E5433_MUX_SEL2);
> +	writel(mux_reg | 1, base + E5433_MUX_SEL2);
> +	wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 2);
> +
> +	/* alternate parent is active now. set the dividers */
> +	writel(div0, base + E5433_DIV_CPU0);
> +	wait_until_divider_stable(base + E5433_DIV_STAT_CPU0, DIV_MASK_ALL);
> +
> +	writel(div1, base + E5433_DIV_CPU1);
> +	wait_until_divider_stable(base + E5433_DIV_STAT_CPU1, DIV_MASK_ALL);
> +
> +	spin_unlock_irqrestore(cpuclk->lock, flags);

One blank line please.

> +	return 0;
> +}
> +
> +/* handler for post-rate change notification from parent clock */
> +static int exynos5433_cpuclk_post_rate_change(struct clk_notifier_data *ndata,
> +			struct exynos_cpuclk *cpuclk, void __iomem *base)
> +{
> +	unsigned long div = 0, div_mask = DIV_MASK;
> +	unsigned long mux_reg;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(cpuclk->lock, flags);
> +
> +	/* select apll as the alternate parent */
> +	mux_reg = readl(base + E5433_MUX_SEL2);
> +	writel(mux_reg & ~1, base + E5433_MUX_SEL2);
> +	wait_until_mux_stable(base + E5433_MUX_STAT2, 0, 1);
> +
> +	exynos5433_set_safe_div(base, div, div_mask);
> +	spin_unlock_irqrestore(cpuclk->lock, flags);

One blank line please.

> +	return 0;
> +}
> +
> +/*
>   * This notifier function is called for the pre-rate and post-rate change
>   * notifications of the parent clock of cpuclk.
>   */
> @@ -275,6 +378,29 @@ static int exynos_cpuclk_notifier_cb(struct notifier_block *nb,
>  	return notifier_from_errno(err);
>  }
>  
> +/*
> + * This notifier function is called for the pre-rate and post-rate change
> + * notifications of the parent clock of cpuclk.
> + */
> +static int exynos5433_cpuclk_notifier_cb(struct notifier_block *nb,
> +				unsigned long event, void *data)
> +{
> +	struct clk_notifier_data *ndata = data;
> +	struct exynos_cpuclk *cpuclk;
> +	void __iomem *base;
> +	int err = 0;
> +
> +	cpuclk = container_of(nb, struct exynos_cpuclk, clk_nb);
> +	base = cpuclk->ctrl_base;
> +
> +	if (event == PRE_RATE_CHANGE)
> +		err = exynos5433_cpuclk_pre_rate_change(ndata, cpuclk, base);
> +	else if (event == POST_RATE_CHANGE)
> +		err = exynos5433_cpuclk_post_rate_change(ndata, cpuclk, base);
> +
> +	return notifier_from_errno(err);
> +}

Entire function is a duplication of exynos_cpuclk_notifier_cb(), except
the {pre,post}_rate_change. How about checking the flags here and using
only one notifier? Overall the code should be smaller...

Another, more robust solution would be to define new members in:
struct exynos_cpuclk {
	int (pre_rate_change) *(....);
	int (post_rate_change) *(....);
}
This way the notifier_cb would be exactly the same for all implementations.

Best regards,
Krzysztof

> +
>  /* helper function to register a CPU clock */
>  int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>  		unsigned int lookup_id, const char *name, const char *parent,
> @@ -301,7 +427,10 @@ int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
>  	cpuclk->ctrl_base = ctx->reg_base + offset;
>  	cpuclk->lock = &ctx->lock;
>  	cpuclk->flags = flags;
> -	cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
> +	if (flags & CLK_CPU_HAS_E5433_REGS_LAYOUT)
> +		cpuclk->clk_nb.notifier_call = exynos5433_cpuclk_notifier_cb;
> +	else
> +		cpuclk->clk_nb.notifier_call = exynos_cpuclk_notifier_cb;
>  
>  	cpuclk->alt_parent = __clk_lookup(alt_parent);
>  	if (!cpuclk->alt_parent) {
> diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
> index 37874d3..d4b6b51 100644
> --- a/drivers/clk/samsung/clk-cpu.h
> +++ b/drivers/clk/samsung/clk-cpu.h
> @@ -57,10 +57,12 @@ struct exynos_cpuclk {
>  	struct notifier_block			clk_nb;
>  	unsigned long				flags;
>  
> -/* The CPU clock registers has DIV1 configuration register */
> +/* The CPU clock registers have DIV1 configuration register */
>  #define CLK_CPU_HAS_DIV1		(1 << 0)
>  /* When ALT parent is active, debug clocks need safe divider values */
>  #define CLK_CPU_NEEDS_DEBUG_ALT_DIV	(1 << 1)
> +/* The CPU clock registers have Exynos5433-compatible layout */
> +#define CLK_CPU_HAS_E5433_REGS_LAYOUT	(1 << 2)
>  };
>  
>  extern int __init exynos_register_cpu_clock(struct samsung_clk_provider *ctx,
> 
