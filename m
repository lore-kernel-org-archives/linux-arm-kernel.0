From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 21 Mar 2017 16:43:34 -0700
Subject: [PATCH 1/5] clk: meson: Add support for parameters for specific
 PLLs
In-Reply-To: <1489411604-18700-2-git-send-email-narmstrong@baylibre.com>
References: <1489411604-18700-1-git-send-email-narmstrong@baylibre.com>
 <1489411604-18700-2-git-send-email-narmstrong@baylibre.com>
Message-ID: <149013981400.54062.11268768959465562064@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Neil Armstrong (2017-03-13 06:26:40)
> In recent Amlogic GXBB, GXL and GXM SoCs, the GP0 PLL needs some specific
> parameters in order to initialize and lock correctly.
> 
> This patch adds an optional PARAM table used to initialize the PLL to a
> default value with it's parameters in order to achieve to desired frequency.
> 
> The GP0 PLL in GXBB, GXL/GXM also needs some tweaks in the initialization
> steps, and these are exposed along the PARAM table.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/clk-pll.c | 52 +++++++++++++++++++++++++++++++++++++++++++--
>  drivers/clk/meson/clkc.h    | 23 ++++++++++++++++++++
>  2 files changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 4adc1e8..aff223b 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -116,6 +116,29 @@ static const struct pll_rate_table *meson_clk_get_pll_settings(struct meson_clk_
>         return NULL;
>  }
>  
> +/* Specific wait loop for GXL/GXM GP0 PLL */
> +static int meson_clk_pll_wait_lock_reset(struct meson_clk_pll *pll,
> +                                        struct parm *p_n)
> +{
> +       int delay = 100;
> +       u32 reg;
> +
> +       while (delay > 0) {
> +               reg = readl(pll->base + p_n->reg_off);
> +               writel(reg | MESON_PLL_RESET, pll->base + p_n->reg_off);
> +               udelay(10);
> +               writel(reg & ~MESON_PLL_RESET, pll->base + p_n->reg_off);
> +
> +               mdelay(1);

Can you add a comment explaining where the delay values come from? Can
they vary from chip to chip?

> +
> +               reg = readl(pll->base + p_n->reg_off);
> +               if (reg & MESON_PLL_LOCK)
> +                       return 0;
> +               delay--;
> +       }
> +       return -ETIMEDOUT;
> +}
> +
>  static int meson_clk_pll_wait_lock(struct meson_clk_pll *pll,
>                                    struct parm *p_n)
>  {
> @@ -132,6 +155,15 @@ static int meson_clk_pll_wait_lock(struct meson_clk_pll *pll,
>         return -ETIMEDOUT;
>  }
>  
> +static void meson_clk_pll_init_params(struct meson_clk_pll *pll)
> +{
> +       int i;
> +
> +       for (i = 0 ; i < pll->params.params_count ; ++i)
> +               writel(pll->params.params_table[i].value,
> +                      pll->base + pll->params.params_table[i].reg_off);
> +}
> +
>  static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>                                   unsigned long parent_rate)
>  {
> @@ -151,10 +183,16 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>         if (!rate_set)
>                 return -EINVAL;
>  
> +       /* Initialize the PLL in a clean state if specified */
> +       if (pll->params.params_count)
> +               meson_clk_pll_init_params(pll);
> +
>         /* PLL reset */
>         p = &pll->n;
>         reg = readl(pll->base + p->reg_off);
> -       writel(reg | MESON_PLL_RESET, pll->base + p->reg_off);
> +       /* If no_init_reset is provided, avoid resetting at this point */
> +       if (!pll->params.no_init_reset)
> +               writel(reg | MESON_PLL_RESET, pll->base + p->reg_off);
>  
>         reg = PARM_SET(p->width, p->shift, reg, rate_set->n);
>         writel(reg, pll->base + p->reg_off);
> @@ -184,7 +222,17 @@ static int meson_clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
>         }
>  
>         p = &pll->n;
> -       ret = meson_clk_pll_wait_lock(pll, p);
> +       /* If unreset_for_lock is provided, remove the reset bit here */
> +       if (pll->params.unreset_for_lock) {

Small nitpick, but I find "unreset" to be confusing. Since 'reset' here
is a bit that can be set and unset, maybe use clear_reset_for_lock
instead?

Regards,
Mike

> +               reg = readl(pll->base + p->reg_off);
> +               writel(reg & ~MESON_PLL_RESET, pll->base + p->reg_off);
> +       }
> +
> +       /* If reset_lock_loop, use a special loop including resetting */
> +       if (pll->params.reset_lock_loop)
> +               ret = meson_clk_pll_wait_lock_reset(pll, p);
> +       else
> +               ret = meson_clk_pll_wait_lock(pll, p);
>         if (ret) {
>                 pr_warn("%s: pll did not lock, trying to restore old rate %lu\n",
>                         __func__, old_rate);
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 9bb70e7..5f1c12d 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -62,6 +62,28 @@ struct pll_rate_table {
>                 .frac           = (_frac),                              \
>         }                                                               \
>  
> +struct pll_params_table {
> +       unsigned int reg_off;
> +       unsigned int value;
> +};
> +
> +#define PLL_PARAM(_reg, _val)                                          \
> +       {                                                               \
> +               .reg_off        = (_reg),                               \
> +               .value          = (_val),                               \
> +       }
> +
> +struct pll_setup_params {
> +       struct pll_params_table *params_table;
> +       unsigned int params_count;
> +       /* Workaround for GP0, do not reset before configuring */
> +       bool no_init_reset;
> +       /* Workaround for GP0, unreset right before checking for lock */
> +       bool unreset_for_lock;
> +       /* Workaround for GXL GP0, reset in the lock checking loop */
> +       bool reset_lock_loop;
> +};
> +
>  struct meson_clk_pll {
>         struct clk_hw hw;
>         void __iomem *base;
> @@ -70,6 +92,7 @@ struct meson_clk_pll {
>         struct parm frac;
>         struct parm od;
>         struct parm od2;
> +       const struct pll_setup_params params;
>         const struct pll_rate_table *rate_table;
>         unsigned int rate_count;
>         spinlock_t *lock;
> -- 
> 1.9.1
> 
