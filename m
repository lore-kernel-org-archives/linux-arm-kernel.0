From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 21 Jun 2013 11:13:33 -0700
Subject: [PATCH V2 3/3] ARM: OMAP2+: clk: Fix return type of callbacks
In-Reply-To: <1371458384-23936-4-git-send-email-ambresh@ti.com>
References: <1371458384-23936-1-git-send-email-ambresh@ti.com>
 <1371458384-23936-4-git-send-email-ambresh@ti.com>
Message-ID: <20130621181333.20448.23218@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ambresh K (2013-06-17 01:39:44)
> From: Ambresh K <ambresh@ti.com>
> 
> clk_ops's .get_parent member data return's signed value.
> 
> Signed-off-by: Ambresh K <ambresh@ti.com>

Unsurprisingly I get the following errors when building
multi_v7_defconfig:

drivers/clk/clk-composite.c: In function ?clk_register_composite?:
drivers/clk/clk-composite.c:148:33: warning: assignment from incompatible pointer type [enabled by default]
drivers/clk/clk-prima2.c:411:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/clk-prima2.c:411:2: warning: (near initialization for ?msi_ops.get_parent?) [enabled by default]
drivers/clk/clk-prima2.c:459:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/clk-prima2.c:459:2: warning: (near initialization for ?cpu_ops.get_parent?) [enabled by default]
drivers/clk/clk-prima2.c:485:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/clk-prima2.c:485:2: warning: (near initialization for ?dmn_ops.get_parent?) [enabled by default]
drivers/clk/clk-zynq.c:118:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/clk-zynq.c:118:2: warning: (near initialization for ?zynq_periph_clk_ops.get_parent?) [enabled by default]
drivers/clk/clk-zynq.c:228:2: warning: initialization from incompatible pointer type [enabled by default]
drivers/clk/clk-zynq.c:228:2: warning: (near initialization for ?zynq_cpu_clk_ops.get_parent?) [enabled by default]

All definitions of .get_parent callbacks need to be updated, not just
your platform of choice. And there may well be more than the ones above.

I'm not taking this series for 3.11. After the merge window can you
resubmit this series with fixes for all of the .get_parent definitions?
Not just for OMAP.

Otherwise the rest of the series looks good and I'll be happy to take
this in towards 3.12.

Thanks,
Mike

> ---
>  arch/arm/mach-omap2/clkt_clksel.c |    2 +-
>  arch/arm/mach-omap2/clkt_dpll.c   |    2 +-
>  arch/arm/mach-omap2/clock.h       |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap2/clkt_clksel.c
> index 0ec9f6f..2773657 100644
> --- a/arch/arm/mach-omap2/clkt_clksel.c
> +++ b/arch/arm/mach-omap2/clkt_clksel.c
> @@ -303,7 +303,7 @@ u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk,
>   * way to return an error, so if we encounter an error, just WARN()
>   * and pretend that we know that we're doing.
>   */
> -u8 omap2_clksel_find_parent_index(struct clk_hw *hw)
> +int omap2_clksel_find_parent_index(struct clk_hw *hw)
>  {
>         struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>         const struct clksel *clks;
> diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
> index 924c230..54b8c49 100644
> --- a/arch/arm/mach-omap2/clkt_dpll.c
> +++ b/arch/arm/mach-omap2/clkt_dpll.c
> @@ -186,7 +186,7 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
>  }
>  
>  /* Public functions */
> -u8 omap2_init_dpll_parent(struct clk_hw *hw)
> +int omap2_init_dpll_parent(struct clk_hw *hw)
>  {
>         struct clk_hw_omap *clk = to_clk_hw_omap(hw);
>         u32 v;
> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
> index 7aa32cd..2784087 100644
> --- a/arch/arm/mach-omap2/clock.h
> +++ b/arch/arm/mach-omap2/clock.h
> @@ -384,7 +384,7 @@ void __init omap2_clk_disable_clkdm_control(void);
>  u32 omap2_clksel_round_rate_div(struct clk_hw_omap *clk,
>                                 unsigned long target_rate,
>                                 u32 *new_div);
> -u8 omap2_clksel_find_parent_index(struct clk_hw *hw);
> +int omap2_clksel_find_parent_index(struct clk_hw *hw);
>  unsigned long omap2_clksel_recalc(struct clk_hw *hw, unsigned long parent_rate);
>  long omap2_clksel_round_rate(struct clk_hw *hw, unsigned long target_rate,
>                                 unsigned long *parent_rate);
> @@ -396,7 +396,7 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
>  extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
>  extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
>  
> -u8 omap2_init_dpll_parent(struct clk_hw *hw);
> +int omap2_init_dpll_parent(struct clk_hw *hw);
>  unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
>  
>  int omap2_dflt_clk_enable(struct clk_hw *hw);
> -- 
> 1.7.4.1
