From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 17 Dec 2013 19:01:40 -0800
Subject: [PATCH v2 04/11] clk: sunxi: make factors_clk_setup return the
 clock it registers
In-Reply-To: <1387327503-15651-5-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-5-git-send-email-emilio@elopez.com.ar>
Message-ID: <20131218030140.23538.40290@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-12-17 16:44:56)
> We will be needing this to register a factor clock as parent with leaf
> divisors on a single call. While at it, also prepare the function to set
> the ignore flag on pll5, so our RAM keeps working.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 5b86234..401169b 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -308,8 +308,8 @@ static const struct factors_data sun4i_apb1_data __initconst = {
>         .getter = sun4i_get_apb1_factors,
>  };
>  
> -static void __init sunxi_factors_clk_setup(struct device_node *node,
> -                                          struct factors_data *data)
> +static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
> +                                               const struct factors_data *data)
>  {
>         struct clk *clk;
>         struct clk_factors *factors;
> @@ -320,6 +320,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>         const char *clk_name = node->name;
>         const char *parents[5];
>         void *reg;
> +       unsigned long flags;
>         int i = 0;
>  
>         reg = of_iomap(node, 0);
> @@ -330,14 +331,14 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>  
>         factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
>         if (!factors)
> -               return;
> +               return NULL;
>  
>         /* Add a gate if this factor clock can be gated */
>         if (data->enable) {
>                 gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
>                 if (!gate) {
>                         kfree(factors);
> -                       return;
> +                       return NULL;
>                 }
>  
>                 /* set up gate properties */
> @@ -353,7 +354,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>                 if (!mux) {
>                         kfree(factors);
>                         kfree(gate);
> -                       return;
> +                       return NULL;
>                 }
>  
>                 /* set up gate properties */
> @@ -370,17 +371,21 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>         factors->get_factors = data->getter;
>         factors->lock = &clk_lock;
>  
> +       /* We should not disable pll5, it powers the RAM */
> +       flags = !strcmp("pll5", clk_name) ? CLK_IGNORE_UNUSED : 0;

For hardware-agnostic flags like CLK_IGNORE_UNUSED I think that we can
add a property to the binding description instead of hard-coding a
string name in here.

Rest of the patch looks good to me. Ack.

Regards,
Mike

> +
>         clk = clk_register_composite(NULL, clk_name,
>                         parents, i,
>                         mux_hw, &clk_mux_ops,
>                         &factors->hw, &clk_factors_ops,
> -                       gate_hw, &clk_gate_ops,
> -                       i ? 0 : CLK_IS_ROOT);
> +                       gate_hw, &clk_gate_ops, flags);
>  
>         if (!IS_ERR(clk)) {
>                 of_clk_add_provider(node, of_clk_src_simple_get, clk);
>                 clk_register_clkdev(clk, clk_name, NULL);
>         }
> +
> +       return clk;
>  }
>  
>  
> -- 
> 1.8.5.1
> 
