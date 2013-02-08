From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 08 Feb 2013 12:43:09 +0100
Subject: [PATCH 1/3] clk: arm: sunxi: Add a new clock driver for sunxi SOCs
In-Reply-To: <BLU0-SMTP20672F906C0E06311DBE68E8A050@phx.gbl>
References: <1358835176-7197-1-git-send-email-emilio@elopez.com.ar>
 <1358835176-7197-2-git-send-email-emilio@elopez.com.ar>
 <5110EA86.3040205@free-electrons.com>
 <BLU0-SMTP20672F906C0E06311DBE68E8A050@phx.gbl>
Message-ID: <5114E4CD.6030001@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 11:38 AM, Emilio L?pez wrote:
[Snip]

>>> +
>>
>> This file seems to be a copy and past of clk-fixed-rate.c and
>> clk-gate.c (as explained in your header). The purpose of the common
>> clock framework was to reduce code duplication not increase it! :)
> 
> I agree, I am not much of a fan of code duplication :)
> 
>> The current way to achieve what you want is to declare two clock:
>> one fixed-rate and one gateable.
> 
> I don't like this solution much however, because the software
> representation does not accurately match (1:1) the hardware then.

I don't see as a problem: we just split this clock in logical
components. It allows a better reusability of the components.

> 
>> In this case your fixed clock will only be use by the gateable
>> one. Latter thecomposite clk may be a solution, if you really want to
>> only deal with one clock.
> 
> The composite clock lacks fixed rate support from what I saw on the patches.
> 
> So, right now I can think of three possibilities:
> 1) Use two separate clocks as Gregory suggests, and ignore the
> non-accurate representation.
> 2) Extend composite to support fixed rate and use that.
> 3) Extend gate to support fixed rate and use that.
> 
> I think going with 1) will be best for now, and we can then decide and
> work on getting it improved with 2) or 3)

I agree.

> 
>> You could remove this file and its header, do a little change in the
>> dtsi with something like this:
>>
>> osc24M_fixed: osc24M_fixed {
>> 	#clock-cells = <0>;
>> 	compatible = "fixed-clock";
>> 	clock-frequency = <24000000>;
>> };
>>
>> osc24M osc24M {
>> 	#clock-cells = <0>;
>> 	compatible = "allwinner,sunxi-osc-clk"
>> 	reg = <0x01c20050 0x4>;
>> 	clocks = <&osc24M_fixed>;
>> };
>>
>> And modify sunxi_osc_clk_setup() as below
>>
>>
>> [...]
>>
>>> +
>>> +static void __init sunxi_osc_clk_setup(struct device_node *node)
>>> +{
>>> +	struct clk *clk;
>>> +	const char *clk_name = node->name;
>>> +	void *reg;
>>> +	u32 rate;
>>> +
>>> +	reg = of_iomap(node, 0);
>>
>> here you retrieve the name of the parent clock:
>>
>> 	clk = of_clk_get(np, 0);
>> 	if (!IS_ERR(clk)) {
>> 		parent_name = __clk_get_name(clk);
>> 		clk_put(clk);
>> 	}
>>
>> We don't anymore to get the clock-frequency
>>> +
>>> +	if (of_property_read_u32(node, "clock-frequency", &rate))
>>> +		return;
>>> +
>>
>> And here instead of clk_register_fixed_gate you can use the
>> clk_register_gate as below:
>>> +	clk = clk_register_fixed_gate(NULL, clk_name, NULL,
>>> +				      CLK_IS_ROOT | CLK_IGNORE_UNUSED,
>>> +				      reg, SUNXI_OSC24M_GATE, rate, &clk_lock);
>>> +
>> 	clk = clk_register_gate(NULL, clk_name, parent_name,
>> 			CLK_IGNORE_UNUSED, reg, SUNXI_OSC24M_GATE, 0, &clk->lock);
>>
>>> +	if (clk) {
>>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>> +		clk_register_clkdev(clk, clk_name, NULL);
>>> +	}
>>> +}
>>> +
>>> +
>>> +
>>> +/**
>>> + * sunxi_get_pll1_factors() - calculates n, k, m, p factors for PLL1
>>> + * PLL1 rate is calculated as follows
>>> + * rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
>>> + * parent_rate is always 24Mhz
>>> + */
>>> +
>>> +static void sunxi_get_pll1_factors(u32 *freq, u8 *n, u8 *k, u8 *m, u8 *p)
>>> +{
>>> +	u8 div;
>>> +
>>> +	/* Normalize value to a 6M multiple */
>>> +	div = *freq / 6000000;
>>> +	*freq = 6000000 * div;
>>> +
>>> +	/* we were called to round the frequency, we can now return */
>>> +	if (n == NULL)
>>> +		return;
>>> +
>>> +	/* m is always zero for pll1 */
>>> +	*m = 0;
>>> +
>>> +	/* k is 1 only on these cases */
>>> +	if (*freq >= 768000000 || *freq == 42000000 || *freq == 54000000)
>>> +		*k = 1;
>>> +	else
>>> +		*k = 0;
>>> +
>>> +	/* p will be 3 for divs under 10 */
>>> +	if (div < 10)
>>> +		*p = 3;
>>> +
>>> +	/* p will be 2 for divs between 10 - 20 and odd divs under 32 */
>>> +	else if (div < 20 || (div < 32 && (div & 1)))
>>> +		*p = 2;
>>> +
>>> +	/* p will be 1 for even divs under 32, divs under 40 and odd pairs
>>> +	 * of divs between 40-62 */
>>> +	else if (div < 40 || (div < 64 && (div & 2)))
>>> +		*p = 1;
>>> +
>>> +	/* any other entries have p = 0 */
>>> +	else
>>> +		*p = 0;
>>> +
>>> +	/* calculate a suitable n based on k and p */
>>> +	div <<= *p;
>>> +	div /= (*k + 1);
>>> +	*n = div / 4;
>>> +}
>>> +
>>> +/**
>>> + * sunxi_pll1_clk_setup() - Setup function for PLL1 clock
>>> + */
>>> +
>>> +struct clk_factors_config pll1_config = {
>>> +	.nshift = 8,
>>> +	.nwidth = 5,
>>> +	.kshift = 4,
>>> +	.kwidth = 2,
>>> +	.mshift = 0,
>>> +	.mwidth = 2,
>>> +	.pshift = 16,
>>> +	.pwidth = 2,
>>> +};
>>> +
>>> +static void __init sunxi_pll1_clk_setup(struct device_node *node)
>>> +{
>>> +	struct clk *clk;
>>> +	const char *clk_name = node->name;
>>> +	const char *parent;
>>> +	void *reg;
>>> +
>>> +	reg = of_iomap(node, 0);
>>> +
>>> +	parent = of_clk_get_parent_name(node, 0);
>>> +
>>> +	clk = clk_register_factors(NULL, clk_name, parent, CLK_IGNORE_UNUSED,
>>> +				   reg, &pll1_config, sunxi_get_pll1_factors,
>>> +				   &clk_lock);
>>> +
>>> +	if (clk) {
>>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>> +		clk_register_clkdev(clk, clk_name, NULL);
>>> +	}
>>> +}
>>> +
>>> +
>>> +
>>> +/**
>>> + * sunxi_cpu_clk_setup() - Setup function for CPU mux
>>> + */
>>> +
>>> +#define SUNXI_CPU_GATE		16
>>> +#define SUNXI_CPU_GATE_WIDTH	2
>>> +
>>> +static void __init sunxi_cpu_clk_setup(struct device_node *node)
>>> +{
>>> +	struct clk *clk;
>>> +	const char *clk_name = node->name;
>>> +	const char **parents = kmalloc(sizeof(char *) * 5, GFP_KERNEL);
>>> +	void *reg;
>>> +	int i = 0;
>>> +
>>> +	reg = of_iomap(node, 0);
>>> +
>>> +	while (i < 5 && (parents[i] = of_clk_get_parent_name(node, i)) != NULL)
>>> +		i++;
>>> +
>>> +	clk = clk_register_mux(NULL, clk_name, parents, i, 0, reg,
>>> +			       SUNXI_CPU_GATE, SUNXI_CPU_GATE_WIDTH,
>>> +			       0, &clk_lock);
>>> +
>>> +	if (clk) {
>>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>> +		clk_register_clkdev(clk, clk_name, NULL);
>>> +	}
>>> +}
>>> +
>>> +
>>> +
>>> +/**
>>> + * sunxi_divider_clk_setup() - Setup function for simple divider clocks
>>> + */
>>> +
>>> +#define SUNXI_DIVISOR_WIDTH	2
>>> +
>>> +struct div_data {
>>> +	u8 div;
>>> +	u8 pow;
>>> +};
>>> +
>>> +static const __initconst struct div_data axi_data = {
>>> +	.div = 0,
>>> +	.pow = 0,
>>> +};
>>> +
>>> +static const __initconst struct div_data ahb_data = {
>>> +	.div = 4,
>>> +	.pow = 1,
>>> +};
>>> +
>>> +static const __initconst struct div_data apb0_data = {
>>> +	.div = 8,
>>> +	.pow = 1,
>>> +};
>>> +
>>> +static void __init sunxi_divider_clk_setup(struct device_node *node, u8 shift,
>>> +					   u8 power_of_two)
>>> +{
>>> +	struct clk *clk;
>>> +	const char *clk_name = node->name;
>>> +	const char *clk_parent;
>>> +	void *reg;
>>> +
>>> +	reg = of_iomap(node, 0);
>>> +
>>> +	clk_parent = of_clk_get_parent_name(node, 0);
>>> +
>>> +	clk = clk_register_divider(NULL, clk_name, clk_parent, 0,
>>> +				   reg, shift, SUNXI_DIVISOR_WIDTH,
>>> +				   power_of_two ? CLK_DIVIDER_POWER_OF_TWO : 0,
>>> +				   &clk_lock);
>>> +	if (clk) {
>>> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>>> +		clk_register_clkdev(clk, clk_name, NULL);
>>> +	}
>>> +}
>>> +
>>> +
>>> +/* Matches for of_clk_init */
>>> +static const __initconst struct of_device_id clk_match[] = {
>>> +	{.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
>>> +	{.compatible = "allwinner,sunxi-osc-clk", .data = sunxi_osc_clk_setup,},
>>> +	{.compatible = "allwinner,sunxi-pll1-clk", .data = sunxi_pll1_clk_setup,},
>>> +	{.compatible = "allwinner,sunxi-cpu-clk", .data = sunxi_cpu_clk_setup,},
>>> +	{}
>>> +};
>>> +
>>> +/* Matches for divider clocks */
>>> +static const __initconst struct of_device_id clk_div_match[] = {
>>> +	{.compatible = "allwinner,sunxi-axi-clk", .data = &axi_data,},
>>> +	{.compatible = "allwinner,sunxi-ahb-clk", .data = &ahb_data,},
>>> +	{.compatible = "allwinner,sunxi-apb0-clk", .data = &apb0_data,},
>>> +	{}
>>> +};
>>> +
>>> +static void __init of_sunxi_divider_clock_setup(void)
>>> +{
>>> +	struct device_node *np;
>>> +	const struct div_data *data;
>>> +	const struct of_device_id *match;
>>> +
>>> +	for_each_matching_node(np, clk_div_match) {
>>> +		match = of_match_node(clk_div_match, np);
>>> +		data = match->data;
>>> +		sunxi_divider_clk_setup(np, data->div, data->pow);
>>> +	}
>>> +}
>>> +
>>> +void __init sunxi_init_clocks(void)
>>> +{
>>> +	/* Register all the simple sunxi clocks on DT */
>>> +	of_clk_init(clk_match);
>>> +
>>> +	/* Register divider clocks */
>>> +	of_sunxi_divider_clock_setup();
>>> +}
>>>
>>
>> Regards,
>>
> 
> @Mike and anyone else reading: do you have any other comments before I
> send a v2 series?

I've just sent new comments about the other clocks.

Regards,

Gregory
