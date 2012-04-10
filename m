From: robherring2@gmail.com (Rob Herring)
Date: Tue, 10 Apr 2012 08:17:18 -0500
Subject: [PATCH 7/7] clk: add highbank clock support
In-Reply-To: <20120410020638.GG18692@S2101-09.ap.freescale.net>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-8-git-send-email-robherring2@gmail.com>
 <20120410020638.GG18692@S2101-09.ap.freescale.net>
Message-ID: <4F8432DE.9070308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 09:06 PM, Shawn Guo wrote:
> On Tue, Mar 13, 2012 at 06:22:27PM -0500, Rob Herring wrote:
>> From: Rob Herring <rob.herring@calxeda.com>
>>
>> This adds real clock support to Calxeda Highbank SOC using the common
>> clock infrastructure.
>>
>> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>> ---

[snip]

>> +
>> +				osc: oscillator {
>> +					#clock-cells = <0>;
>> +					compatible = "fixed-clock";
>> +					clock-frequency = <33333000>;
>> +				};
>> +
>> +				ddrpll: ddrpll {
>> +					#clock-cells = <0>;
>> +					compatible = "calxeda,hb-pll-clock";
> 
> Where are all these "calxeda,*-clock' compatible documented?

Right. Need to add that.

> 
>> +					clocks = <&osc>;
>> +					reg = <0x108>;
>> +				};
>> +
>> +				a9pll: a9pll {
>> +					#clock-cells = <0>;
>> +					compatible = "calxeda,hb-pll-clock";
>> +					clocks = <&osc>;
>> +					reg = <0x100>;
>> +				};
>> +
>> +				a9periphclk: a9periphclk {
>> +					#clock-cells = <0>;
>> +					compatible = "calxeda,hb-a9periph-clock";
>> +					clocks = <&a9pll>;
>> +					reg = <0x104>;
>> +					clock-divider = <4>;
> 
> Where is this "clock-divider" binding documented?

This should be deleted.



>> +static unsigned long clk_cpu_periphclk_recalc_rate(struct clk_hw *clk,
>> +						   unsigned long parent_rate)
>> +{
>> +	return parent_rate / 2;
>> +}
>> +
>> +static const struct clk_ops a9periphclk_ops = {
>> +	.recalc_rate = clk_cpu_periphclk_recalc_rate,
>> +};
>> +
> 
> This basically is a clk-fixed-factor added by Sascha.
> 

Well that didn't exist when I sent this out based on v6 of Mike's patches.

Anyway, it is not really fixed divider either. I need to add reading the
register value.

>> +static unsigned long clk_cpu_a9bclk_recalc_rate(struct clk_hw *clk,
>> +						unsigned long parent_rate)
>> +{
>> +	struct hb_clk *hbclk = to_hb_clk(clk);
>> +	u32 div = (readl(hbclk->reg) & HB_A9_BCLK_DIV_MASK) >> HB_A9_BCLK_DIV_SHIFT;
>> +
>> +	return parent_rate / (div + 2);
>> +}
>> +
>> +static const struct clk_ops a9bclk_ops = {
>> +	.recalc_rate = clk_cpu_a9bclk_recalc_rate,
> 
> Since there is a divider for the clock, the ops should have .round_rate
> and .set_rate, no?
> 

Except I have no need or desire to support changing it. When and if
there is a need I will add that.

>> +};
>> +
>> +static unsigned long clk_periclk_recalc_rate(struct clk_hw *clk,
>> +					     unsigned long parent_rate)
>> +{
>> +	struct hb_clk *hbclk = to_hb_clk(clk);
>> +	u32 div;
>> +
>> +	div = readl(hbclk->reg);
>> +	div++;
>> +	div *= 2;
>> +
>> +	return parent_rate / div;
>> +}


>> +
>> +static const __initconst struct of_device_id clk_match[] = {
>> +	{ .compatible = "fixed-clock", .data = of_fixed_clk_setup, },
>> +	{ .compatible = "calxeda,hb-pll-clock", .data = hb_pll_init, },
>> +	{ .compatible = "calxeda,hb-a9periph-clock", .data = hb_a9periph_init, },
>> +	{ .compatible = "calxeda,hb-a9bus-clock", .data = hb_a9bus_init, },
>> +	{ .compatible = "calxeda,hb-emmc-clock", .data = hb_emmc_init, },
> 
> So that's the difference between your clock and mine.  You do not reuse
> any basic clk, except clk_fixed_rate, while my clocks are all about
> basic clk except pll.  That's why you need a long list of SoC specific
> binding, while I do not.  All I need is the binding for those basic
> clks.

Because there are not any I can use. I don't have any muxes or clk
gates. The only one that exists in mainline is divider, but our divider
is not n, n+1, or n^2. It is 2(n+1).

Rob

> 
> Regards,
> Shawn
> 
>> +	{}
>> +};
>> +
>> +void __init highbank_clocks_init(void)
>> +{
>> +	of_clk_init(clk_match);
>> +}
