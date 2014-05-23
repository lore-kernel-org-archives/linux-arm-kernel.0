From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 23 May 2014 14:05:05 -0700
Subject: [PATCH] clk: divider: add CLK_DIVIDER_READ_ONLY flag
In-Reply-To: <1400850135-20382-1-git-send-email-thomas.ab@samsung.com>
References: <1400850135-20382-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20140523210505.23136.13246@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Thomas Abraham (2014-05-23 06:02:15)
> From: Heiko Stuebner <heiko@sntech.de>
> 
> From: Heiko Stuebner <heiko@sntech.de>
> 
> Similar to muxes which already have a read-only flag there sometimes
> exist dividers which should not be changed by the clock framework
> but whose value still should be readable.
> 
> Therefore add a READ_ONLY flag similar to the mux-one to clk-divider
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> [changed flag bit to BIT(5) as suggested by Tomasz Figa]
> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
> Acked-by: Tomasz Figa <t.figa@samsung.com>
> Acked-by: Max Schwarz <max.schwarz@online.de>
> Tested-by: Max Schwarz <max.schwarz@online.de>

Taken into clk-next. Thanks Heiko & Thomas.

Regards,
Mike

> ---
>  drivers/clk/clk-divider.c    |   10 +++++++++-
>  include/linux/clk-provider.h |    4 ++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index b3c8396..c9343f5 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -361,6 +361,11 @@ const struct clk_ops clk_divider_ops = {
>  };
>  EXPORT_SYMBOL_GPL(clk_divider_ops);
>  
> +const struct clk_ops clk_divider_ro_ops = {
> +       .recalc_rate = clk_divider_recalc_rate,
> +};
> +EXPORT_SYMBOL_GPL(clk_divider_ro_ops);
> +
>  static struct clk *_register_divider(struct device *dev, const char *name,
>                 const char *parent_name, unsigned long flags,
>                 void __iomem *reg, u8 shift, u8 width,
> @@ -386,7 +391,10 @@ static struct clk *_register_divider(struct device *dev, const char *name,
>         }
>  
>         init.name = name;
> -       init.ops = &clk_divider_ops;
> +       if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
> +               init.ops = &clk_divider_ro_ops;
> +       else
> +               init.ops = &clk_divider_ops;
>         init.flags = flags | CLK_IS_BASIC;
>         init.parent_names = (parent_name ? &parent_name: NULL);
>         init.num_parents = (parent_name ? 1 : 0);
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 4080943..c7135db 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -320,6 +320,8 @@ struct clk_div_table {
>   *     updated to indicate changing divider bits.
>   * CLK_DIVIDER_ROUND_CLOSEST - Makes the best calculated divider to be rounded
>   *     to the closest integer instead of the up one.
> + * CLK_DIVIDER_READ_ONLY - The divider settings are preconfigured and should
> + *     not be changed by the clock framework.
>   */
>  struct clk_divider {
>         struct clk_hw   hw;
> @@ -336,8 +338,10 @@ struct clk_divider {
>  #define CLK_DIVIDER_ALLOW_ZERO         BIT(2)
>  #define CLK_DIVIDER_HIWORD_MASK                BIT(3)
>  #define CLK_DIVIDER_ROUND_CLOSEST      BIT(4)
> +#define CLK_DIVIDER_READ_ONLY          BIT(5)
>  
>  extern const struct clk_ops clk_divider_ops;
> +extern const struct clk_ops clk_divider_ro_ops;
>  struct clk *clk_register_divider(struct device *dev, const char *name,
>                 const char *parent_name, unsigned long flags,
>                 void __iomem *reg, u8 shift, u8 width,
> -- 
> 1.7.9.5
> 
