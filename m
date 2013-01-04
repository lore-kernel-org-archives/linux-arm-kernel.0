From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Jan 2013 16:46:43 +0530
Subject: [PATCH v4 5/9] ARM: davinci: New reset functionality/API provided
 for Davinci DSP
In-Reply-To: <1355967254-16726-6-git-send-email-rtivy@ti.com>
References: <1355967254-16726-1-git-send-email-rtivy@ti.com>
 <1355967254-16726-6-git-send-email-rtivy@ti.com>
Message-ID: <50E6BA1B.5030101@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 7:04 AM, Robert Tivy wrote:
> Since there is no general "reset" support for SoC devices, and since the
> remoteproc driver needs explicit control of the DSP's reset line, a new
> Davinci-specific API is added.

You should probably note here that the private API will disappear with
DT migration and provide a link to the latest discussions on reset
handling in DT case.

> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>
> ---
>  arch/arm/mach-davinci/clock.c              |   31 ++++++++++++++++++++++++++++
>  arch/arm/mach-davinci/clock.h              |    3 +++
>  arch/arm/mach-davinci/include/mach/clock.h |    3 +++
>  arch/arm/mach-davinci/include/mach/psc.h   |    3 +++
>  arch/arm/mach-davinci/psc.c                |   28 +++++++++++++++++++++++++
>  5 files changed, 68 insertions(+)
> 
> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
> index 34668ea..d50664f 100644
> --- a/arch/arm/mach-davinci/clock.c
> +++ b/arch/arm/mach-davinci/clock.c
> @@ -52,6 +52,37 @@ static void __clk_disable(struct clk *clk)
>  		__clk_disable(clk->parent);
>  }
>  
> +int davinci_clk_reset(struct clk *clk, bool reset)
> +{
> +	unsigned long flags;
> +
> +	if (clk == NULL || IS_ERR(clk))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +	if (clk->flags & CLK_PSC)
> +		davinci_psc_reset_config(clk->domain, clk->gpsc, clk->lpsc,
> +				reset, clk->flags);

Not sure if you really need to pass flags down to this function. You
could straightaway check for (clk->flags & PSC_LRST) here.

> +	spin_unlock_irqrestore(&clockfw_lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(davinci_clk_reset);
> +
> +int davinci_reset_assert(struct clk *clk)

davinci_clk_reset_assert for consistency?

> +{
> +	BUG_ON(!clk->reset);

Triggering a bug is too harsh. No need to crash without even allowing to
save data. Just return error.

> +	return clk->reset(clk, true);
> +}
> +EXPORT_SYMBOL(davinci_reset_assert);
> +
> +int davinci_reset_deassert(struct clk *clk)
> +{
> +	BUG_ON(!clk->reset);
> +	return clk->reset(clk, false);
> +}
> +EXPORT_SYMBOL(davinci_reset_deassert);
> +
>  int clk_enable(struct clk *clk)
>  {
>  	unsigned long flags;
> diff --git a/arch/arm/mach-davinci/clock.h b/arch/arm/mach-davinci/clock.h
> index 46f0f1b..8694b39 100644
> --- a/arch/arm/mach-davinci/clock.h
> +++ b/arch/arm/mach-davinci/clock.h
> @@ -103,6 +103,7 @@ struct clk {
>  	unsigned long (*recalc) (struct clk *);
>  	int (*set_rate) (struct clk *clk, unsigned long rate);
>  	int (*round_rate) (struct clk *clk, unsigned long rate);
> +	int (*reset) (struct clk *clk, bool reset);
>  };
>  
>  /* Clock flags: SoC-specific flags start at BIT(16) */
> @@ -112,6 +113,7 @@ struct clk {
>  #define PRE_PLL			BIT(4) /* source is before PLL mult/div */
>  #define PSC_SWRSTDISABLE	BIT(5) /* Disable state is SwRstDisable */
>  #define PSC_FORCE		BIT(6) /* Force module state transtition */
> +#define PSC_LRST		BIT(8) /* Use local reset on enable/disable */
>  
>  #define CLK(dev, con, ck) 	\
>  	{			\
> @@ -126,6 +128,7 @@ int davinci_set_pllrate(struct pll_data *pll, unsigned int prediv,
>  int davinci_set_sysclk_rate(struct clk *clk, unsigned long rate);
>  int davinci_set_refclk_rate(unsigned long rate);
>  int davinci_simple_set_rate(struct clk *clk, unsigned long rate);
> +int davinci_clk_reset(struct clk *clk, bool reset);
>  
>  extern struct platform_device davinci_wdt_device;
>  extern void davinci_watchdog_reset(struct platform_device *);
> diff --git a/arch/arm/mach-davinci/include/mach/clock.h b/arch/arm/mach-davinci/include/mach/clock.h
> index a3b0402..cdb8f2f 100644
> --- a/arch/arm/mach-davinci/include/mach/clock.h
> +++ b/arch/arm/mach-davinci/include/mach/clock.h
> @@ -18,4 +18,7 @@ struct clk;
>  extern int clk_register(struct clk *clk);
>  extern void clk_unregister(struct clk *clk);
>  
> +int davinci_reset_assert(struct clk *c);
> +int davinci_reset_deassert(struct clk *c);
> +
>  #endif
> diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
> index 40a0027..21746bd 100644
> --- a/arch/arm/mach-davinci/include/mach/psc.h
> +++ b/arch/arm/mach-davinci/include/mach/psc.h
> @@ -246,6 +246,7 @@
>  
>  #define MDSTAT_STATE_MASK	0x3f
>  #define PDSTAT_STATE_MASK	0x1f
> +#define MDCTL_LRST		BIT(8)
>  #define MDCTL_FORCE		BIT(31)
>  #define PDCTL_NEXT		BIT(0)
>  #define PDCTL_EPCGOOD		BIT(8)
> @@ -253,6 +254,8 @@
>  #ifndef __ASSEMBLER__
>  
>  extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
> +extern void davinci_psc_reset_config(unsigned int domain, unsigned int ctlr,
> +		unsigned int id, bool reset, u32 flags);
>  extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
>  		unsigned int id, bool enable, u32 flags);
>  
> diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
> index bddaba9..a2a33d4 100644
> --- a/arch/arm/mach-davinci/psc.c
> +++ b/arch/arm/mach-davinci/psc.c
> @@ -48,6 +48,34 @@ int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
>  	return mdstat & BIT(12);
>  }
>  
> +/* Control "reset" line associated with PSC domain */
> +void davinci_psc_reset_config(unsigned int domain, unsigned int ctlr,
> +		unsigned int id, bool reset, u32 flags)

You don't use domain in this function. No need to pass it.

Thanks,
Sekhar
