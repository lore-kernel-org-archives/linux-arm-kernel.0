From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 May 2017 17:40:07 +0300
Subject: [PATCHv3b 5/5] ARM: OMAP2+: hwmod: populate clkctrl clocks for
 hwmods if available
In-Reply-To: <20170530181516.GB3730@atomide.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <1496155669-1677-6-git-send-email-t-kristo@ti.com>
 <20170530181516.GB3730@atomide.com>
Message-ID: <221e96f4-b1bf-4ae8-3ce8-b5536a8e18ba@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 21:15, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [170530 07:52]:
>> If clkctrl clocks are available on a device, populate these automatically
>> to replace hwmod main_clk info. First, the patch parses all "ti,clkctrl"
>> compatible nodes and maps these against existing clockdomain data. Once
>> done, individual hwmod init routines can search for a clkctrl clock
>> handle based on the clockdomain info and the created mapping.
> ...
>> --- a/arch/arm/mach-omap2/omap_hwmod.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>>   /**
>>    * _init_main_clk - get a struct clk * for the the hwmod's main functional clk
>>    * @oh: struct omap_hwmod *
>> + * @np: device node mapped to this hwmod
>>    *
>>    * Called from _init_clocks().  Populates the @oh _clk (main
>>    * functional clock pointer) if a clock matching the hwmod name is found,
>>    * or a main_clk is present.  Returns 0 on success or -EINVAL on error.
>>    */
>> -static int _init_main_clk(struct omap_hwmod *oh)
>> +static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
>>   {
>>   	int ret = 0;
>> -	char name[MOD_CLK_MAX_NAME_LEN];
>> -	struct clk *clk;
>> -	static const char modck[] = "_mod_ck";
>> +	struct clk *clk = NULL;
>>   
>> -	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
>> -		pr_warn("%s: warning: cropping name for %s\n", __func__,
>> -			oh->name);
>> -
>> -	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
>> -	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
>> +	if (np) {
>> +		clk = _lookup_clkctrl_clk(oh, np);
This func call above maps the hwmod to a clkctrl clock. See below.

>> +
>> +		if (!IS_ERR_OR_NULL(clk)) {
>> +			pr_debug("%s: mapped main_clk %s for %s\n", __func__,
>> +				 __clk_get_name(clk), oh->name);
>> +			oh->main_clk = __clk_get_name(clk);
>> +			oh->_clk = clk;
>> +			soc_ops.disable_direct_prcm(oh);
>> +		}
>> +	}
> 
> Shouldn't we just parse all "ti,clkctrl" matches to
> a list, then match against that list?

Yeah, this is actually what we are doing. Check out what 
_init_clkctrl_providers() is doing. _lookup_clkctrl_clk() is then used 
to match each individual hwmod to its main clkctrl clk.

> 
> Again I'm worried that the "struct device_node *np"
> here won't really map to struct omap_hwmod but to one of
> the child devices. Or what is the np here?

The np is actually not needed for anything anymore here, so I will drop 
it from v4.

-Tero
