From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 29 May 2013 16:05:16 -0700
Subject: [PATCH] ARM : omap3 : fix wrong container_of in clock36xx.c
In-Reply-To: <1368805886-26085-1-git-send-email-jp.francois@cynove.com>
References: <CAGGh5h3BNV7fE3jC0KSmA+2K6zKwVyHdeo8AW0gvmhgQsy8ZEg@mail.gmail.com>
 <1368805886-26085-1-git-send-email-jp.francois@cynove.com>
Message-ID: <20130529230516.6058.74417@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jean-Philippe Francois (2013-05-17 08:51:26)
> omap36xx_pwrdn_clk_enable_with_hsdiv_restore expects the parent hw of the clock
> to be a clk_hw_omap. However, looking at cclock3xxx_data.c, all concerned clock
> have parent defined as clk_divider.
> Fix the function to use clk_divider. 
> Tested with  3.9 on dm3730.
> 
> Signed-off-by: Jean-Philippe Fran??ois <jp.francois@cynove.com>
> 
> Index: b/arch/arm/mach-omap2/clock36xx.c
> ===================================================================
> --- a/arch/arm/mach-omap2/clock36xx.c
> +++ b/arch/arm/mach-omap2/clock36xx.c
> @@ -20,11 +20,12 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/io.h>
>  
>  #include "clock.h"
>  #include "clock36xx.h"
> -
> +#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
>  
>  /**
>   * omap36xx_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
> @@ -39,29 +40,28 @@
>   */
>  int omap36xx_pwrdn_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
>  {
> -       struct clk_hw_omap *parent;
> +       struct clk_divider *parent;
>         struct clk_hw *parent_hw;
> -       u32 dummy_v, orig_v, clksel_shift;
> +       u32 dummy_v, orig_v;
>         int ret;
>  
>         /* Clear PWRDN bit of HSDIVIDER */
>         ret = omap2_dflt_clk_enable(clk);
>  
>         parent_hw = __clk_get_hw(__clk_get_parent(clk->clk));
> -       parent = to_clk_hw_omap(parent_hw);
> +       parent = to_clk_divider(parent_hw);

Peaking inside of clock structures was OK back in the legacy clock days,
and even if the clocks are the same type (clk_hw_omap), but having omap
code dig into clk-divider structures is pretty gross.

How about reentrantly calling clk_set_rate here to achieve the same
effect?

	/* kick parent's clksel register after toggling PWRDN bit */
	struct clk *parent = clk_get_parent(clk->clk);
	unsigned long parent_rate = clk_get_rate(parent);
	clk_set_rate(parent, parent_rate/2);
	clk_set_rate(parent, parent_rate);

Regards,
Mike

>  
>         /* Restore the dividers */
>         if (!ret) {
> -               clksel_shift = __ffs(parent->clksel_mask);
> -               orig_v = __raw_readl(parent->clksel_reg);
> +               orig_v = __raw_readl(parent->reg);
>                 dummy_v = orig_v;
>  
>                 /* Write any other value different from the Read value */
> -               dummy_v ^= (1 << clksel_shift);
> -               __raw_writel(dummy_v, parent->clksel_reg);
> +               dummy_v ^= (1 << parent->shift);
> +               __raw_writel(dummy_v, parent->reg);
>  
>                 /* Write the original divider */
> -               __raw_writel(orig_v, parent->clksel_reg);
> +               __raw_writel(orig_v, parent->reg);
>         }
>  
>         return ret;
