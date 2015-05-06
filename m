From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 6 May 2015 17:47:00 +0800
Subject: [PATCH 2/6] clk: sunxi: Add H3 clocks support
In-Reply-To: <1430904693-1404-3-git-send-email-jenskuske@gmail.com>
References: <1430904693-1404-1-git-send-email-jenskuske@gmail.com>
 <1430904693-1404-3-git-send-email-jenskuske@gmail.com>
Message-ID: <CAGb2v67dHFTttPhddOo+a2Rh0jaCxHqRw=Eo3jkNnFGCOfawRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 6, 2015 at 5:31 PM, Jens Kuske <jenskuske@gmail.com> wrote:
> The H3 clock control unit is similar to the those of other sun8i family
> members like the A23.
>
> The AHB1 gates got split up into AHB1 and AHB2, with AHB2 clock source
> being muxable between AHB1 and PLL6/2, but still sharing gate registers.
> The documentation isn't totally clear about which devices belong to
> AHB2 now, especially USB EHIC/OHIC, so it is mostly based on Allwinner
> kernel source code.
>
> Signed-off-by: Jens Kuske <jenskuske@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |  7 ++++
>  drivers/clk/sunxi/clk-sunxi.c                     | 46 ++++++++++++++++++++++-
>  2 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 4fa11af..4eeb893 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -14,6 +14,8 @@ Required properties:
>         "allwinner,sun4i-a10-pll5-clk" - for the PLL5 clock
>         "allwinner,sun4i-a10-pll6-clk" - for the PLL6 clock
>         "allwinner,sun6i-a31-pll6-clk" - for the PLL6 clock on A31
> +       "allwinner,sun8i-h3-pll6-clk" - for the PLL6 clock on H3
> +       "allwinner,sun8i-h3-pll8-clk" - for the PLL8 clock on H3
>         "allwinner,sun9i-a80-gt-clk" - for the GT bus clock on A80
>         "allwinner,sun4i-a10-cpu-clk" - for the CPU multiplexer clock
>         "allwinner,sun4i-a10-axi-clk" - for the AXI clock
> @@ -28,8 +30,11 @@ Required properties:
>         "allwinner,sun7i-a20-ahb-gates-clk" - for the AHB gates on A20
>         "allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
>         "allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
> +       "allwinner,sun8i-h3-ahb2-clk" - for the AHB2 clock on H3
>         "allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
>         "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
> +       "allwinner,sun8i-h3-ahb1-gates-clk" - for the AHB1 gates on H3
> +       "allwinner,sun8i-h3-ahb2-gates-clk" - for the AHB2 gates on H3
>         "allwinner,sun9i-a80-ahb0-gates-clk" - for the AHB0 gates on A80
>         "allwinner,sun9i-a80-ahb1-gates-clk" - for the AHB1 gates on A80
>         "allwinner,sun9i-a80-ahb2-gates-clk" - for the AHB2 gates on A80
> @@ -52,8 +57,10 @@ Required properties:
>         "allwinner,sun6i-a31-apb1-gates-clk" - for the APB1 gates on A31
>         "allwinner,sun7i-a20-apb1-gates-clk" - for the APB1 gates on A20
>         "allwinner,sun8i-a23-apb1-gates-clk" - for the APB1 gates on A23
> +       "allwinner,sun8i-h3-apb1-gates-clk" - for the APB1 gates on H3
>         "allwinner,sun9i-a80-apb1-gates-clk" - for the APB1 gates on A80
>         "allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
> +       "allwinner,sun8i-h3-apb2-gates-clk" - for the APB2 gates on H3
>         "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
>         "allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
>         "allwinner,sun4i-a10-mmc-clk" - for the MMC clock
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 7e1e2bd..152a1f7 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -727,6 +727,12 @@ static const struct factors_data sun5i_a13_ahb_data __initconst = {
>         .getter = sun5i_a13_get_ahb_factors,
>  };
>
> +static const struct factors_data sun8i_h3_pll8_data __initconst = {
> +       .enable = 31,
> +       .table = &sun6i_a31_pll6_config,
> +       .getter = sun6i_a31_get_pll6_factors,
> +};
> +

If it's fully compatible with sun6i-a31-pll6, please just use it.

On second thought, maybe it's not working because of the .name field?
If so, you're missing one here.

>  static const struct factors_data sun4i_apb1_data __initconst = {
>         .mux = 24,
>         .muxmask = BIT(1) | BIT(0),
> @@ -777,6 +783,10 @@ static const struct mux_data sun6i_a31_ahb1_mux_data __initconst = {
>         .shift = 12,
>  };
>
> +static const struct mux_data sun8i_h3_ahb2_mux_data __initconst = {
> +       .shift = 0,
> +};
> +
>  static void __init sunxi_mux_clk_setup(struct device_node *node,
>                                        struct mux_data *data)
>  {
> @@ -892,7 +902,7 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
>   * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
>   */
>
> -#define SUNXI_GATES_MAX_SIZE   64
> +#define SUNXI_GATES_MAX_SIZE   160
>
>  struct gates_data {
>         DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
> @@ -926,6 +936,10 @@ static const struct gates_data sun8i_a23_ahb1_gates_data __initconst = {
>         .mask = {0x25386742, 0x2505111},
>  };
>
> +static const struct gates_data sun8i_h3_ahb1_gates_data __initconst = {
> +       .mask = {0x1fbc6760, 0x00701b39, 0x00000000, 0x00000000, 0x00000081},
> +};
> +

Wow, what's with the hardware design... :|

>  static const struct gates_data sun9i_a80_ahb0_gates_data __initconst = {
>         .mask = {0xF5F12B},
>  };
> @@ -938,6 +952,10 @@ static const struct gates_data sun9i_a80_ahb2_gates_data __initconst = {
>         .mask = {0x9B7},
>  };
>
> +static const struct gates_data sun8i_h3_ahb2_gates_data __initconst = {
> +       .mask = {0xe0020000},
> +};
> +
>  static const struct gates_data sun4i_apb0_gates_data __initconst = {
>         .mask = {0x4EF},
>  };
> @@ -978,6 +996,10 @@ static const struct gates_data sun8i_a23_apb1_gates_data __initconst = {
>         .mask = {0x3021},
>  };
>
> +static const struct gates_data sun8i_h3_apb1_gates_data __initconst = {
> +       .mask = {0x7123},
> +};
> +
>  static const struct gates_data sun6i_a31_apb2_gates_data __initconst = {
>         .mask = {0x3F000F},
>  };
> @@ -994,6 +1016,10 @@ static const struct gates_data sun8i_a23_apb2_gates_data __initconst = {
>         .mask = {0x1F0007},
>  };
>
> +static const struct gates_data sun8i_h3_apb2_gates_data __initconst = {
> +       .mask = {0x1F0007},
> +};
> +
>  static void __init sunxi_gates_clk_setup(struct device_node *node,
>                                          struct gates_data *data)
>  {
> @@ -1106,6 +1132,16 @@ static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
>         }
>  };
>
> +static const struct divs_data sun8i_h3_pll6_divs_data __initconst = {
> +       .factors = &sun6i_a31_pll6_data,
> +       .ndivs = 3,
> +       .div = {
> +               { .fixed = 2 }, /* normal output, pll6 */
> +               { .self = 1 }, /* base factor clock, pll6 x2 */
> +               { .fixed = 4 }, /* divided output, pll6 /2 */

Since you have the luxury of starting a new binding, maybe you could
put the ".self" clock first?

> +       }
> +};
> +
>  /**
>   * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
>   *
> @@ -1252,6 +1288,7 @@ static const struct of_device_id clk_factors_match[] __initconst = {
>         {.compatible = "allwinner,sun5i-a13-ahb-clk", .data = &sun5i_a13_ahb_data,},
>         {.compatible = "allwinner,sun4i-a10-apb1-clk", .data = &sun4i_apb1_data,},
>         {.compatible = "allwinner,sun7i-a20-out-clk", .data = &sun7i_a20_out_data,},
> +       {.compatible = "allwinner,sun8i-h3-pll8-clk", .data = &sun8i_h3_pll8_data,},

Matching comment above, no need to add a new compatible for something that's
the same.

ChenYu

>         {}
>  };
>
> @@ -1269,6 +1306,7 @@ static const struct of_device_id clk_divs_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-a10-pll5-clk", .data = &pll5_divs_data,},
>         {.compatible = "allwinner,sun4i-a10-pll6-clk", .data = &pll6_divs_data,},
>         {.compatible = "allwinner,sun6i-a31-pll6-clk", .data = &sun6i_a31_pll6_divs_data,},
> +       {.compatible = "allwinner,sun8i-h3-pll6-clk", .data = &sun8i_h3_pll6_divs_data,},
>         {}
>  };
>
> @@ -1276,6 +1314,7 @@ static const struct of_device_id clk_divs_match[] __initconst = {
>  static const struct of_device_id clk_mux_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-a10-cpu-clk", .data = &sun4i_cpu_mux_data,},
>         {.compatible = "allwinner,sun6i-a31-ahb1-mux-clk", .data = &sun6i_a31_ahb1_mux_data,},
> +       {.compatible = "allwinner,sun8i-h3-ahb2-clk", .data = &sun8i_h3_ahb2_mux_data,},
>         {}
>  };
>
> @@ -1288,9 +1327,11 @@ static const struct of_device_id clk_gates_match[] __initconst = {
>         {.compatible = "allwinner,sun6i-a31-ahb1-gates-clk", .data = &sun6i_a31_ahb1_gates_data,},
>         {.compatible = "allwinner,sun7i-a20-ahb-gates-clk", .data = &sun7i_a20_ahb_gates_data,},
>         {.compatible = "allwinner,sun8i-a23-ahb1-gates-clk", .data = &sun8i_a23_ahb1_gates_data,},
> +       {.compatible = "allwinner,sun8i-h3-ahb1-gates-clk", .data = &sun8i_h3_ahb1_gates_data,},
>         {.compatible = "allwinner,sun9i-a80-ahb0-gates-clk", .data = &sun9i_a80_ahb0_gates_data,},
>         {.compatible = "allwinner,sun9i-a80-ahb1-gates-clk", .data = &sun9i_a80_ahb1_gates_data,},
>         {.compatible = "allwinner,sun9i-a80-ahb2-gates-clk", .data = &sun9i_a80_ahb2_gates_data,},
> +       {.compatible = "allwinner,sun8i-h3-ahb2-gates-clk", .data = &sun8i_h3_ahb2_gates_data,},
>         {.compatible = "allwinner,sun4i-a10-apb0-gates-clk", .data = &sun4i_apb0_gates_data,},
>         {.compatible = "allwinner,sun5i-a10s-apb0-gates-clk", .data = &sun5i_a10s_apb0_gates_data,},
>         {.compatible = "allwinner,sun5i-a13-apb0-gates-clk", .data = &sun5i_a13_apb0_gates_data,},
> @@ -1302,9 +1343,11 @@ static const struct of_device_id clk_gates_match[] __initconst = {
>         {.compatible = "allwinner,sun6i-a31-apb1-gates-clk", .data = &sun6i_a31_apb1_gates_data,},
>         {.compatible = "allwinner,sun7i-a20-apb1-gates-clk", .data = &sun7i_a20_apb1_gates_data,},
>         {.compatible = "allwinner,sun8i-a23-apb1-gates-clk", .data = &sun8i_a23_apb1_gates_data,},
> +       {.compatible = "allwinner,sun8i-h3-apb1-gates-clk", .data = &sun8i_h3_apb1_gates_data,},
>         {.compatible = "allwinner,sun9i-a80-apb1-gates-clk", .data = &sun9i_a80_apb1_gates_data,},
>         {.compatible = "allwinner,sun6i-a31-apb2-gates-clk", .data = &sun6i_a31_apb2_gates_data,},
>         {.compatible = "allwinner,sun8i-a23-apb2-gates-clk", .data = &sun8i_a23_apb2_gates_data,},
> +       {.compatible = "allwinner,sun8i-h3-apb2-gates-clk", .data = &sun8i_h3_apb2_gates_data,},
>         {}
>  };
>
> @@ -1389,6 +1432,7 @@ static void __init sun6i_init_clocks(struct device_node *node)
>  CLK_OF_DECLARE(sun6i_a31_clk_init, "allwinner,sun6i-a31", sun6i_init_clocks);
>  CLK_OF_DECLARE(sun6i_a31s_clk_init, "allwinner,sun6i-a31s", sun6i_init_clocks);
>  CLK_OF_DECLARE(sun8i_a23_clk_init, "allwinner,sun8i-a23", sun6i_init_clocks);
> +CLK_OF_DECLARE(sun8i_h3_clk_init, "allwinner,sun8i-h3", sun6i_init_clocks);
>
>  static void __init sun9i_init_clocks(struct device_node *node)
>  {
> --
> 2.3.7
>
