From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:48:19 -0800
Subject: [PATCHv4 1/5] clk: mvebu: support for 98DX3236 SoC
In-Reply-To: <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170121004819.GA8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13, Chris Packham wrote:
> @@ -158,6 +170,14 @@ static const struct coreclk_soc_desc axp_coreclks = {
>  	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
>  };
>  
> +static const struct coreclk_soc_desc mv98dx3236_coreclks = {
> +	.get_tclk_freq = mv98dx3236_get_tclk_freq,
> +	.get_cpu_freq = mv98dx3236_get_cpu_freq,
> +	.get_clk_ratio = NULL,
> +	.ratios = NULL,
> +	.num_ratios = 0,

Are these intentionally initialized to 0 explicitly? Otherwise we
could leave them out and it's all the same.

> +};
> +
>  /*
>   * Clock Gating Control
>   */
[..]
> @@ -243,5 +245,30 @@ static void __init of_cpu_clk_setup(struct device_node *node)
>  	iounmap(clock_complex_base);
>  }
>  
> +/* Use this function to call the generic setup with the correct
> + * clock operation
> + */
> +static void __init of_cpu_clk_setup(struct device_node *node)
> +{
> +	_of_cpu_clk_setup(node, &cpu_ops);
> +}
> +
>  CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
>  					 of_cpu_clk_setup);
> +
> +/* Define the clock and operations for the mv98dx3236 - it cannot perform
> + * any operations.
> + */
> +static const struct clk_ops mv98dx3236_cpu_ops = {
> +	.recalc_rate = NULL,
> +	.round_rate = NULL,
> +	.set_rate = NULL,

But clk_set_rate() works silently? Why not just register a clk
provider that returns a NULL pointer? Then there isn't any
structure to maintain?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
