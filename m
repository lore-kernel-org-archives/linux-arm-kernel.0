From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Fri, 07 Feb 2014 15:17:54 -0300
Subject: [PATCH] clk: respect the clock dependencies in of_clk_init
In-Reply-To: <52F52189.5090506@free-electrons.com>
References: <1391554766-11285-1-git-send-email-gregory.clement@free-electrons.com>
 <52F4DA40.4090804@elopez.com.ar> <20140207142430.GU8533@titan.lakedaemon.net>
 <20140207144325.GA8218@localhost> <52F4F279.6010006@free-electrons.com>
 <52F4F502.2010703@elopez.com.ar> <52F4F7EF.7090900@free-electrons.com>
 <52F506E4.8070900@elopez.com.ar> <52F52189.5090506@free-electrons.com>
Message-ID: <52F52352.9010407@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 07/02/14 15:10, Gregory CLEMENT escribi?:
(snip)
>> ---
>>    drivers/clk/mvebu/common.c | 13 +++++++------
>>    1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
>> index 25ceccf..730625b 100644
>> --- a/drivers/clk/mvebu/common.c
>> +++ b/drivers/clk/mvebu/common.c
>> @@ -119,19 +119,20 @@ void __init mvebu_clk_gating_setup(struct
>> device_node *np,
>>    				   const struct clk_gating_soc_desc *desc)
>>    {
>>    	struct clk_gating_ctrl *ctrl;
>> -	struct clk *clk;
>>    	void __iomem *base;
>> -	const char *default_parent = NULL;
>> +	struct of_phandle_args clkspec;
>> +	const char *default_parent = "tclk";
>>    	int n;
>>
>>    	base = of_iomap(np, 0);
>>    	if (WARN_ON(!base))
>>    		return;
>>
>> -	clk = of_clk_get(np, 0);
>> -	if (!IS_ERR(clk)) {
>> -		default_parent = __clk_get_name(clk);
>> -		clk_put(clk);
>> +	if (!of_parse_phandle_with_args(np, "clocks", "#clock-cells", 0,
>> &clkspec)) {
>> +		of_property_read_string_index(clkspec.np, "clock-output-names",
>> +					      clkspec.args_count ? clkspec.args[0] : 0,
>> +					      &default_parent);
>> +		of_node_put(clkspec.np);
>
> OK here you duplicate the code from of_clk_get_parent_name, I wonder why
> you didn't use the function.But whatever.

I specifically duplicated it because of_clk_get_parent_name returns the 
node name if there's no clock-output-names. That wouldn't be useful in 
this case.

> Here you will get default_parent = "mvebu-sar" which is the name of the node, you
> can't have "tclk" because this name is not in the device tree, but it will be
> created by the initialization of the core clocks.

No, default_parent would be "tclk" still because clock-output-names 
property doesn't exist. If you ever add such a property, it will 
override "tclk".

Cheers,

Emilio
