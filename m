From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 13 May 2014 10:40:32 +0200
Subject: [PATCH 5/8] clk: berlin: add driver for BG2x complex divider cells
In-Reply-To: <1399839881-29895-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1399839881-29895-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1399839881-29895-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <5371DA80.2060603@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2014 10:24 PM, Sebastian Hesselbarth wrote:
> From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>
> This is a driver for the complex divider cells found on Marvell Berlin2
> SoCs. The cells come in two flavors: single register cells and shared
> register cells. The single register cells are registered by using a DT
> node, while the shared ones will be taken care of in a SoC-specific
> core clock driver.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
[...]
> diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
> new file mode 100644
> index 000000000000..96513a6e8ca7
> --- /dev/null
> +++ b/drivers/clk/berlin/berlin2-div.c
> @@ -0,0 +1,326 @@
[...]
> +static void __init berlin2_div_of_setup(struct device_node *np)
> +{
> +	const char *parent_names[9] = {};
> +	char *mux_name = "mux0";
> +	int num_parents = 0;

num_parents is always zero...

> +	void __iomem *base;
> +	struct clk *iclk;
> +	struct clk *div;
> +	char *div_name;
> +	int n;
> +
> +	iclk = of_clk_get_by_name(np, "mux_bypass");
> +	if (IS_ERR(iclk)) {
> +		pr_err("%s: Missing mux bypass clock\n", np->full_name);
> +		return;
> +	}
> +	parent_names[0] = __clk_get_name(iclk);

.. and needs to be incremented here..

> +	clk_put(iclk);
> +
> +	/* collect mux input clock names */
> +	for (n = 0; n < 8; n++) {
> +		sprintf(mux_name, "mux%d", n);
> +		iclk = of_clk_get_by_name(np, mux_name);
> +		if (IS_ERR(iclk))
> +			continue;
> +		parent_names[1 + n] = __clk_get_name(iclk);

.. and here.

I'll fix it up for v2.

Sebastian

> +		clk_put(iclk);
> +	}
> +
> +	base = of_iomap(np, 0);
> +	if (!base) {
> +		pr_err("%s: Unable to map div register\n", np->full_name);
> +		return;
> +	}
> +
> +	div_name = of_clk_create_name(np);
> +	div = berlin2_div_register(&berlin2_single_div_map, base, div_name,
> +				   BERLIN2_DIV_HAS_GATE | BERLIN2_DIV_HAS_MUX,
> +				   parent_names, num_parents, 0, NULL);
> +	if (!IS_ERR(div))
> +		of_clk_add_provider(np, of_clk_src_simple_get, div);
> +
> +	kfree(div_name);
> +}
> +CLK_OF_DECLARE(berlin2_div, "marvell,berlin2-div", berlin2_div_of_setup);
