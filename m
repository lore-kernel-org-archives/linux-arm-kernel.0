From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 11 Jan 2013 19:03:50 -0800
Subject: [PATCH] clk: max77686: Remove unnecessary NULL checking for
 container_of()
In-Reply-To: <1355817292.32595.2.camel@phoenix>
References: <1355817292.32595.2.camel@phoenix>
Message-ID: <20130112030350.4361.71934@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Axel Lin (2012-12-17 23:54:52)
> container_of() never returns NULL, thus remove the NULL checking for it.
> Also rename get_max77686_clk() to to_max77686_clk() for better readability.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/clk/clk-max77686.c |   30 ++++++++----------------------
>  1 file changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
> index 8944214..3680f66 100644
> --- a/drivers/clk/clk-max77686.c
> +++ b/drivers/clk/clk-max77686.c
> @@ -44,48 +44,34 @@ struct max77686_clk {
>         struct clk_lookup *lookup;
>  };
>  
> -static struct max77686_clk *get_max77686_clk(struct clk_hw *hw)
> +static struct max77686_clk *to_max77686_clk(struct clk_hw *hw)
>  {
>         return container_of(hw, struct max77686_clk, hw);
>  }
>  
>  static int max77686_clk_prepare(struct clk_hw *hw)
>  {
> -       struct max77686_clk *max77686;
> -       int ret;
> -
> -       max77686 = get_max77686_clk(hw);
> -       if (!max77686)
> -               return -ENOMEM;
> -
> -       ret = regmap_update_bits(max77686->iodev->regmap,
> -               MAX77686_REG_32KHZ, max77686->mask, max77686->mask);
> +       struct max77686_clk *max77686 = to_max77686_clk(hw);
>  
> -       return ret;
> +       return regmap_update_bits(max77686->iodev->regmap,
> +                                 MAX77686_REG_32KHZ, max77686->mask,
> +                                 max77686->mask);
>  }
>  
>  static void max77686_clk_unprepare(struct clk_hw *hw)
>  {
> -       struct max77686_clk *max77686;
> -
> -       max77686 = get_max77686_clk(hw);
> -       if (!max77686)
> -               return;
> +       struct max77686_clk *max77686 = to_max77686_clk(hw);
>  
>         regmap_update_bits(max77686->iodev->regmap,
> -               MAX77686_REG_32KHZ, max77686->mask, ~max77686->mask);
> +                          MAX77686_REG_32KHZ, max77686->mask, 0);

Looks like the change to ~max77686->mask snuck in.  It is not mentioned
in the changelog.  Care to respin the patch without the change?

Thanks,
Mike

>  }
>  
>  static int max77686_clk_is_enabled(struct clk_hw *hw)
>  {
> -       struct max77686_clk *max77686;
> +       struct max77686_clk *max77686 = to_max77686_clk(hw);
>         int ret;
>         u32 val;
>  
> -       max77686 = get_max77686_clk(hw);
> -       if (!max77686)
> -               return -ENOMEM;
> -
>         ret = regmap_read(max77686->iodev->regmap,
>                                 MAX77686_REG_32KHZ, &val);
>  
> -- 
> 1.7.9.5
