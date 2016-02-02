From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Feb 2016 18:35:29 +0800
Subject: [PATCH 1/5] clk: sunxi: Make clocks setup functions return their
 clock
In-Reply-To: <1454402834-6385-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66CyhkM0vabbede43eAaf7WVg0Lm8w_OUKwqHnFO182uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 2, 2016 at 4:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The clocks registration code in clk-sunxi was most of the time not
> returning the struct clk (or struct clk array) that was registered,
> preventing the users of such functions to manipulate it, for example to
> protect it.
>
> Make them return it so that we can start using it.

Should they return error codes as well? So the CLK_OF_DECLARE setup functions
can report errors. Or make these helper functions report errors directly?

ChenYu

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi/clk-sunxi.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index e460a6b0068c..67ef94948544 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -615,8 +615,8 @@ static const struct mux_data sun8i_h3_ahb2_mux_data __initconst = {
>         .shift = 0,
>  };
>
> -static void __init sunxi_mux_clk_setup(struct device_node *node,
> -                                      struct mux_data *data)
> +static struct clk * __init sunxi_mux_clk_setup(struct device_node *node,
> +                                              struct mux_data *data)
>  {
>         struct clk *clk;
>         const char *clk_name = node->name;
> @@ -638,6 +638,8 @@ static void __init sunxi_mux_clk_setup(struct device_node *node,
>                 of_clk_add_provider(node, of_clk_src_simple_get, clk);
>                 clk_register_clkdev(clk, clk_name, NULL);
>         }
> +
> +       return clk;
>  }
>
>
> @@ -722,7 +724,6 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
>  }
>
>
> -
>  /**
>   * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
>   */
> @@ -808,8 +809,8 @@ static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
>   *           |________________________|
>   */
>
> -static void __init sunxi_divs_clk_setup(struct device_node *node,
> -                                       struct divs_data *data)
> +static struct clk ** __init sunxi_divs_clk_setup(struct device_node *node,
> +                                                struct divs_data *data)
>  {
>         struct clk_onecell_data *clk_data;
>         const char *parent;
> @@ -836,7 +837,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
>
>         clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
>         if (!clk_data)
> -               return;
> +               return NULL;
>
>         clks = kcalloc(ndivs, sizeof(*clks), GFP_KERNEL);
>         if (!clks)
> @@ -922,7 +923,7 @@ static void __init sunxi_divs_clk_setup(struct device_node *node,
>
>         of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>
> -       return;
> +       return clks;
>
>  free_gate:
>         kfree(gate);
> @@ -930,6 +931,7 @@ free_clks:
>         kfree(clks);
>  free_clkdata:
>         kfree(clk_data);
> +       return NULL;
>  }
>
>
> --
> 2.6.4
>
