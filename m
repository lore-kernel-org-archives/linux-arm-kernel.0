From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Tue, 30 Jul 2013 21:14:14 -0300
Subject: [PATCH 1/4] clk: sunxi: Rename the structure to prepare the
 addition of sun6i
In-Reply-To: <1375195462-19566-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1375195462-19566-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375195462-19566-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <51F856D6.2050504@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 30/07/13 11:44, Maxime Ripard escribi?:
> Rename all the generic-named structure to sun4i to avoid confusion when
> we will introduce the sun6i (A31) clocks.
> 
> While we're at it, avoid too long lines and wrap the DT compatibles
> tables.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Overall the patch looks good :)

> ---
>  drivers/clk/sunxi/clk-sunxi.c | 108 +++++++++++++++++++++++++++++-------------
>  1 file changed, 75 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index fe1528e..3c91888 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -25,12 +25,12 @@
>  static DEFINE_SPINLOCK(clk_lock);
>  
>  /**
> - * sunxi_osc_clk_setup() - Setup function for gatable oscillator
> + * sun4i_osc_clk_setup() - Setup function for gatable oscillator
>   */
>  
>  #define SUNXI_OSC24M_GATE	0
>  
> -static void __init sunxi_osc_clk_setup(struct device_node *node)
> +static void __init sun4i_osc_clk_setup(struct device_node *node)
>  {
>  	struct clk *clk;
>  	struct clk_fixed_rate *fixed;
> @@ -73,13 +73,13 @@ static void __init sunxi_osc_clk_setup(struct device_node *node)
>  
>  
>  /**
> - * sunxi_get_pll1_factors() - calculates n, k, m, p factors for PLL1
> + * sun4i_get_pll1_factors() - calculates n, k, m, p factors for PLL1
>   * PLL1 rate is calculated as follows
>   * rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
>   * parent_rate is always 24Mhz
>   */
>  
> -static void sunxi_get_pll1_factors(u32 *freq, u32 parent_rate,
> +static void sun4i_get_pll1_factors(u32 *freq, u32 parent_rate,
>  				   u8 *n, u8 *k, u8 *m, u8 *p)
>  {
>  	u8 div;
> @@ -127,12 +127,12 @@ static void sunxi_get_pll1_factors(u32 *freq, u32 parent_rate,
>  
>  
>  /**
> - * sunxi_get_apb1_factors() - calculates m, p factors for APB1
> + * sun4i_get_apb1_factors() - calculates m, p factors for APB1
>   * APB1 rate is calculated as follows
>   * rate = (parent_rate >> p) / (m + 1);
>   */
>  
> -static void sunxi_get_apb1_factors(u32 *freq, u32 parent_rate,
> +static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
>  				   u8 *n, u8 *k, u8 *m, u8 *p)
>  {
>  	u8 calcm, calcp;
> @@ -178,7 +178,7 @@ struct factors_data {
>  	void (*getter) (u32 *rate, u32 parent_rate, u8 *n, u8 *k, u8 *m, u8 *p);
>  };
>  
> -static struct clk_factors_config pll1_config = {
> +static struct clk_factors_config sun4i_pll1_config = {
>  	.nshift = 8,
>  	.nwidth = 5,
>  	.kshift = 4,
> @@ -189,21 +189,21 @@ static struct clk_factors_config pll1_config = {
>  	.pwidth = 2,
>  };
>  
> -static struct clk_factors_config apb1_config = {
> +static struct clk_factors_config sun4i_apb1_config = {
>  	.mshift = 0,
>  	.mwidth = 5,
>  	.pshift = 16,
>  	.pwidth = 2,
>  };
>  
> -static const __initconst struct factors_data pll1_data = {
> -	.table = &pll1_config,
> -	.getter = sunxi_get_pll1_factors,
> +static const __initconst struct factors_data sun4i_pll1_data = {
> +	.table = &sun4i_pll1_config,
> +	.getter = sun4i_get_pll1_factors,
>  };
>  
> -static const __initconst struct factors_data apb1_data = {
> -	.table = &apb1_config,
> -	.getter = sunxi_get_apb1_factors,
> +static const __initconst struct factors_data sun4i_apb1_data = {
> +	.table = &sun4i_apb1_config,
> +	.getter = sun4i_get_apb1_factors,
>  };
>  
>  static void __init sunxi_factors_clk_setup(struct device_node *node,
> @@ -239,11 +239,11 @@ struct mux_data {
>  	u8 shift;
>  };
>  
> -static const __initconst struct mux_data cpu_mux_data = {
> +static const __initconst struct mux_data sun4i_cpu_mux_data = {
>  	.shift = 16,
>  };
>  
> -static const __initconst struct mux_data apb1_mux_data = {
> +static const __initconst struct mux_data sun4i_apb1_mux_data = {
>  	.shift = 24,
>  };
>  
> @@ -284,17 +284,17 @@ struct div_data {
>  	u8 pow;
>  };
>  
> -static const __initconst struct div_data axi_data = {
> +static const __initconst struct div_data sun4i_axi_data = {
>  	.shift = 0,
>  	.pow = 0,
>  };
>  
> -static const __initconst struct div_data ahb_data = {
> +static const __initconst struct div_data sun4i_ahb_data = {
>  	.shift = 4,
>  	.pow = 1,
>  };
>  
> -static const __initconst struct div_data apb0_data = {
> +static const __initconst struct div_data sun4i_apb0_data = {
>  	.shift = 8,
>  	.pow = 1,
>  };
> @@ -413,35 +413,77 @@ CLK_OF_DECLARE(sunxi_osc, "allwinner,sun4i-osc-clk", sunxi_osc_clk_setup);
>  
>  /* Matches for factors clocks */
>  static const __initconst struct of_device_id clk_factors_match[] = {
> -	{.compatible = "allwinner,sun4i-pll1-clk", .data = &pll1_data,},
> -	{.compatible = "allwinner,sun4i-apb1-clk", .data = &apb1_data,},
> +	{
> +		.compatible = "allwinner,sun4i-pll1-clk",
> +		.data = &sun4i_pll1_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-apb1-clk",
> +		.data = &sun4i_apb1_data,
> +	},
>  	{}
>  };
>  
>  /* Matches for divider clocks */
>  static const __initconst struct of_device_id clk_div_match[] = {
> -	{.compatible = "allwinner,sun4i-axi-clk", .data = &axi_data,},
> -	{.compatible = "allwinner,sun4i-ahb-clk", .data = &ahb_data,},
> -	{.compatible = "allwinner,sun4i-apb0-clk", .data = &apb0_data,},
> +	{
> +		.compatible = "allwinner,sun4i-axi-clk",
> +		.data = &sun4i_axi_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-ahb-clk",
> +		.data = &sun4i_ahb_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-apb0-clk",
> +		.data = &sun4i_apb0_data,
> +	},
>  	{}
>  };
>  
>  /* Matches for mux clocks */
>  static const __initconst struct of_device_id clk_mux_match[] = {
> -	{.compatible = "allwinner,sun4i-cpu-clk", .data = &cpu_mux_data,},
> -	{.compatible = "allwinner,sun4i-apb1-mux-clk", .data = &apb1_mux_data,},
> +	{
> +		.compatible = "allwinner,sun4i-cpu-clk",
> +		.data = &sun4i_cpu_mux_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-apb1-mux-clk",
> +		.data = &sun4i_apb1_mux_data,
> +	},
>  	{}
>  };
>  
>  /* Matches for gate clocks */
>  static const __initconst struct of_device_id clk_gates_match[] = {
> -	{.compatible = "allwinner,sun4i-axi-gates-clk", .data = &sun4i_axi_gates_data,},
> -	{.compatible = "allwinner,sun4i-ahb-gates-clk", .data = &sun4i_ahb_gates_data,},
> -	{.compatible = "allwinner,sun5i-a13-ahb-gates-clk", .data = &sun5i_a13_ahb_gates_data,},
> -	{.compatible = "allwinner,sun4i-apb0-gates-clk", .data = &sun4i_apb0_gates_data,},
> -	{.compatible = "allwinner,sun5i-a13-apb0-gates-clk", .data = &sun5i_a13_apb0_gates_data,},
> -	{.compatible = "allwinner,sun4i-apb1-gates-clk", .data = &sun4i_apb1_gates_data,},
> -	{.compatible = "allwinner,sun5i-a13-apb1-gates-clk", .data = &sun5i_a13_apb1_gates_data,},
> +	{
> +		.compatible = "allwinner,sun4i-axi-gates-clk",
> +		.data = &sun4i_axi_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-ahb-gates-clk",
> +		.data = &sun4i_ahb_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun5i-a13-ahb-gates-clk",
> +		.data = &sun5i_a13_ahb_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-apb0-gates-clk",
> +		.data = &sun4i_apb0_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun5i-a13-apb0-gates-clk",
> +		.data = &sun5i_a13_apb0_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun4i-apb1-gates-clk",
> +		.data = &sun4i_apb1_gates_data,
> +	},
> +	{
> +		.compatible = "allwinner,sun5i-a13-apb1-gates-clk",
> +		.data = &sun5i_a13_apb1_gates_data,
> +	},
>  	{}
>  };
>  

I'm not particularly a fan of this though; in my opinion it hurts
readability a bit and it uses 4x the lines. It looks like a highly
probable source of git conflicts too if not handled appropriately :)

Other than that,

Reviewed-by: Emilio L?pez <emilio@elopez.com.ar>

Thanks!

Emilio
