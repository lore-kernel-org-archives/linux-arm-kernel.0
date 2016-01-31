From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 31 Jan 2016 11:33:34 +0800
Subject: [PATCH 05/14] clk: sunxi: Add APB1 clock for A83T
In-Reply-To: <1454203266-4450-6-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
 <1454203266-4450-6-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <CAGb2v649_A2suoshTpYUBnihMia+V9bZDF_rYEs1b9gANMExuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 31, 2016 at 9:20 AM, Vishnu Patekar
<vishnupatekar0510@gmail.com> wrote:
> APB1 is similar to sun4i-a10-apb0-clk, except different dividers.
>
> This adds support for apb1 on A83T.
>
> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index bfd82f1..10637e7 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -49,6 +49,7 @@ Required properties:
>         "allwinner,sun8i-a23-apb0-gates-clk" - for the APB0 gates on A23
>         "allwinner,sun9i-a80-apb0-gates-clk" - for the APB0 gates on A80
>         "allwinner,sun4i-a10-apb1-clk" - for the APB1 clock
> +       "allwinner,sun8i-a83t-apb1-clk" - for the APB1 clock on A83T
>         "allwinner,sun9i-a80-apb1-clk" - for the APB1 bus clock on A80
>         "allwinner,sun4i-a10-apb1-gates-clk" - for the APB1 gates on A10
>         "allwinner,sun5i-a13-apb1-gates-clk" - for the APB1 gates on A13
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 02bbdf6..6510b0e 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -772,6 +772,22 @@ static const struct div_data sun4i_apb0_data __initconst = {
>         .table  = sun4i_apb0_table,
>  };
>
> +
> +static const struct clk_div_table sun8i_a83t_apb1_table[] __initconst = {
> +       { .val = 0, .div = 1 },
> +       { .val = 1, .div = 2 },
> +       { .val = 2, .div = 3 },
> +       { .val = 3, .div = 4 },
> +       { } /* sentinel */
> +};

The table is only needed if it cannot be handled by default or with
the div flags,
such as dividers not increasing or not power-of-2.

ChenYu

> +static const struct div_data sun8i_a83t_apb1_data __initconst = {
> +       .shift  = 8,
> +       .pow    = 0,
> +       .width  = 2,
> +       .table  = sun8i_a83t_apb1_table,
> +};
> +
>  static void __init sunxi_divider_clk_setup(struct device_node *node,
>                                            struct div_data *data)
>  {
> @@ -1027,6 +1043,7 @@ static const struct of_device_id clk_div_match[] __initconst = {
>         {.compatible = "allwinner,sun8i-a23-axi-clk", .data = &sun8i_a23_axi_data,},
>         {.compatible = "allwinner,sun4i-a10-ahb-clk", .data = &sun4i_ahb_data,},
>         {.compatible = "allwinner,sun4i-a10-apb0-clk", .data = &sun4i_apb0_data,},
> +       {.compatible = "allwinner,sun8i-a83t-apb1-clk", .data = &sun8i_a83t_apb1_data,},
>         {}
>  };
>
> --
> 1.9.1
>
