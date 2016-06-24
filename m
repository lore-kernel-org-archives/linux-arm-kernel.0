From: neidhard.kim@lge.com (Jongsung Kim)
Date: Fri, 24 Jun 2016 13:43:52 +0900
Subject: [PATCH 1/2] clk: fixed-factor: Allow for a few clocks to change
 the parent rate
In-Reply-To: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
References: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
Message-ID: <576CBA88.2060502@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

We need a path to set CLK_SET_RATE_PARENT any other needed flags when a fixed-factor-clock is initialized by DT. It seems your way will work also for my case. However, I suggested some more generic approach:

https://lkml.org/lkml/2016/6/24/3

Please leave any comments.


On 2016? 06? 22? 18:15, Maxime Ripard wrote:
> The only way for a fixed factor clock to change its rate would be to change
> its parent rate.
>
> Since passing blindly CLK_SET_RATE_PARENT might break a lot of platforms
> that were relying on the fact that the parent rate wouldn't change,
> introduce a compatible-based whitelist that will allow clocks to opt-in
> that flag.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../devicetree/bindings/clock/fixed-factor-clock.txt          |  4 ++++
>  drivers/clk/clk-fixed-factor.c                                | 11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
> index 1bae8527eb9b..189467a7188a 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
> @@ -14,6 +14,10 @@ Required properties:
>  Optional properties:
>  - clock-output-names : From common clock binding.
>  
> +Some clocks that require special treatments are also handled by that
> +driver, with the compatibles:
> +  - allwinner,sun4i-a10-pll3-2x-clk
> +
>  Example:
>  	clock {
>  		compatible = "fixed-factor-clock";
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 75cd6c792cb8..4db3be214077 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -142,6 +142,11 @@ void clk_hw_unregister_fixed_factor(struct clk_hw *hw)
>  EXPORT_SYMBOL_GPL(clk_hw_unregister_fixed_factor);
>  
>  #ifdef CONFIG_OF
> +static const struct of_device_id set_rate_parent_matches[] = {
> +	{ .compatible = "allwinner,sun4i-a10-pll3-2x-clk" },
> +	{ /* Sentinel */ },
> +};
> +
>  /**
>   * of_fixed_factor_clk_setup() - Setup function for simple fixed factor clock
>   */
> @@ -150,6 +155,7 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
>  	struct clk *clk;
>  	const char *clk_name = node->name;
>  	const char *parent_name;
> +	unsigned long flags = 0;
>  	u32 div, mult;
>  
>  	if (of_property_read_u32(node, "clock-div", &div)) {
> @@ -167,7 +173,10 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
>  	of_property_read_string(node, "clock-output-names", &clk_name);
>  	parent_name = of_clk_get_parent_name(node, 0);
>  
> -	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
> +	if (of_match_node(set_rate_parent_matches, node))
> +		flags |= CLK_SET_RATE_PARENT;
> +
> +	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
>  					mult, div);
>  	if (!IS_ERR(clk))
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
