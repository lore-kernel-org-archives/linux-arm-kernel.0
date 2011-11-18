From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2011 11:06:49 -0800
Subject: [PATCH 03/10] arm/tegra: prepare clock code for multiple tegra
 variants
In-Reply-To: <1321546766-26770-4-git-send-email-pdeschrijver@nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
 <1321546766-26770-4-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111118190649.GB31678@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

A nit and two comments below.

On Thu, Nov 17, 2011 at 06:19:17PM +0200, Peter De Schrijver wrote:
> Rework the tegra20 clock code to support multiple tegra variants :
> 
>  * remove tegra2_periph_reset_assert/tegra2_periph_reset_deassert. This
>    functionality should be in clock.c.
>  * compile tegra_sdmmc_tap_delay only on tegra20 as this feature will not
>    be available in future variants.
>  * don't export clk_measure_input_freq as its functionality is also available
>    using clk_get_rate().
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  arch/arm/mach-tegra/clock.c         |   14 +++++++++-----
>  arch/arm/mach-tegra/clock.h         |    3 ---
>  arch/arm/mach-tegra/tegra2_clocks.c |   14 +-------------
>  arch/arm/mach-tegra/timer.c         |   12 ++++++++----
>  4 files changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
> index f8d41ff..47f6366 100644
> --- a/arch/arm/mach-tegra/clock.c
> +++ b/arch/arm/mach-tegra/clock.c
> @@ -387,13 +387,15 @@ EXPORT_SYMBOL(tegra_clk_init_from_table);
>  
>  void tegra_periph_reset_deassert(struct clk *c)
>  {
> -	tegra2_periph_reset_deassert(c);
> +	BUG_ON(!c->ops->reset);
> +	c->ops->reset(c, false);
>  }
>  EXPORT_SYMBOL(tegra_periph_reset_deassert);
>  
>  void tegra_periph_reset_assert(struct clk *c)
>  {
> -	tegra2_periph_reset_assert(c);
> +	BUG_ON(!c->ops->reset);
> +	c->ops->reset(c, true);
>  }
>  EXPORT_SYMBOL(tegra_periph_reset_assert);
>  
> @@ -403,10 +405,11 @@ void __init tegra_init_clock(void)
>  }
>  
>  /*
> - * The SDMMC controllers have extra bits in the clock source register that
> - * adjust the delay between the clock and data to compenstate for delays
> - * on the PCB.
> + * The SDMMC controllers on tegra20 have extra bits in the clock source
> + * register that adjust the delay between the clock and data to compenstate
> + * for delays on the PCB.
>   */
> +#ifdef CONFIG_ARCH_TEGRA_2x_SOC
>  void tegra_sdmmc_tap_delay(struct clk *c, int delay)
>  {
>  	unsigned long flags;
> @@ -415,6 +418,7 @@ void tegra_sdmmc_tap_delay(struct clk *c, int delay)
>  	tegra2_sdmmc_tap_delay(c, delay);
>  	spin_unlock_irqrestore(&c->spinlock, flags);
>  }
> +#endif

Ifdeffing this out doesn't quite make sense. Better to do a #ifdef in the
include file with an #else case that fills in an empty function. This
needs to be abstracted differently for the two platforms anyway but
that can be done separately from this. Does tegra3 have tap delay setup
as well? (I don't have the TRM handy right now).

>  
> diff --git a/arch/arm/mach-tegra/clock.h b/arch/arm/mach-tegra/clock.h
> index 688316a..18df129 100644
> --- a/arch/arm/mach-tegra/clock.h
> +++ b/arch/arm/mach-tegra/clock.h
> @@ -146,11 +146,8 @@ struct tegra_clk_init_table {
>  };
>  
>  void tegra2_init_clocks(void);
> -void tegra2_periph_reset_deassert(struct clk *c);
> -void tegra2_periph_reset_assert(struct clk *c);
>  void clk_init(struct clk *clk);
>  struct clk *tegra_get_clock_by_name(const char *name);
> -unsigned long clk_measure_input_freq(void);

This should maybe be done as a separate change, but don't worry about
it this time around.

>  int clk_reparent(struct clk *c, struct clk *parent);
>  void tegra_clk_init_from_table(struct tegra_clk_init_table *table);
>  unsigned long clk_get_rate_locked(struct clk *c);
> diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
> index 371869d..2ab18f6 100644
> --- a/arch/arm/mach-tegra/tegra2_clocks.c
> +++ b/arch/arm/mach-tegra/tegra2_clocks.c
> @@ -174,7 +174,7 @@ static int tegra_periph_clk_enable_refcount[3 * 32];
>  #define pmc_readl(reg) \
>  	__raw_readl(reg_pmc_base + (reg))
>  
> -unsigned long clk_measure_input_freq(void)
> +static unsigned long clk_measure_input_freq(void)

This has only a single user left, so it can be folded down in that function
instead, especially since there's just two switch statements. That can be done
in a separate change.


-Olof
