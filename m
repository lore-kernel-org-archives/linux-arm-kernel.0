From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 23 Jan 2017 07:53:21 +0000
Subject: [PATCHv4 1/5] clk: mvebu: support for 98DX3236 SoC
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-2-chris.packham@alliedtelesis.co.nz>
 <20170121004819.GA8801@codeaurora.org>
Message-ID: <be295fd327674a2ca91437456db7a047@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/01/17 13:48, Stephen Boyd wrote:
> On 01/13, Chris Packham wrote:
>> @@ -158,6 +170,14 @@ static const struct coreclk_soc_desc axp_coreclks = {
>>  	.num_ratios = ARRAY_SIZE(axp_coreclk_ratios),
>>  };
>>
>> +static const struct coreclk_soc_desc mv98dx3236_coreclks = {
>> +	.get_tclk_freq = mv98dx3236_get_tclk_freq,
>> +	.get_cpu_freq = mv98dx3236_get_cpu_freq,
>> +	.get_clk_ratio = NULL,
>> +	.ratios = NULL,
>> +	.num_ratios = 0,
>
> Are these intentionally initialized to 0 explicitly? Otherwise we
> could leave them out and it's all the same.
>

No reason, just didn't remove the unused members when copying the 
armada-xp example above.

>> +};
>> +
>>  /*
>>   * Clock Gating Control
>>   */
> [..]
>> @@ -243,5 +245,30 @@ static void __init of_cpu_clk_setup(struct device_node *node)
>>  	iounmap(clock_complex_base);
>>  }
>>
>> +/* Use this function to call the generic setup with the correct
>> + * clock operation
>> + */
>> +static void __init of_cpu_clk_setup(struct device_node *node)
>> +{
>> +	_of_cpu_clk_setup(node, &cpu_ops);
>> +}
>> +
>>  CLK_OF_DECLARE(armada_xp_cpu_clock, "marvell,armada-xp-cpu-clock",
>>  					 of_cpu_clk_setup);
>> +
>> +/* Define the clock and operations for the mv98dx3236 - it cannot perform
>> + * any operations.
>> + */
>> +static const struct clk_ops mv98dx3236_cpu_ops = {
>> +	.recalc_rate = NULL,
>> +	.round_rate = NULL,
>> +	.set_rate = NULL,
>
> But clk_set_rate() works silently? Why not just register a clk
> provider that returns a NULL pointer? Then there isn't any
> structure to maintain?
>

Not 100% sure what you mean. Something like this?

+static void __init of_mv98dx3236_cpu_clk_setup(struct device_node *node)
+{
+       of_clk_add_provider(node, of_clk_src_simple_get, NULL);
+}

Seems to work as expected (i.e. does nothing, kernel boots/runs).
