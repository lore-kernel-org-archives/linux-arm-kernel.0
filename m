From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 20:59:40 -0800
Subject: [PATCH v2 07/11] clk: sunxi: mod0 support
In-Reply-To: <1387327503-15651-8-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-8-git-send-email-emilio@elopez.com.ar>
Message-ID: <20131219045940.23538.57052@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-12-17 16:44:59)
> This commit implements support for the "module 0" type of clocks, as
> used by MMC, IR, NAND, SATA and other components.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  5 +-
>  drivers/clk/sunxi/clk-sunxi.c                     | 57 +++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 80b2a39..46d8433 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -35,10 +35,13 @@ Required properties:
>         "allwinner,sun7i-a20-apb1-gates-clk" - for the APB1 gates on A20
>         "allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
>         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
> +       "allwinner,sun4i-mod0-clk" - for the module 0 family of clocks
>  
>  Required properties for all clocks:
>  - reg : shall be the control register address for the clock.
> -- clocks : shall be the input parent clock(s) phandle for the clock
> +- clocks : shall be the input parent clock(s) phandle for the clock. For
> +       multiplexed clocks, the list order must match the hardware
> +       programming order.
>  - #clock-cells : from common clock binding; shall be set to 0 except for
>         "allwinner,*-gates-clk" where it shall be set to 1
>  
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 84e2186..b40cf30 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -286,6 +286,47 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
>  
>  
>  /**
> + * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
> + * MMC rate is calculated as follows
> + * rate = (parent_rate >> p) / (m + 1);
> + */
> +
> +static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
> +                                  u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +       u8 div, calcm, calcp;
> +
> +       /* These clocks can only divide, so we will never be able to achieve
> +        * frequencies higher than the parent frequency */
> +       if (*freq > parent_rate)
> +               *freq = parent_rate;
> +
> +       div = parent_rate / *freq;
> +
> +       if (div < 16)
> +               calcp = 0;
> +       else if (div / 2 < 16)
> +               calcp = 1;
> +       else if (div / 4 < 16)
> +               calcp = 2;
> +       else
> +               calcp = 3;
> +
> +       calcm = DIV_ROUND_UP(div, 1 << calcp);
> +
> +       *freq = (parent_rate >> calcp) / calcm;
> +
> +       /* we were called to round the frequency, we can now return */
> +       if (n == NULL)
> +               return;
> +
> +       *m = calcm - 1;
> +       *p = calcp;
> +}
> +
> +
> +
> +/**
>   * sunxi_factors_clk_setup() - Setup function for factor clocks
>   */
>  
> @@ -332,6 +373,14 @@ static struct clk_factors_config sun4i_apb1_config = {
>         .pwidth = 2,
>  };
>  
> +/* user manual says "n" but it's really "p" */
> +static struct clk_factors_config sun4i_mod0_config = {
> +       .mshift = 0,
> +       .mwidth = 4,
> +       .pshift = 16,
> +       .pwidth = 2,
> +};
> +
>  static const struct factors_data sun4i_pll1_data __initconst = {
>         .enable = 31,
>         .table = &sun4i_pll1_config,
> @@ -355,6 +404,13 @@ static const struct factors_data sun4i_apb1_data __initconst = {
>         .getter = sun4i_get_apb1_factors,
>  };
>  
> +static const struct factors_data sun4i_mod0_data __initconst = {
> +       .enable = 31,
> +       .mux = 24,
> +       .table = &sun4i_mod0_config,
> +       .getter = sun4i_get_mod0_factors,
> +};
> +
>  static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
>                                                 const struct factors_data *data)
>  {
> @@ -845,6 +901,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-pll1-clk", .data = &sun4i_pll1_data,},
>         {.compatible = "allwinner,sun6i-a31-pll1-clk", .data = &sun6i_a31_pll1_data,},
>         {.compatible = "allwinner,sun4i-apb1-clk", .data = &sun4i_apb1_data,},
> +       {.compatible = "allwinner,sun4i-mod0-clk", .data = &sun4i_mod0_data,},
>         {}
>  };
>  
> -- 
> 1.8.5.1
> 
