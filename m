From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 15 May 2015 09:44:20 +0800
Subject: [PATCH 06/18] ARM: imx: New timer driver APIs based on IP block
In-Reply-To: <1430405073-13106-7-git-send-email-shenwei.wang@freescale.com>
References: <1430405073-13106-1-git-send-email-shenwei.wang@freescale.com>
 <1430405073-13106-7-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150515014420.GC10411@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 09:44:21AM -0500, Shenwei Wang wrote:
> Implemented the necessory imx timer driver APIs directly
> based on the version of IP block. These APIs are only relating
> to the version of the timer block, and are independent of
> the SoC.
> 
> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
> ---
>  arch/arm/mach-imx/time.c | 171 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
> index 4db233f..811d50a 100644
> --- a/arch/arm/mach-imx/time.c
> +++ b/arch/arm/mach-imx/time.c
> @@ -101,6 +101,54 @@ static enum clock_event_mode clockevent_mode = CLOCK_EVT_MODE_UNUSED;
>  
>  static void __iomem *timer_base;
>  
> +static void gpt_irq_disable_v0_v1(struct imx_timer *tm)
> +{
> +	unsigned int tmp;
> +
> +	tmp = __raw_readl(tm->timer_base + MXC_TCTL);
> +	__raw_writel(tmp & ~MX1_2_TCTL_IRQEN, tm->timer_base + MXC_TCTL);
> +
> +}
> +
> +static void gpt_irq_disable_v2_v3(struct imx_timer *tm)
> +{
> +	__raw_writel(0, tm->timer_base + V2_IR);
> +
> +}
> +
> +static void gpt_irq_enable_v0_v1(struct imx_timer *tm)
> +{
> +	__raw_writel(__raw_readl(tm->timer_base + MXC_TCTL) | MX1_2_TCTL_IRQEN,
> +			tm->timer_base + MXC_TCTL);
> +}
> +
> +static void gpt_irq_enable_v2_v3(struct imx_timer *tm)
> +{
> +	__raw_writel(1, tm->timer_base + V2_IR);
> +}
> +
> +static void gpt_irq_acknowledge_v0(struct imx_timer *tm)
> +{
> +	__raw_readl(tm->timer_base + MX1_2_TSTAT);
> +
> +	__raw_writel(0, tm->timer_base + MX1_2_TSTAT);
> +}
> +
> +static void gpt_irq_acknowledge_v1(struct imx_timer *tm)
> +{
> +	__raw_readl(tm->timer_base + MX1_2_TSTAT);
> +
> +	__raw_writel(MX2_TSTAT_CAPT | MX2_TSTAT_COMP,
> +			tm->timer_base + MX1_2_TSTAT);
> +}
> +
> +static void gpt_irq_acknowledge_v2_v3(struct imx_timer *tm)
> +{
> +	__raw_readl(tm->timer_base + V2_TSTAT);
> +
> +	__raw_writel(V2_TSTAT_OF1, tm->timer_base + V2_TSTAT);
> +}
> +
>  static inline void gpt_irq_disable(void)
>  {
>  	unsigned int tmp;
> @@ -314,6 +362,129 @@ static int __init mxc_clockevent_init(struct clk *timer_clk,
>  	return 0;
>  }
>  
> +static void __init _mxc_timer_init_v0_v1(int irq, struct clk *clk_per,
> +		struct clk *clk_ipg, struct imx_timer *tm)
> +{
> +	uint32_t tctl_val;
> +
> +	if (IS_ERR(clk_per)) {
> +		pr_err("i.MX timer: unable to get clk\n");
> +		return;
> +	}
> +
> +	if (!IS_ERR(clk_ipg))
> +		clk_prepare_enable(clk_ipg);
> +
> +	clk_prepare_enable(clk_per);
> +
> +	/*
> +	 * Initialise to a known state (all timers off, and timing reset)
> +	 */
> +
> +	__raw_writel(0, tm->timer_base + MXC_TCTL);
> +	__raw_writel(0, tm->timer_base + MXC_TPRER); /* see datasheet note */
> +
> +	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
> +
> +	__raw_writel(tctl_val, tm->timer_base + MXC_TCTL);
> +
> +	/* init and register the timer to the framework */
> +	mxc_clocksource_init(clk_per, tm->timer_base + MX1_2_TCN);
> +
> +	tm->evt.set_next_event = mx1_2_set_next_event;
> +	mxc_clockevent_init(clk_per, tm);
> +
> +	/* Make irqs happen */
> +	setup_irq(irq, &tm->act);
> +}
> +
> +static void __init _mxc_timer_init_v2(int irq, struct clk *clk_per,
> +		struct clk *clk_ipg, struct imx_timer *tm)
> +{
> +	uint32_t tctl_val;
> +
> +	if (IS_ERR(clk_per)) {
> +		pr_err("i.MX timer: unable to get clk\n");
> +		return;
> +	}
> +
> +	if (!IS_ERR(clk_ipg))
> +		clk_prepare_enable(clk_ipg);
> +
> +	clk_prepare_enable(clk_per);
> +
> +	/*
> +	 * Initialise to a known state (all timers off, and timing reset)
> +	 */
> +
> +	__raw_writel(0, tm->timer_base + MXC_TCTL);
> +	__raw_writel(0, tm->timer_base + MXC_TPRER); /* see datasheet note */
> +
> +	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
> +
> +	if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8)
> +		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
> +	else
> +		tctl_val |= V2_TCTL_CLK_PER;
> +
> +	__raw_writel(tctl_val, tm->timer_base + MXC_TCTL);
> +
> +	/* init and register the timer to the framework */
> +	mxc_clocksource_init(clk_per, tm->timer_base + V2_TCN);
> +
> +	tm->evt.set_next_event = v2_set_next_event;
> +	mxc_clockevent_init(clk_per, tm);
> +
> +	/* Make irqs happen */
> +	setup_irq(irq, &tm->act);
> +}
> +
> +static void __init _mxc_timer_init_v3(int irq, struct clk *clk_per,
> +		struct clk *clk_ipg, struct imx_timer *tm)
> +{
> +	uint32_t tctl_val;
> +
> +	if (IS_ERR(clk_per)) {
> +		pr_err("i.MX timer: unable to get clk\n");
> +		return;
> +	}
> +
> +	if (!IS_ERR(clk_ipg))
> +		clk_prepare_enable(clk_ipg);
> +
> +	clk_prepare_enable(clk_per);
> +
> +	/*
> +	 * Initialise to a known state (all timers off, and timing reset)
> +	 */
> +
> +	__raw_writel(0, tm->timer_base + MXC_TCTL);
> +	__raw_writel(0, tm->timer_base + MXC_TPRER); /* see datasheet note */
> +
> +	tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
> +
> +	if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
> +		tctl_val |= V2_TCTL_CLK_OSC_DIV8;
> +		/* 24 / 8 = 3 MHz */
> +		__raw_writel(7 << V2_TPRER_PRE24M,
> +					tm->timer_base + MXC_TPRER);
> +		tctl_val |= V2_TCTL_24MEN;
> +	} else {
> +		tctl_val |= V2_TCTL_CLK_PER;
> +	}
> +
> +	__raw_writel(tctl_val, tm->timer_base + MXC_TCTL);
> +
> +	/* init and register the timer to the framework */
> +	mxc_clocksource_init(clk_per, tm->timer_base + V2_TCN);
> +
> +	tm->evt.set_next_event = v2_set_next_event;
> +	mxc_clockevent_init(clk_per, tm);
> +
> +	/* Make irqs happen */
> +	setup_irq(irq, &tm->act);
> +}
> +

Quite some bit of the code is duplicated among these three
_mxc_timer_init_v?() functions.  I'm not sure this makes the most sense.

Shawn

>  static void __init _mxc_timer_init(int irq,
>  				   struct clk *clk_per, struct clk *clk_ipg)
>  {
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
