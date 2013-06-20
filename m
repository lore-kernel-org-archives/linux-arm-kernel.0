From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 19 Jun 2013 23:38:01 -0700
Subject: [PATCH 1/2] clk: nomadik: implement the Nomadik clocks properly
In-Reply-To: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
References: <1370775348-7440-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130620063801.9136.80841@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2013-06-09 03:55:47)
> +static void pll_clk_disable(struct clk_hw *hw)
> +{
> +       struct clk_pll *pll = to_pll(hw);
> +       u32 val;
> +
> +       return;

Is the early return intentional? Everything else looks good.

Acked-by: Mike Turquette <mturquette@linaro.org>

> +
> +       spin_lock(&src_lock);
> +       val = readl(src_base + SRC_PLLCR);
> +       if (pll->id == 1) {
> +               if (val & SRC_PLLCR_PLL1OVER) {
> +                       val &= ~SRC_PLLCR_PLL1EN;
> +                       writel(val, src_base + SRC_PLLCR);
> +               }
> +       } else if (pll->id == 2) {
> +               val &= ~SRC_PLLCR_PLL2EN;
> +               writel(val, src_base + SRC_PLLCR);
> +       }
> +       spin_unlock(&src_lock);
> +}
